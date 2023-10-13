#ifndef __MAPS_H
#define __MAPS_H

// Should I map in the tile and attribute maps to $8000-$bb60?  Going to store 
// the tilemap up in $ff80000 with the attribute map, and then MAP it into 
// lower memory to work directly with it.  I'm going to have an array of 
// pointers to the various pixies so that I can very easily work directly on
// them.
#define TILE_MAP 0x8000;
#define ATTR_MAP 0xa000;

#endif
