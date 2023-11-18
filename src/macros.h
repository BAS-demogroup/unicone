/// \file	macros.h
/// 
/// \brief	This file defines several macros used to make basic things simpler
///
/// This header file defines several macros to make basic reading and writing
/// of memory easier, as well as the basic music interface.
///
/// \copyright 2023 by BAS and deathy (AKA Clifford A. Anderson).  
/// All rights reserved.
#ifndef __MACROS_H
#define __MACROS_H

/// \brief	Set a memory location to a value
///
/// \param	a	The address to set
/// \param	t	The value to set the address to
#define poke(a, t) *((volatile char *)a) = t

/// \brief	Set a memory location in upper memory to a value
///
/// \param	a	The address to set
/// \param	t	The value to set the address to
#define farpoke(a, t) *((volatile __far char *)a) = t

/// \brief	Read a memory location
///
/// \param	a	The address to read
/// \returns	The value at the address
#define peek(a) *((volatile char *)a)

/// \brief	Set a specific bit mask at a memory location
///
/// \param	a	The address to set
/// \param	t	The bitmask to set at the location
#define set_bit(a, t) *((char *)a) |= t

/// \brief	Clear a specific bit mask at a memory location
///
/// \param	a	The address to clear
/// \param	t	The bitmask to clear at the location
#define clear_bit(a, t) *((char *)a) &= ~t

typedef void (*PROC_PTR)(void);

/// \brief	Initialize the music
#define musicInit ((PROC_PTR)0xc000)
/// \brief	Play the music
#define musicPlay ((PROC_PTR)0xc003)

#endif
