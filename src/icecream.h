#ifndef __ICECREAM_H
#define __ICECREAM_H

void update_falling_icecream();
void clear_falling_icecream();

extern unsigned short falling_icecream_x;
extern unsigned short falling_icecream_y;
extern char           falling_icecream_state;
extern char           stack_top;

#endif
