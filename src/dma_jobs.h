/// \file	dma_jobs.h
/// 
/// \brief	This file is the header file that declares all of the DMA jobs used
///			in the game.
///
/// This header file declares every DMA job used in the game.
///
/// \copyright 2023 by BAS and deathy (AKA Clifford A. Anderson).  
/// All rights reserved.
#ifndef __DMA_JOBS_H
#define __DMA_JOBS_H


#include "dma.h"


// running jobs - title screen functional
extern dma_job_far_addresses_t   load_title_attrmap;

// running jobs - in game functional
extern dma_job_t                 clear_ingame_tilemap;

extern dma_job_t                 load_flavor[3];

extern dma_job_far_addresses_t   load_ingame_attrmap;


// loader jobs - loader screen data
extern dma_job_t                 load_palette;
extern dma_job_far_destination_t load_loader_attrmap;
extern dma_job_t                 move_tileset_3b;
extern dma_job_t                 move_tileset_4b;

// loader jobs - title screen data
extern dma_job_far_destination_t backup_title_bank_1;
extern dma_job_far_destination_t backup_title_bank_3a;
extern dma_job_far_destination_t backup_title_bank_3b;
extern dma_job_far_destination_t backup_title_bank_4a;
extern dma_job_far_destination_t backup_title_bank_4b;
extern dma_job_far_destination_t backup_title_bank_5;

// loader jobs - level complete data
extern dma_job_far_destination_t backup_level_complete_bank_3;

// loader jobs - in-game data
extern dma_job_far_destination_t backup_ingame_bank_1;
extern dma_job_far_destination_t backup_ingame_bank_2;
extern dma_job_far_destination_t backup_ingame_bank_3;
extern dma_job_far_destination_t backup_ingame_bank_4a;
extern dma_job_far_destination_t backup_ingame_bank_4b;
extern dma_job_far_destination_t backup_ingame_bank_5;

// loader jobs - game over data
extern dma_job_far_destination_t backup_game_over_bank_2;
extern dma_job_far_destination_t backup_game_over_bank_3;


// running jobs - title screen data
extern dma_job_far_source_t load_title_banks[4];

// running jobs - in-game data
extern dma_job_far_source_t load_ingame_banks[5];

// running jobs - game over data
extern dma_job_far_source_t load_game_over_banks[2];

// running jobs - level complete data
extern dma_job_far_source_t load_level_complete_bank[1];


#endif