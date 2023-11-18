/// \file	rrb.h
/// 
/// \brief	This file defines the interface to rrb.
///
/// This header file defines the structures that are used to interface with the
/// raster rewrite buffer
///
/// \copyright 2023 by BAS and deathy (AKA Clifford A. Anderson).  
/// All rights reserved.
#ifndef __RRB_H
#define __RRB_H

#include <stdint.h>

// This block just creates the types for the structs
typedef struct _RRB_TILE_NORMAL RRB_TILE_NORMAL_t;
typedef struct _RRB_TILE_GOTOX  RRB_TILE_GOTOX_t;
typedef struct _RRB_ATTR_NORMAL RRB_ATTR_NORMAL_t;
typedef struct _RRB_ATTR_GOTOX  RRB_ATTR_GOTOX_t;

/// \brief	This struct interfaces with a normal entry on a tile map
struct _RRB_TILE_NORMAL {
	union {
		uint16_t TILE      : 13;
		uint16_t HTRIM_LSB : 3;
	};
};

/// \brief	This struct interfaces with a normal entry on an attribute map
struct _RRB_ATTR_NORMAL {
	union {
		uint8_t  VTRIM         : 2;
		uint8_t  HTRIM_MSB     : 1;
		uint8_t  NCM_ON        : 1;
		uint8_t  GOTOX         : 1;	// For normal mode, this should always be 
				 					// 0, otherwise, we're using the wrong 
				 					// struct.
		uint8_t  ALPHABLEND_ON : 1;
		uint8_t  HFLIP         : 1;
		uint8_t  VFLIP         : 1;
	};
	// At this time, these structs do not support VIC3 extended attributes
	uint8_t      FGCOLOR;
};

/// \brief	This struct interfaces with a GOTOX entry on a tile map
struct _RRB_TILE_GOTOX {
	union {
		uint16_t XPOS     : 10;
		uint16_t RESERVED : 3;	// set to 0
		uint16_t YOFF     : 3;
	};
};

/// \brief	This struct interfaces with a GOTO entry on an attribute map
struct _RRB_ATTR_GOTOX {
	union {
		uint8_t  RESERVED1  : 2;	// set to 0
		uint8_t  ALWAYS_FG  : 1;
		uint8_t  ROWMASK_ON : 1;
		uint8_t  GOTOX      : 1;	// For GOTOX mode, this of course must always 
				    				// be 1
		uint8_t  RESERVED2  : 1;	// set to 0
		uint8_t  ALWAYS_BG  : 1;
	};
	uint8_t      ROWMASK;
};

#endif
