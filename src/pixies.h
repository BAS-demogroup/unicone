#ifndef __PIXIES_H
#define __PIXIES_H


unsigned short get_cone_tile(char shadow, char x, char y);
unsigned short get_icecream_top_tile(char shadow, char x, char y);
unsigned short get_icecream_bottom_tile(char shadow, char x, char y);

void set_icecream_pos(char layer, unsigned short x_pix, char y_tile, 
	char y_pix);
void paint_icecream_top_tile(char x_tile, char y_tile, char y_offset);
void paint_icecream_bottom_tile(char layer, char x_tile, char y_tile, 
	char y_offset);
	
void set_stacked_pos(char layer, unsigned short x_pix, char y_tile, 
	char y_pix);
void paint_stacked_top_tile(char x_tile, char y_tile, char y_offset);
void paint_stacked_bottom_tile(char layer, char x_tile, char y_tile, 
	char y_offset);
	

extern unsigned short unicorn_pixie_tiles[5][3][5];
extern unsigned short tail_pixie_tiles[2][5][4];
extern unsigned short mane_pixie_tiles[5][3];
extern unsigned short large_icecream_top_pixie_tiles[2][2][5];
extern unsigned short medium_icecream_top_pixie_tiles[2][3];
extern unsigned short small_icecream_top_pixie_tiles[2][2];
extern unsigned short large_icecream_bottom_pixie_tiles[2][2][3];
extern unsigned short medium_icecream_bottom_pixie_tiles[2][2];
extern unsigned short small_icecream_bottom_pixie_tiles[2][2];
extern unsigned short large_cone_pixie_tiles[2][2][7];
extern unsigned short medium_cone_pixie_tiles[2][4];
extern unsigned short small_cone_pixie_tiles[2][3];
extern unsigned short numbers[10][2][5];
extern unsigned short splash_pixie_tiles[3][2];

#endif
