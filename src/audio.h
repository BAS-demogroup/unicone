/// \file	audio.h
/// 
/// \brief	This file is the header file that declares most of the audio code
///
/// This header file declares the procedures and structures that handle most of
/// the audio samples and hard stopping the SID audio.
///
/// \copyright 2023 by BAS and deathy (AKA Clifford A. Anderson).  
/// All rights reserved.
#ifndef __AUDIO_H
#define __AUDIO_H

void play_sample(unsigned long start, unsigned short end, char sixteen_bit);
void stop_all_SID_voices();

extern char next_channel;

extern unsigned long runtime_sample_start[6];
extern unsigned short runtime_sample_end[6];

extern unsigned long level_complete_sample_start[1];
extern unsigned short level_complete_sample_end[1];

extern unsigned long game_over_sample_start[2];
extern unsigned short game_over_sample_end[2];

#endif
