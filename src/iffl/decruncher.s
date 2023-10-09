	.rtmodel version,"1"
	.rtmodel codeModel,"plain"
	.rtmodel core,"45gs02"
	.rtmodel target,"mega65"
	.extern _Zp

; -----------------------------------------------------------------------------------------------

; dc_base		= 0x02				; -
dc_bits: .equlab _Zp
dc_get_zp: .equlab	_Zp + 1

; original data

; FF FF FF FF FF FF FF FF FF FF 08 FE FE 08 FF FF
; FF 08 FE 08 08 FE 08 FF FF FE 08 08 FE FF FE FF
; FF FE 08 FF 08 FE FE FF FF 08 FE 08 FF FF FF FF
; FF FF 08 FE FE FE 08 FF FF FF FF FF FF FF FF FF
; FF FF FF FF FF FF FF FF FF FF FF 08 FE 08 FF FF
; FF FF FF FE 08 FE FF FF FF FF 08 FE FF FE 08 FF
; FF FF FE 08 FF 08 FE FF FF 08 FE FE FE FE FE 08
; FF FE 08 FF FF FF 08 FE FF FF FF FF FF FF FF FF
; FF FF FF FF FF FF FF FF FF FE FE FE FE FE 08 FF

; compressed data

; 0001372A

; 00 00 01 00 2A FF 1E A6 08 FE FE 08 26 16 1B 03
; 89 87 C4 73 9B 47 46 A3 63 E1 7D 8F F9 BD 04 FE
; B0 3C C4 F1 7F B3 27 98 FE 26 FE 65 FF FF


; 2A    0 0 1 0 1 0 1 0
; FF    1 1 1 1 1 1 1 1
; 1E    0 0 0 1 1 1 1 0
; A6    1 0 1 0 0 1 1 0
; 08    0 0 0 0 1 0 0 0
; FE    1 1 1 1 1 1 1 0
; FE    1 1 1 1 1 1 1 0
; 08    0 0 0 0 1 0 0 0
; 26    0 0 1 0 0 1 1 0
; 16    0 0 0 1 0 1 1 0
; 1B    0 0 0 1 1 0 1 1
; 03    0 0 0 0 0 0 1 1
; 89    1 0 0 0 1 0 0 1
; 87    1 0 0 0 0 1 1 1
; C4    1 1 0 0 0 1 0 0
; 73    0 1 1 1 0 0 1 1
; 9B    1 0 0 1 1 0 1 1
; 47    0 1 0 0 0 1 1 1

; ----------------------------------------------------

; 0 = literal run
; 1 = match

; 2A FF 1E A6 08 FE FE 08 26 16 1B 03 89 87 C4 73
; 9B 47 46 A3 63 E1 7D 8F F9 BD 04 FE B0 3C C4 F1

; 0x0000: Lit(1, F)
; 0x0001: Mat(1, 9, F)
; 0x000a: Lit(4, F)
; 0x000e: Mat(7, 4, F)
; 0x0012: Mat(6, 2, T)

; ----------------------------------------------------

; 80       10000000
; asl  1 < 00000000

; bits empty, get new bits

; 2a       00101010
; rol  0 < 01010101 < 1

; GETLEN (because c = 0)

;      A = 1
; asl  0 < 10101010
; carry clear, end

; GETLEN (because next sequence should be a match)

;              A = 1
; asl bits     10101000
;              01010100 c = 1          carry is one, continue adding to A
; asl bits     01010100
;              10101000 c = 0
; rol          A = 2                   7th bit 1, so continue
; asl bits     10101000
;              01010000 c = 1          carry is one, continue adding to A
; asl bits     01010000
;              10100000 c = 0
; rol          A = 4                   7th bit 1, so continue
; asl bits     10100000
;              01000000 c = 1          carry is one, continue adding to A
; asl bits     01000000
;              10000000 c = 0
; rol          A = 8                   7th bit 1, so continue
; asl bits     10000000
;              00000000 c = 0
;                                    dc_bits = 0 -> fetch next bits
; 
;              A = 8
;              00011110
; rol bits 0 < 00111100

; -----------------------------------------------------------------------------------------------

addput:
	clc
	tya
	adc dc_ldst+0
	sta dc_ldst+0
	bcc next1$
	lda dc_ldst+1
	adc #0x00
	sta dc_ldst+1
	bcc next1$
	lda dc_ldst+2
	adc #0x00
	sta dc_ldst+2

next1$:
	clc
	tya
	adc dc_mdst+0
	sta dc_mdst+0
	bcc next2$
	lda dc_mdst+1
	adc #0x00
	sta dc_mdst+1
	bcc next2$
	lda dc_mdst+2
	adc #0x00
	sta dc_mdst+2
next2$:
	rts

addget:
	clc
	tya
	adc dc_get_zp+0
	sta dc_get_zp+0
	bcc next$
	lda dc_get_zp+1
	adc #0x00
	sta dc_get_zp+1
	bcc next$
	lda dc_get_zp+2
	adc #0x00
	sta dc_get_zp+2
next$:
	rts

getlen:
	lda #1
glloop:
	jsr getnextbit
	bcc glend
	jsr rolnextbit									; if next bit is 1 then rol a the next-next bit into A
	bpl glloop										; if the highest bit is now still 0, continue. this means highest len is 255
glend:
	rts

rolnextbit:
	jsr getnextbit
	rol a												; rol sets N flag
	rts

getnextbit:
	asl dc_bits
	bne dgend
	pha
	jsr getnextbyte
	rol a
	sta dc_bits
	pla
dgend:
	rts

getnextbyte:
	lda [dc_get_zp],z
	inc dc_get_zp+0
	bne next$
	inc dc_get_zp+1
	bne next$
	inc dc_get_zp+2
next$:
	rts

; -----------------------------------------------------------------------------------------------

offsets:
	.byte 0b11011111 ; 3								; short offsets
	.byte 0b11111011 ; 6
	.byte 0b00000000 ; 8
	.byte 0b10000000 ; 10
	.byte 0b11101111 ; 4								; long offsets
	.byte 0b11111101 ; 7
	.byte 0b10000000 ; 10
	.byte 0b11110000 ; 13

; -----------------------------------------------------------------------------------------------

	.section code,text
	.public decrunch
decrunch:
	ldz #0x00
	jsr getnextbyte									; set unpack address
	sta dc_ldst+0
	sta dc_mdst+0
	jsr getnextbyte
	sta dc_ldst+1
	sta dc_mdst+1
	jsr getnextbyte
	sta dc_ldst+2
	sta dc_mdst+2
	jsr getnextbyte
	;sta dc_ldst+3									; ignore 4th byte (attic ram) for now
	;sta dc_mdst+3

	clc

	lda #0x80
	sta dc_bits

dloop:
	jsr getnextbit									; after this, carry is 0, bits = 01010101
	bcs match

	jsr getlen										; Literal run.. get length. after this, carry = 0, bits = 10101010, A = 1
	sta dc_llen
	tay												; put length into y for addput

	lda dc_get_zp+0
	sta dc_lsrc+0
	lda dc_get_zp+1
	sta dc_lsrc+1
	lda dc_get_zp+2
	sta dc_lsrc+2

	sta 0xd707										; inline DMA copy
	.byte 0x00										; end of job options
	.byte 0x00										; copy
dc_llen:
	.word 0x0000										; count
dc_lsrc:
	.word 0x0000										; src
	.byte 0x00										; src bank
dc_ldst:
	.word 0x0000										; dst
	.byte 0x00										; dst bank
	.byte 0x00										; cmd hi
	.word 0x0000										; modulo, ignored

	jsr addget
	jsr addput

	iny	
	beq dloop
													; has to continue with a match so fall through
match:
	jsr getlen										; match.. get length.

	tax												; length 255 -> EOF
	inx
	beq dc_end

	stx dc_mlen

	lda #0											; Get num bits
	cpx #3
	rol a
	jsr rolnextbit
	jsr rolnextbit
	tax
	lda offsets,x
	beq m8

loop$:
	jsr rolnextbit									; Get bits < 8
	bcs loop$
	bmi mshort

m8:
	eor #0xff										; Get byte
	tay
	jsr getnextbyte
	jmp mdone

	;.byte 0xae ; = jmp mdone (LDX 0xFFA0)

mshort:
	ldy #0xff

mdone:	;clc

							; HRMPF! HAVE TO DO THIS NASTY SHIT TO WORK AROUND DMA BUG :(((((
	ldx #0x00
	cmp #0xff				; compare A with ff
	bne next1$
	cpy #0xff				; compare Y with ff
	bne next1$
	ldx #0b00000010			; FFFF = -1 offset -> set source addressing to HOLD
next1$:
	stx dc_cmdh

	clc
	adc dc_mdst+0
	sta dc_msrc+0
	tya
	adc dc_mdst+1
	sta dc_msrc+1

	lda dc_mdst+2									; added for m65 for when we cross banks
	sta dc_msrc+2
	bcs next2$
	dec dc_msrc+2
next2$:
	sta 0xd707										; inline DMA copy
	.byte 0x00										; end of job options
	.byte 0x00										; copy
dc_mlen:
	.word 0x0000										; count
dc_msrc:
	.word 0x0000										; src
	.byte 0x00										; src bank and flags
dc_mdst:
	.word 0x0000										; dst
	.byte 0x00										; dst bank and flags
dc_cmdh:
	.byte 0x00										; cmd hi
	.word 0x0000										; modulo, ignored

	ldy dc_mlen
	jsr addput

	;beq dc_end
	jmp dloop

dc_end:
	rts

; -----------------------------------------------------------------------------------------------

dc_breaknow:
	.byte 0x00
