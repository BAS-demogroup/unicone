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


void setup() {
	// __disable_interrupts();
	
	// // set the speed to 40MHz
	// CPU.PORTDDR = 65;

	// CPU.PORTDDR = 0b00000111;
	// CPU.PORT    = 0b00000101;
	
	// // disable CIA interrupts
	// CIA1.ICR = 0b01111111;
	// CIA2.ICR = 0b01111111;

	// CIA1.ICR;
	// CIA2.ICR;
	
	// // map I/O (Mega65 memory mapping)
	// VIC3.ROM8  = 0;
	// VIC3.ROMA  = 0;
	// VIC3.ROMC  = 0;
	// VIC3.CROM9 = 0;
	// VIC3.ROME  = 0;

	// __asm(" lda #0x00\n"
		  // " tax\n"
		  // " tay\n"
		  // " taz\n"
		  // " map\n"
		  // " nop");

	// // Enable the VIC4
	// VIC3.KEY = 0x47;
	// VIC3.KEY = 0x53;
	
	// // disable RAM protection in banks 2 and 3
	// poke(0xD640, 0x70);		// $d640 = HTRAP00
	// __no_operation();		// clv would be better
	
	// load();
	
	// clear the screens
	//run_dma_job((__far char *)&clear_tilemap);
	run_dma_job((__far char *)&load_ingame_attrmap);
	
	// // conigure PAL or NTSC
	// if(VIC4.PALNTSC) {
		// VIC4.PALNTSC  = 1;
		// matrix_raster = 0x1c6;
	// } else {
		// VIC4.PALNTSC  = 0;
		// matrix_raster = 0x1f7;
	// }
	
	// // disable raster interrupts
	// VIC4.FNRST    = 0;
	// VIC4.FNRSTCMP = 0;
	
	// // enable 640 horizontal width
	// VIC3.H640 = 1;
	
	// // disable hot registers
	// VIC4.HOTREG = 0;
	
	// // use wide character lookup (i.e. character data anywhere in memory)
	// VIC4.CHR16 = 1;
	
	// // set multicolor mode - allows use of both color palettes
	// VIC2.MCM = 1;
	
	// configure screen row length
	VIC4.LINESTEP    = LINE_LENGTH << 1;
	VIC4.CHRCOUNTLSB = LINE_LENGTH;
	VIC4.CHRCOUNTMSB = LINE_LENGTH >> 8;
	VIC4.DISPROWS    = LINE_COUNT;
	
	// set tile map location
	VIC4.SCRNPTR    = TILE_MAP_STORE & 0xffff;
	VIC4.SCRNPTRBNK = (TILE_MAP_STORE & 0xf0000) >> 16;
	VIC4.SCRNPTRMB  = 0x0;
	
	// // load the color palette
	// run_dma_job((__far char *)&load_palette);
	
	// // enable rrb double buffering
	// VIC4.NORRDEL = 0;
	
	// enable 400 vertical height
	VIC3.V400    = 1;
	VIC4.CHRYSCL = 0;
	
	// // disable double-height rrb
	// VIC4.DBLRR = 0;

	VIC2.BORDERCOL = 23;
	VIC2.SCREENCOL = 23;
	
	muted = 0;
	next_channel = 0;
	current_loaded_state = 0;
	
	// poke(0xd711,0b10000000);
}

void run_loader() {
	__disable_interrupts();
	
	// set the speed to 40MHz
	CPU.PORTDDR = 65;

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

	VIC2.DEN = 0;
	
	load_loader();
	
	run_dma_job((__far char *)&load_loader_attrmap);
	
	// conigure PAL or NTSC
	if(VIC4.PALNTSC) {
		VIC4.PALNTSC  = 1;
		matrix_raster = 0x1c6;
	} else {
		VIC4.PALNTSC  = 0;
		matrix_raster = 0x1f7;
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
	// TODO: This needs NTSC fixing
	VIC4.TBDRPOSLSB  = 0x40;	// defaults to $68/104
	VIC4.TBDRPOSMSB  = 0;	    // defaults to $00/0
	VIC4.BBDRPOSLSB  = 0x20;	// defaults to $f8/248
	VIC4.BBDRPOSMSB  = 0x2;	    // defaults to $01/1		(i.e. 504)
	
	VIC4.TEXTYPOSLSB = 0x40;
	VIC4.TEXTYPOSMSB = 0;
	
	// configure screen row length
	VIC4.LINESTEP    = LOADER_LINE_LENGTH << 1;
	VIC4.CHRCOUNTLSB = LOADER_LINE_LENGTH;
	VIC4.CHRCOUNTMSB = LOADER_LINE_LENGTH >> 8;
	VIC4.DISPROWS    = LOADER_LINE_COUNT;
	
	VIC4.FCLRLO = 1;
	VIC4.FCLRHI = 1;
	
	// set tile map location
	VIC4.SCRNPTR    = LOADER_TILE_MAP & 0xffff;
	VIC4.SCRNPTRBNK = (LOADER_TILE_MAP & 0xf0000) >> 16;
	VIC4.SCRNPTRMB  = 0x0;

	// enable rrb double buffering
	VIC4.NORRDEL = 0;
	
	// enable 400 vertical height
	VIC3.V400    = 1;
	VIC4.CHRYSCL = 0;
	
	VIC4.CHRXSCL = 0x78;

	// disable double-height rrb
	VIC4.DBLRR = 0;

	VIC2.DEN = 1;
	
	poke(0xd711,0b10000000);
	
	// load the rest of the data
	load_rest();
}

void title_setup() {
	VIC2.DEN = 0;

	run_dma_job((__far char *)&load_title_bank_1);
	run_dma_job((__far char *)&load_title_bank_3);
	run_dma_job((__far char *)&load_title_bank_4);
	run_dma_job((__far char *)&load_title_bank_5);
	
	current_loaded_state = 0;

	// configure screen row length
	VIC4.LINESTEP    = TITLE_LINE_LENGTH << 1;
	VIC4.CHRCOUNTLSB = TITLE_LINE_LENGTH;
	VIC4.CHRCOUNTMSB = TITLE_LINE_LENGTH >> 8;
	VIC4.DISPROWS    = TITLE_LINE_COUNT;
	
	// set tile map location
	VIC4.SCRNPTR    = TITLE_TILE_MAP & 0xffff;
	VIC4.SCRNPTRBNK = (TITLE_TILE_MAP & 0xf0000) >> 16;
	VIC4.SCRNPTRMB  = 0x0;

	run_dma_job((__far char *)&load_title_attrmap);

	VIC2.BORDERCOL = 28;
	VIC2.SCREENCOL = 28;
	
	VIC2.DEN = 1;

	musicInit();
}

void ingame_setup() {
}

void load_loader() {
	fl_init();
	fl_waiting();
	
	floppy_iffl_fast_load_init("+UNICONE0");
	
	// load the palette
	floppy_iffl_fast_load();
	
	run_dma_job((__far char *)&load_palette);
	
	VIC2.BORDERCOL = 28;
	VIC2.SCREENCOL = 28;
	
	// load "loading" screen tilemap parts 0 and 1
	for (char i = 0; i < 2; i++) {
		floppy_iffl_fast_load();
	}
	
	// move part 1 into the correct location
	run_dma_job((__far char *)&move_tilemap_3b);
	
	// load "loading" screen tilemap parts 2 and 3
	for (char i = 0; i < 2; i++) {
		floppy_iffl_fast_load();
	}
	
	// move part 1 into the correct location
	run_dma_job((__far char *)&move_tilemap_4b);
	
	// load "loading" screen tilemap part 4, tile map and attribute map
	for (char i = 0; i < 3; i++) {
		floppy_iffl_fast_load();
	}
	
}

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
	
	run_dma_job((__far char *)&clear_bank_1);
	// load the title screen tileset 3 of 3, tilemap and attrmap
	for (char i = 0; i < 4; i++) {
		floppy_iffl_fast_load();
	}
	run_dma_job((__far char *)&backup_title_bank_5);
	
	// -------------------
	// IN-GAME DATA LOADER
	// -------------------
	
	// load the in-game music, tileset, tile map, and flavors palettes
	for (char i = 0; i < 4; i++) {
		floppy_iffl_fast_load();
	}
	run_dma_job((__far char *)&backup_ingame_bank_1);
	
	// load the in-game sound effects for game start, trot and splat 1
	for (char i = 0; i < 3; i++) {
		floppy_iffl_fast_load();
	}
	run_dma_job((__far char *)&backup_ingame_bank_2a);
	
	// load the in-game sound effect splat 2
	floppy_iffl_fast_load();
	run_dma_job((__far char *)&backup_ingame_bank_2b);
	
	// load the in-game sound effects for falling and splat 3
	floppy_iffl_fast_load();
	floppy_iffl_fast_load();
	run_dma_job((__far char *)&backup_ingame_bank_3);
	
	// load the in-game backdrop tileset part 1 of 2
	// floppy_iffl_fast_load();
	// run_dma_job((__far char *)&backup_ingame_bank_4);
	
	// load the in-game backdrop tileset part 2 of 2 and the attribute map
	// floppy_iffl_fast_load();
	floppy_iffl_fast_load();
	run_dma_job((__far char *)&backup_ingame_bank_5);
	
	// ---------------------
	// GAME OVER DATA LOADER
	// ---------------------
	
	fl_exit();
	
	floppy_iffl_fast_load_init("+UNICONE1");
	// load the game over sound effects for game over 1
	floppy_iffl_fast_load();
	run_dma_job((__far char *)&backup_game_over_bank_2);
	
	// load the game over sound effects for game over 2
	floppy_iffl_fast_load();
	run_dma_job((__far char *)&backup_game_over_bank_3);
	
	fl_exit();
}
