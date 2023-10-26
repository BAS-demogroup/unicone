#ifndef __AUDIO_H
#define __AUDIO_H

void play_sample(unsigned long start, unsigned short end, char sixteen_bit);

extern char next_channel;

extern unsigned long game_start_sample_start[1];
extern unsigned short game_start_sample_end[1];

extern unsigned long runtime_sample_start[5];
extern unsigned short runtime_sample_end[5];

extern unsigned long game_over_sample_start[2];
extern unsigned short game_over_sample_end[2];

#endif
