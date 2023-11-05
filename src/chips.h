#ifndef __CHIPS_H
#define __CHIPS_H

#include <stdint.h>

typedef struct _CPU           _CPU_t;
typedef struct _VIC2          _VIC2_t;
typedef struct _VIC3          _VIC3_t;
typedef struct _VIC4          _VIC4_t;
typedef struct _FDC           _FDC_t;
typedef struct _SID           _SID_t;
typedef struct _SID_VOICE     _SID_VOICE_t;
typedef struct _KEYSCAN       _KEYSCAN_t;
typedef struct _DMA           _DMA_t;
typedef struct _MATH          _MATH_t;
typedef struct _AUDIO_DMA     _AUDIO_DMA_t;
typedef struct _AUDIO_CHANNEL _AUDIO_CHANNEL_t;
typedef struct _CIA1          _CIA1_t;
typedef struct _CIA2          _CIA2_t;
typedef struct _IRQ_VECTORS   _IRQ_VECTORS_t;

struct _CPU {
	uint8_t     PORTDDR;
	uint8_t     PORT;
};

struct _VIC2 {
	uint8_t     S0X;
	uint8_t     S0Y;
	uint8_t     S1X;
	uint8_t     S1Y;
	uint8_t     S2X;
	uint8_t     S2Y;
	uint8_t     S3X;
	uint8_t     S3Y;
	uint8_t     S4X;
	uint8_t     S4Y;
	uint8_t     S5X;
	uint8_t     S5Y;
	uint8_t     S6X;
	uint8_t     S6Y;
	uint8_t     S7X;
	uint8_t     S7Y;
	uint8_t     SXMSB;
	union {
		uint8_t YSCL : 3;
		uint8_t RSEL : 1;
		uint8_t DEN  : 1;
		uint8_t BMM  : 1;
		uint8_t ECM  : 1;
		uint8_t RC8  : 1;
	};
	uint8_t     RC;
	uint8_t     LPX;
	uint8_t     LPY;
	uint8_t     SE;
	union {
		uint8_t XSCL : 3;
		uint8_t CSEL : 1;
		uint8_t MCM  : 1;
		uint8_t RST  : 1;
	};
	uint8_t     SEXY;
	union {
		uint8_t _NA0 : 1;
		uint8_t CB   : 3;
		uint8_t VS   : 4;
	};
	union {
		uint8_t RIRQ : 1;
		uint8_t ISBC : 1;
		uint8_t ISSC : 1;
		uint8_t ILP  : 1;
	};
	union {
		uint8_t MRIRQ : 1;
		uint8_t MISBC : 1;
		uint8_t MISSC : 1;
	};
	uint8_t     BSP;
	uint8_t     SCM;
	uint8_t     SEXX;
	uint8_t     SSC;
	uint8_t     SBC;
	uint8_t     BORDERCOL;
	uint8_t     SCREENCOL;
	uint8_t     MC1;
	uint8_t     MC2;
	uint8_t     MC3;
	uint8_t     SPRMC0;
	uint8_t     SPRMC1;
	uint8_t     SPR0COL;
	uint8_t     SPR1COL;
	uint8_t     SPR2COL;
	uint8_t     SPR3COL;
	uint8_t     SPR4COL;
	uint8_t     SPR5COL;
	uint8_t     SPR6COL;
	uint8_t     SPR7COL;
	uint8_t     _NA1;
	uint8_t     C128_FAST;
};

struct _VIC3 {
	uint8_t     KEY;
	union {
		uint8_t CRAM2K  : 1;
		uint8_t EXTSYNC : 1;
		uint8_t PAL     : 1;
		uint8_t ROM8    : 1;
		uint8_t ROMA    : 1;
		uint8_t ROMC    : 1;
		uint8_t CROM9   : 1;
		uint8_t ROME    : 1;
	};
	union {
		uint8_t INT   : 1;
		uint8_t MONO  : 1;
		uint8_t H1280 : 1;
		uint8_t V400  : 1;
		uint8_t BPM   : 1;
		uint8_t ATTR  : 1;
		uint8_t FAST  : 1;
		uint8_t H640  : 1;
	};
	union {
		uint8_t _NA1  : 1;
		uint8_t B0EVN : 3;
		uint8_t _NA2  : 1;
		uint8_t B0ODD : 3;
	};
	union {
		uint8_t _NA3  : 1;
		uint8_t B1EVN : 3;
		uint8_t _NA4  : 1;
		uint8_t B1ODD : 3;
	};
	union {
		uint8_t _NA5  : 1;
		uint8_t B2EVN : 3;
		uint8_t _NA6  : 1;
		uint8_t B2ODD : 3;
	};
	union {
		uint8_t _NA7  : 1;
		uint8_t B3EVN : 3;
		uint8_t _NA8  : 1;
		uint8_t B3ODD : 3;
	};
	union {
		uint8_t _NA9  : 1;
		uint8_t B4EVN : 3;
		uint8_t _NA10 : 1;
		uint8_t B4ODD : 3;
	};
	union {
		uint8_t _NA11 : 1;
		uint8_t B5EVN : 3;
		uint8_t _NA12 : 1;
		uint8_t B5ODD : 3;
	};
	union {
		uint8_t _NA13 : 1;
		uint8_t B6EVN : 3;
		uint8_t _NA14 : 1;
		uint8_t B6ODD : 3;
	};
	union {
		uint8_t _NA15 : 1;
		uint8_t B7EVN : 3;
		uint8_t _NA16 : 1;
		uint8_t B7ODD : 3;
	};
	uint8_t     BPCOMP;
	uint8_t     BPX;
	uint8_t     BPY;
	uint8_t     HPOS;
	uint8_t     VPOS;
	uint8_t     B0PIX;
	uint8_t     B1PIX;
	uint8_t     B2PIX;
	uint8_t     B3PIX;
	uint8_t     B4PIX;
	uint8_t     B5PIX;
	uint8_t     B6PIX;
	uint8_t     B7PIX;
	uint8_t     _NA17    [0xB9];
	uint8_t     PALRED   [0x100];
	uint8_t     PALGREEN [0x100];
	uint8_t     PALBLUE  [0x100];
	
};

struct _VIC4 {
	uint8_t     TBDRPOSLSB;
	union {
		uint8_t TBDRPOSMSB  : 4;
		uint8_t SPRBPMENLSB : 4;
	};
	uint8_t     BBDRPOSLSB;
	union {
		uint8_t BBDRPOSMSB  : 4;
		uint8_t SPRBPMENMSB : 4;
	};
	uint8_t     TEXTXPOSLSB;
	union {
		uint8_t TEXTXPOSMSB : 4;
		uint8_t SPRTILENLSB : 4;
	};
	uint8_t     TEXTYPOSLSB;
	union {
		uint8_t TEXTYPOSMSB : 4;
		uint8_t SPRTILENMSB : 4;
	};
	uint8_t     XPOSLSB;
	union {
		uint8_t XPOSMSB : 6;
		uint8_t DBLRR   : 1;
		uint8_t NORRDEL : 1;
	};
	uint8_t     FNRASTERLSB;
	union {
		uint8_t FNRASTERMSB : 3;
		uint8_t _NA1        : 2;
		uint8_t UPSCALE     : 1;
		uint8_t SHDEMU      : 1;
		uint8_t FNRST       : 1;
	};
	union {
		uint8_t CHR16  : 1;
		uint8_t FCLRLO : 1;
		uint8_t FCLRHI : 1;
		uint8_t SMTH   : 1;
		uint8_t SPR640 : 1;
		uint8_t PALEMU : 1;
		uint8_t VFAST  : 1;
		uint8_t ALPHEN : 1;
	};
	uint8_t     SPRHGTEN;
	uint8_t     SPRHGHT;
	uint8_t     SPRX64EN;
	uint16_t    LINESTEP;
	uint8_t     CHRXSCL;
	uint8_t     CHRYSCL;
	uint8_t     SDBDRWDLSB;
	union {
		uint8_t SDBDRWDMSB : 6;
		uint8_t RSTDELEN   : 1;
		uint8_t HOTREG     : 1;
	};
	uint8_t     CHRCOUNTLSB;
	uint8_t     SPRXSMSBS;
	uint16_t    SCRNPTR;
	uint8_t     SCRNPTRBNK;
	union {
		uint8_t SCRNPTRMB   : 4;
		uint8_t CHRCOUNTMSB : 2;
		uint8_t FCOLMCM     : 1;
		uint8_t EXGLYPH     : 1;
	};
	uint16_t    COLPTR;
	uint8_t     _NA2;
	uint8_t     SBPDEBUG;
	uint16_t    CHARPTR;
	uint8_t     CHARPTRBNK;
	uint8_t     SPR16EN;
	uint16_t    SPRPTRADR;
	union {
		uint8_t SPRPTADRRBNK : 7;
		uint8_t SPRPTR16     : 1;
	};
	union {
		uint8_t RASLINE0 : 6;
		uint8_t VGAHDTV  : 1;
		uint8_t PALNTSC  : 1;
	};
	union {
		uint8_t ABTPALSEL : 2;
		uint8_t SPRPALSEL : 2;
		uint8_t BTPALSEL  : 2;
		uint8_t MAPEDPAL  : 2;
	};
	uint8_t     BP16ENS;
	uint8_t     SPRYADJ;
	union {
		uint8_t ALPHADELAY   : 4;
		uint8_t RASTERHEIGHT : 4;
	};
	uint8_t     SPRENALPHA;
	uint8_t     SPRALPHAVAL;
	uint8_t     SPRENV400;
	uint8_t     SRPYMSBS;
	uint8_t     SPRYSMSBS;
	uint8_t     RSTCOMPLSB;
	union {
		uint8_t RSTCMPMSB   : 3;
		uint8_t SPTRCONT    : 1;
		uint8_t _NA3        : 1;
		uint8_t NOBUGCOMPAT : 1;
		uint8_t EXTIRQS     : 1;
		uint8_t FNRSTCMP    : 1;
	};
	uint8_t     DISPROWS;
	union {
		uint8_t BITPBANK : 3;
		uint8_t _NA4     : 1;
		uint8_t HSYNCP   : 1;
		uint8_t VSYNCP   : 1;
		uint8_t DEBUGC   : 2;
	};
	uint8_t     _NA5[0x84];
	uint8_t     PALRED   [0x100];
	uint8_t     PALGREEN [0x100];
	uint8_t     PALBLUE  [0x100];
};

struct _FDC {
	union {
		uint8_t DS    : 3;
		uint8_t SIDEF : 1;
		uint8_t SWAP  : 1;
		uint8_t MOTOR : 1;
		uint8_t LED   : 1;
		uint8_t IRQ   : 1;
	};
	union {
		uint8_t NOBUF : 1;
		uint8_t ALT   : 1;
		uint8_t ALGO  : 1;
		uint8_t DIR   : 1;
		uint8_t STEPF : 1;
		uint8_t FREE  : 1;
		uint8_t RDCMD : 1;
		uint8_t WRCMD : 1;
	};
	union {
		uint8_t TK0  : 1;
		uint8_t PROT : 1;
		uint8_t LOST : 1;
		uint8_t CRC  : 1;
		uint8_t RNF  : 1;
		uint8_t EQ   : 1;
		uint8_t DRQ  : 1;
		uint8_t BUSY : 1;
	};
	union {
		uint8_t DSKCHG  : 1;
		uint8_t C65_IRQ : 1;
		uint8_t INDEX   : 1;
		uint8_t DISKIN  : 1;
		uint8_t WGATE   : 1;
		uint8_t RUN     : 1;
		uint8_t WTREQ   : 1;
		uint8_t RDREQ   : 1;
	};
	uint8_t     TRACK;
	uint8_t     SECTOR;
	uint8_t     SIDE;
	uint8_t     DATA;
	uint8_t     CLOCK;
	uint8_t     STEP;
	uint8_t     PCODE;
};

struct _SID_VOICE {
	uint16_t    FREQUENCY;
	uint16_t    PULSE_WIDTH;
	uint8_t     CONTROL;		// Choosing to not expand all the bits, as you 
     				   			// can't use TRB/TSB with SID chips.
	uint8_t     ATTACKDECAY;
	uint8_t     SUSTAINRELEASE;
};

struct _SID {
	_SID_VOICE_t VOICE[3];

	uint8_t      CUTOFF_LSB;
	uint8_t      CUTOFF_MSB;
	uint8_t      RESONANCE_ROUTING;
	uint8_t      VOLUME_FTYPE;
};

struct _KEYSCAN {
	uint8_t     CRTACSCNT;
	uint8_t     MATRIXPEEK;
};

struct _DMA {
	uint8_t     ADDRLSBTRIG;
	uint8_t     ADDRMSB;
	uint8_t     ADDRBANK;
	uint8_t     EN018B;
	uint8_t     ADDRMB;
	uint8_t     ETRIG;
	uint8_t     ETRIGMAPD;
	uint8_t     _NA[7];
	uint8_t     ADDRLSB;
};

struct _MATH {
	union {
		uint8_t _NA1    : 6;
		uint8_t MULBUSY : 1;
		uint8_t DIVBUSY : 1;
	};
	uint8_t     _NA2[88];
	uint32_t    DIVOUT;
	uint32_t    DIVOUTFRACT;
	uint32_t    MATHINA;
	uint32_t    MATHINB;
	uint32_t    MULTOUT;
};

struct _AUDIO_CHANNEL {
	uint8_t     CONTROL;
	uint16_t    BADDR;
	uint8_t     BADDRMB;
	uint16_t    FREQ;
	uint8_t     FREQMB;
	uint16_t    TADDR;
	uint8_t     VOLUME;
	uint16_t    CURADDR;
	uint8_t     CURADDRMB;
	uint16_t    TMRADDR;
	uint8_t     TMRADDRMB;
};

struct _AUDIO_DMA {
	uint8_t          CH0RVOL;
	uint8_t          CH1RVOL;
	uint8_t          CH2LVOL;
	uint8_t          CH3LVOL;
	
	_AUDIO_CHANNEL_t CHANNELS[4];
};

// I can't get the CIA chips to work right.
struct _CIA1 {
	uint8_t     PORTA;
	uint8_t     PORTB;
	uint8_t     DDRA;
	uint8_t     DDRB;
	uint16_t    TIMERA;
	uint16_t    TIMERB;
	uint8_t     TODJIF;
	uint8_t     TODSEC;
	uint8_t     TODMIN;
	uint8_t     TODHOUR;
	uint8_t     SDR;
	uint8_t     ICR;
	uint8_t     CRA;
	uint8_t     CRB;
	uint8_t     TALATCH0;
	uint8_t     TALATCH1;
	uint8_t     TALATCH2;
	uint8_t     TALATCH3;
	uint8_t     TALATCH4;
	uint8_t     TALATCH5;
	uint8_t     TALATCH6;
	uint8_t     TALATCH7;
	uint8_t     IRM;
	uint8_t     GS_TODSEC;
	uint8_t     GS_TODMIN;
	uint8_t     GS_TODHOUR;
	uint8_t     ALRMJIF;
	uint8_t     ALRMSEC;
	uint8_t     ALRMMIN;
	uint8_t     ALRMHOUR;
};

struct _CIA2 {
	uint8_t     PORTA;
	uint8_t     PORTB;
	uint8_t     DDRA;
	uint8_t     DDRB;
	uint16_t    TIMERA;
	uint16_t    TIMERB;
	uint8_t     TODJIF;
	uint8_t     TODSEC;
	uint8_t     TODMIN;
	uint8_t     TODHOUR;
	uint8_t     SDR;
	uint8_t     ICR;
	uint8_t     CRA;
	uint8_t     CRB;
	uint8_t     TALATCH0;
	uint8_t     TALATCH1;
	uint8_t     TALATCH2;
	uint8_t     TALATCH3;
	uint8_t     TALATCH4;
	uint8_t     TALATCH5;
	uint8_t     TALATCH6;
	uint8_t     TALATCH7;
	uint8_t     IRM;
	uint8_t     GS_TODSEC;
	uint8_t     GS_TODMIN;
	uint8_t     GS_TODHOUR;
	uint8_t     ALRMJIF;
	uint8_t     ALRMSEC;
	uint8_t     ALRMMIN;
	uint8_t     ALRMHOUR;
};

struct _IRQ_VECTORS {
	uint16_t    NMI;
	uint16_t    COLDSTART;
	uint16_t    IRQ;
};

#define CPU         (* (volatile _CPU_t *)           0x00)
#define VIC2        (* (volatile _VIC2_t *)        0xd000)
#define VIC3        (* (volatile _VIC3_t *)        0xd02f)
#define VIC4        (* (volatile _VIC4_t *)        0xd048)
#define FDC         (* (volatile _FDC_t *)         0xd080)
#define SID1        (* (volatile _SID_t *)         0xd400)
#define SID2        (* (volatile _SID_t *)         0xd420)
#define SID3        (* (volatile _SID_t *)         0xd440)
#define SID4        (* (volatile _SID_t *)         0xd460)
#define KEYSCAN     (* (volatile _KEYSCAN_t *)     0xd613)
#define DMA         (* (volatile _DMA_t *)         0xd700)
#define MATH        (* (volatile _MATH_t *)        0xd70f)
#define AUDIO_DMA   (* (volatile _AUDIO_DMA_t *)   0xd71c)
#define CIA1        (* (volatile _CIA1_t *)        0xdc00)
#define CIA2        (* (volatile _CIA2_t *)        0xdd00)
#define IRQ_VECTORS (* (volatile _IRQ_VECTORS_t *) 0xfffa)

#endif
