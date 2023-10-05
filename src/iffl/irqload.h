// Mirage's IFfastload loader code, ported to C.  Pretty sure the fastloader
// code is an adaptation of gardners' FL code.

#ifndef _IRQLOAD_H
#define _IRQLOAD_H

#include "../dma.h"

void fastload_init();
void fastload_exit();
void fastload_set_filename(char *filename);
void fastload_waiting();

void fastload_irq();
void fastload_seek_track_0();
void fastload_select_side1();
void fastload_select_side0();
void fastload_new_request();
void fastload_read_dir_for_ui();
void fastload_directory_scan();
void fastload_read_sector();
void fastload_reading_sector();
void fastload_step_track();
void fastload_read_next_sector();
void fastload_logical_to_physical_sector();
void fastload_read_file_block();
void fastload_dma_read_bytes();
void fastload_copy_sector_to_buffer();

__attribute__((interrupt(0xfffe)))
void fastload_irq_handler();

void iffl_read_file_block_init();
void iffl_read_file_block();
void iffl_performcopy();

char 		fastload_filename[16];
char 		fastload_filename_len;
long 		fastload_address;
long		fastload_iffl_counter;
signed char	fastload_request;
signed char fastload_request_stashed;
char 		fastload_current_track;
char		fastload_file_next_track;
char		fastload_file_next_sector;
char		fastload_prev_track;
char		fastload_prev_sector;
char		fastload_prev_side;

char          iffl_numfiles;
char          iffl_currentfile;
unsigned long iffl_sizeremaining;
char          iffl_bytecounter;

// char           fastload_data_read_dmalist_type = 0x0b;
// char           fastload_data_read_dmalist_dbank_token = 0x81;
// char           fastload_data_read_dmalist_dbank = 0x00;
// char           fastload_data_read_dmalist_end_options = 0x00;
dma_copy_job_huge_destination_t fastload_data_read_dmalist;

__attribute__((aligned(256))) char fastload_sector_buffer[512];
__attribute__((aligned(256))) char iffl_start_address_and_size[256];

// char                       fastload_sector_read_dmalist_type = 0x0b;
// char                       fastload_sector_read_dmalist_sbank_token = 0x80;
// char                       fastload_sector_read_dmalist_sbank = 0xff;
// char                       fastload_sector_read_dmalist_end_options = 0x00;
dma_copy_job_huge_source_t fastload_sector_read_dmalist /*= {
	.command = 0, 
	.count   = 512, 
	.source  = 0x6c00,
	{
		0xd
		// .source_bank      = 0xd, 
		// .source_hold      = 0, 
		// .source_modulo    = 0, 
		// .source_direction = 0, 
		// .source_io        = 0, 
	},
	.destination = (unsigned short)&fastload_sector_buffer, 
	{
		0
		// .destination_bank      = 0, 
		// .destination_hold      = 0, 
		// .destination_modulo    = 0, 
		// .destination_direction = 0, 
		// .destination_io        = 0, 
	},
	.modulo = 0
}*/;

#endif