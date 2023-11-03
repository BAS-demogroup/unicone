#include "audio.h"


#include "chips.h"


	// @gardners:
	// so 44K1 = ( 44100 x 2^24 ) / ( 40.5 x 10^6 )
	// 40.5 * 10 ^ 6 = 40,500,000 (of course)
	// = 18269
	// = $00475D, assuming I got it right.
			
	// 11KHz = 11000 x 2 ^ 24 = 184,549,376,000
	// That / 40.5M = 4556.7747160493827160493827160494
	// = $0011cd
void play_sample(unsigned long start, unsigned short end, char sixteen_bit) {
	switch (next_channel) {
		case 0:
			// stop the channel - seems to be necessary if a sample has played
			// in the channel, even if it is no longer playing.
			AUDIO_DMA.CH0CONTROL = 0b00000000;
			
			AUDIO_DMA.CH0CURADDR = start & 0xffff;
			AUDIO_DMA.CH0CURADDRMB = (start & 0xff0000) >> 16;
			
			AUDIO_DMA.CH0TADDR = end;
			
			// set frequency
			AUDIO_DMA.CH0FREQ = 0x11cd;
			AUDIO_DMA.CH0FREQMB = 0x00;
			
			// max volume, and mono
			AUDIO_DMA.CH0VOLUME = 0x6f;
			AUDIO_DMA.CH0RVOL = 0x6f;

			// 16-bit signed, start playing
			if (sixteen_bit) {
				AUDIO_DMA.CH0CONTROL = 0b10000011;
			} else {
				AUDIO_DMA.CH0CONTROL = 0b10100010;
			}				
			
			break;
		case 1:
			// stop the channel - seems to be necessary if a sample has played
			// in the channel, even if it is no longer playing.
			AUDIO_DMA.CH1CONTROL = 0b00000000;
			
			AUDIO_DMA.CH1CURADDR = start & 0xffff;
			AUDIO_DMA.CH1CURADDRMB = (start & 0xff0000) >> 16;
			AUDIO_DMA.CH1TADDR = end;
			
			// set frequency
			AUDIO_DMA.CH1FREQ = 0x11cd;
			AUDIO_DMA.CH1FREQMB = 0x00;
			
			// max volume, and mono
			AUDIO_DMA.CH1VOLUME = 0x6f;
			AUDIO_DMA.CH1RVOL = 0x6f;

			// 16-bit signed, start playing
			if (sixteen_bit) {
				AUDIO_DMA.CH1CONTROL = 0b10000011;
			} else {
				AUDIO_DMA.CH1CONTROL = 0b10100010;
			}				
			
			break;
		case 2:
			// stop the channel - seems to be necessary if a sample has played
			// in the channel, even if it is no longer playing.
			AUDIO_DMA.CH2CONTROL = 0b00000000;
			
			AUDIO_DMA.CH2CURADDR = start & 0xffff;
			AUDIO_DMA.CH2CURADDRMB = (start & 0xff0000) >> 16;
			AUDIO_DMA.CH2TADDR = end;
			
			// set frequency
			AUDIO_DMA.CH2FREQ = 0x11cd;
			AUDIO_DMA.CH2FREQMB = 0x00;
			
			// max volume, and mono
			AUDIO_DMA.CH2VOLUME = 0x6f;
			AUDIO_DMA.CH2LVOL = 0x6f;

			// 16-bit signed, start playing
			if (sixteen_bit) {
				AUDIO_DMA.CH2CONTROL = 0b10000011;
			} else {
				AUDIO_DMA.CH2CONTROL = 0b10100010;
			}				
			
			break;
		case 3:
			// stop the channel - seems to be necessary if a sample has played
			// in the channel, even if it is no longer playing.
			AUDIO_DMA.CH3CONTROL = 0b00000000;
			
			AUDIO_DMA.CH3CURADDR = start & 0xffff;
			AUDIO_DMA.CH3CURADDRMB = (start & 0xff0000) >> 16;
			AUDIO_DMA.CH3TADDR = end;
			
			// set frequency
			AUDIO_DMA.CH3FREQ = 0x11cd;
			AUDIO_DMA.CH3FREQMB = 0x00;
			
			// max volume, and mono
			AUDIO_DMA.CH3VOLUME = 0x6f;
			AUDIO_DMA.CH3LVOL = 0x6f;

			// 16-bit signed, start playing
			if (sixteen_bit) {
				AUDIO_DMA.CH3CONTROL = 0b10000011;
			} else {
				AUDIO_DMA.CH3CONTROL = 0b10100010;
			}				
			
			break;
	}

	if (++next_channel > 3) {
		next_channel = 0;
	}
}

char next_channel;

unsigned long runtime_sample_start[6] = {
	0x022b00,	// game start 1
	0x029100,	// trot
	0x030000,	// falling
	0x02ac00,	// splat 1
	0x03b700,	// splat 2
	0x057c00	// splat 3
};

unsigned short runtime_sample_end[6] = {
	0x9048,
	0xab22,
	0xb6a4,
	0xd9ea,
	0xe51a,
	0xb83c
};


unsigned long game_over_sample_start[2] = {
	0x022b00,	// game over 1
	0x030000	// game over 2
};

unsigned short game_over_sample_end[2] = {
	0xb130,
	0xa730
};
