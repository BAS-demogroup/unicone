/// \file	tilemap.asm
/// 
/// \brief	This file is the static data for the tile map for the game
///
/// This Acme assembly file is used to construct the tile map data for use with 
/// the game.
///
/// \copyright 2023 by BAS and deathy (AKA Clifford A. Anderson).  
/// All rights reserved.
!to "build/tilemap.bin", plain

* = $2000
// line 01 - background
!word	$06e4,$06e4,$06e5,$06e4,$06e4,$06e4,$06e4,$06e4,$06e6,$06e7
!word	$06e4,$06e4,$06e4,$06e4,$06e4,$06e4,$06e4,$06e4,$06e4,$06e4
!word	$06e4,$06e4,$06e4,$06e4,$06e4,$06e4,$06e4,$06e4,$06e4,$06e4
!word	$06e4,$06e4,$06e4,$06e4,$06e8,$06e9,$06e4,$06e4,$06e4,$06e4

!word	$0260,$05b8,$05b8	// unicorn pixie
!word	$0270,$05b8			// tail
!word	$0270,$05b8			// mane

!word	$0270,$05b8,$0270
!word	$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270
!word	$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270
!word	$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270
!word	$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270
!word	$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270
!word	$05b8,$0270,$05b8,$0270,$05b8,$0260,$05b8,$05b8

// line 02 - background
!word	$06e4,$06ea,$06eb,$06ec,$06e4,$06e4,$06e4,$06ed,$06ee,$06ef
!word	$06e4,$06e4,$06e4,$06e4,$06e4,$06f0,$06f1,$06e4,$06e4,$06e4
!word	$06e4,$06e4,$06e4,$06e4,$06e4,$06e4,$06e4,$06e4,$06e4,$06e4
!word	$06e4,$06e4,$06e4,$06e4,$06f2,$06f3,$06e4,$06e4,$06e4,$06e4

!word	$0260,$05b8,$05b8	// unicorn pixie
!word	$0270,$05b8			// tail
!word	$0270,$05b8			// mane
!word	$0280,$0ea0			// g
!word	$0280,$0ea4			// a
!word	$0280,$0ea8			// m
!word	$0280,$0eac			// e
!word	$0280,$05b8			// space
!word	$0280,$0eb0			// o
!word	$0280,$0eb4			// v
!word	$0280,$0eb8			// e
!word	$0280,$0ebc			// r

!word	$0270,$05b8,$0270,$05b8,$0270
!word	$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270
!word	$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270
!word	$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270
!word	$05b8,$0270,$05b8,$0270,$05b8,$0260,$05b8,$05b8

// line 03 - background
!word	$06f4,$06f5,$06f6,$06f7,$06f4,$06f4,$06f4,$06f8,$06f9,$06fa
!word	$06f4,$06f4,$06f4,$06f4,$06fb,$06fc,$06fd,$06f4,$06f4,$06f4
!word	$06f4,$06f4,$06f4,$06f4,$06f4,$06f4,$06f4,$06f4,$06f4,$06f4
!word	$06f4,$06f4,$06f4,$06fe,$06ff,$0700,$06f4,$06f4,$06f4,$06f4

!word	$0260,$05b8,$05b8	// unicorn pixie
!word	$0270,$05b8			// tail
!word	$0270,$05b8			// mane
!word	$0280,$0ea1			// g
!word	$0280,$0ea5			// a
!word	$0280,$0ea9			// m
!word	$0280,$0ead			// e
!word	$0280,$05b8			// space
!word	$0280,$0eb1			// o
!word	$0280,$0eb5			// v
!word	$0280,$0eb9			// e
!word	$0280,$0ebd			// r

!word	$0270,$05b8,$0270,$05b8,$0270
!word	$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270
!word	$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270
!word	$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270
!word	$05b8,$0270,$05b8,$0270,$05b8,$0260,$05b8,$05b8

// line 04 - background
!word	$0701,$0702,$0703,$0704,$0701,$0701,$0701,$0705,$0706,$0707
!word	$0701,$0701,$0701,$0701,$0708,$0709,$070a,$0701,$0701,$0701
!word	$0701,$0701,$0701,$0701,$0701,$0701,$0701,$0701,$0701,$0701
!word	$0701,$0701,$0701,$0701,$0701,$0701,$0701,$0701,$0701,$0701

!word	$0260,$05b8,$05b8	// unicorn pixie
!word	$0270,$05b8			// tail
!word	$0270,$05b8			// reserved
!word	$0280,$0ea2			// g
!word	$0280,$0ea6			// a
!word	$0280,$0eaa			// m
!word	$0280,$0eae			// e
!word	$0280,$05b8			// space
!word	$0280,$0eb2			// o
!word	$0280,$0eb6			// v
!word	$0280,$0eba			// e
!word	$0280,$0ebe			// r

!word	$0270,$05b8,$0270,$05b8,$0270
!word	$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270
!word	$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270
!word	$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270
!word	$05b8,$0270,$05b8,$0270,$05b8,$0260,$05b8,$05b8

// line 05 - background
!word	$070b,$070b,$070b,$070b,$070b,$070b,$070b,$070b,$070b,$070b
!word	$070b,$070b,$070b,$070b,$070b,$070b,$070b,$070b,$070b,$070b
!word	$070b,$070b,$070b,$070b,$070b,$070b,$070b,$070b,$070b,$070b
!word	$070b,$070b,$070b,$070b,$070b,$070b,$070b,$070b,$070b,$070b

!word	$0260,$05b8,$05b8	// unicorn pixie
!word	$0270,$05b8			// reserved
!word	$0270,$05b8			// reserved
!word	$0280,$0ea3			// g
!word	$0280,$0ea7			// a
!word	$0280,$0eab			// m
!word	$0280,$0eaf			// e
!word	$0280,$05b8			// space
!word	$0280,$0eb3			// o
!word	$0280,$0eb7			// v
!word	$0280,$0ebb			// e
!word	$0280,$0ebf			// r

!word	$0270,$05b8,$0270,$05b8,$0270
!word	$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270
!word	$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270
!word	$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270
!word	$05b8,$0270,$05b8,$0270,$05b8,$0260,$05b8,$05b8

// line 06 - divider
!word	$070c,$070d,$070e,$070f,$0710,$0711,$0712,$0713,$0714,$070c
!word	$070d,$070e,$070f,$0710,$0711,$0712,$0713,$0714,$070c,$070d
!word	$070e,$070f,$0710,$0711,$0712,$0713,$0714,$070c,$070d,$070e
!word	$070f,$0710,$0711,$0712,$0713,$0714,$070c,$070d,$070e,$070f
// no pixies
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 07 - background
!word 	$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000
!word 	$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1001,$1002
!word 	$1002,$1002,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000
!word 	$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000

!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 08 - background
!word 	$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000
!word 	$1000,$1000,$1000,$1001,$1002,$1003,$1004,$1005,$1005,$1005
!word 	$1005,$1005,$1005,$1006,$1007,$1002,$1002,$1000,$1000,$1000
!word 	$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000

!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 09 - background
!word 	$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000
!word 	$1000,$1002,$1003,$1005,$1005,$1008,$1008,$1009,$100A,$100A
!word 	$100A,$100A,$1008,$1008,$1008,$100B,$1005,$1007,$1002,$100C
!word 	$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000

!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 10 - background
!word 	$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1001
!word 	$100D,$1005,$1008,$1009,$100E,$100F,$1010,$1011,$1011,$1012
!word 	$1012,$1011,$1011,$1013,$100F,$1014,$1015,$1008,$1016,$1017
!word 	$1002,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000

!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 11 - background
!word 	$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1003,$1005
!word 	$1018,$1019,$100F,$101A,$1012,$1012,$101B,$101C,$101C,$101C
!word 	$101C,$101C,$101C,$101C,$1012,$1012,$101D,$100F,$1015,$1008
!word 	$1005,$1007,$100C,$1000,$1000,$1000,$1000,$1000,$1000,$1000

!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 12 - background
!word 	$1000,$1000,$1000,$1000,$1000,$1000,$1000,$100D,$1005,$1009
!word 	$101E,$101F,$1012,$101B,$101C,$1020,$1021,$1022,$1023,$1024
!word 	$1024,$1024,$1022,$1025,$1026,$101C,$101C,$1012,$101D,$100F
!word 	$1008,$100B,$1017,$100C,$1000,$1000,$1000,$1000,$1000,$1000

!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 13 - background
!word 	$1000,$1000,$1000,$1000,$1000,$1001,$100D,$1018,$1019,$1010
!word 	$1012,$1027,$1028,$1021,$1023,$1029,$102A,$102A,$102A,$102B
!word 	$102C,$102D,$102A,$102A,$102E,$1024,$1025,$102F,$101C,$1012
!word 	$1013,$1030,$1031,$1017,$1002,$1000,$1000,$1000,$1000,$1000

!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 14 - background
!word 	$1000,$1000,$1000,$1000,$1000,$100D,$1018,$100E,$1032,$1012
!word 	$101C,$1033,$1023,$102A,$1034,$102C,$1035,$1036,$1037,$1037
!word 	$1037,$1037,$1038,$1039,$102C,$103A,$102A,$1024,$1025,$101C
!word 	$103B,$103C,$103D,$1031,$1017,$100C,$1000,$1000,$1000,$1000

!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 15 - background
!word 	$1000,$1000,$1000,$1000,$100D,$1018,$100E,$1032,$103E,$103F
!word 	$1021,$1029,$102A,$1035,$1036,$1037,$1040,$1041,$1041,$1041
!word 	$1041,$1041,$1041,$1042,$1037,$1043,$102C,$103A,$1044,$1045
!word 	$1046,$103B,$103C,$103D,$1031,$1017,$100C,$1000,$1000,$1000

!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 16 - background
!word 	$1000,$1000,$1000,$1001,$1005,$1047,$1032,$103E,$103F,$1048
!word 	$102A,$1049,$104A,$104B,$1041,$1041,$104C,$104C,$104D,$104D
!word 	$104D,$104D,$104C,$104C,$104E,$104F,$1050,$1051,$102C,$102E
!word 	$1024,$1046,$103B,$103C,$1030,$100B,$1002,$1000,$1000,$1000

!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 17 - background
!word 	$1000,$1000,$1000,$1052,$1047,$1053,$1012,$103F,$1021,$102A
!word 	$102C,$1054,$1055,$1041,$104C,$1056,$1057,$1058,$1059,$1059
!word 	$1059,$1059,$105A,$1057,$105B,$104C,$104E,$1042,$1043,$102C
!word 	$102E,$1045,$1046,$103B,$1013,$1008,$105C,$100C,$1000,$1000

!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 18 - background
!word 	$1000,$1000,$105D,$1018,$100E,$101F,$101B,$1033,$105E,$1049
!word 	$1054,$105F,$1060,$1061,$1057,$1059,$1059,$1062,$1062,$1063
!word 	$1064,$1062,$1062,$1065,$1066,$1067,$1068,$104E,$1069,$106A
!word 	$102C,$1044,$106B,$101C,$106C,$106D,$1031,$106E,$1000,$1000

!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 19 - background
!word 	$1000,$1000,$1052,$1047,$106F,$103E,$103F,$1070,$1049,$1036
!word 	$1055,$1060,$1061,$1071,$1059,$1062,$1072,$1073,$1074,$1075
!word 	$1075,$1076,$1073,$1077,$1062,$1078,$105A,$1079,$104E,$107A
!word 	$1051,$107B,$107C,$1046,$103B,$103C,$1008,$105C,$100C,$1000

!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 20 - background
!word 	$1000,$1001,$107D,$100E,$101F,$101B,$1048,$102A,$107E,$107F
!word 	$1080,$1061,$1071,$1081,$1082,$1073,$1083,$1083,$1084,$1084
!word 	$1084,$1084,$1083,$1085,$1086,$1062,$1065,$1087,$1068,$104E
!word 	$1050,$102C,$1088,$1089,$101C,$106C,$108A,$1031,$1002,$1000

!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 21 - background
!word 	$1000,$108B,$108C,$1053,$1012,$103F,$108D,$1049,$1036,$1041
!word 	$108E,$108F,$1059,$1082,$1090,$1083,$1091,$1092,$1093,$1094
!word 	$1094,$1094,$1095,$1084,$1083,$1086,$1062,$1078,$1067,$104C
!word 	$1069,$1096,$107B,$107C,$1046,$1097,$1098,$1031,$1017,$1000

!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 22 - background
!word 	$1000,$100D,$1099,$106F,$103E,$1033,$109A,$107E,$109B,$1080
!word 	$109C,$109D,$109E,$1090,$1083,$1091,$109F,$10A0,$10A1,$10A1
!word 	$10A1,$10A1,$10A2,$10A3,$1084,$1085,$10A4,$1062,$10A5,$10A6
!word 	$104E,$10A7,$102C,$10A8,$106B,$10A9,$103C,$10AA,$10AB,$100C

!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 23 - background
!word 	$1000,$1052,$10AC,$10AD,$1027,$10AE,$102A,$10AF,$1055,$10B0
!word 	$108F,$1059,$10B1,$10B2,$10B3,$109F,$10B4,$10B5,$10B6,$10B7
!word 	$10B8,$10B9,$10BA,$10BB,$10A3,$10BC,$1076,$10BD,$1078,$10BE
!word 	$104C,$10BF,$1051,$1088,$1089,$101C,$10C0,$1030,$105C,$100C

!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 24 - background
!word 	$1000,$1005,$10AC,$101F,$10C1,$1048,$1034,$1036,$10C2,$10C3
!word 	$10C4,$10C5,$10C6,$1083,$10C7,$10C8,$10A1,$10C9,$10CA,$10CB
!word 	$10CB,$10CC,$10CD,$10CE,$10CF,$10D0,$1085,$10D1,$10D2,$1087
!word 	$10D3,$1069,$10D4,$103A,$1089,$10D5,$10C0,$108A,$100B,$100C

!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 25 - background
!word 	$1000,$107D,$10AC,$10D6,$10C1,$10D7,$1049,$10D8,$10C2,$10C3
!word 	$10D9,$109E,$10C6,$10DA,$10DB,$10DC,$10DD,$10DE,$10CB,$10DF
!word 	$10E0,$10E1,$10E2,$10BA,$10E3,$10E4,$10E5,$10D1,$10D2,$10E6
!word 	$1068,$10E7,$10E8,$107B,$1024,$10D5,$106C,$10E9,$1031,$100C

!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 26 - background
!word 	$1000,$107D,$10AC,$10D6,$10C1,$10D7,$10EA,$10D8,$10C2,$10C3
!word 	$10D9,$109E,$10C6,$10DA,$10DB,$10DC,$10DD,$10EB,$10EC,$10ED
!word 	$10EE,$10E1,$10EF,$10BA,$10E3,$10E4,$10F0,$10D1,$10D2,$10E6
!word 	$1068,$10E7,$10E8,$107B,$1024,$10D5,$106C,$10E9,$1031,$100C

!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 27 - background
!word 	$1000,$107D,$10AC,$10D6,$10C1,$10D7,$10EA,$10D8,$10C2,$10C3
!word 	$10D9,$109E,$10C6,$10DA,$10DB,$10DC,$10DD,$10EB,$10EC,$10ED
!word 	$10EE,$10E1,$10EF,$10BA,$10E3,$10E4,$10F0,$10D1,$10D2,$10E6
!word 	$1068,$10E7,$10E8,$107B,$1024,$10D5,$106C,$10E9,$1031,$100C

!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 28 - background
!word 	$1000,$1052,$10AC,$1100,$10C1,$10AE,$1101,$10AF,$1102,$108E
!word 	$1103,$1104,$10B1,$1105,$1106,$1107,$1108,$1109,$10F5,$110A
!word 	$110A,$110B,$110C,$110D,$110E,$10BC,$110F,$1110,$1111,$10FE
!word 	$10D3,$10BF,$10D4,$1088,$1089,$10D5,$10C0,$108A,$105C,$100C

!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 29 - background
!word 	$1000,$1052,$1099,$1100,$103E,$1112,$109A,$10AF,$1113,$1080
!word 	$1114,$1115,$1116,$1117,$10F1,$1118,$1119,$1108,$111A,$111B
!word 	$111B,$111C,$111D,$1119,$10D0,$111E,$111F,$1120,$10E6,$1121
!word 	$1122,$10A7,$1123,$1088,$1124,$10A9,$1125,$10AA,$105C,$100C

!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 30 - background
!word 	$1000,$105D,$108C,$1126,$1127,$1128,$1129,$10EA,$10D8,$10C2
!word 	$112A,$112B,$1104,$10B1,$112C,$112D,$1118,$112E,$1119,$10F3
!word 	$112F,$1119,$110E,$1130,$111E,$1117,$1110,$1111,$10FE,$1131
!word 	$1132,$1133,$107B,$107C,$1134,$1097,$1125,$1135,$106E,$1000

!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 31 - background
!word 	$1000,$1136,$107D,$1137,$1138,$10C1,$10AE,$1101,$10AF,$1113
!word 	$1139,$1114,$113A,$113B,$10B1,$1117,$113C,$112D,$113D,$1118
!word 	$113E,$113D,$113F,$1140,$1117,$1141,$1142,$1143,$1121,$1122
!word 	$1144,$1145,$1088,$1089,$10D5,$10C0,$10E9,$1031,$1146,$1000

!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 32 - background
!word 	$1000,$1000,$1052,$1147,$1148,$103E,$1128,$1129,$10EA,$10D8
!word 	$1149,$108E,$1114,$113A,$1104,$114A,$114B,$1117,$114C,$114C
!word 	$114C,$114D,$1117,$111F,$114E,$1142,$1143,$114F,$1150,$10BF
!word 	$10E8,$107B,$107C,$1134,$1097,$1125,$10AA,$105C,$100C,$1000

!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 33 - background
!word 	$1000,$1000,$105D,$1151,$1126,$1152,$10C1,$10AE,$109A,$1153
!word 	$1154,$1155,$108E,$1114,$112B,$1115,$1156,$114A,$114E,$114E
!word 	$114E,$114E,$1157,$1142,$1158,$112B,$114F,$1150,$1155,$1133
!word 	$1123,$1159,$115A,$10D5,$10C0,$10E9,$1031,$106E,$1000,$1000

!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 34 - background
!word 	$1000,$1000,$1000,$115B,$115C,$115D,$1127,$115E,$115F,$1101
!word 	$1160,$1154,$1149,$1161,$1162,$112B,$112B,$1163,$1158,$1158
!word 	$1158,$1158,$1164,$112B,$112B,$1165,$1166,$10BF,$1154,$1123
!word 	$1088,$1089,$1167,$1168,$1125,$10AA,$105C,$1000,$1000,$1000

!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 35 - background
!word 	$1000,$1000,$1000,$1136,$1169,$10AC,$1148,$1127,$116A,$115F
!word 	$1101,$1153,$1154,$116B,$116C,$1161,$1162,$116D,$112B,$112B
!word 	$112B,$112B,$116E,$1162,$1150,$1132,$1144,$1133,$1123,$1088
!word 	$116F,$1167,$1097,$1170,$1171,$1172,$1146,$1000,$1000,$1000

!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 36 - background
!word 	$1000,$1000,$1000,$1000,$105D,$1151,$1137,$1100,$1127,$115E
!word 	$115A,$1173,$1174,$1175,$1154,$116B,$1155,$116C,$1176,$1177
!word 	$1177,$1178,$1132,$1155,$1179,$1154,$117A,$117B,$1159,$115A
!word 	$1167,$117C,$1170,$10E9,$1031,$106E,$1000,$1000,$1000,$1000

!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 37 - background
!word 	$1000,$1000,$1000,$1000,$1000,$117D,$117E,$1137,$1148,$1127
!word 	$115E,$10AE,$117F,$1180,$1181,$1160,$1182,$1154,$1154,$1154
!word 	$1154,$1154,$1154,$1133,$1160,$117B,$1159,$116F,$115A,$116A
!word 	$1168,$1170,$10E9,$1135,$1183,$1000,$1000,$1000,$1000,$1000

!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 38 - background
!word 	$1000,$1000,$1000,$1000,$1000,$1000,$117D,$1151,$1137,$1148
!word 	$1184,$1185,$116A,$115A,$1186,$1173,$1187,$1181,$1181,$1153
!word 	$1160,$1181,$1188,$1187,$1173,$116F,$115A,$1167,$1189,$118A
!word 	$115D,$1171,$1135,$118B,$1000,$1000,$1000,$1000,$1000,$1000

!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 39 - background
!word 	$1000,$1000,$1000,$1000,$1000,$1000,$1000,$105D,$118C,$118D
!word 	$115D,$118E,$118F,$1185,$116A,$1190,$115A,$115A,$1186,$1186
!word 	$1186,$1186,$115A,$115A,$1124,$1167,$1189,$118A,$1170,$115D
!word 	$1171,$1172,$106E,$1000,$1000,$1000,$1000,$1000,$1000,$1000

!word	$0260,$05b8,$05b8	// cone shadow
!word	$0260,$05b8,$05b8	// cone
!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8

// line 40 - background
!word 	$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1136,$118B
!word 	$115C,$1137,$115D,$1148,$1184,$1191,$1185,$1192,$116A,$116A
!word 	$116A,$116A,$1193,$1194,$1195,$1184,$1196,$115D,$1171,$1135
!word 	$1183,$1146,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000

!word	$0260,$05b8,$05b8	// cone shadow
!word	$0260,$05b8,$05b8	// cone
!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8

// line 41 - background
!word 	$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000
!word 	$117D,$1197,$1198,$118D,$115D,$115D,$1148,$118E,$1152,$1184
!word 	$1184,$1199,$118E,$115D,$115D,$119A,$1171,$1135,$119B,$118B
!word 	$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000

!word	$0260,$05b8,$05b8	// cone shadow
!word	$0260,$05b8,$05b8	// cone
!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8

// line 42 - background
!word 	$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000
!word 	$1000,$1000,$119C,$118B,$119D,$1198,$118D,$118D,$119E,$119E
!word 	$119E,$119E,$118D,$118D,$119F,$1172,$1183,$11A0,$1000,$1000
!word 	$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000

!word	$0260,$05b8,$05b8	// cone shadow
!word	$0260,$05b8,$05b8	// cone
!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8

// line 43 - background
!word 	$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000
!word 	$1000,$1000,$1000,$1000,$1000,$1136,$117D,$118B,$118B,$118B
!word 	$118B,$118B,$118B,$118B,$11A1,$1000,$1000,$1000,$1000,$1000
!word 	$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000

!word	$0260,$05b8,$05b8	// cone shadow
!word	$0260,$05b8,$05b8	// cone
!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8

// line 44 - background
!word 	$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000
!word 	$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000
!word 	$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000
!word 	$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000,$1000

!word	$0260,$05b8,$05b8	// cone shadow
!word	$0260,$05b8,$05b8	// cone
!word	$0260,$05b8,$05b8	// stacked icecream 1 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 2 shadow
!word	$0260,$05b8,$05b8	// stacked icecream 3 shadow
!word	$0270,$05b8			// small stacked icecream shadow a
!word	$0270,$05b8			// small stacked icecream shadow b
!word	$0260,$05b8,$05b8	// falling icecream 1 shadow
!word	$0260,$05b8,$05b8	// falling icecream 2 shadow
!word	$0260,$05b8,$05b8	// falling icecream 3 shadow
!word	$0270,$05b8			// small falling icecream shadow a
!word	$0270,$05b8			// small falling icecream shadow b
!word	$0270,$05b8			// effect shadow a
!word	$0270,$05b8			// effect shadow b
!word	$0260,$05b8,$05b8	// stacked icecream 1
!word	$0260,$05b8,$05b8	// stacked icecream 2
!word	$0260,$05b8,$05b8	// stacked icecream 3
!word	$0270,$05b8			// small stacked icecream a
!word	$0270,$05b8			// small stacked icecream b
!word	$0260,$05b8,$05b8	// falling icecream 1 
!word	$0260,$05b8,$05b8	// falling icecream 2
!word	$0260,$05b8,$05b8	// falling icecream 3 
!word	$0270,$05b8			// small falling icecream a
!word	$0270,$05b8			// small falling icecream b
!word	$0270,$05b8			// effect a
!word	$0270,$05b8			// effect b

!word	$0270,$05b8

// line 45 - divider
!word	$0697,$0697,$0697,$0697,$0697,$0697,$0697,$0697,$0697,$0697
!word	$0697,$0697,$0697,$0697,$0697,$0697,$0697,$0697,$0697,$0697
!word	$0697,$0697,$0697,$0697,$0697,$0697,$0697,$0697,$0697,$0697
!word	$0697,$0697,$0697,$0697,$0697,$0697,$0697,$0697,$0697,$0697
// no pixies
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 46 - stats
!word	$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8
!word	$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8
!word	$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8
!word	$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8

!word   $0280,$05b8,$05b8       // level number 1
!word   $0280,$05b8,$05b8       // level number 2
!word	$0280,$0694				// life shadow 1
!word	$0280,$0694				// life shadow 2
!word	$0280,$0694				// life shadow 3
!word	$0280,$0691			    // life 1
!word	$0280,$0691			    // life 2
!word	$0280,$0691			    // life 3

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 47 - stats
!word	$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8
!word	$05b8,$05b8,$05b8,$0699,$069a,$069b,$069c,$069d,$069e,$05b8
!word	$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8
!word	$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8

!word   $0280,$05b8,$05b8       // level number 1
!word   $0280,$05b8,$05b8       // level number 2
!word	$0280,$0695				// life shadow 1
!word	$0280,$0695				// life shadow 2
!word	$0280,$0695				// life shadow 3
!word	$0280,$0692			    // life 1
!word	$0280,$0692			    // life 2
!word	$0280,$0692			    // life 3

!word	$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 48 - stats
!word	$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8
!word	$05b8,$05b8,$05b8,$06a0,$06a1,$06a2,$06a3,$06a4,$069e,$05b8
!word	$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8
!word	$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8

!word   $0280,$05b8,$05b8       // level number 1
!word   $0280,$05b8,$05b8       // level number 2

!word	$0270,$05b8,$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 49 - stats
!word	$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8
!word	$05b8,$05b8,$05b8,$06a5,$06a6,$06a7,$06a8,$06a9,$06aa,$05b8
!word	$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8
!word	$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8

!word   $0280,$05b8,$05b8       // level number 1
!word   $0280,$05b8,$05b8       // level number 2

!word	$0270,$05b8,$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8
!word	$0270,$05b8,$0270,$05b8,$0270,$05b8,$0270,$05b8

// line 50 - stats
!word	$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8
!word	$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8
!word	$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8
!word	$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8,$05b8

!word   $0280,$05b8,$05b8       // level number 1
!word   $0280,$05b8,$05b8       // level number 2

!word	$0280,$0280,$0280,$0280
!word	$0280,$0280,$0280,$0280,$0280,$0280,$0280,$0280,$0280,$0280
!word	$0280,$0280,$0280,$0280,$0280,$0280,$0280,$0280,$0280,$0280
!word	$0280,$0280,$0280,$0280,$0280,$0280,$0280,$0280,$0280,$0280
!word	$0280,$0280,$0280,$0280,$0280,$0280,$0280,$0280,$0280,$0280
!word	$0280,$0280,$0280,$0280,$0280,$0280,$0280,$0280,$0280,$0280
!word	$0280,$0280,$0280,$0280,$0280,$0280,$0280,$05b8
