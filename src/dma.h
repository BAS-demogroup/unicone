#ifndef _DMA_H
#define _DMA_H

typedef struct _dma_copy_job dma_copy_job_t;
typedef struct _dma_copy_job_huge_source dma_copy_job_huge_source_t;
typedef struct _dma_copy_job_huge_destination dma_copy_job_huge_destination_t;

struct _dma_copy_job {
	char type;
	char end_options;
	char command;
	unsigned short count;
	unsigned short source;
	union {
		char source_bank      : 4;
		char source_hold      : 1;
		char source_modulo    : 1;
		char source_direction : 1;
		char source_io        : 1;
	};
	unsigned short destination;
	union {
		char destination_bank      : 4;
		char destination_hold      : 1;
		char destination_modulo    : 1;
		char destination_direction : 1;
		char destination_io        : 1;
	};
	unsigned short modulo;
};

struct _dma_copy_job_huge_source {
	char type;
	char sbank_token;
	char sbank;
	char end_options;
	char command;
	unsigned short count;
	unsigned short source;
	union {
		char source_bank      : 4;
		char source_hold      : 1;
		char source_modulo    : 1;
		char source_direction : 1;
		char source_io        : 1;
	};
	unsigned short destination;
	union {
		char destination_bank      : 4;
		char destination_hold      : 1;
		char destination_modulo    : 1;
		char destination_direction : 1;
		char destination_io        : 1;
	};
	unsigned short modulo;
};

struct _dma_copy_job_huge_destination {
	char type;
	char dbank_token;
	char dbank;
	char end_options;
	char command;
	unsigned short count;
	unsigned short source;
	union {
		char source_bank      : 4;
		char source_hold      : 1;
		char source_modulo    : 1;
		char source_direction : 1;
		char source_io        : 1;
	};
	unsigned short destination;
	union {
		char destination_bank      : 4;
		char destination_hold      : 1;
		char destination_modulo    : 1;
		char destination_direction : 1;
		char destination_io        : 1;
	};
	unsigned short modulo;
};

void dma_run_job(__far char *ptr);

#endif