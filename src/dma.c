#include "dma.h"


#include "chips.h"


void dma_run_job(__far char *ptr) {
	DMA.ADDRMB = 0;	// Is there EVER a case where MB can be anything but 0?  As
					// far as I know, DMA jobs can't be stores in the attic and
					// run from there.
	DMA.ADDRBANK = (char)((unsigned long)ptr >> 16);
	DMA.ADDRMSB = (char)((unsigned long)ptr >> 8);
	DMA.ETRIG = (char)((unsigned long)ptr & 0xff);
}
