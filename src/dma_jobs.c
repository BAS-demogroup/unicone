#include "dma_jobs.h"


#include "constants.h"


// running jobs - title screen functional
dma_job_far_addresses_t load_title_attrmap = {
	.type				= 0x0b,
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
	.modulo				= 0x0
};

// running jobs - in game functional
dma_job_t clear_ingame_tilemap = {
	.type				= 0x0b,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= INGAME_MAP_LENGTH,
	.source				= (INGAME_TILE_MAP_BAK & 0xffff),
	.source_bank		= ((INGAME_TILE_MAP_BAK & 0xf0000) >> 16),
	.destination		= INGAME_TILE_MAP_STORE & 0xffff,
	.destination_bank	= (INGAME_TILE_MAP_STORE & 0xf0000) >> 16,
	.modulo				= 0x0
};

dma_job_t load_flavor_red = {
	.type				= 0x0b,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x0010,
	.source				= (FLAVORS_RED & 0xffff),
	.source_bank		= ((FLAVORS_RED & 0xf0000) >> 16),
	.destination		= 0xd100,
	.destination_bank	= 0b10000000,	// bit 7 = copy to io, thus loading the palette
	.modulo				= 0x0
};

dma_job_t load_flavor_green = {
	.type				= 0x0b,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x0010,
	.source				= (FLAVORS_GREEN & 0xffff),
	.source_bank		= ((FLAVORS_GREEN & 0xf0000) >> 16),
	.destination		= 0xd200,
	.destination_bank	= 0b10000000,	// bit 7 = copy to io, thus loading the palette
	.modulo				= 0x0
};

dma_job_t load_flavor_blue = {
	.type				= 0x0b,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x0010,
	.source				= (FLAVORS_BLUE & 0xffff),
	.source_bank		= ((FLAVORS_BLUE & 0xf0000) >> 16),
	.destination		= 0xd300,
	.destination_bank	= 0b10000000,	// bit 7 = copy to io, thus loading the palette
	.modulo				= 0x0
};

dma_job_far_addresses_t load_ingame_attrmap = {
	.type				= 0x0b,
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
	.modulo				= 0x0
};


// loader jobs - loader screen data
dma_job_t load_palette = {
	.type				= 0x0b,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x0300,
	.source				= (PALETTE_STORE & 0xffff),
	.source_bank		= ((PALETTE_STORE & 0xf0000) >> 16),
	.destination		= 0xd100,
	.destination_bank	= 0b10000000,	// bit 7 = copy to io, thus loading the palette
	.modulo				= 0x0
};

dma_job_far_destination_t load_loader_attrmap = {
	.type				= 0x0b,
	.dbank_token		= 0x81,
	.dbank				= 0xff,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= LOADER_MAP_LENGTH,
	.source				= LOADER_ATTR_MAP & 0xffff,
	.source_bank		= (LOADER_ATTR_MAP & 0xf0000) >> 16,
	.destination		= 0x0000,
	.destination_bank	= 0x08,
	.modulo				= 0x0
};

dma_job_t move_tilemap_3b = {
	.type				= 0x0b,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x8000,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0x8000,
	.destination_bank	= 0x03,
	.modulo				= 0x0
};

dma_job_t move_tilemap_4b = {
	.type				= 0x0b,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x8000,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0x8000,
	.destination_bank	= 0x04,
	.modulo				= 0x0
};


// loader jobs - title screen data
dma_job_far_destination_t backup_title_bank_1 = {
	.type				= 0x0b,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x2e32,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0x0000,
	.destination_bank	= 0x00,
	.modulo				= 0x0
};

dma_job_far_destination_t backup_title_bank_3a = {
	.type				= 0x0b,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x8000,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0x0000,
	.destination_bank	= 0x01,
	.modulo				= 0x0
};

dma_job_far_destination_t backup_title_bank_3b = {
	.type				= 0x0b,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x8000,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0x8000,
	.destination_bank	= 0x01,
	.modulo				= 0x0
};

dma_job_far_destination_t backup_title_bank_4a = {
	.type				= 0x0b,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x8000,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0x0000,
	.destination_bank	= 0x02,
	.modulo				= 0x0
};

dma_job_far_destination_t backup_title_bank_4b = {
	.type				= 0x0b,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x8000,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0x8000,
	.destination_bank	= 0x02,
	.modulo				= 0x0
};

dma_job_far_destination_t backup_title_bank_5 = {
	.type				= 0x0b,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0xda80,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0x0000,
	.destination_bank	= 0x03,
	.modulo				= 0x0
};


// loader jobs - in-game data
dma_job_far_destination_t backup_ingame_bank_1 = {
	.type				= 0x0b,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0xf580,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0x0000,
	.destination_bank	= 0x04,
	.modulo				= 0x0
};

dma_job_far_destination_t backup_ingame_bank_2a = {
	.type				= 0x0b,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0xd9ea,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0x0000,
	.destination_bank	= 0x05,
	.modulo				= 0x0
};

// remove
dma_job_far_destination_t backup_ingame_bank_2b = {
	.type				= 0x0b,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x2ea1,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0xcd00,
	.destination_bank	= 0x05,
	.modulo				= 0x0
};

dma_job_far_destination_t backup_ingame_bank_3 = {
	.type				= 0x0b,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0xe5a1,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0x0000,
	.destination_bank	= 0x06,
	.modulo				= 0x0
};

dma_job_far_destination_t backup_ingame_bank_4a = {
	.type				= 0x0b,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x8000,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0x0000,
	.destination_bank	= 0x07,
	.modulo				= 0x0
};

dma_job_far_destination_t backup_ingame_bank_4b = {
	.type				= 0x0b,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x8000,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0x8000,
	.destination_bank	= 0x07,
	.modulo				= 0x0
};

dma_job_far_destination_t backup_ingame_bank_5 = {
	.type				= 0x0b,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0xbf30,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0x0000,
	.destination_bank	= 0x08,
	.modulo				= 0x0
};


// loader jobs - game over data
dma_job_far_destination_t backup_game_over_bank_2 = {
	.type				= 0x0b,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0xb130,
	.source				= 0x2b00,
	.source_bank		= 0x01,
	.destination		= 0x2b00,
	.destination_bank	= 0x09,
	.modulo				= 0x0
};

dma_job_far_destination_t backup_game_over_bank_3 = {
	.type				= 0x0b,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0xa730,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0x0000,
	.destination_bank	= 0x0a,
	.modulo				= 0x0
};


// running jobs - title screen data
dma_job_far_source_t load_title_bank_1 = {
	.type				= 0x0b,
	.sbank_token		= 0x80,
	.sbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x2e32,
	.source				= 0x0000,
	.source_bank		= 0x00,
	.destination		= 0x0000,
	.destination_bank	= 0x01,
	.modulo				= 0x0
};

dma_job_far_source_t load_title_bank_3 = {
	.type				= 0x0b,
	.sbank_token		= 0x80,
	.sbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x0000,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0x0000,
	.destination_bank	= 0x03,
	.modulo				= 0x0
};

dma_job_far_source_t load_title_bank_4 = {
	.type				= 0x0b,
	.sbank_token		= 0x80,
	.sbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x0000,
	.source				= 0x0000,
	.source_bank		= 0x02,
	.destination		= 0x0000,
	.destination_bank	= 0x04,
	.modulo				= 0x0
};

dma_job_far_source_t load_title_bank_5 = {
	.type				= 0x0b,
	.sbank_token		= 0x80,
	.sbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0xda80,
	.source				= 0x0000,
	.source_bank		= 0x03,
	.destination		= 0x0000,
	.destination_bank	= 0x05,
	.modulo				= 0x0
};


// running jobs - in-game data
dma_job_far_source_t load_ingame_bank_1 = {
	.type				= 0x0b,
	.sbank_token		= 0x80,
	.sbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0xf580,
	.source				= 0x0000,
	.source_bank		= 0x04,
	.destination		= 0x0000,
	.destination_bank	= 0x01,
	.modulo				= 0x0
};

dma_job_far_source_t load_ingame_bank_2 = {
	.type				= 0x0b,
	.sbank_token		= 0x80,
	.sbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0xd9ea,
	.source				= 0x0000,
	.source_bank		= 0x05,
	.destination		= 0x0000,
	.destination_bank	= 0x02,
	.modulo				= 0x0
};

dma_job_far_source_t load_ingame_bank_3 = {
	.type				= 0x0b,
	.sbank_token		= 0x80,
	.sbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x0000,
	.source				= 0x0000,
	.source_bank		= 0x06,
	.destination		= 0x0000,
	.destination_bank	= 0x03,
	.modulo				= 0x0
};

dma_job_far_source_t load_ingame_bank_4 = {
	.type				= 0x0b,
	.sbank_token		= 0x80,
	.sbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x0000,
	.source				= 0x0000,
	.source_bank		= 0x07,
	.destination		= 0x0000,
	.destination_bank	= 0x04,
	.modulo				= 0x0
};

dma_job_far_source_t load_ingame_bank_5 = {
	.type				= 0x0b,
	.sbank_token		= 0x80,
	.sbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0xb83c,
	.source				= 0x0000,
	.source_bank		= 0x08,
	.destination		= 0x0000,
	.destination_bank	= 0x05,
	.modulo				= 0x0
};


// running jobs - game over data
dma_job_far_source_t load_game_over_bank_2 = {
	.type				= 0x0b,
	.sbank_token		= 0x80,
	.sbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x8630,
	.source				= 0x2b00,
	.source_bank		= 0x09,
	.destination		= 0x2b00,
	.destination_bank	= 0x02,
	.modulo				= 0x0
};

dma_job_far_source_t load_game_over_bank_3 = {
	.type				= 0x0b,
	.sbank_token		= 0x80,
	.sbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0xa730,
	.source				= 0x0000,
	.source_bank		= 0x0a,
	.destination		= 0x0000,
	.destination_bank	= 0x03,
	.modulo				= 0x0
};

