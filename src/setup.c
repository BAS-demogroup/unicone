#include "setup.h"


#include <calypsi/intrinsics6502.h>


#include "chips.h"
#include "constants.h"
#include "dma.h"
#include "dma_jobs.h"
#include "gameloop.h"
#include "macros.h"
#include "maps.h"


#include "iffl/iffl.h"
#include "iffl/irqload.h"


void setup() {
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

	// disable RAM protection in banks 2 and 3
	poke(0xD640, 0x70);		// $d640 = HTRAP00
	__no_operation();		// clv would be better

	// Enable the VIC4
	VIC3.KEY = 0x47;
	VIC3.KEY = 0x53;
	
	VIC2.BORDERCOL = 0;
	VIC2.SCREENCOL = 0;
	
	load();
	
	// clear the screens
	run_dma_job((__far char *)&clear_tilemap);
	run_dma_job((__far char *)&clear_attrmap);
	run_dma_job((__far char *)&pageflip_attrmap);
	
	// conigure PAL or NTSC
	if(VIC4.PALNTSC) {
		VIC4.PALNTSC = 1;
		matrix_raster = 0x180;
	} else {
		VIC4.PALNTSC = 0;
		matrix_raster = 0x1b0;
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
	VIC2.MCM = 1;
	
	// configure screen row length
	VIC4.LINESTEP = LINE_LENGTH << 1;
	VIC4.CHRCOUNTLSB = LINE_LENGTH;
	VIC4.CHRCOUNTMSB = LINE_LENGTH >> 8;
	VIC4.DISPROWS    = LINE_COUNT;
	
	// set tile map location
	VIC4.SCRNPTR = TILE_MAP_STORE & 0xffff;
	VIC4.SCRNPTRBNK = (TILE_MAP_STORE & 0xf0000) >> 16;
	VIC4.SCRNPTRMB = 0x0;
	
	// load the color palette
	run_dma_job((__far char *)&load_palette);
	
	// enable rrb double buffering
	VIC4.NORRDEL = 0;
	
	// enable 400 vertical height
	VIC3.V400    = 1;
	VIC4.CHRYSCL = 0;
	
	// disable double-height rrb
	VIC4.DBLRR = 0;
	
	// bank the music in
	__asm(" lda #0xc0\n"
		  " tax\n"
		  " tay\n"
		  " ldz #0x30\n"
		  " map\n"
		  " nop");
	
	// initalize the music
	musicInit();
	
	// restore the original bank configuration
	__asm(" lda #0x00\n"
		  " tax\n"
		  " tay\n"
		  " taz\n"
		  " map\n"
		  " nop");
}

// load all the data from the IFFL
void load() {
	fl_init();
	fl_waiting();
	floppy_iffl_fast_load_init("+UNICONE");
	for (char i = 0; i < 5; i++) {
		floppy_iffl_fast_load();
	}
	fl_exit();
}
