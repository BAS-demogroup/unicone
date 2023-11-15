#include "pixies.h"


#include "difficulty.h"
#include "maps.h"


unsigned short get_cone_tile(char shadow, char x, char y) {
	switch (scale) {
		case 1:
			return medium_cone_pixie_tiles[shadow][y];
		case 2:
			return small_cone_pixie_tiles[shadow][y];
		default:
			return large_cone_pixie_tiles[shadow][x][y];
	}
}

unsigned short get_icecream_top_tile(char shadow, char x, char y) {
	switch (scale) {
		case 1:
			return medium_icecream_top_pixie_tiles[shadow][y];
		case 2:
			return small_icecream_top_pixie_tiles[shadow][y];
		default:
			return large_icecream_top_pixie_tiles[shadow][x][y];
	}
}

unsigned short get_icecream_bottom_tile(char shadow, char x, char y) {
	switch (scale) {
		case 1:
			return medium_icecream_bottom_pixie_tiles[shadow][y];
		case 2:
			return small_icecream_bottom_pixie_tiles[shadow][y];
		default:
			return large_icecream_bottom_pixie_tiles[shadow][x][y];
	}
}

void paint_icecream_top_tile(char x_tile, char y_tile, char y_offset) {
	switch (scale) {
		case 1:
		case 2:
			small_icecream_shadow_tiles[0][y_tile + y_offset]->TILE =
				get_icecream_top_tile(1, x_tile, y_tile);
				
			small_icecream_tiles[0][y_tile + y_offset]->TILE =
				get_icecream_top_tile(0, x_tile, y_tile);

			break;
			
		default:
			falling_icecream_shadow_tiles[0][x_tile][y_tile + y_offset]->TILE =
				get_icecream_top_tile(1, x_tile, y_tile);

			falling_icecream_tiles[0][x_tile][y_tile + y_offset]->TILE = 
				get_icecream_top_tile(0, x_tile, y_tile);
				
			break;
	}
}

void paint_icecream_bottom_tile(char layer, char x_tile, char y_tile, 
	char y_offset) {
		
	switch (scale) {
		case 1:
		case 2:
			if (layer < 2) {
				small_icecream_shadow_tiles[layer][y_tile + y_offset]->TILE =
					get_icecream_bottom_tile(1, x_tile, y_tile);
					
				small_icecream_tiles[layer][y_tile + y_offset]->TILE =
					get_icecream_bottom_tile(0, x_tile, y_tile);
					
					
			} else {
				falling_icecream_shadow_tiles[layer - 2][x_tile]
					[y_tile + y_offset]->TILE = 
					get_icecream_bottom_tile(1, x_tile, y_tile);

				falling_icecream_tiles[layer - 2][x_tile][y_tile + y_offset]->
					TILE = get_icecream_bottom_tile(0, x_tile, y_tile);
					
			}
			break;
			
		default:
			falling_icecream_shadow_tiles[layer][x_tile][y_tile + y_offset]->
				TILE = get_icecream_bottom_tile(1, x_tile, y_tile);

			falling_icecream_tiles[layer][x_tile][y_tile + y_offset]->TILE = 
				get_icecream_bottom_tile(0, x_tile, y_tile);
				
			break;
	}
}

void set_icecream_pos(char layer, unsigned short x_pix, char y_tile, 
	char y_pix) {
		
	switch (scale) {
		case 1:
		case 2:
			if (layer < 2) {
				small_icecream_shadow_position[layer][y_tile]->YOFF = y_pix;
				small_icecream_position[layer][y_tile]->YOFF = y_pix;
				
				small_icecream_shadow_position[layer][y_tile]->XPOS = x_pix;
				small_icecream_position[layer][y_tile]->XPOS = x_pix;
			} else {
				falling_icecream_shadow_position[layer - 2][y_tile]->YOFF = 
					y_pix;
					
				falling_icecream_position[layer - 2][y_tile]->YOFF = y_pix;

				falling_icecream_shadow_position[layer - 2][y_tile]->XPOS = 
					x_pix;
					
				falling_icecream_position[layer - 2][y_tile]->XPOS = x_pix;
			}
			break;
			
		default:
			falling_icecream_shadow_position[layer][y_tile]->YOFF = y_pix;
			falling_icecream_position[layer][y_tile]->YOFF = y_pix;

			falling_icecream_shadow_position[layer][y_tile]->XPOS = x_pix;
			falling_icecream_position[layer][y_tile]->XPOS = x_pix;
			break;
	}
}

void set_stacked_pos(char layer, unsigned short x_pix, char y_tile, 
	char y_pix) {
		
	switch (scale) {
		case 1:
		case 2:
			if (layer < 3) {
				small_stacked_shadow_position[layer][y_tile]->YOFF = y_pix;
				small_stacked_position[layer][y_tile]->YOFF = y_pix;
				
				small_stacked_shadow_position[layer][y_tile]->XPOS = x_pix;
				small_stacked_position[layer][y_tile]->XPOS = x_pix;
			} else {
				stacked_icecream_shadow_position[layer - 3][y_tile]->YOFF = 
					y_pix;
					
				stacked_icecream_position[layer - 3][y_tile]->YOFF = y_pix;

				stacked_icecream_shadow_position[layer - 3][y_tile]->XPOS = 
					x_pix;
					
				stacked_icecream_position[layer - 3][y_tile]->XPOS = x_pix;
			}
			break;
			
		default:
			stacked_icecream_shadow_position[layer][y_tile]->YOFF = y_pix;
			stacked_icecream_position[layer][y_tile]->YOFF = y_pix;

			stacked_icecream_shadow_position[layer][y_tile]->XPOS = x_pix;
			stacked_icecream_position[layer][y_tile]->XPOS = x_pix;
			break;
	}
}
	
void paint_stacked_top_tile(char x_tile, char y_tile, char y_offset) {
	switch (scale) {
		case 1:
		case 2:
			small_stacked_shadow_tiles[0][y_tile + y_offset]->TILE =
				get_icecream_top_tile(1, x_tile, y_tile);
				
			small_stacked_tiles[0][y_tile + y_offset]->TILE =
				get_icecream_top_tile(0, x_tile, y_tile);
			break;
			
		default:
			stacked_icecream_shadow_tiles[0][x_tile][y_tile + y_offset]->TILE =
				get_icecream_top_tile(1, x_tile, y_tile);

			stacked_icecream_tiles[0][x_tile][y_tile + y_offset]->TILE = 
				get_icecream_top_tile(0, x_tile, y_tile);
				
			break;
	}
}

void paint_stacked_bottom_tile(char layer, char x_tile, char y_tile, 
	char y_offset) {

		
	switch (scale) {
		case 1:
		case 2:
			if (layer < 3) {
				small_stacked_shadow_tiles[layer][y_tile + y_offset]->TILE =
					get_icecream_bottom_tile(1, x_tile, y_tile);
					
				small_stacked_tiles[layer][y_tile + y_offset]->TILE =
					get_icecream_bottom_tile(0, x_tile, y_tile);
					
			} else {
				stacked_icecream_shadow_tiles[layer - 3][x_tile]
					[y_tile + y_offset]->TILE = 
					get_icecream_bottom_tile(1, x_tile, y_tile);

				stacked_icecream_tiles[layer - 3][x_tile][y_tile + y_offset]->
					TILE = get_icecream_bottom_tile(0, x_tile, y_tile);
			}
			break;
			
		default:
			stacked_icecream_shadow_tiles[layer][x_tile][y_tile + y_offset]->
				TILE = get_icecream_bottom_tile(1, x_tile, y_tile);

			stacked_icecream_tiles[layer][x_tile][y_tile + y_offset]->TILE = 
				get_icecream_bottom_tile(0, x_tile, y_tile);
			break;
	}
}


unsigned short unicorn_pixie_tiles[5][3][5] = {
	{
		{ 0x05b8,0x05b9,0x05ba,0x05bb,0x05bc },
		{ 0x05bd,0x05be,0x05bf,0x05c0,0x05c1 },
		{ 0x05c2,0x05c3,0x05c4,0x05c5,0x05c6 }
	},
	{
		{ 0x05c7,0x05c8,0x05c9,0x05ca,0x05cb },
		{ 0x05cc,0x05cd,0x05ce,0x05cf,0x05d0 },
		{ 0x05d1,0x05d2,0x05d3,0x05d4,0x05d5 }
	},
	{
		{ 0x05d6,0x05d7,0x05d8,0x05d9,0x05da },
		{ 0x05db,0x05dc,0x05dd,0x05de,0x05df },
		{ 0x05e0,0x05e1,0x05e2,0x05e3,0x05e4 }
	},
	{
		{ 0x05e5,0x05e6,0x05e7,0x05e8,0x05e9 },
		{ 0x05ea,0x05eb,0x05ec,0x05ed,0x05ee },
		{ 0x05ef,0x05f0,0x05f1,0x05f2,0x05f3 }
	},
	{
		{ 0x05f4,0x05f5,0x05f6,0x05f7,0x05f8 },
		{ 0x05f9,0x05fa,0x05fb,0x05fc,0x05fd },
		{ 0x05fe,0x05ff,0x0600,0x0601,0x0602 }
	}
};

unsigned short tail_pixie_tiles[2][5][4] = {
	{
		{ 0x0603,0x0604,0x0605,0x0606 },
		{ 0x0607,0x0608,0x0609,0x060a },
		{ 0x060b,0x060c,0x060d,0x060e },
		{ 0x060f,0x0610,0x0611,0x0612 },
		{ 0x0613,0x0614,0x0615,0x0616 }
	},
	{
		{ 0x0617,0x0618,0x0619,0x061a },
		{ 0x061b,0x061c,0x061d,0x061e },
		{ 0x061f,0x0620,0x0621,0x0622 },
		{ 0x0623,0x0624,0x0625,0x0626 },
		{ 0x0627,0x0628,0x0629,0x062a }
	}
};

unsigned short mane_pixie_tiles[5][3] = {
	{ 0x062b,0x062c,0x062d },
	{ 0x062e,0x062f,0x0630 },
	{ 0x0631,0x0632,0x0633 },
	{ 0x0634,0x0635,0x0636 },
	{ 0x0637,0x0638,0x0639 }
};

unsigned short large_icecream_top_pixie_tiles[2][2][5] = {
	{
		{ 0x063a,0x063b,0x063c,0x063d,0x063e },
		{ 0x063f,0x0640,0x0641,0x0642,0x0643 }
	},
	{
		{ 0x0644,0x0645,0x0646,0x0647,0x0648 },
		{ 0x0649,0x064a,0x064b,0x064c,0x064d }
	}
};

unsigned short medium_icecream_top_pixie_tiles[2][3] = {
	{ 0x064e,0x064f,0x0650 },
	{ 0x0651,0x0652,0x0653 }
};

unsigned short small_icecream_top_pixie_tiles[2][2] = {
	{ 0x0654,0x0655 },
	{ 0x0656,0x0657 }
};

unsigned short large_icecream_bottom_pixie_tiles[2][2][3] = {
	{
		{ 0x0658,0x0659,0x065a },
		{ 0x065b,0x065c,0x065d }
	},
	{
		{ 0x065e,0x065f,0x0660 },
		{ 0x0661,0x0662,0x0663 }
	}
};

unsigned short medium_icecream_bottom_pixie_tiles[2][2] = {
	{ 0x0664,0x0665 },
	{ 0x0666,0x0667 }
};

unsigned short small_icecream_bottom_pixie_tiles[2][2] = {
	{ 0x0668,0x0669 },
	{ 0x066a,0x066b }
};

unsigned short large_cone_pixie_tiles[2][2][7] = {
	{
		{ 0x066c,0x066d,0x066e,0x066f,0x0670,0x0671,0x0672 },
		{ 0x0673,0x0674,0x0675,0x0676,0x0677,0x0678,0x0679 }
	},
	{
		{ 0x067a,0x067b,0x067c,0x067d,0x067e,0x067f,0x0680 },
		{ 0x0681,0x0682,0x0683,0x0684,0x0685,0x0686,0x0687 }
	}
};

unsigned short medium_cone_pixie_tiles[2][4] = {
	{ 0x0688,0x0689,0x068a,0x068b },
	{ 0x068c,0x068d,0x068e,0x068f }
};

unsigned short small_cone_pixie_tiles[2][3] = {
	{ 0x0690,0x0691,0x0692 },
	{ 0x0693,0x0694,0x0695 }
};

unsigned short numbers[10][2][5] = {
	{	// 0
		{
			0x06d6,0x06d8,0x06e2,0x06e3,0x06d5
		},
		{
			0x06ad,0x06b0,0x06cc,0x06bb,0x06c1
		}
	},
	{	// 1
		{
			0x06ab,0x06ae,0x06b1,0x06b6,0x06bc
		},
		{
			0x069f,0x069f,0x069f,0x06b7,0x06bd
		}
	},
	{	// 2
		{
			0x06ac,0x06af,0x06b2,0x06b8,0x06be
		},
		{
			0x06ad,0x06b0,0x06b3,0x06b9,0x06bf
		}
	},
	{	// 3
		{
			0x06ac,0x06af,0x06b4,0x06ba,0x06c0
		},
		{
			0x06ad,0x06b0,0x06b5,0x06bb,0x06c1
		}
	},
	{	// 4
		{
			0x06c2,0x06c6,0x06cb,0x06d0,0x06d4
		},
		{
			0x06c3,0x06c7,0x06cc,0x06d1,0x06bf
		}
	},
	{	// 5
		{
			0x06c4,0x06c8,0x06cd,0x06d2,0x06c0
		},
		{
			0x06c3,0x06c9,0x06ce,0x06bb,0x06c1
		}
	},
	{	// 6
		{
			0x06c5,0x06ca,0x06cf,0x06d3,0x06d5
		},
		{
			0x06b7,0x06bd,0x06ce,0x06bb,0x06c1
		}
	},
	{	// 7
		{
			0x06c4,0x06d7,0x06d9,0x06dd,0x06e0
		},
		{
			0x06c3,0x06c7,0x06da,0x069f,0x069f
		}
	},
	{	// 8
		{
			0x06d6,0x06d8,0x06db,0x06de,0x06d5
		},
		{
			0x06ad,0x06b0,0x06b5,0x06bb,0x06c1
		}
	},
	{	// 9
		{
			0x06d6,0x06d8,0x06dc,0x06df,0x06e1
		},
		{
			0x06ad,0x06b0,0x06cc,0x06bb,0x06c1
		}
	}
};

unsigned short splash_pixie_tiles[3][2] = {
	{
		0x0673,0x067a
	},
	{
		0x0681,0x0688
	},
	{
		0x068c,0x0690
	}
};
