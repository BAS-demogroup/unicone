#ifndef __RRB_H
#define __RRB_H

#include <stdint.h>

typedef struct _RRB_TILE_NORMAL RRB_TILE_NORMAL_t;
typedef struct _RRB_TILE_GOTOX  RRB_TILE_GOTOX_t;
typedef struct _RRB_ATTR_NORMAL RRB_ATTR_NORMAL_t;
typedef struct _RRB_ATTR_GOTOX  RRB_ATTR_GOTOX_t;

struct _RRB_TILE_NORMAL {
	uint8_t TILE_IDX_LSB;
	union {
		uint8_t TILE_IDX_MSB : 5;
		uint8_t HTRIM_LSB    : 3;
	};
};

struct _RRB_ATTR_NORMAL {
	union {
		uint8_t VTRIM         : 2;
		uint8_t HTRIM_MSB     : 1;
		uint8_t NCM_ON        : 1;
		uint8_t GOTOX         : 1;	// For normal mode, this should always be 
									// 0, otherwise, we're using the wrong 
									// struct.
		uint8_t ALPHABLEND_ON : 1;
		uint8_t HFLIP         : 1;
		uint8_t VFLIP         : 1;
	};
	// At this time, these structs do not support VIC3 extended attributes
	uint8_t FGCOLOR;
};

struct _RRB_TILE_GOTOX {
	uint8_t XPOS_LSB;
	union {
		uint8_t XPOS_MSB : 2;
		uint8_t RESERVED : 2;	// set to 0
		uint8_t YOFF     : 4;
	};
};

struct _RRB_ATTR_GOTOX {
	union {
		uint8_t RESERVED1  : 2;	// set to 0
		uint8_t ALWAYS_FG  : 1;
		uint8_t ROWMASK_ON : 1;
		uint8_t GOTOX      : 1;	// For GOTOX mode, this of course must always 
								// be 1
		uint8_t RESERVED2  : 1;	// set to 0
		uint8_t ALWAYS_BG  : 1;
	};
	uint8_t ROWMASK;
};

#endif