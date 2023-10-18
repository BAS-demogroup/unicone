!to "build/music_swap_stub.bin", plain
!cpu m65

* = $c000

	jmp init
	jmp play
	
init:
	lda #$c0 
	tax
	tay
	ldz #$30 
	map
	eom
	
	jsr $4000
	
	lda #$00
	tax
	tay
	taz
	map
	eom
	
	rts

play:
	lda #$c0 
	tax
	tay
	ldz #$30 
	map
	eom
	
	jsr $4003
	
	lda #$00
	tax
	tay
	taz
	map
	eom
	
	rts
