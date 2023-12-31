/// \file	dma.c
/// 
/// \brief	This file is the c file for the code used to execute DMA jobs.
///
/// This c file contains the code for the procedure that is used to execute DMA 
/// jobs
///
/// \copyright 2023 by BAS and deathy (AKA Clifford A. Anderson).  
/// All rights reserved.
#include "dma.h"


#include "chips.h"


/// \brief	This procedure is called to execute a DMA job
///
/// This procedure is called to execute a DMA job.
///
/// \param	ptr	A pointer to the job to execute.
void run_dma_job(__far char *ptr) {
	// set the MB
	DMA.ADDRMB   = 0;
					  
	// set the bank of our DMA job
	DMA.ADDRBANK = (char)((unsigned long)ptr >> 16);
	// point to the MSB of the job
	DMA.ADDRMSB  = (char)((unsigned long)ptr >> 8);
	// point to the LSB of the job, and then trigger the job
	DMA.ETRIG    = (char)((unsigned long)ptr & 0xff);
}
