#ifndef __DMA_JOBS_H
#define __DMA_JOBS_H


#include "dma.h"


// running jobs - title screen functional
extern dma_job_far_addresses_t   load_title_attrmap;

// running jobs - in game functional
extern dma_job_t                 clear_ingame_tilemap;
extern dma_job_t                 load_flavor_red;
extern dma_job_t                 load_flavor_green;
extern dma_job_t                 load_flavor_blue;
extern dma_job_far_addresses_t   load_ingame_attrmap;


// loader jobs - loader screen data
extern dma_job_t                 load_palette;
extern dma_job_far_destination_t load_loader_attrmap;
extern dma_job_t                 move_tilemap_3b;
extern dma_job_t                 move_tilemap_4b;

// loader jobs - title screen data
extern dma_job_far_destination_t backup_title_bank_1;
extern dma_job_far_destination_t backup_title_bank_3a;
extern dma_job_far_destination_t backup_title_bank_3b;
extern dma_job_far_destination_t backup_title_bank_4a;
extern dma_job_far_destination_t backup_title_bank_4b;
extern dma_job_far_destination_t backup_title_bank_5;

// loader jobs - in-game data
extern dma_job_far_destination_t backup_ingame_bank_1;
extern dma_job_far_destination_t backup_ingame_bank_2a;
extern dma_job_far_destination_t backup_ingame_bank_2b;
extern dma_job_far_destination_t backup_ingame_bank_3;
extern dma_job_far_destination_t backup_ingame_bank_4a;
extern dma_job_far_destination_t backup_ingame_bank_4b;
extern dma_job_far_destination_t backup_ingame_bank_5;

// loader jobs - game over data
extern dma_job_far_destination_t backup_game_over_bank_2;
extern dma_job_far_destination_t backup_game_over_bank_3;


// for running jobs, look into chaining them if I can make the data work
// running jobs - title screen data
extern dma_job_far_source_t load_title_bank_1;
extern dma_job_far_source_t load_title_bank_3;
extern dma_job_far_source_t load_title_bank_4;
extern dma_job_far_source_t load_title_bank_5;

// running jobs - in-game data
extern dma_job_far_source_t load_ingame_bank_1;
extern dma_job_far_source_t load_ingame_bank_2;
extern dma_job_far_source_t load_ingame_bank_3;
extern dma_job_far_source_t load_ingame_bank_4;
extern dma_job_far_source_t load_ingame_bank_5;

// running jobs - game over data
extern dma_job_far_source_t load_game_over_bank_2;
extern dma_job_far_source_t load_game_over_bank_3;

#endif