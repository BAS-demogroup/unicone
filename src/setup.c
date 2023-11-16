/// \file	setup.c
/// 
/// \brief	This file contains the code responsible for loading and setup of 
/// 		the game
///
/// This C file contains all the code that loads all of the data at startup, as 
/// well as the code that is called for switching between the 3 modes of the 
/// game - title screen, in-game loop, and game over.
///
/// \copyright 2023 by BAS and deathy (AKA Clifford A. Anderson).  
/// All rights reserved.
#include "setup.h"


#include <calypsi/intrinsics6502.h>


#include "audio.h"
#include "chips.h"
#include "constants.h"
#include "dma.h"
#include "dma_jobs.h"
#include "gameloop.h"
#include "input.h"
#include "macros.h"
#include "maps.h"


#include "iffl/iffl.h"
#include "iffl/irqload.h"


/// \brief	This function performs setup common to the entire game and then 
///			loads all of the data.
///
/// This function first configures all of the settings that are global to the
/// entire game, then loads the minimal amount of data to display a loading 
/// screen, then displays that screen, and proceeds to load the rest of the
/// game data and storing it in the attic
void loader() {
	__disable_interrupts();
	
	// set the speed to 40MHz
	CPU.PORTDDR = 65;

	// bank out everything except for I/O
	CPU.PORTDDR = 0b00000111;
	CPU.PORT    = 0b00000101;
	
	// disable CIA interrupts
	CIA1.ICR = 0b01111111;
	CIA2.ICR = 0b01111111;

	CIA1.ICR;
	CIA2.ICR;
	
	// map I/O (Mega65 memory mapping)
	VIC3.ROM8  = 0;
	VIC3.ROMA  = 0;
	VIC3.ROMC  = 0;
	VIC3.CROM9 = 0;
	VIC3.ROME  = 0;

	__asm(" lda #0x00\n"
		  " tax\n"
		  " tay\n"
		  " taz\n"
		  " map\n"
		  " nop");

	// Enable the VIC4
	VIC3.KEY = 0x47;
	VIC3.KEY = 0x53;
	
	// disable RAM protection in banks 2 and 3
	poke(0xD640, 0x70);		// $d640 = HTRAP00
	__no_operation();		// clv would be better

	// blank the screen while we do our initial loading
	VIC2.DEN = 0;
	
	// load the minimal data required to show the titlescreen
	load_loader();
	
	// load the titlescreen attribute map to $ff80000
	run_dma_job((__far char *)&load_loader_attrmap);
	
	// configure PAL or NTSC
	// for some reason, there is value in setting the PALNTSC flag to its 
	// already set value... in Classy, doing this fixed a blank screen bug in
	// NTSC
	// The update raster is the first raster after the border in 640x400
	if(VIC4.PALNTSC) {
		VIC4.PALNTSC  = 1;
		update_raster = 0x1c6;
		end_of_level_timer_start = 200;
	} else {
		VIC4.PALNTSC  = 0;
		update_raster = 0x1f7;
		end_of_level_timer_start = 240;
	}
	
	// disable raster interrupts
	VIC4.FNRST    = 0;
	VIC4.FNRSTCMP = 0;
	
	// enable 640 horizontal width
	VIC3.H640 = 1;
	
	// disable hot registers
	VIC4.HOTREG = 0;
	
	// use wide character lookup (i.e. character data anywhere in memory)
	VIC4.CHR16 = 1;
	
	// set multicolor mode - allows use of both color palettes
	// probably not necessary to turn this on, but it also doesn't hurt.
	VIC2.MCM = 1;
	
	// set 480 vertical resolution
	set_480();
	
	// configure screen row length
	VIC4.LINESTEP    = LOADER_LINE_LENGTH << 1;
	VIC4.CHRCOUNTLSB = LOADER_LINE_LENGTH;
	VIC4.CHRCOUNTMSB = LOADER_LINE_LENGTH >> 8;
	VIC4.DISPROWS    = LOADER_LINE_COUNT;
	
	// use NCM and FCM for all characters
	VIC4.FCLRLO = 1;	// lower block, i.e. 0-255
	VIC4.FCLRHI = 1;	// everything above 255
	
	// set tile map location
	VIC4.SCRNPTR    = LOADER_TILE_MAP & 0xffff;
	VIC4.SCRNPTRBNK = (LOADER_TILE_MAP & 0xf0000) >> 16;
	VIC4.SCRNPTRMB  = 0x0;

	// enable rrb double buffering - this isn't actually used by the loader or
	// title screen, but it makes more sense to configure it here
	VIC4.NORRDEL = 0;
	
	// enable 400 vertical height
	VIC3.V400    = 1;
	VIC4.CHRYSCL = 0;
	VIC4.CHRXSCL = 0x78;

	// disable double-height rrb - again, this isn't used by the loader or
	// or title screen, but this still seems like the better place to put it
	VIC4.DBLRR = 0;

	// unblank the screen, making the loading screen visible
	VIC2.DEN = 1;
	
	// audio DMA must be explicitly enabled on real hardware, though xemu does
	// not care either way
	poke(0xd711,0b10000000);
	
	// load the rest of the data
	load_rest();
	
	// start with the music not muted
	muted = 0;
	// the audio channel to play samples through rotates - start with channel 0
	next_channel = 0;
}

/// \brief	This procedure is called to setup for showing the title screen
///
/// This procedure blanks the screen, loads the title screen data from attic, 
/// sets all of the register values for the title screen, loads the attribute
/// map, unblanks the screen, and initializes the music.
void title_setup() {
	// blank the screen
	VIC2.DEN = 0;

	// load all of the title screen data from attic RAM into fast RAM
	run_dma_job((__far char *)&load_title_banks);
	
	// set the current_loaded_state to 0, which is used elsewhere to determine
	// which state the game is in for a few things
	current_loaded_state = 0;

	// set 480 vertical resolution
	set_480();
	
	// configure screen row length
	VIC4.LINESTEP    = TITLE_LINE_LENGTH << 1;
	VIC4.CHRCOUNTLSB = TITLE_LINE_LENGTH;
	VIC4.CHRCOUNTMSB = TITLE_LINE_LENGTH >> 8;
	VIC4.DISPROWS    = TITLE_LINE_COUNT;
	
	// set tile map location
	VIC4.SCRNPTR    = TITLE_TILE_MAP & 0xffff;
	VIC4.SCRNPTRBNK = (TITLE_TILE_MAP & 0xf0000) >> 16;
	VIC4.SCRNPTRMB  = 0x0;

	// load the attribute map into $ff80000
	run_dma_job((__far char *)&load_title_attrmap);

	// set the border and screen colors to red, to match the picture
	VIC2.BORDERCOL = 28;
	VIC2.SCREENCOL = 28;
	
	// unblank the screen
	VIC2.DEN = 1;
		
	// initalize the music
	musicInit();
}

/// \brief	This procedure is called to setup for the in-game screen
///
/// This proedure blanks the screen, loads the in-game data from the attic, 
/// sets all of the register values for the in-game screen, clears the screen,
/// unblanks the screen, and initalizes the music.
void ingame_setup() {
	if (current_loaded_state == 1) return;
	
	// blank the screen
	VIC2.DEN = 0;

	// load all of the in-game data from the attic into the fast RAM
	run_dma_job((__far char *)&load_ingame_banks);

	// set current_loaded_state to 1 so other parts of the game know we're
	// in "in-game" mode.
	current_loaded_state = 1;

	// set 400 vertical resolution
	set_400();

	// configure screen row length
	VIC4.LINESTEP    = INGAME_LINE_LENGTH << 1;
	VIC4.CHRCOUNTLSB = INGAME_LINE_LENGTH;
	VIC4.CHRCOUNTMSB = INGAME_LINE_LENGTH >> 8;
	VIC4.DISPROWS    = INGAME_LINE_COUNT;
	
	// set tile map location
	VIC4.SCRNPTR    = INGAME_TILE_MAP_STORE & 0xffff;
	VIC4.SCRNPTRBNK = (INGAME_TILE_MAP_STORE & 0xf0000) >> 16;
	VIC4.SCRNPTRMB  = 0x0;

	// copy the default screen layout to the working layout memory
	run_dma_job((__far char *)&clear_ingame_tilemap);
	// copy the attribute map to $ff80000
	run_dma_job((__far char *)&load_ingame_attrmap);

	// set the border and screen color to white
	VIC2.BORDERCOL = 23;
	VIC2.SCREENCOL = 23;
	
	// unblank the screen
	VIC2.DEN = 1;
	
	// initalize the music
	musicInit();
}

void levelcomplete_setup() {
	if (current_loaded_state == 3) return;
	
	// load all of the in-game data from the attic into the fast RAM
	run_dma_job((__far char *)&load_level_complete_bank[0]);
	
	current_loaded_state = 3;
}

/// \brief	This procedure is called to setup for game over
///
/// This simple procedure only loads the data for game over, which is just a
/// couple of samples that were too big to fit in the fast RAM during in-game
void gameover_setup() {
	if (current_loaded_state == 2) return;
	
	// load the game over sound effects
	run_dma_job((__far char *)&load_game_over_banks);
	
	// and set the current_loaded_state to game over, which is not explicitly
	// tested for anywhere, but distinguishes itself from the title screen and
	// the in-game mode, so I still set it.
	current_loaded_state = 2;
}


/// \brief	This procedure loads the data needed to display the loader screen
///
/// This procedure does the minimal work necessary to show the loader screen
void load_loader() {
	// initalize the fast loader system
	fl_init();
	// and set it to waiting
	fl_waiting();
	
	// then set Mirage's IFFL to load from the first (of two) data files.  this
	// is necessary because there is a limit in the IFFL format of no more than
	// 32 files, and we use more than that here.
	floppy_iffl_fast_load_init("+UNICONE0");
	
	// load the palette.  this is only done once, as the same palette is used
	// throughout the entire game
	floppy_iffl_fast_load();
	run_dma_job((__far char *)&load_palette);
	
	// set the border and screen color to the same red as the loading screen
	VIC2.BORDERCOL = 28;
	VIC2.SCREENCOL = 28;
	
	// load "loading" screen tilemap parts 0 and 1
	for (char i = 0; i < 2; i++) {
		floppy_iffl_fast_load();
	}
	
	// move part 1 into the correct location
	// the job name suggests it is multipart, but its true purpose is because
	// the tile set needs to be multipart, and it is more effective to load the
	// second half into bank 1 first, and then copy it into $0038000.
	run_dma_job((__far char *)&move_tileset_3b);
	
	// load "loading" screen tilemap parts 2 and 3
	for (char i = 0; i < 2; i++) {
		floppy_iffl_fast_load();
	}
	
	// move parts 2 and 3 into the correct location
	// see above for why there's only a "b" job.
	run_dma_job((__far char *)&move_tileset_4b);
	
	// load "loading" screen tilemap part 4, tile map and attribute map
	for (char i = 0; i < 3; i++) {
		floppy_iffl_fast_load();
	}
	
}

/// \brief	This procedure loads all the rest of the game data into the attic
///
/// This procedure loads all the rest of the data into bank $001 for staging,
/// then copies the data from there into the attic RAM where it will be stored
/// until we need it.
void load_rest() {
	// load the music switchboard
	floppy_iffl_fast_load();

	
	// ------------------------
	// TITLE SCREEN DATA LOADER
	// ------------------------

	// load the title music
	floppy_iffl_fast_load();
	run_dma_job((__far char *)&backup_title_bank_1);
	
	// load the title screen tileset 1 and 2 of 3;
	floppy_iffl_fast_load();
	run_dma_job((__far char *)&backup_title_bank_3a);
	floppy_iffl_fast_load();
	run_dma_job((__far char *)&backup_title_bank_3b);
	floppy_iffl_fast_load();
	run_dma_job((__far char *)&backup_title_bank_4a);
	floppy_iffl_fast_load();
	run_dma_job((__far char *)&backup_title_bank_4b);
	
	// load the title screen tileset 3 of 3, tilemap and attrmap
	for (char i = 0; i < 4; i++) {
		floppy_iffl_fast_load();
	}
	run_dma_job((__far char *)&backup_title_bank_5);
	
	floppy_iffl_fast_load();
	run_dma_job((__far char *)&backup_level_complete_bank_3);
	
	// end of first data file, close it
	fl_exit();
	
	// and open the second of two data files.  see above for why
	floppy_iffl_fast_load_init("+UNICONE1");

	
	// -------------------
	// IN-GAME DATA LOADER
	// -------------------
	
	// load the in-game music, tileset, tile map, and flavors palettes
	for (char i = 0; i < 4; i++) {
		floppy_iffl_fast_load();
	}

	// load the titlescreen attribute map to $ff80000 - we have to do this
	// again, because there's some bug that stomps on the attribute map data,
	// causing the very top of the "d" in "loading" to flip horizontally.
	//
	// for future use - $001f800 is an area of memory which cannot be used.  In
	// this case, I don't fully get what's happening as I'm not actually
	// touching that memory, but I think that maybe the IFFL loader might be
	// writing values there, as the bug triggers during a call to
	// floppy_iffl_fast_load.
	//
	// this can be fixed using COLPTR and setting the offset to $0800, but this
	// would also offset the attribute map at $ff8000, and since this 
	// workaround fixed the issue, I would rather not risk any potential
	// cascading errors that might be caused by offset $ff8000 since that is
	// a very core part of the game, and I have no idea what all could break
	// from moving that.
	//
	// in the future, though, it may be desirable to set COLPTR to $0800 and 
	// sacrifice that 2KiB of the real attribute map, since 32KiB is literally
	// more than we can possibly use for maps.
	run_dma_job((__far char *)&load_loader_attrmap);

	run_dma_job((__far char *)&backup_ingame_bank_1);
	
	// load the in-game sound effects for game start, trot and splat 1
	for (char i = 0; i < 3; i++) {
		floppy_iffl_fast_load();
	}
	run_dma_job((__far char *)&backup_ingame_bank_2);
	
	// load the in-game sound effects for falling and splat 2
	floppy_iffl_fast_load();
	floppy_iffl_fast_load();
	run_dma_job((__far char *)&backup_ingame_bank_3);
	
	// load the in-game backdrop tileset part 1 of 2
	floppy_iffl_fast_load();
	run_dma_job((__far char *)&backup_ingame_bank_4a);
	//floppy_iffl_fast_load();
	//run_dma_job((__far char *)&backup_ingame_bank_4b);
	
	// load the in-game backdrop tileset part 2 of 2 and sound effect splat 3
	//floppy_iffl_fast_load();
	floppy_iffl_fast_load();
	run_dma_job((__far char *)&backup_ingame_bank_5);

	
	// ---------------------
	// GAME OVER DATA LOADER
	// ---------------------

	// load the game over sound effects for game over 1 and the in-game 
	// attributes map
	floppy_iffl_fast_load();
	floppy_iffl_fast_load();
	run_dma_job((__far char *)&backup_game_over_bank_2);
	
	// load the game over sound effects for game over 2 and the game over logo
	floppy_iffl_fast_load();
	floppy_iffl_fast_load();
	run_dma_job((__far char *)&backup_game_over_bank_3);
	
	fl_exit();
}


/// \brief	This procedure sets the vertical resolution to 480 pixels
///
/// This procedure sets the top and bottom border positions to allow 480 pixels
/// to be displayed.
void set_480() {
	// set 480 vertical resolution - this is video standard dependent.
	if (VIC4.PALNTSC) {
		VIC4.TBDRPOSLSB  = 0x01;	// defaults to $37/55
		VIC4.TBDRPOSMSB  = 0;	    // defaults to $00/0
		VIC4.BBDRPOSLSB  = 0xe1;	// defaults to $c7/199
		VIC4.BBDRPOSMSB  = 0x1;	    // defaults to $01/1		(i.e. 455)
		
		VIC4.TEXTYPOSLSB = 0x01;
		VIC4.TEXTYPOSMSB = 0;
	} else {
		VIC4.TBDRPOSLSB  = 0x40;	// defaults to $68/104
		VIC4.TBDRPOSMSB  = 0;	    // defaults to $00/0
		VIC4.BBDRPOSLSB  = 0x20;	// defaults to $f8/248
		VIC4.BBDRPOSMSB  = 0x2;	    // defaults to $01/1		(i.e. 504)
		
		VIC4.TEXTYPOSLSB = 0x40;
		VIC4.TEXTYPOSMSB = 0;
	}
}

/// \brief	This procedure sets the vertical resolution to 400 pixels
///
/// This procedure sets the top and bottom border positions to allow 400 pixels
/// to be displayed.
void set_400() {
	// set 400 vertical resolution - this is video standard dependent.
	if (VIC4.PALNTSC) {
		VIC4.TBDRPOSLSB  = 0x37;	// defaults to $37/55
		VIC4.TBDRPOSMSB  = 0;	    // defaults to $00/0
		VIC4.BBDRPOSLSB  = 0xc7;	// defaults to $c7/199
		VIC4.BBDRPOSMSB  = 0x1;	    // defaults to $01/1		(i.e. 455)
		
		VIC4.TEXTYPOSLSB = 0x37;
		VIC4.TEXTYPOSMSB = 0;
	} else {
		VIC4.TBDRPOSLSB  = 0x68;	// defaults to $68/104
		VIC4.TBDRPOSMSB  = 0;	    // defaults to $00/0
		VIC4.BBDRPOSLSB  = 0xf8;	// defaults to $f8/248
		VIC4.BBDRPOSMSB  = 0x1;	    // defaults to $01/1		(i.e. 504)
		
		VIC4.TEXTYPOSLSB = 0x68;
		VIC4.TEXTYPOSMSB = 0;
	}
}


/// \brief	The raster postition where we update the screen
///
/// This variable is the raster position of the beginning of the bottom border
/// of the in-game screen, where we can safely do our updates.  It is PAL and
/// NTSC fixed.
unsigned short update_raster;
