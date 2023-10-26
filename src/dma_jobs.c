#include "dma_jobs.h"


#include "constants.h"


dma_copy_job_t clear_tilemap = {
	.type				= 0x0b,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= MAP_LENGTH,
	.source				= (TILE_MAP_BAK & 0xffff),
	.source_bank		= ((TILE_MAP_BAK & 0xf0000) >> 16),
	.destination		= TILE_MAP_STORE & 0xffff,
	.destination_bank	= (TILE_MAP_STORE & 0xf0000) >> 16,
	.modulo				= 0x0
};

dma_copy_job_t load_palette = {
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

dma_copy_job_t load_flavor_red = {
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

dma_copy_job_t load_flavor_green = {
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

dma_copy_job_t load_flavor_blue = {
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

dma_copy_job_huge_destination_t load_attrmap = {
	.type				= 0x0b,
	.dbank_token		= 0x81,
	.dbank				= 0xff,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= MAP_LENGTH,
	.source				= ATTR_MAP_BAK & 0xffff,
	.source_bank		= (ATTR_MAP_BAK & 0xf0000) >> 16,
	.destination		= 0x0000,
	.destination_bank	= 0x08,
	.modulo				= 0x0
};

dma_copy_job_huge_destination_t backup_runtime_samples_1 = {
	.type				= 0x0b,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0xff3c,
	.source				= 0x0000,
	.source_bank		= 0x04,
	.destination		= 0x0000,
	.destination_bank	= 0x00,
	.modulo				= 0x0
};

dma_copy_job_huge_destination_t backup_runtime_samples_2 = {
	.type				= 0x0b,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0xd1a4,
	.source				= 0x0000,
	.source_bank		= 0x05,
	.destination		= 0x0000,
	.destination_bank	= 0x01,
	.modulo				= 0x0
};

dma_copy_job_huge_destination_t backup_game_over_samples_1 = {
	.type				= 0x0b,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x8630,
	.source				= 0x0000,
	.source_bank		= 0x04,
	.destination		= 0x0000,
	.destination_bank	= 0x02,
	.modulo				= 0x0
};

dma_copy_job_huge_destination_t backup_game_over_samples_2 = {
	.type				= 0x0b,
	.dbank_token		= 0x81,
	.dbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0xa730,
	.source				= 0x0000,
	.source_bank		= 0x05,
	.destination		= 0x0000,
	.destination_bank	= 0x03,
	.modulo				= 0x0
};

dma_copy_job_huge_source_t load_runtime_samples_1 = {
	.type				= 0x0b,
	.sbank_token		= 0x80,
	.sbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0xff3c,
	.source				= 0x0000,
	.source_bank		= 0x00,
	.destination		= 0x0000,
	.destination_bank	= 0x04,
	.modulo				= 0x0
};

dma_copy_job_huge_source_t load_runtime_samples_2 = {
	.type				= 0x0b,
	.sbank_token		= 0x80,
	.sbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0xd1a4,
	.source				= 0x0000,
	.source_bank		= 0x01,
	.destination		= 0x0000,
	.destination_bank	= 0x05,
	.modulo				= 0x0
};

dma_copy_job_huge_source_t load_game_over_samples_1 = {
	.type				= 0x0b,
	.sbank_token		= 0x80,
	.sbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x8630,
	.source				= 0x0000,
	.source_bank		= 0x02,
	.destination		= 0x0000,
	.destination_bank	= 0x04,
	.modulo				= 0x0
};

dma_copy_job_huge_source_t load_game_over_samples_2 = {
	.type				= 0x0b,
	.sbank_token		= 0x80,
	.sbank				= 0x80,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0xa730,
	.source				= 0x0000,
	.source_bank		= 0x03,
	.destination		= 0x0000,
	.destination_bank	= 0x05,
	.modulo				= 0x0
};
