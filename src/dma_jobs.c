/// \file	dma_jobs.c
/// 
/// \brief	This file is the c file that defines all of the DMA jobs used
///			in the game.
///
/// This header file defines every DMA job used in the game.
///
/// \copyright 2023 by BAS and deathy (AKA Clifford A. Anderson).  
/// All rights reserved.
#include "dma_jobs.h"


#include "constants.h"


// running jobs - title screen functional

/// \brief	This job loads the attribute map for the title screen
///
/// This job copies the attribute map for the title screen from the address 
/// pointed to by TITLE_ATTR_MAP to $ff8000, copying a total of 
/// TITLE_MAP_LENGTH bytes.
dma_job_far_addresses_t load_title_attrmap = {
	.type				= 0x0a,
	.sbank_token		= 0x80,
	.sbank				= (TITLE_ATTR_MAP & 0xff00000) >> 20,
	.dbank_token		= 0x81,
	.dbank				= 0xff,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= TITLE_MAP_LENGTH,
	.source				= TITLE_ATTR_MAP & 0xffff,
	.source_bank		= (TITLE_ATTR_MAP & 0xf0000) >> 16,
	.destination		= 0x0000,
	.destination_bank	= 0x08,
	.modulo				= 0x0000
};

// running jobs - in game functional

/// \brief	This job loads the tile map into the working storage
///
/// This job copies the tile map from the address pointed to by 
/// INGAME_TILE_MAP_BAK to the working tile map storage space pointed to by
/// INGAME_TILE_MAP_STORE, copying a total of INGAME_MAP_LENGTH bytes.
dma_job_t clear_ingame_tilemap = {
	.type				= 0x0a,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= INGAME_MAP_LENGTH,
	.source				= (INGAME_TILE_MAP_BAK & 0xffff),
	.source_bank		= ((INGAME_TILE_MAP_BAK & 0xf0000) >> 16),
	.destination		= INGAME_TILE_MAP_STORE & 0xffff,
	.destination_bank	= (INGAME_TILE_MAP_STORE & 0xf0000) >> 16,
	.modulo				= 0x0000
};

/// \brief	This job loads a specific flavor onto the palette
///
/// This job is used to load the current level's flavor into the first slice of 
/// the palette
dma_job_t load_flavor[3] = {
	{
		.type				= 0x0a,
		.end_options		= 0x00,
		.command			= 0x04,
		.count				= 0x0010,
		.source				= (FLAVORS_RED & 0xffff),
		.source_bank		= ((FLAVORS_RED & 0xf0000) >> 16),
		.destination		= 0xd100,
		.destination_bank	= 0b10000000,	// bit 7 = copy to io, thus loading the palette
		.modulo				= 0x0000
	},
	{
		.type				= 0x0a,
		.end_options		= 0x00,
		.command			= 0x04,
		.count				= 0x0010,
		.source				= (FLAVORS_GREEN & 0xffff),
		.source_bank		= ((FLAVORS_GREEN & 0xf0000) >> 16),
		.destination		= 0xd200,
		.destination_bank	= 0b10000000,	// bit 7 = copy to io, thus loading the palette
		.modulo				= 0x0000
	},
	{
		.type				= 0x0a,
		.end_options		= 0x00,
		.command			= 0x00,
		.count				= 0x0010,
		.source				= (FLAVORS_BLUE & 0xffff),
		.source_bank		= ((FLAVORS_BLUE & 0xf0000) >> 16),
		.destination		= 0xd300,
		.destination_bank	= 0b10000000,	// bit 7 = copy to io, thus loading the palette
		.modulo				= 0x0000
	}
};

/// \brief	This job loads the attribute map for the in-game screen
///
/// This job copies the attribute map for the in-game screen from the address 
/// pointed to by INGAME_ATTR_MAP_BAK to $ff8000, copying a total of 
/// INGAME_MAP_LENGTH bytes.
dma_job_far_addresses_t load_ingame_attrmap = {
	.type				= 0x0a,
	.sbank_token		= 0x80,
	.sbank				= (INGAME_ATTR_MAP_BAK & 0xff00000) >> 20,
	.dbank_token		= 0x81,
	.dbank				= 0xff,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= INGAME_MAP_LENGTH,
	.source				= INGAME_ATTR_MAP_BAK & 0xffff,
	.source_bank		= (INGAME_ATTR_MAP_BAK & 0xf0000) >> 16,
	.destination		= 0x0000,
	.destination_bank	= 0x08,
	.modulo				= 0x0000
};


// loader jobs - loader screen data

/// \brief	This job loads the full palette
///
/// This job copies the full palette from PALETTE_STORE into the VIC4 palette
/// memory, at $d100.
dma_job_t load_palette = {
	.type				= 0x0a,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x0300,
	.source				= (PALETTE_STORE & 0xffff),
	.source_bank		= ((PALETTE_STORE & 0xf0000) >> 16),
	.destination		= 0xd100,
	.destination_bank	= 0b10000000,	// bit 7 = copy to io, thus loading the palette
	.modulo				= 0x0000
};

/// \brief	This job loads the attribute map for the loader screen
///
/// This job copies the attribute map from the memory address pointed to by
/// LOADER_ATTR_MAP to the attribute map memory at $ff8000.  It copies 
/// LOADER_MAP_LENGTH bytes.
dma_job_far_destination_t load_loader_attrmap = {
	.type				= 0x0a,
	.dbank_token		= 0x81,
	.dbank				= 0xff,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= LOADER_MAP_LENGTH,
	.source				= LOADER_ATTR_MAP & 0xffff,
	.source_bank		= (LOADER_ATTR_MAP & 0xf0000) >> 16,
	.destination		= 0x0000,
	.destination_bank	= 0x08,
	.modulo				= 0x0000
};

/// \brief This job loads part 2 of the tileset data
///
/// This job copies the second part of the tileset data from $0010000 to 
/// $0038000.  This is necessary because that data had to be split because the
/// IFFL system does not always handle loading entire banks in one go.
dma_job_t move_tileset_3b = {
	.type				= 0x0a,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x8000,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0x8000,
	.destination_bank	= 0x03,
	.modulo				= 0x0000
};

/// \brief This job loads part 4 of the tileset data
///
/// This job copies the fourth part of the tileset data from $0010000 to 
/// $0048000.  This is necessary because that data had to be split because the
/// IFFL system does not always handle loading entire banks in one go.
dma_job_t move_tileset_4b = {
	.type				= 0x0a,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x8000,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0x8000,
	.destination_bank	= 0x04,
	.modulo				= 0x0000
};


// loader jobs - title screen data

/// \brief	This job stores title screen bank 1 data to the attic
///
/// This job copies the loaded data for the title screen from $0010000 to the
/// attic RAM, at $8000000, copying $2e32 bytes of data.
dma_job_far_destination_t backup_title_bank_1 = {
	.type				= 0x0a,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x2e32,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0x0000,
	.destination_bank	= 0x00,
	.modulo				= 0x0000
};

/// \brief	This job stores the first half of the title screen bank 3 data to 
///			the attic
///
/// This job copies the loaded data for the title screen from $0010000 to the
/// attic RAM, at $8010000, copying $8000 bytes of data.  As described above,
/// the bank has to be split for best IFFL results.
dma_job_far_destination_t backup_title_bank_3a = {
	.type				= 0x0a,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x8000,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0x0000,
	.destination_bank	= 0x01,
	.modulo				= 0x0000
};

/// \brief	This job stores the second half of the title screen bank 3 data to 
///			the attic
///
/// This job copies the loaded data for the title screen from $0010000 to the
/// attic RAM, at $8018000, copying $8000 bytes of data.  As described above,
/// the bank has to be split for best IFFL results.
dma_job_far_destination_t backup_title_bank_3b = {
	.type				= 0x0a,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x8000,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0x8000,
	.destination_bank	= 0x01,
	.modulo				= 0x0000
};

/// \brief	This job stores the first half of the title screen bank 4 data to 
///			the attic
///
/// This job copies the loaded data for the title screen from $0010000 to the
/// attic RAM, at $8020000, copying $8000 bytes of data.  As described above,
/// the bank has to be split for best IFFL results.
dma_job_far_destination_t backup_title_bank_4a = {
	.type				= 0x0a,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x8000,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0x0000,
	.destination_bank	= 0x02,
	.modulo				= 0x0000
};

/// \brief	This job stores the second half of the title screen bank 4 data to 
///			the attic
///
/// This job copies the loaded data for the title screen from $0010000 to the
/// attic RAM, at $8010000, copying $8000 bytes of data.  As described above,
/// the bank has to be split for best IFFL results.
dma_job_far_destination_t backup_title_bank_4b = {
	.type				= 0x0a,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x8000,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0x8000,
	.destination_bank	= 0x02,
	.modulo				= 0x0000
};

/// \brief	This job stores title screen bank 5 data in the attic
///
/// This job copies the loaded data for the title screen from $0010000 to the
/// attic RAM, at $8030000, copying $da80 bytes of data.
dma_job_far_destination_t backup_title_bank_5 = {
	.type				= 0x0a,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0xdf80,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0x0000,
	.destination_bank	= 0x03,
	.modulo				= 0x0000
};


// loader jobs - level complete data

/// \brief	This job stores level complete bank 5 data to the attic
///
/// This job copies the loaded data for the level complete sound effects from 
/// $0010000 to the attic RAM, at $80b0000, copying $d756 bytes of data.
dma_job_far_destination_t backup_level_complete_bank_3 = {
	.type				= 0x0a,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0xd756,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0x0000,
	.destination_bank	= 0x0b,
	.modulo				= 0x0000
};


// loader jobs - in-game data

/// \brief	This job stores in game bank 1 data to the attic
///
/// This job copies the loaded data for the in-game screen from $0010000 to the
/// attic RAM, at $8040000, copying $f580 bytes of data.
dma_job_far_destination_t backup_ingame_bank_1 = {
	.type				= 0x0a,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0xf580,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0x0000,
	.destination_bank	= 0x04,
	.modulo				= 0x0000
};

/// \brief	This job stores in game bank 2 data to the attic
///
/// This job copies the loaded data for the in-game screen from $0010000 to the
/// attic RAM, at $8050000, copying $d9ea bytes of data.
dma_job_far_destination_t backup_ingame_bank_2 = {
	.type				= 0x0a,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0xd9ea,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0x0000,
	.destination_bank	= 0x05,
	.modulo				= 0x0000
};

/// \brief	This job stores in game bank 3 data to the attic
///
/// This job copies the loaded data for the in-game screen from $0010000 to the
/// attic RAM, at $8060000, copying $e5a1 bytes of data.
dma_job_far_destination_t backup_ingame_bank_3 = {
	.type				= 0x0a,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0xe5a1,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0x0000,
	.destination_bank	= 0x06,
	.modulo				= 0x0000
};

/// \brief	This job stores the first half of the in-game screen bank 4 data to 
///			the attic
///
/// This job copies the loaded data for the in-game screen from $0010000 to the
/// attic RAM, at $8070000, copying $8000 bytes of data.  As described above,
/// the bank has to be split for best IFFL results.
dma_job_far_destination_t backup_ingame_bank_4a = {
	.type				= 0x0a,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x8000,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0x0000,
	.destination_bank	= 0x07,
	.modulo				= 0x0000
};

/// \brief	This job stores the second half of the in-game screen bank 4 data 
///			to the attic
///
/// This job copies the loaded data for the in-game screen from $0010000 to the
/// attic RAM, at $8078000, copying $8000 bytes of data.  As described above,
/// the bank has to be split for best IFFL results.
dma_job_far_destination_t backup_ingame_bank_4b = {
	.type				= 0x0a,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x8000,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0x8000,
	.destination_bank	= 0x07,
	.modulo				= 0x0000
};

/// \brief	This job stores in game bank 5 data to the attic
///
/// This job copies the loaded data for the in-game screen from $0010000 to the
/// attic RAM, at $8080000, copying $bf30 bytes of data.
dma_job_far_destination_t backup_ingame_bank_5 = {
	.type				= 0x0a,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0xbf30,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0x0000,
	.destination_bank	= 0x08,
	.modulo				= 0x0000
};


// loader jobs - game over data

/// \brief	This job stores game over bank 2 data to the attic
///
/// This job copies the loaded data for the game over sound effects from 
/// $0012b00 to the attic RAM, at $8092b00, copying $b130 bytes of data.
dma_job_far_destination_t backup_game_over_bank_2 = {
	.type				= 0x0a,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0xb130,
	.source				= 0x2b00,
	.source_bank		= 0x01,
	.destination		= 0x2b00,
	.destination_bank	= 0x09,
	.modulo				= 0x0000
};

/// \brief	This job stores game over bank 3 data to the attic
///
/// This job copies the loaded data for the game over sound effects from 
/// $0010000 to the attic RAM, at $80a0000, copying $a730 bytes of data.
dma_job_far_destination_t backup_game_over_bank_3 = {
	.type				= 0x0a,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0xb100,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0x0000,
	.destination_bank	= 0x0a,
	.modulo				= 0x0000
};


// running jobs - title screen data

/// \brief	This job loads all of the title screen data from the attic
///
/// This is a chain of 4 jobs that load all of the title screen data out of the
/// attic and into the fast RAM banks.  The exact memory locations will not be
/// detailed, but is easy to read in the code below.
dma_job_far_source_t load_title_banks[4] = {
	{
		.type				= 0x0a,
		.sbank_token		= 0x80,
		.sbank				= 0x80,
		.end_options		= 0x00,
		.command			= 0x04,
		.count				= 0x2e32,
		.source				= 0x0000,
		.source_bank		= 0x00,
		.destination		= 0x0000,
		.destination_bank	= 0x01,
		.modulo				= 0x0000
	},
	{
		.type				= 0x0a,
		.sbank_token		= 0x80,
		.sbank				= 0x80,
		.end_options		= 0x00,
		.command			= 0x04,
		.count				= 0x0000,
		.source				= 0x0000,
		.source_bank		= 0x01,
		.destination		= 0x0000,
		.destination_bank	= 0x03,
		.modulo				= 0x0000
	},
	{
		.type				= 0x0a,
		.sbank_token		= 0x80,
		.sbank				= 0x80,
		.end_options		= 0x00,
		.command			= 0x04,
		.count				= 0x0000,
		.source				= 0x0000,
		.source_bank		= 0x02,
		.destination		= 0x0000,
		.destination_bank	= 0x04,
		.modulo				= 0x0000
	},
	{
		.type				= 0x0a,
		.sbank_token		= 0x80,
		.sbank				= 0x80,
		.end_options		= 0x00,
		.command			= 0x00,
		.count				= 0xdf80,
		.source				= 0x0000,
		.source_bank		= 0x03,
		.destination		= 0x0000,
		.destination_bank	= 0x05,
		.modulo				= 0x0000
	}
};


// running jobs - in-game data

/// \brief	This job loads all of the in-game screen data from the attic
///
/// This is a chain of 5 jobs that load all of the in-game screen data out of 
/// the attic and into the fast RAM banks.  The exact memory locations will not 
/// be detailed, but is easy to read in the code below.
dma_job_far_source_t load_ingame_banks[5] = {
	{
		.type				= 0x0a,
		.sbank_token		= 0x80,
		.sbank				= 0x80,
		.end_options		= 0x00,
		.command			= 0x04,
		.count				= 0xf580,
		.source				= 0x0000,
		.source_bank		= 0x04,
		.destination		= 0x0000,
		.destination_bank	= 0x01,
		.modulo				= 0x0000
	},
	{
		.type				= 0x0a,
		.sbank_token		= 0x80,
		.sbank				= 0x80,
		.end_options		= 0x00,
		.command			= 0x04,
		.count				= 0xd9ea,
		.source				= 0x0000,
		.source_bank		= 0x05,
		.destination		= 0x0000,
		.destination_bank	= 0x02,
		.modulo				= 0x0000
	},
	{
		.type				= 0x0a,
		.sbank_token		= 0x80,
		.sbank				= 0x80,
		.end_options		= 0x00,
		.command			= 0x04,
		.count				= 0x0000,
		.source				= 0x0000,
		.source_bank		= 0x07,
		.destination		= 0x0000,
		.destination_bank	= 0x04,
		.modulo				= 0x0000
	},
	{
		.type				= 0x0a,
		.sbank_token		= 0x80,
		.sbank				= 0x80,
		.end_options		= 0x00,
		.command			= 0x04,
		.count				= 0xb83c,
		.source				= 0x0000,
		.source_bank		= 0x08,
		.destination		= 0x0000,
		.destination_bank	= 0x05,
		.modulo				= 0x0000
	},
	{
		.type				= 0x0a,
		.sbank_token		= 0x80,
		.sbank				= 0x80,
		.end_options		= 0x00,
		.command			= 0x00,
		.count				= 0x0000,
		.source				= 0x0000,
		.source_bank		= 0x06,
		.destination		= 0x0000,
		.destination_bank	= 0x03,
		.modulo				= 0x0000
	}
};


// running jobs - game over data

/// \brief	This job loads both of the game over samples from the attic
///
/// This is a chain of 5 jobs that load both of the game over samples out of
/// the attic and into the fast RAM banks.  The exact memory locations will not 
/// be detailed, but is easy to read in the code below.
dma_job_far_source_t load_game_over_banks[2] = {
	{
		.type				= 0x0a,
		.sbank_token		= 0x80,
		.sbank				= 0x80,
		.end_options		= 0x00,
		.command			= 0x04,
		.count				= 0x8630,
		.source				= 0x2b00,
		.source_bank		= 0x09,
		.destination		= 0x2b00,
		.destination_bank	= 0x02,
		.modulo				= 0x0000
	},
	{
		.type				= 0x0a,
		.sbank_token		= 0x80,
		.sbank				= 0x80,
		.end_options		= 0x00,
		.command			= 0x00,
		.count				= 0xb100,
		.source				= 0x0000,
		.source_bank		= 0x0a,
		.destination		= 0x0000,
		.destination_bank	= 0x03,
		.modulo				= 0x0000
	}
};

// running jobs - level complete data

/// \brief	This job loads the level complete sample from the attic
///
/// This job loads the level complete sample out of the attic and into the fast 
/// RAM banks, from 0x80b0000 to 0x0030000.
dma_job_far_source_t load_level_complete_bank[1] = {
	{
		.type				= 0x0a,
		.sbank_token		= 0x80,
		.sbank				= 0x80,
		.end_options		= 0x00,
		.command			= 0x00,
		.count				= 0xd756,
		.source				= 0x0000,
		.source_bank		= 0x0b,
		.destination		= 0x0000,
		.destination_bank	= 0x03,
		.modulo				= 0x0000
	}
};
