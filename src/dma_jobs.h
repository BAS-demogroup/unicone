#ifndef __DMA_JOBS_H
#define __DMA_JOBS_H


#include "dma.h"


extern dma_copy_job_t                  clear_tilemap;
extern dma_copy_job_t                  load_palette;
extern dma_copy_job_t                  load_flavor_red;
extern dma_copy_job_t                  load_flavor_green;
extern dma_copy_job_t                  load_flavor_blue;

extern dma_copy_job_huge_destination_t load_attrmap;

extern dma_copy_job_huge_destination_t backup_runtime_samples_1;
extern dma_copy_job_huge_destination_t backup_runtime_samples_2;
extern dma_copy_job_huge_destination_t backup_game_over_samples_1;
extern dma_copy_job_huge_destination_t backup_game_over_samples_2;

extern dma_copy_job_huge_source_t load_runtime_samples_1;
extern dma_copy_job_huge_source_t load_runtime_samples_2;
extern dma_copy_job_huge_source_t load_game_over_samples_1;
extern dma_copy_job_huge_source_t load_game_over_samples_2;

#endif