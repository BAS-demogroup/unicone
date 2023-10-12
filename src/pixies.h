#ifndef __PIXIES_H
#define __PIXIES_H

#define UNICORN_PIXIE_ATTRIBUTE 0x1f08;
unsigned short unicorn_pixie_tiles[5][3][5] = {
	{
		{ 0x05b6,0x05b7,0x05b8,0x05b9,0x05ba },
		{ 0x05bb,0x05bc,0x05bd,0x05be,0x05bf },
		{ 0x05c0,0x05c1,0x05c2,0x05c3,0x05c4 }
	},
	{
		{ 0x05c5,0x05c6,0x05c7,0x05c8,0x05c9 },
		{ 0x05ca,0x05cb,0x05cc,0x05cd,0x05ce },
		{ 0x05cf,0x05d0,0x05d1,0x05d2,0x05d3 }
	},
	{
		{ 0x05d4,0x05d5,0x05d6,0x06d7,0x05d8 },
		{ 0x05d9,0x05da,0x05db,0x05dc,0c05dd },
		{ 0x05de,0x05df,0x05e0,0x05e1,0x05e2 }
	},
	{
		{ 0x05e3,0x05e4,0x05e5,0x05e6,0x05e7 },
		{ 0x05e8,0x05e9,0x05ea,0x05eb,0x05ec },
		{ 0x05ed,0x05ee,0x05ef,0x05f0,0x05f1 }
	},
	{
		{ 0x05f2,0x05f3,0x05f4,0x05f5,0x05f6 },
		{ 0x05f7,0x05f8,0x05f9,0x05fa,0x05fb },
		{ 0x05fc,0x05fd,0x05fe,0x05ff,0x0600 }
	}
};

#define TAIL_PIXIE_ATTRIBUTE 0x0f08;
unsigned short tail_pixie_tiles[2][5][4] = {
	{
		{ 0x0601,0x0602,0x0603,0x0604 },
		{ 0x0605,0x0606,0x0607,0x0608 },
		{ 0x0609,0x060a,0x060b,0x060c },
		{ 0x060d,0x060e,0x060f,0x0610 },
		{ 0x0611,0x0612,0x0613,0x0614 }
	},
	{
		{ 0x0615,0x0616,0x0617,0x0618 },
		{ 0x0619,0x061a,0x061b,0x061c },
		{ 0x061d,0x061e,0x061f,0x0620 },
		{ 0x0621,0x0622,0x0623,0x0624 },
		{ 0x0625,0x0626,0x0627,0x0628 }
	}
};

#define MANE_PIXIE_ATTRIBUTE 0x0f08;
unsigned short mane_pixie_tiles[5][3] = {
	{ 0x0629,0x062a,0x062b },
	{ 0x062c,0x062d,0x062e },
	{ 0x062f,0x0630,0x0631 },
	{ 0x0632,0x0633,0x0634 },
	{ 0x0635,0x0636,0x0637 }
};

#define ICECREAM_PIXIE_ATTRIBUTE 0x1f08;
unsigned short large_icecream_top_pixie_tiles[2][2][5] = {
	{
		{ 0x0638,0x0639,0x063a,0x063b,0x063c },
		{ 0x063d,0x063e,0x063f,0x0640,0x0641 }
	},
	{
		{ 0x0642,0x0643,0x0644,0x0645,0x0646 },
		{ 0x0647,0x0648,0x0649,0x064a,0x064b }
	}
};

unsigned short medium_iceream_top_pixie_tiles[2][3] = {
	{ 0x064c,0x064d,0x064e },
	{ 0x064f,0x0650,0x0651 }
};

unsigned short small_icecream_top_pixie_tiles[2][2] = {
	{ 0x0652,0x0653 },
	{ 0x0654,0x0655 }
};

unsigned short large_icecream_bottom_pixie_tiles[2][2][3] = {
	{
		{ 0x0656,0x0657,0x0658 },
		{ 0x0659,0x065a,0x065b }
	},
	{
		{ 0x065c,0x065d,0x065e },
		{ 0x065f,0x0660,0x0661 }
	}
};

unsigned short medium_icecream_bottom_pixie_tiles[2][2] = {
	{ 0x0662,0x0663 },
	{ 0x0664,0x0665 }
};

unsigned short small_icream_bottom_pixie_tiles[2][2] = {
	{ 0x0666,0x0667 },
	{ 0x0668,0x0669 }
};

#define CONE_PIXIE_ATTRIBUTE 0x2f08;
unsigned short large_cone_pixie_tiles[2][2][7] = {
	{
		{ 0x066a,0x066b,0x066c,0x066d,0x066e,0x066f,0x0670 },
		{ 0x0671,0x0672,0x0673,0x0674,0x0675,0x0676,0x0677 }
	},
	{
		{ 0x0678,0x0679,0x067a,0x067b,0x067c,0x067d,0x067e },
		{ 0x067f,0x0680,0x0681,0x0682,0x0683,0x0684,0x0685 }
	}
};

unsigned short medium_cone_pixie_tiles[2][4] = {
	{ 0x0686,0x0687,0x0688,0x0689 },
	{ 0x068a,0x068b,0x068b,0x068c }
};

unsigned short small_cone_pixie_tiles[2][3] = {
	{ 0x068d,0x068e,0x068f },
	{ 0x0690,0x0691,0x0692 }
};

#endif
