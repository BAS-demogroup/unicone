/// \file	music_swap_stub.asm
/// 
/// \brief	This file is a small assembly stub to handle the music interface
///
/// This stub maps in the music routines into bank 0, then executes the 
/// interface call, either intializing or playing the music, then maps the
/// music routines back out again
///
/// \copyright 2023 by BAS and deathy (AKA Clifford A. Anderson).  
/// All rights reserved.
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
