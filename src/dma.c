#include "dma.h"


#include "chips.h"


/// \brief	This procedure is called to execute a DMA job
///
/// This procedure is called to execute a DMA job.  At this time, it will only
/// execute a DMA job in bank 0.
///
/// \param	A pointer to the job to execute.
void run_dma_job(__far char *ptr) {
	DMA.ADDRMB   = 0; // Is there EVER a case where MB can be anything but 0?  
					  // As far as I know, DMA jobs can't be stores in the attic 
					  // and run from there.
					  
	// set the bank of our DMA job
	DMA.ADDRBANK = (char)((unsigned long)ptr >> 16);
	// point to the MSB of the job
	DMA.ADDRMSB  = (char)((unsigned long)ptr >> 8);
	// point to the LSB of the job, and then trigger the job
	DMA.ETRIG    = (char)((unsigned long)ptr & 0xff);
}
