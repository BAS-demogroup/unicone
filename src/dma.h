#ifndef __DMA_H
#define __DMA_H

typedef struct _dma_copy_job                  dma_copy_job_t;
typedef struct _dma_copy_job_huge_source      dma_copy_job_huge_source_t;
typedef struct _dma_copy_job_huge_destination dma_copy_job_huge_destination_t;

struct _dma_copy_job {
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

struct _dma_copy_job_huge_source {
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

struct _dma_copy_job_huge_destination {
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

void run_dma_job(__far char *ptr);

#endif
