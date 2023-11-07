/// \file	rng.c
/// 
/// \brief	This file is the code for the pseudo-random number generator
///
/// \copyright 2023 by BAS and deathy (AKA Clifford A. Anderson).  
/// All rights reserved.
	.rtmodel version,"1"
	.rtmodel codeModel,"plain"
	.rtmodel core,"45gs02"
	.rtmodel target,"mega65"
	.extern _Zp

/// \brief	This procedure generates a 32 bit random number
/// 
///	This procedure generates a 32 bit random number using the pseudo-random 
/// number generator popular in many audio engineering applications.
/// 
/// \returns	A 32 bit RNG using all 4 registers
	.section code,text
	.public random
random:
    ldq 	rand_seed
    stq 	0xd770
    ldq 	factor
    stq 	0xd774
    ldq 	0xd778
	clc
    adcq 	offset
    stq 	rand_seed
	stq		_Zp
    rts

/// \brief	The last random number that was generated, or the initial seed
rand_seed:
    .word 0x56ce, 0x0000
	
/// \brief	This constant is multiplied by the seed to generate the RNG
factor:
    .word 0x8435, 0x0bb3
	
/// \brief	This offset is then added to the generated RNG to shuffle the bits
///			more.
offset:
    .word 0x636b, 0x3619
