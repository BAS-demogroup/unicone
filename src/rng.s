	.rtmodel version,"1"
	.rtmodel codeModel,"plain"
	.rtmodel core,"45gs02"
	.rtmodel target,"mega65"
	.extern _Zp
	
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

rand_seed:
    .word 0x56ce, 0x0000
factor:
    .word 0x8435, 0x0bb3
offset:
    .word 0x636b, 0x3619
	