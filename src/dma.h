/// \file	dma.h
/// 
/// \brief	This file is the header file for the code used to create and 
///			execute DMA jobs.
///
/// This header file defines the procedures and structures that are used to
/// create and execute DMA jobs
///
/// \copyright 2023 by BAS and deathy (AKA Clifford A. Anderson).  
/// All rights reserved.
#ifndef __DMA_H
#define __DMA_H

/// \brief	The type definition for a simple DMA job
typedef struct _dma_job                 dma_job_t;
/// \brief	The type definition for a DMA job that has a source in upper memory
typedef struct _dma_job_far_source      dma_job_far_source_t;
/// \brief	The type definition for a DMA job that has a destination in upper
///			memory
typedef struct _dma_job_far_destination dma_job_far_destination_t;
/// \brief	The type definition for a DMA job that has both a source and a 
///			destination in upper memory
typedef struct _dma_job_far_addresses   dma_job_far_addresses_t;

/// \brief	The struct for a simple DMA job
/// 
/// This struct is used for a simple DMA job, that only works in fast RAM
struct _dma_job {
	char           type;
	char           end_options;
	char           command;
	unsigned short count;
	unsigned short source;
	char           source_bank;
	unsigned short destination;
	char           destination_bank;
	unsigned short modulo;
};

/// \brief	The struct for a DMA job that has a source in upper memory.
/// 
/// This struct is used for a DMA job that has a source outside the fast RAM,
/// in upper memory.
struct _dma_job_far_source {
	char           type;
	char           sbank_token;
	char           sbank;
	char           end_options;
	char           command;
	unsigned short count;
	unsigned short source;
	char           source_bank;
	unsigned short destination;
	char           destination_bank;
	unsigned short modulo;
};

/// \brief	The struct for a DMA job that has a destination in upper memory.
/// 
/// This struct is used for a DMA job that has a destination outside the fast 
/// RAM, in upper memory.
struct _dma_job_far_destination {
	char           type;
	char           dbank_token;
	char           dbank;
	char           end_options;
	char           command;
	unsigned short count;
	unsigned short source;
	char           source_bank;
	unsigned short destination;
	char           destination_bank;
	unsigned short modulo;
};

/// \brief	The struct for a DMA job that has both a source and destination in
///			upper memory.
/// 
/// This struct is used for a DMA job where both the source and the destination
/// are outside the fast RAM, in upper memory.
struct _dma_job_far_addresses {
	char           type;
	char           sbank_token;
	char           sbank;
	char           dbank_token;
	char           dbank;
	char           end_options;
	char           command;
	unsigned short count;
	unsigned short source;
	char           source_bank;
	unsigned short destination;
	char           destination_bank;
	unsigned short modulo;
};

void run_dma_job(__far char *ptr);

#endif
