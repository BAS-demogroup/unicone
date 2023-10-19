#include "irqload.h"


#include "../chips.h"
#include "../macros.h"


void fastload_init() {
	FDC.MOTOR = 1;
	FDC.LED   = 1;
}

void fastload_exit() {
	FDC.MOTOR = 0;
	FDC.LED   = 0;
}

void fastload_set_filename(char *filename) {
	char i;
	for (i = 15; i >= 0; i--) {
		fastload_filename[i] = 0xa0;
	}
	
	for (i = 0; i < 16; i++) {
		if (filename[i] == 0) break;
		
		fastload_filename[i] = filename[i];
	}
	
	fastload_filename_len = i;
}

void fastload_waiting() {
	// Wait for the request byte to go back to $00, or to report an error. The 
	// request value will continually update based on the state of the loading.
	do {
		fastload_irq();
	} while (fastload_request > 0);
	
	if (fastload_request == 0) return;
	
	// ERROR.  Choke hard.
	do {
		VIC2.BORDERCOL = 2;
		VIC2.BORDERCOL = 7;
	} while (1);
}

void fastload_irq() {
	// if we're in an idle state, then nothing to do here.
	if (fastload_request == 0) return;
	
	// if the FDC is currently busy, then there's also nothing to do here.
	if (FDC.BUSY) return;
	
	// if we're in an error state, then again, there's nothing we CAN do here.
	if (fastload_request < 0) return;
	
	// ... and if the current request is out of bounds, then this is also an
	// error state and there's nothing we can do here.
	if (fastload_request >= 8) return;
	
	// however, if everything is good, then we can call the correct function to
	// move forward.
	switch (fastload_request) {
		case 1:
			fastload_new_request();
			break;
		case 2:
			fastload_directory_scan();
			break;
		case 3:
			fastload_read_file_block();
			break;
		case 4:
			fastload_seek_track_0();
			break;
		case 5:
			fastload_reading_sector();
			break;
		case 6:
			iffl_read_file_block_init();
			break;
		case 7:
			iffl_read_file_block();
			break;
	}
}

void fastload_seek_track_0() {
	// TK0 - F011 Head is over track 0 flag (read only)
	if (FDC.TK0) {
		fastload_request = 0;
		fastload_current_track = 0;
	}
	
	// Step back towards track 0
	FDC.STEPF = 1;
}

void fastload_select_side1() {
	// requested side
	FDC.SIDE  = 1;
	
	FDC.MOTOR = 1;
	FDC.LED   = 1;
	// Sides are inverted on the 1581
	// physical side selected of mechanical drive
	FDC.SIDEF = 0;
}

void fastload_select_side0() {
	// requested side
	FDC.SIDE = 0;

	FDC.MOTOR = 1;
	FDC.LED   = 1;
	// Sides are inverted on the 1581
	// physical side selected of mechanical drive
	FDC.SIDEF = 1;
}

void fastload_new_request() {
	// Acknowledge fastload request
	fastload_request = 2;
	
	fastload_read_dir_for_ui();
}

void fastload_read_dir_for_ui() {
	// We need to seek to track 40, sector 3, for a directory scan.
	FDC.TRACK  = 39;
	FDC.SECTOR = (3/2) + 1;		// Physical sectors are 512 bytes, not 256, 
								// and indexing starts at 1, so we need to load
								// sector (3/2) + 1 to load what we would think
								// of as sector 3.
	
	
	fastload_select_side0();
	fastload_read_sector();		// request read
}

void fastload_directory_scan() {
	fastload_copy_sector_to_buffer();

	// (XXX we scan the last BAM sector as well, to keep the code simple.)
	// filenames are at offset 4 in each 32-byte directory entry, padded at
	// the end with $A0
	
	char *fastload_sector_buffer_ptr = fastload_sector_buffer + 5;

	char i;
	do {
		for (i = 0; i < 16; i++) {
			if (fastload_sector_buffer_ptr[i] != fastload_filename[i]) break;
		}

		if (i == 16) {	// filename matches
			fastload_sector_buffer_ptr -= 0x12;
		
			// Store track and sector of file
			fastload_file_next_track = fastload_sector_buffer_ptr[0];
			fastload_file_next_sector = fastload_sector_buffer_ptr[1];

			// Advance to next state (6=fl_iffl_read_file_block_init)
			fastload_request = 6;

			// Request reading of next track and sector
			fastload_read_next_sector();

			return;
		}
		
		// Advance to next directory entry
		fastload_sector_buffer_ptr += 32 - i;
	} while (fastload_sector_buffer_ptr - fastload_sector_buffer < 512);

	// No matching name in this 512 byte sector.
	// Load the next one, or give up the search
	if (++FDC.SECTOR > 10) {
		// Ran out of sectors in directory track
		// (XXX only checks side 0, and assumes DD disk)

		// Mark load as failed. $80 = File not found
		fastload_request = -128;
	} else {
		// Request read. No need to change state
		fastload_read_sector();
	}
}

void fastload_read_sector() {
	// Remember the state that we need to return to
	fastload_request_stashed = fastload_request;

	// and then set ourselves to the track stepping/sector reading state
	fastload_request = 5;
	
	fastload_reading_sector();
}

void fastload_reading_sector() {
// fl_reading_sector
	// lda $d084										; Check if we are already on the correct track/side
	// cmp fl_current_track							; and if not, select/step as required
	// beq fl_on_correct_track
	// bcc fl_step_in
	
	if (FDC.TRACK > fastload_current_track) {
		// track step out
		FDC.DIR   = 1;
		FDC.STEPF = 1;

		++fastload_current_track;

		return;
	} else if (FDC.TRACK < fastload_current_track) {
		// track step in
		FDC.DIR   = 0;
		FDC.STEPF = 1;

		--fastload_current_track;

		return;
	}
	
	if (FDC.TRACK  == fastload_prev_track 
	 && FDC.SIDE   == fastload_prev_side
	 && FDC.SECTOR == fastload_prev_sector) {

		// We are being asked to read the sector we already have in the buffer
		fastload_request = fastload_request_stashed;
		// Jump immediately to the correct routine
		fastload_irq();
	}
	
	// ISSUE ACTUAL READ COMMAND
	FDC.RDCMD = 1;

	// Now that we are finally reading the sector,
	// restore the stashed state ID
	fastload_request = fastload_request_stashed;
}

void fastload_step_track() {
	// advance to next state (3=fastload_read_file_block)
	fastload_request = 3;
	
	fastload_read_next_sector();
}

void fastload_read_next_sector() {
	// Check if we reached the end of the file first
	if (!fastload_file_next_track) return;

	// Read next sector of file	
	fastload_logical_to_physical_sector();
	fastload_read_sector();
}

void fastload_logical_to_physical_sector() {
	// Remember current loaded sector, so that we can optimise when asked
	// to read other half of same physical sector
	fastload_prev_track = FDC.TRACK;
	fastload_prev_sector = FDC.SECTOR;
	fastload_prev_side = FDC.SIDE;
	
	// Convert 1581 sector numbers to physical ones on the disk.
	fastload_select_side0();
	
	// Track = Track - 1
	FDC.TRACK = fastload_file_next_track - 1;

	// Sector = 1 + (Sector/2)
	char ns = 1 + (fastload_file_next_sector >> 1);
	if (ns < 11) {
		FDC.SECTOR = ns;
	} else {
		// If sector > 10, then sector=sector-10, side=1
		// but sides are inverted
		FDC.SECTOR = ns - 10;
		fastload_select_side1();
	}
}

void fastload_read_file_block() {
	// We have a sector from the floppy drive.
	// Work out which half and how many bytes, and copy them into place.

	// Get sector from FDC
	fastload_copy_sector_to_buffer();

	// Assume full sector initially (256 bytes)
	// subtract 2 for track and sector bytes
	fastload_data_read_dmalist.count = 256 - 2;

	// Work out which half we care about
	if ((fastload_file_next_sector & 0x01) == 0) {
		fastload_data_read_dmalist.source = (unsigned short)&fastload_sector_buffer;
		fastload_file_next_sector = fastload_sector_buffer[1];
		fastload_file_next_track = fastload_sector_buffer[0];
		// if next track is 0 then this is a partial sector and 'sector' now 
		// becomes the number of bytes left in this sector
		if (fastload_file_next_track == 0) {
			// track is 0, so sector contains number of bytes left
			// minus 1, because the byte that contains the size is included
			fastload_data_read_dmalist.count = fastload_sector_buffer[1] - 1;
			// Mark end of loading
			fastload_request = 0;
		}

	// odd next sector number, so second half
	} else {
		fastload_data_read_dmalist.source = (unsigned short)&fastload_sector_buffer + 256;
		fastload_file_next_sector = fastload_sector_buffer[0x101];
		fastload_file_next_track = fastload_sector_buffer[0x100];
		
		// if next track is 0 then this is a partial sector and 'sector' now 
		// becomes the number of bytes left in this sector
		if (fastload_file_next_track == 0) {
			// track is 0, so sector contains number of bytes left
			// minus 1, because the byte that contains the size is included
			fastload_data_read_dmalist.count = fastload_sector_buffer[0x101] - 1;
			// Mark end of loading
			fastload_request = 0;
		}
	}
	
	fastload_dma_read_bytes();
}

void fastload_dma_read_bytes() {
	// Update destination address

	// update destination MB
	fastload_data_read_dmalist.dbank = (fastload_address & 0xff00000) >> 20;
	
	// update Dest bank
	fastload_data_read_dmalist.destination_bank = (fastload_address & 0xf0000) >> 16;
	
	// update Dest Address low and high
	fastload_data_read_dmalist.destination = fastload_address & 0xffff;

	fastload_data_read_dmalist.type = 0x0b;
	fastload_data_read_dmalist.dbank_token = 0x81;
	fastload_data_read_dmalist.end_options = 0;
	// Copy sector buffer data to final address
	run_dma_job((__far char *)&fastload_data_read_dmalist);

	// Update load address
	fastload_address += fastload_data_read_dmalist.count;

	// Schedule reading of next block
	fastload_read_next_sector();
}

void fastload_copy_sector_to_buffer() {
	// Make sure FDC sector buffer is selected
	poke(0xd689, 0b10000000);
	
	// Temporarily initialize the dmalist while hth313 works on fixing a bug 
	// with struct initialization.
	fastload_sector_read_dmalist.command = 0;
	fastload_sector_read_dmalist.count = 512;
	fastload_sector_read_dmalist.source = 0x6c00;
	fastload_sector_read_dmalist.source_bank = 0xd;
	fastload_sector_read_dmalist.source_hold = 0;
	fastload_sector_read_dmalist.source_modulo = 0;
	fastload_sector_read_dmalist.source_direction = 0;
	fastload_sector_read_dmalist.source_io = 0;
	fastload_sector_read_dmalist.destination = (unsigned short)&fastload_sector_buffer;
	fastload_sector_read_dmalist.destination_bank = 0;
	fastload_sector_read_dmalist.destination_hold = 0;
	fastload_sector_read_dmalist.destination_modulo = 0;
	fastload_sector_read_dmalist.destination_direction = 0;
	fastload_sector_read_dmalist.destination_io = 0;
	fastload_sector_read_dmalist.modulo = 0;
	
	fastload_sector_read_dmalist.type = 0x0b;
	fastload_sector_read_dmalist.sbank_token = 0x80;
	fastload_sector_read_dmalist.end_options = 0;
	// Copy FDC data to our buffer
	run_dma_job((__far char *)&fastload_sector_read_dmalist);
}

// This entire function is useless and I am not of the opinion that it should
// be included here.
__attribute__((interrupt(0xfffe)))
void fastload_irq_handler() {
	++VIC2.BORDERCOL;
	++VIC2.SCREENCOL;
	
	VIC2.RC += 0x20;
	
	VIC2.RIRQ = 0;
}

void iffl_read_file_block_init() {
	// Set state to fl_iffl_read_file_block
	fastload_request = 7;

	// Get sector from FDC
	fastload_copy_sector_to_buffer();

	unsigned short offset = 0;
	// Work out which half we care about
	// odd next sector number, so second half
	if (fastload_file_next_sector & 1) {
		offset = 0x100;
	}

	// read number of file entries in iffl from first sector
	iffl_numfiles = fastload_sector_buffer[2];

	for (int i = 0; i < iffl_numfiles; i++) {
		for (int j = 0; j < 8; j++) {
			// get start addresses and sizess for files in iffl
			iffl_start_address_and_size[offset + j] = fastload_sector_buffer[offset + j + 3];
		}
	
		offset += 8;
	}
	// set iffl byte counter to 1 (nexttrack) + 1 (nextsector) + 1 (numfiles) 
	// 		+ numfiles * 8
	iffl_bytecounter = (iffl_numfiles << 3) + 3;
	iffl_currentfile = 0;

	fastload_address = iffl_start_address_and_size[0] +
		((unsigned long)iffl_start_address_and_size[1] << 8) +
		((unsigned long)iffl_start_address_and_size[2] << 16) +
		((unsigned long)iffl_start_address_and_size[3] << 24);

	iffl_sizeremaining = iffl_start_address_and_size[4] +
		((unsigned long)iffl_start_address_and_size[5] << 8) +
		((unsigned long)iffl_start_address_and_size[6] << 16) +
		((unsigned long)iffl_start_address_and_size[7] << 24);

	// Mark end of loading
	fastload_request = 0;
}

void iffl_read_file_block() {
	// Get sector from FDC
	fastload_copy_sector_to_buffer();

	if (256 - iffl_bytecounter > iffl_sizeremaining) {
		// copy until remaining size

		if ((fastload_file_next_sector & 1) == 0) {
			fastload_data_read_dmalist.source = (unsigned short)&fastload_sector_buffer;
		} else {
			// odd next sector number, so second half
			fastload_data_read_dmalist.source = (unsigned short)&fastload_sector_buffer + 0x100;
		}

		// set offset for DMA copy
		fastload_data_read_dmalist.source += iffl_bytecounter;
		fastload_data_read_dmalist.count = iffl_sizeremaining & 0xff;
		iffl_bytecounter += fastload_data_read_dmalist.count;

		// Mark end of loading
		fastload_request = 0;
		
		iffl_performcopy();

		return;
	}
	
	// copy remaining buffer
	if ((fastload_file_next_sector & 1) == 0) {
		fastload_data_read_dmalist.source = (unsigned short)&fastload_sector_buffer;
		fastload_file_next_sector = fastload_sector_buffer[1];
		fastload_file_next_track = fastload_sector_buffer[0];
	} else {
		// odd next sector number, so second half
		fastload_data_read_dmalist.source = (unsigned short)&fastload_sector_buffer & 0xff00;
		fastload_file_next_sector = fastload_sector_buffer[0x101];
		fastload_file_next_track = fastload_sector_buffer[0x100];
	}

	fastload_data_read_dmalist.count = 256 - iffl_bytecounter;
	iffl_sizeremaining -= fastload_data_read_dmalist.count;

	// set offset for DMA copy
	fastload_data_read_dmalist.source = (fastload_data_read_dmalist.source & 0xff00) | iffl_bytecounter;
	
	iffl_performcopy();

	iffl_bytecounter += fastload_data_read_dmalist.count + 2;

	// Schedule reading of next block
	fastload_read_next_sector();
}

void iffl_performcopy() {
	// Update destination address

	// update destination MB
	fastload_data_read_dmalist.dbank = (fastload_address & 0xff00000) >> 20;
	
	// update Dest bank
	fastload_data_read_dmalist.destination_bank = (fastload_address & 0xf0000) >> 16;
	
	// update Dest Address low and high
	fastload_data_read_dmalist.destination = fastload_address & 0xffff;

	fastload_data_read_dmalist.type = 0x0b;
	fastload_data_read_dmalist.dbank_token = 0x81;
	fastload_data_read_dmalist.end_options = 0;
	// Copy sector buffer data to final address
	run_dma_job((__far char *)&fastload_data_read_dmalist);

	// Update load address
	fastload_address += fastload_data_read_dmalist.count;
}
