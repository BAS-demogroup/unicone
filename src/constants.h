/// \file	constants.h
/// 
/// \brief	This file defines the constants of the screen layout
///
/// \copyright 2023 by BAS and deathy (AKA Clifford A. Anderson).  
/// All rights reserved.
#ifndef __CONSTANTS_H
#define __CONSTANTS_H


/// \brief	This is where the palette is stored initially
///
/// This is where the palette is stored during loading.  Once it is written to
/// the VIC3's palette, it is no longer used and gets stomped on by other 
/// things.
#define PALETTE_STORE         0x0025000

/// \brief	How long each line is in the loader's tile and attribute map
#define LOADER_LINE_LENGTH    80
/// \brief	How tall are the loader's maps
#define LOADER_LINE_COUNT     60
/// \brief	The byte size of the loader tile and attribute map
#define LOADER_MAP_LENGTH     0x2580

/// \brief	A pointer to where the loader's tile map is stored during 
///			loading				      
#define LOADER_TILE_MAP       0x0059200
/// \brief	A pointer to where the loader's attribute map is stored during 
///			loading
#define LOADER_ATTR_MAP       0x005b800


/// \brief	How long each line is in the title screen's tile and attribute map
#define TITLE_LINE_LENGTH     80
/// \brief	How tall are the title screen's maps
#define TITLE_LINE_COUNT      60
/// \brief	The byte size of the title screen's tile and attribute map
#define TITLE_MAP_LENGTH      0x2580
						      
/// \brief	A pointer to where the title screen's tile map is stored
#define TITLE_TILE_MAP        0x0059400
/// \brief	A pointer to where the title screen's attribute map is stored
#define TITLE_ATTR_MAP        0x803ba00


/// \brief	How long each line is in the in-game tile and attribute map
#define INGAME_LINE_LENGTH    108
/// \brief	How tall are the in-game maps
#define INGAME_LINE_COUNT     50
/// \brief	The byte sie of the in-game maps
#define INGAME_MAP_LENGTH     0x2a30

/// \brief	This is where the cleared in-game tile map is stored.
///
/// This is where the cleared in-game tile map is stored.  It is DMAed to the 
/// INGAME_TILE_MAP_STORE
#define INGAME_TILE_MAP_BAK   0x001c600
/// \brief	This is where the in-game attribute map is stored.
#define INGAME_ATTR_MAP_BAK   0x809b200
/// \brief	This is where the screen that is actively being displayed is stored
///			and worked on
#define INGAME_TILE_MAP_STORE 0x0020000

/// \brief	The red elements of each ice cream flavor
#define FLAVORS_RED           0x001f100
/// \brief	The green elements of each ice cream flavor
#define FLAVORS_GREEN         0x001f280
/// \brief	The blue elements of each ice cream flavor
#define FLAVORS_BLUE          0x001f400


#endif
