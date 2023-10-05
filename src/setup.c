#include "setup.h"


#include "chips.h"
//#include "mega65_io.h"
#include "macros.h"
#include "constants.h"
#include <calypsi/intrinsics6502.h>


void setup() {
	__disable_interrupts();
	
	// set the speed to 40MHz
	CPU.PORTDDR = 65;

	CPU.PORTDDR = 0b00000111;
	CPU.PORT    = 0b00000101;
	
	// disable CIA interrupts
	CIA1.TA   = 1;
	CIA1.TB   = 1;
	CIA1.ALRM = 1;
	CIA1.SP   = 1;
	CIA1.FLG  = 1;
	CIA1.IR   = 0;

	CIA2.NMISIG = 15;
	CIA2.NMIIRQ = 15;

	CIA1.IR;
	CIA2.NMISIG;
	
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
	
	// conigure PAL or NTSC
	if(VIC4.PALNTSC) {
		VIC4.PALNTSC = 1;
	} else {
		VIC4.PALNTSC = 0;
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
	VIC4.LINESTEPLSB = LINE_LENGTH << 1;
	VIC4.CHRCOUNTLSB = LINE_LENGTH;
	VIC4.LINESTEPMSB = LINE_LENGTH >> 7;
	VIC4.CHRCOUNTMSB = LINE_LENGTH >> 8;
	VIC4.DISPROWS    = LINE_COUNT;
	
	// load attributes map
	// set tile map location
	// backup the maps for resetting
	// load the color palette
	
	// enable rrb double buffering
	VIC4.NORRDEL = 0;
	
	// enable 400 vertical height
	VIC3.V400    = 1;
	VIC4.CHRYSCL = 0;
	
	// disable double-height rrb
	VIC4.DBLRR = 0;
	
	// initalize the music
	musicInit();
}

// load all the data from the IFFL
void load() {
}
