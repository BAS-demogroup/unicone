/// \file	attrmap.asm
/// 
/// \brief	This file is the static data for the attribute map for the game
///
/// This Acme assembly file is used to construct the attribute map data for use
/// with the game.
///
/// \copyright 2023 by BAS and deathy (AKA Clifford A. Anderson).  
/// All rights reserved.
!to "build/attrmap.bin", plain

* = $2000
// line 01 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$1f08,$1f08	// unicorn pixie
!word	$0090,$0f08			// tail
!word	$0090,$0f08			// mane

!word	$0090,$0f08,$0090
!word	$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090
!word	$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090
!word	$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090
!word	$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090
!word	$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090
!word	$0f08,$0090,$0f08,$0090,$0f08,$0260,$0f08,$0f08

// line 02 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$1f08,$1f08	// unicorn pixie
!word	$0090,$0f08			// tail
!word	$0090,$0f08			// mane

!word	$0090,$0f08,$0090
!word	$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090
!word	$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090
!word	$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090
!word	$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090
!word	$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090
!word	$0f08,$0090,$0f08,$0090,$0f08,$0260,$0f08,$0f08

// line 03 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$1f08,$1f08	// unicorn pixie
!word	$0090,$0f08			// tail
!word	$0090,$0f08			// mane

!word	$0090,$0f08,$0090
!word	$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090
!word	$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090
!word	$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090
!word	$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090
!word	$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090
!word	$0f08,$0090,$0f08,$0090,$0f08,$0260,$0f08,$0f08

// line 04 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$1f08,$1f08	// unicorn pixie
!word	$0090,$0f08			// tail

!word	$0090,$0f08,$0090,$0f08,$0090
!word	$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090
!word	$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090
!word	$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090
!word	$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090
!word	$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090
!word	$0f08,$0090,$0f08,$0090,$0f08,$0260,$0f08,$0f08

// line 05 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$1f08,$1f08	// unicorn pixie

!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090
!word	$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090
!word	$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090
!word	$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090
!word	$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090
!word	$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090
!word	$0f08,$0090,$0f08,$0090,$0f08,$0260,$0f08,$0f08

// line 06 - divider
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
// no pixies
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 07 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 08 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 09 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 10 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 11 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 12 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 13 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 14 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 15 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 16 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 17 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 18 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 19 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 20 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 21 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 22 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 23 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 24 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 25 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 26 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 27 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 28 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 29 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 30 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 31 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 32 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 33 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 34 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 35 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 36 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 37 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 38 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 39 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$2f08,$2f08	// cone shadow
!word	$0090,$2f08,$2f08	// cone
!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08

// line 40 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$2f08,$2f08	// cone shadow
!word	$0090,$2f08,$2f08	// cone
!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08

// line 41 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$2f08,$2f08	// cone shadow
!word	$0090,$2f08,$2f08	// cone
!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08

// line 42 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$2f08,$2f08	// cone shadow
!word	$0090,$2f08,$2f08	// cone
!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08

// line 43 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$2f08,$2f08	// cone shadow
!word	$0090,$2f08,$2f08	// cone
!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08

// line 44 - background
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08
!word	$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08,$3f08

!word	$0090,$2f08,$2f08	// cone shadow
!word	$0090,$2f08,$2f08	// cone
!word	$0090,$0f08,$0f08	// stacked ice cream 1 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 2 shadow
!word	$0090,$0f08,$0f08	// stacked ice cream 3 shadow
!word	$0090,$0f08			// small stacked ice cream shadow a
!word	$0090,$0f08			// small stacked ice cream shadow b
!word	$0090,$0f08,$0f08	// falling ice cream 1 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 2 shadow
!word	$0090,$0f08,$0f08	// falling ice cream 3 shadow
!word	$0090,$0f08			// small falling ice cream shadow a
!word	$0090,$0f08			// small falling ice cream shadow b
!word	$0090,$0f08			// effect shadow a
!word	$0090,$1f08			// effect shadow b
!word	$0090,$0f08,$0f08	// stacked ice cream 1 
!word	$0090,$0f08,$0f08	// stacked ice cream 2 
!word	$0090,$0f08,$0f08	// stacked ice cream 3
!word	$0090,$0f08			// small stacked ice cream a
!word	$0090,$0f08			// small stacked ice cream b
!word	$0090,$0f08,$0f08	// falling ice cream 1 
!word	$0090,$0f08,$0f08	// falling ice cream 2 
!word	$0090,$0f08,$0f08	// falling ice cream 3 
!word	$0090,$0f08			// small falling ice cream a
!word	$0090,$0f08			// small falling ice cream b
!word	$0090,$0f08			// effect a
!word	$0090,$1f08			// effect b

!word	$0090,$0f08

// line 45 - divider
!word	$1f08,$1f08,$1f08,$1f08,$1f08,$1f08,$1f08,$1f08,$1f08,$1f08
!word	$1f08,$1f08,$1f08,$1f08,$1f08,$1f08,$1f08,$1f08,$1f08,$1f08
!word	$1f08,$1f08,$1f08,$1f08,$1f08,$1f08,$1f08,$1f08,$1f08,$1f08
!word	$1f08,$1f08,$1f08,$1f08,$1f08,$1f08,$1f08,$1f08,$1f08,$1f08
// no pixies
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 46 - stats
!word	$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08
!word	$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08
!word	$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08
!word	$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08

!word   $0090,$0f08,$0f08       // level number 1
!word   $0090,$0f08,$0f08       // level number 2
!word	$0090,$2f08				// life shadow 1
!word	$0090,$2f08				// life shadow 2
!word	$0090,$2f08				// life shadow 3
!word	$0090,$2f08			    // life 1
!word	$0090,$2f08			    // life 2
!word	$0090,$2f08			    // life 3

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 47 - stats
!word	$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08
!word	$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08
!word	$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08
!word	$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08

!word   $0090,$0f08,$0f08       // level number 1
!word   $0090,$0f08,$0f08       // level number 2
!word	$0090,$2f08				// life shadow 1
!word	$0090,$2f08				// life shadow 2
!word	$0090,$2f08				// life shadow 3
!word	$0090,$2f08			    // life 1
!word	$0090,$2f08			    // life 2
!word	$0090,$2f08			    // life 3

!word	$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 48 - stats
!word	$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08
!word	$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08
!word	$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08
!word	$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08

!word   $0090,$0f08,$0f08       // level number 1
!word   $0090,$0f08,$0f08       // level number 2

!word	$0090,$0f08,$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 49 - stats
!word	$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08
!word	$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08
!word	$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08
!word	$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08

!word   $0090,$0f08,$0f08       // level number 1
!word   $0090,$0f08,$0f08       // level number 2

!word	$0090,$0f08,$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08
!word	$0090,$0f08,$0090,$0f08,$0090,$0f08,$0090,$0f08

// line 50 - stats
!word	$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08
!word	$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08
!word	$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08
!word	$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08,$0f08

!word   $0090,$0f08,$0f08       // level number 1
!word   $0090,$0f08,$0f08       // level number 2

!word	$0090,$0090,$0090,$0090
!word	$0090,$0090,$0090,$0090,$0090,$0090,$0090,$0090,$0090,$0090
!word	$0090,$0090,$0090,$0090,$0090,$0090,$0090,$0090,$0090,$0090
!word	$0090,$0090,$0090,$0090,$0090,$0090,$0090,$0090,$0090,$0090
!word	$0090,$0090,$0090,$0090,$0090,$0090,$0090,$0090,$0090,$0090
!word	$0090,$0090,$0090,$0090,$0090,$0090,$0090,$0090,$0090,$0090
!word	$0090,$0090,$0090,$0090,$0090,$0090,$0090,$0f08
