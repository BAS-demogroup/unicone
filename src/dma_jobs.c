#include "dma_jobs.h"


#include "constants.h"


dma_copy_job_t clear_tilemap = {
	.type				= 0x0b,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x1db0,
	.source				= (TILE_MAP_BAK & 0xffff),
	.source_bank		= ((TILE_MAP_BAK & 0xf0000) >> 16),
	.destination		= TILE_MAP_STORE & 0xffff,
	.destination_bank	= (TILE_MAP_STORE & 0xf0000) >> 16,
	.modulo				= 0x0
};

// dma_copy_job_t clear_attrmap = {
	// .type				= 0x0b,
	// .end_options		= 0x00,
	// .command			= 0x00,
	// .count				= 0x1db0,
	// .source				= ATTR_MAP_BAK & 0xffff,
	// .source_bank		= (ATTR_MAP_BAK & 0xf0000) >> 16,
	// .destination		= ATTR_MAP_STORE & 0xffff,
	// .destination_bank	= (ATTR_MAP_STORE & 0xf0000) >> 16,
	// .modulo				= 0x0
// };

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

dma_copy_job_huge_destination_t load_attrmap = {
	.type				= 0x0b,
	.dbank_token		= 0x81,
	.dbank				= 0xff,
	.end_options		= 0x00,
	.command			= 0x00,
	.count				= 0x1db0,
	.source				= ATTR_MAP_BAK & 0xffff,
	.source_bank		= (ATTR_MAP_BAK & 0xf0000) >> 16,
	.destination		= 0x0000,
	.destination_bank	= 0x08,
	.modulo				= 0x0
};
