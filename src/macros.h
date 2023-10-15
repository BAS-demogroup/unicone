#ifndef __MACROS_H
#define __MACROS_H

#define poke(a, t) *((volatile char *)a) = t
#define peek(a) *((volatile char *)a)
#define set_bit(a, t) *((char *)a) |= t
#define clear_bit(a, t) *((char *)a) &= ~t

typedef void (*PROC_PTR)(void);

#define musicInit ((PROC_PTR)0x4000)
#define musicPlay ((PROC_PTR)0xc000)

#endif
