	.section code
	.public set_bits
	.extern addr
	.extern val
set_bits:
	lda #val
	tsb addr

	.section code
	.public clear_bits
	.extern addr
	.extern val
clear_bits:
	lda #val
	trb addr
	