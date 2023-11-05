/// \file	audio.c
/// 
/// \brief	This file is the c file that contains most of the audio code
///
/// This file contains the procedures and structures that handle most of
/// the audio samples and hard stopping the SID audio.
///
/// \copyright 2023 by BAS and deathy (AKA Clifford A. Anderson).  
/// All rights reserved.
#include "audio.h"


#include "chips.h"


/// \brief	This procedure is called to play a sample
/// 
/// This procedure is called to play a sample, rotating through each channel
/// so that up to 4 samples could be played simultaneously.
///
/// \param	start		The beginning of the sample to play in fast RAM
/// \param	end			The end point of the sample, expressed only as the 
///						memory location in the same bank as it started.
/// \param	sixteen_bit	A toggle for whether the sample is 16 bit, or 8-bit.
void play_sample(unsigned long start, unsigned short end, char sixteen_bit) {
	// stop the channel - seems to be necessary if a sample has played
	// in the channel, even if it is no longer playing.
	AUDIO_DMA.CHANNELS[next_channel].CONTROL = 0b00000000;
	
	// set the start of the sample 
	AUDIO_DMA.CHANNELS[next_channel].CURADDR = start & 0xffff;
	AUDIO_DMA.CHANNELS[next_channel].CURADDRMB = (start & 0xff0000) >> 16;
	
	// set the end address (top) of the sample
	AUDIO_DMA.CHANNELS[next_channel].TADDR = end;

	// the frequency calculation
	//
	// @gardners:
	// so 44K1 = ( 44100 x 2^24 ) / ( 40.5 x 10^6 )
	// 40.5 * 10 ^ 6 = 40,500,000 (of course)
	// = 18269
	// = $00475D, assuming I got it right.
	//
	// 11KHz = 11000 x 2 ^ 24 = 184,549,376,000
	// That / 40.5M = 4556.7747160493827160493827160494
	// = $0011cd
	
	// set frequency to 11KHz
	AUDIO_DMA.CHANNELS[next_channel].FREQ = 0x11cd;
	AUDIO_DMA.CHANNELS[next_channel].FREQMB = 0x00;
	
	// set the volume to approximately 43%, so that the samples do not 
	// overpower the SID music.
	AUDIO_DMA.CHANNELS[next_channel].VOLUME = 0x6f;

	if (sixteen_bit) {
		// 16-bit signed, start playing
		// (16 bit signed flag is inverted for 16 bit, or something like that)
		AUDIO_DMA.CHANNELS[next_channel].CONTROL = 0b10000011;
	} else {
		// 8-bit signed, start playing
		AUDIO_DMA.CHANNELS[next_channel].CONTROL = 0b10100010;
	}				

	// advance the channel index for the next sample
	if (++next_channel > 3) {
		next_channel = 0;
	}
}

/// \brief	This procedure turns off the gates on all of the voices.
///
/// This procedure sets all the voice gates off so that we can switch between
/// songs.
void stop_all_SID_voices() {
	for (char v = 0; v < 3; v++) {
		SID1.VOICE[v].CONTROL = 0x00;
		SID2.VOICE[v].CONTROL = 0x00;
		SID3.VOICE[v].CONTROL = 0x00;
		SID4.VOICE[v].CONTROL = 0x00;
	};
}


/// \brief	This variable is used to rotate sample channels.
char next_channel;

/// \brief	This array holds the addresses of the start of each of the in-game
///			sound effects
unsigned long runtime_sample_start[6] = {
	0x022b00,	// game start 1
	0x029100,	// trot
	0x030000,	// falling
	0x02ac00,	// splat 1
	0x03b700,	// splat 2
	0x057c00	// splat 3
};

/// \brief	This array holds the addresses of the end of each of the in-game
///			samples
unsigned short runtime_sample_end[6] = {
	0x9048,		// game start 1
	0xab22,		// trot
	0xb6a4,		// falling
	0xd9ea,		// splat 1
	0xe51a,		// splat 2
	0xb83c  	// splat 3 
};


/// \brief	This array holds the addresses of the start of each of the game 
///			over sound effects
unsigned long game_over_sample_start[2] = {
	0x022b00,	// game over 1
	0x030000	// game over 2
};

/// \brief	This array holds the addresses of the end of each of the game over
///			sound effects
unsigned short game_over_sample_end[2] = {
	0xb130,	    // game over 1
	0xa730  	// game over 2 
};
