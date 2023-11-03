!to "megakitty_theme_1.prg", plain
!cpu m65

!set title = "megakitty theme 1"
!set author = "deathy/bas"

;!set include_stub = 1
!set ghost_registers = 1

!set looping = 1
!set uses_fmode_volume = 1
!set uses_cutoff = 1
!set uses_res_routing = 1

!set nt_uses_susto = 0
!set nt_uses_goto = 0
!set nt_uses_end = 1
!set pt_uses_end = 1
!set wt_uses_end = 1

!addr cmd_delay = bit_01
!addr cmd_fmode_volume = bit_02
!addr cmd_cutoff = bit_04
!addr cmd_resonance_routing = bit_08
!addr cmd_programchange = bit_10
!addr cmd_noteon = bit_20
!addr cmd_hardrestart = bit_40

!ifdef include_stub {
	* = $2001
	
	!byte $16,$20			;End of command marker (first byte after the 00 terminator)
	!byte $0a,$00			;10
	!byte $fe,$02,$30,$3a	;BANK 0:
	!byte $9e				;SYS
	!text "$202C"
	!byte $3a, $8f			;:REM
	!fill 21, $14
	!text "BAS", $00
	!byte $00,$00			;End of basic terminators
	
stub:
	sei
	
	lda #65
	sta $00
	
	lda #$00
	tax
	tay
	taz
	map
	eom

	lda #%00110111
	sta $00
	lda #%00110101
	sta $01
	
	lda #%10000000
	trb $d06f
	
	lda #%01111111
	sta $dc0d
	sta $dd0d
	
	lda $dc0d
	lda $dd0d
	
	jsr interface
	
	!zone
	lda #$00
	sta $d020
	sta $d021
.here
	lda #$40
	ldx #$01
.loop
	cmp $d012
	bne .loop
	stx $d020
	stx $d021
	jsr interface+3
	lda #$40
.loop2
	cmp $d012
	beq .loop2
	
	ldx #$00
	stx $d020
	stx $d021
	bra .here
}

	* = $4000
	
!zone	
!addr zp	= $02
!addr zp2	= $04
!addr sidzp	= $06

interface:
	jmp init
	jmp play
	
!scr "- ", title
!scr " by ", author, " -"

init:
!ifdef ghost_registers {
	lda zp
	sta ghost
	lda zp+1
	sta ghost+1
}

	ldx #$0f
	stx $d418
	stx $d438
	stx $d458
	stx $d478

!ifndef ghost_registers {
	lda #$d4
	sta sidzp+1
}

	; reset the song position and
	; set the pointers to the current 
	; patterns' starts
	; 
	; this pointer doubles as the 
	; cursor as well, the pointer is
	; where the updated index is stored
	; also.
	ldz #$00
-	lda list_ptrs_lo, x
	sta zp
	lda list_ptrs_hi, x
	sta zp+1
	
	lda (zp), z
	tay
	lda pattern_lookup_lo, y
	sta current_patterns_lo, x
	lda pattern_lookup_hi, y
	sta current_patterns_hi, x
	
	lda #$01
	sta pattern_delays, x
	sta hard_restarting, x
	
	lsr
	
	sta pattern_indices, x
	sta current_note, x
	
	dex
	lbpl -
	
!ifdef ghost_registers {
	lda ghost
	sta zp
	lda ghost+1
	sta zp+1
}

	rts
	
play:

!ifdef ghost_registers {
	lda zp
	sta ghost
	lda zp+1
	sta ghost+1
	lda zp2
	sta ghost+2
	lda zp2+1
	sta ghost+3
	lda sidzp
	sta ghost+4
	lda sidzp+1
	sta ghost+5
	
	lda #$d4
	sta sidzp+1
}

	ldx #$0f

pattern_loop:
	dec pattern_delays, x
	beq +
	
	dex
	bpl pattern_loop
	
	jmp update
	
+	
	lda current_patterns_lo, x
	sta zp
	lda current_patterns_hi, x
	sta zp+1
	lda sid_lookup, x
	sta sidzp

cmd_byte:
	; read command byte
	ldz #$00
	lda (zp), z
	sta current_command
	inz
	
	cmp #$ff
	bne ++
	
next_pat:
	; next pattern
	lda list_ptrs_lo, x
	sta zp2
	lda list_ptrs_hi, x
	sta zp2+1

	ldy pattern_indices, x
	iny
	lda (zp2), y
	cmp #$ff
	bne +

!ifdef looping {
	iny
	lda (zp2), y
	sec
	sbc #$01
	sta pattern_indices, x
	bra next_pat
}

!ifndef looping {	
	lda #$ff
	sta pattern_delays, x
	dex
	bpl pattern_loop
	
	jmp update
}
	
+	inc pattern_indices, x
	tay
	lda pattern_lookup_lo, y
	sta current_patterns_lo, x
	sta zp
	lda pattern_lookup_hi, y
	sta current_patterns_hi, x
	sta zp+1
	
	bra cmd_byte

++
!ifdef uses_res_routing {
res_routing:
	; voice filter toggle
	bit cmd_resonance_routing
	beq +

	lda (zp), z
	ldy #$17
	sta (sidzp), y
	
	inz
	lda current_command
+
}
!ifdef uses_cutoff {
cutoff:
	; cutoff
	bit cmd_cutoff
	beq +
	
	lda (zp), z
	ldy #$16
	sta (sidzp), y
	
	inz
	lda current_command
+
}
!ifdef uses_fmode_volume {
fmode_volume:
	; filter type
	bit cmd_fmode_volume
	beq +
	
	lda (zp), z
	ldy #$18
	sta (sidzp), y
	
	inz
	lda current_command
+
}
program:
	; program change
	bit cmd_programchange
	beq +

	; lookup the new instrument
	lda (zp), z
	tay
	
	lda program_ad, y
	sta current_ad, x
	lda program_sr, y
	sta current_sr, x
	
	lda wt_lookup_lo, y
	sta wt_ptr_lo, x
	lda wt_lookup_hi, y
	sta wt_ptr_hi, x
	
	lda nt_lookup_lo, y
	sta nt_ptr_lo, x
	lda nt_lookup_hi, y
	sta nt_ptr_hi, x
	
	lda pt_lookup_lo, y
	sta pt_ptr_lo, x
	lda pt_lookup_hi, y
	sta pt_ptr_hi, x
	
	lda #$01
	sta ad_changed, x
	sta sr_changed, x
	
	inz
	lda current_command
	
+
note_on:
	; note on
	bit cmd_noteon
	beq +++
	
	lda sustaining, x
	bne +

	; load the arp length
+	lda (zp), z
	bne +
	
	; zero length - release note
	inz
	lda #$00
	sta sustaining, x
	beq ++

+
	lda #$00
	sta hard_restarting, x
	sta nt_indices, x
	sta pt_indices, x
	sta wt_indices, x

	; point to the arp
	tza
	clc
	adc zp
	sta arp_ptr_lo, x
	lda #$00
	adc zp+1
	sta arp_ptr_hi, x
	
	tza
	clc
	adc (zp), z
	taz
	inz
	
	lda #$01
	sta sustaining, x

++
	lda current_command
+++

!ifdef uses_attackdecay {
	bit cmd_attackdecay
	beq +
	
	lda (zp), z
	inz
	sta current_ad, x
	
	lda #$01
	sta ad_changed, x
	
	lda current_command
+
}

!ifdef uses_sustainrelease {
	bit cmd_sustainrelease
	beq +
	
	lda (zp), z
	inz
	sta current_sr, x
	
	lda #$01
	sta sr_changed, x
	
	lda current_command
+
}

!ifdef uses_pulsewidth {
	bit cmd_pulsewidth
	beq +
	
	lda (zp), z
	sta current_pw_lo, x
	inz
	lda (zp), z
	sta current_pw_hi, x
	inz
	
	lda current_command
+
}

hardrestart:
	bit cmd_hardrestart
	beq +
	
	ldy #$06
	lda #$00
-	sta (sidzp), y
	dey
	cpy #$04
	bpl -
	
	lda #$01
	sta hard_restarting, x
	sta ad_changed, x
	sta sr_changed, x
	
	lda current_command
+

delay:
	; delay
	; delay needs to execute last as 
	; it is the last byte in the row
	; of data
	bit cmd_delay
	beq +
	
	lda (zp), z
	inz
	bne ++
	
+	; There will ALWAYS be a delay of
	; 1, so if the bit is not set, then
	; it is assumed to be 1, since
	; frequently updated data needs to
	; be smaller.
	lda #$01

++	sta pattern_delays, x




	; update the pattern pointer for 
	; this column
	tza
	
	clc
	adc current_patterns_lo, x
	sta current_patterns_lo, x
	lda #$00
	adc current_patterns_hi, x
	sta current_patterns_hi, x
	
	dex
	lbpl pattern_loop
	
update:
	ldx #$0f
update_loop:
	lda skip_update, x
	beq +

-	
	dex
	bne update_loop
	
	rts
	
+
	lda hard_restarting, x
	bne -

	lda sid_lookup, x
	sta sidzp
	
note_table:
	lda nt_ptr_lo, x
	sta zp2
	lda nt_ptr_hi, x
	sta zp2+1
	
	ldy nt_indices, x
-
	lda (zp2), y
	
	; command
	bit bit_20
	beq absolute
	
!if nt_uses_susto {
nt_susto:	
	; sustain to
	cmp #$23
	bne ++
	
	iny
	
	lda sustaining, x
	beq +
	; sustaining, loop back
	lda (zp2), y
	tay
	lda mul_3, y
	sta nt_indices, x
	tay
	bra -
	
+
	; not sustaining, fall through
	iny
	iny
	tya
	sta nt_indices, x
	bra -
++
}

!if nt_uses_goto {
goto:
	; goto
	cmp #$22
	bne +
	
	iny
	lda (zp2), y
	tay
	lda mul_3, y
	tay
	sta nt_indices, x
	bra -

+	
}

!ifdef nt_uses_end {
nt_end:
	; end
	dey
	dey
	dey
	tya
	sta nt_indices, x
	bra -
}

absolute:
	; absolute
	cmp #$01
	bne +
	
	iny
	lda (zp2), y
	pha
	
	iny
	lda (zp2), y
	pha
	
	iny
	tya
	sta nt_indices, x
	
	ldy #$01
	pla
	sta (sidzp), y
	dey
	pla
	sta (sidzp), y
	bra pulse_table
	
+
nt_reltv:
	; relative
	iny
	lda (zp2), y
	sta current_note, x
	tya
	adc #$02
	sta nt_indices, x

arp_table:
	; update arp table
	lda arp_ptr_hi, x
	sta zp2+1
	beq pulse_table
	lda arp_ptr_lo, x
	sta zp2
	
	ldy #$00
	lda (zp2), y

	cmp arp_indices, x
	bmi +
	bne ++
	
+	lda #$00
	sta arp_indices, x

++	inc arp_indices, x
	ldy arp_indices, x
	
	lda (zp2), y
	clc
	adc current_note, x
	tay
	ldz #$00
	lda freq_lo, y
	sta (sidzp), z
	inz
	lda freq_hi, y
	sta (sidzp), z
	
pulse_table:
	; pulse table
	lda pt_ptr_lo, x
	sta zp2
	lda pt_ptr_hi, x
	sta zp2+1
	
	ldy pt_indices, x
-
	lda (zp2), y
	
	; command
	bit bit_20
	beq pulse_value

!ifdef pt_uses_susto {	
pt_susto:
	; sustain to
	cmp #$23
	bne ++
	
	iny
	
	lda sustaining, x
	beq +
	; sustaining, loop back
	lda (zp2), y
	asl
	sta pt_indices, x
	tay
	bra -
	
+
	; not sustaining, fall through
	iny
	tya
	sta pt_indices, x
	bra -
++	
}

!ifdef pt_uses_goto {
pulse_goto:
	; goto
	cmp #$22
	bne +
	
	iny
	lda (zp2), y
	asl
	sta pt_indices, x
	tay
	bra -

+	
}

!ifdef pt_uses_end {
pt_end:
	; end
	dey
	dey
	tya
	sta pt_indices, x
	bra -
}

pulse_value:
	pha
	iny
	lda (zp2), y
	pha
	
	iny
	tya
	sta pt_indices, x
	
	ldy #$02
	pla
	sta (sidzp), y
	iny
	pla
	sta (sidzp), y
	
wavetable:
	; wavetable
	lda wt_ptr_lo, x
	sta zp2
	lda wt_ptr_hi, x
	sta zp2+1
	
	ldy wt_indices, x
-
	lda (zp2), y
	
	; command
	beq wave_value

!ifdef wt_uses_susto {	
wt_susto:
	; sustain to
	cmp #$23
	bne ++
	
	iny
	
	lda sustaining, x
	beq +
	; sustaining, loop back
	lda (zp2), y
	asl
	sta wt_indices, x
	tay
	bra -
	
+
	; not sustaining, fall through
	iny
	tya
	sta wt_indices, x
	bra -
++	
}

!ifdef wt_uses_goto {
wave_goto:
	; goto
	cmp #$22
	bne +
	
	iny
	lda (zp2), y
	asl
	sta wt_indices, x
	tay
	bra -

+	
}

!ifdef wt_uses_end {
wt_end:
	; end
	dey
	dey
	tya
	sta wt_indices, x
	bra -
}

wave_value:
	iny
	lda (zp2), y
	ldz sustaining, x
	bne +
	and #$fe

+
	taz
	iny
	tya
	sta wt_indices, x
	
	ldy #$06
	lda sr_changed, x
	beq +
	lda current_sr, x
	sta (sidzp), y
	lda #$00
	sta sr_changed, x
+
	dey
	lda ad_changed, x
	beq +
	lda current_ad, x
	sta (sidzp), y
	lda #$00
	sta ad_changed, x
	
+
	dey
	tza
	sta (sidzp), y
	
	dex
	lbne update_loop
	
!ifdef ghost_registers {
	lda ghost
	sta zp
	lda ghost+1
	sta zp+1
	lda ghost+2
	sta zp2
	lda ghost+3
	sta zp2+1
	lda ghost+4
	sta sidzp
	lda ghost+5
	sta sidzp+1
}

	rts
	
sid_lookup:
	!byte $00, $00, $07, $0e, $20, $20, $27, $2e
	!byte $40, $40, $47, $4e, $60, $60, $67, $6e
	
skip_update:
	!byte $01, $00, $00, $00
	!byte $01, $00, $00, $00
	!byte $01, $00, $00, $00
	!byte $01, $00, $00, $00

bit_01:
	!byte %00000001
bit_02:
	!byte %00000010
bit_04:
	!byte %00000100
bit_08:
	!byte %00001000
bit_10:
	!byte %00010000
bit_20:
	!byte %00100000
bit_40:
	!byte %01000000
bit_80:
	!byte %10000000
	
freq_lo:
	!byte $93, $9C, $A6, $AF, $BA, $C5, $D1, $DD, $EA, $F8, $07
	!byte $09, $19, $2A, $3B, $4E, $62, $77, $8D
	!byte $A5, $BE, $D9, $F5, $12, $32, $53, $77 
	!byte $9C, $C4, $EE, $1B, $4A, $7C, $B1, $E9 
	!byte $25, $64, $A7, $ED, $38, $88, $DC, $35 
	!byte $94, $F8, $62, $D2, $4A, $C8, $4D, $DB 
	!byte $71, $10, $B8, $6B, $28, $F0, $C4, $A5 
	!byte $93, $8F, $9B, $B6, $E2, $20, $71, $D5 
	!byte $4F, $E0, $88, $4A, $26, $1F, $35, $6C 
	!byte $C4, $40, $E1, $AB, $9F, $C0, $10, $94 
	!byte $4C, $3D, $6B, $D7, $88, $7F, $C2, $55 
	!byte $3E, $80, $21, $27, $98, $7B, $D5, $AF 
	!byte $0F, $FE, $84, $AB, $7B, $FF, $42, $4E

freq_hi:
	!byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01 
	!byte $01, $01, $01, $01, $02, $02, $02, $02 
	!byte $02, $02, $02, $03, $03, $03, $03, $03 
	!byte $04, $04, $04, $04, $05, $05, $05, $06 
	!byte $06, $06, $07, $07, $08, $08, $09, $09 
	!byte $0A, $0B, $0B, $0C, $0D, $0D, $0E, $0F 
	!byte $10, $11, $12, $13, $14, $16, $17, $18 
	!byte $1A, $1B, $1D, $1F, $21, $23, $25, $27 
	!byte $29, $2C, $2E, $31, $34, $37, $3B, $3E 
	!byte $42, $46, $4A, $4E, $53, $58, $5D, $63 
	!byte $69, $6F, $76, $7D, $84, $8C, $94, $9D 
	!byte $A7, $B0, $BB, $C6, $D2, $DE, $EC, $FA

!if nt_uses_susto | nt_uses_goto {
mul_3:
	!byte $01, $03, $06, $09, $0c, $0f, $12, $15
	!byte $18, $1B, $1E, $21, $24, $27, $2A, $2D
	!byte $34, $33, $36, $39, $3c, $3f, $45, $45
	!byte $48, $4B, $4E, $54, $54, $57, $5A, $5D
	!byte $67, $63, $66, $69, $6c, $6f, $78, $75
	!byte $78, $7B, $7E, $87, $84, $87, $8A, $8D
	!byte $9A, $93, $96, $99, $9c, $9f, $AB, $A5
	!byte $A8, $AB, $AE, $BA, $B4, $B7, $BA, $BD
	!byte $CD, $C3, $C6, $C9, $Cc, $Cf, $DE, $D5
	!byte $D8, $DB, $DE, $ED, $E4, $E7, $EA, $ED
	!byte $F1, $F3, $F6, $F9, $Fc, $Ff
}

pattern_indices:
	!fill $10
	
pattern_delays:
	!fill $10

current_patterns_lo:
	!fill $10
current_patterns_hi:
	!fill $10
	
current_command:
	!byte $00

current_note:
	!fill $10
sustaining:
	!fill $10

hard_restarting:
	!fill $10
current_ad:
	!fill $10
ad_changed:
	!fill $10
current_sr:
	!fill $10
sr_changed:
	!fill $10

arp_indices:
	!fill $10

arp_ptr_lo:
	!fill $10
arp_ptr_hi:
	!fill $10

wt_indices:
	!fill $10
wt_ptr_lo:
	!fill $10
wt_ptr_hi:
	!fill $10
	
nt_indices:
	!fill $10
nt_ptr_lo:
	!fill $10
nt_ptr_hi:
	!fill $10
pt_indices:
	!fill $10
pt_ptr_lo:
	!fill $10
pt_ptr_hi:
	!fill $10

temp:
	!byte $00

!ifdef ghost_registers {
ghost:
	!fill $06
}

list_ptrs_lo:
	!byte <s0_global_pattern_list,   <s0_voice_00_pattern_list 
	!byte <s0_voice_01_pattern_list, <s0_voice_02_pattern_list
	!byte <s1_global_pattern_list,   <s1_voice_00_pattern_list 
	!byte <s1_voice_01_pattern_list, <s1_voice_02_pattern_list
	!byte <s2_global_pattern_list,   <s2_voice_00_pattern_list 
	!byte <s2_voice_01_pattern_list, <s2_voice_02_pattern_list
	!byte <s3_global_pattern_list,   <s3_voice_00_pattern_list 
	!byte <s3_voice_01_pattern_list, <s3_voice_02_pattern_list
list_ptrs_hi:
	!byte >s0_global_pattern_list,   >s0_voice_00_pattern_list 
	!byte >s0_voice_01_pattern_list, >s0_voice_02_pattern_list
	!byte >s1_global_pattern_list,   >s1_voice_00_pattern_list 
	!byte >s1_voice_01_pattern_list, >s1_voice_02_pattern_list
	!byte >s2_global_pattern_list,   >s2_voice_00_pattern_list 
	!byte >s2_voice_01_pattern_list, >s2_voice_02_pattern_list
	!byte >s3_global_pattern_list,   >s3_voice_00_pattern_list 
	!byte >s3_voice_01_pattern_list, >s3_voice_02_pattern_list

s0_global_pattern_list:
	!byte $00, $01, $01, $01, $01, $01, $01, $01
	!byte $02, $03, $04, $05, $06, $07, $08, $09
	!byte $0a, $0b, $0c, $0d, $0e, $0f, $10, $11
	!byte $02, $03, $04, $05, $06, $07, $08, $09
	!byte $0a, $0b, $0c, $0d, $0e, $0f, $10, $11
	!byte $02, $03, $04, $05, $06, $07, $08, $09
	!byte $02, $03, $04, $05, $06, $07, $08, $09
	!byte $02, $03, $04, $05, $06, $07, $08, $09
	!byte $0a, $0b, $0c, $0d, $0e, $0f, $10, $11
	!byte $02, $03, $04, $05, $06, $07, $08, $09
	!byte $0a, $0b, $0c, $0d, $0e, $0f, $10, $11
	!byte $02, $03, $04, $05, $06, $07, $08, $09
	!byte $ff, $08

s0_voice_00_pattern_list:
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $ff, $08

s0_voice_01_pattern_list:
	!byte $12, $01, $01, $01, $01, $01, $01, $13
	!byte $14, $15, $16, $17, $14, $15, $18, $19
	!byte $1a, $1b, $1c, $1d, $1a, $1b, $1a, $1e
	!byte $14, $15, $16, $17, $14, $15, $18, $19
	!byte $1a, $1b, $1c, $1d, $1a, $1b, $1a, $1e
	!byte $14, $15, $16, $17, $14, $15, $18, $19
	!byte $14, $15, $16, $17, $14, $15, $18, $19
	!byte $14, $15, $16, $17, $14, $15, $18, $19
	!byte $1a, $1b, $1c, $1d, $1a, $1b, $1a, $1e
	!byte $14, $15, $16, $17, $14, $15, $18, $19
	!byte $1a, $1b, $1c, $1d, $1a, $1b, $1a, $1e
	!byte $14, $15, $16, $17, $14, $15, $18, $1f
	!byte $ff, $08

s0_voice_02_pattern_list:
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $ff, $08

s1_global_pattern_list:
	!byte $20, $21, $22, $23, $24, $25, $26, $27
	!byte $28, $21, $22, $23, $24, $25, $26, $27
	!byte $29, $2a, $2b, $2c, $2d, $2e, $2f, $30
	!byte $28, $21, $22, $23, $24, $25, $26, $27
	!byte $29, $2a, $2b, $2c, $2d, $2e, $2f, $30
	!byte $28, $21, $22, $23, $24, $25, $26, $27
	!byte $28, $21, $22, $23, $24, $25, $26, $27
	!byte $28, $21, $22, $23, $24, $25, $26, $27
	!byte $29, $2a, $2b, $2c, $2d, $2e, $2f, $30
	!byte $28, $21, $22, $23, $24, $25, $26, $27
	!byte $29, $2a, $2b, $2c, $2d, $2e, $2f, $30
	!byte $28, $21, $22, $23, $24, $25, $26, $27
	!byte $ff, $08

s1_voice_00_pattern_list:
	!byte $31, $32, $33, $34, $35, $35, $36, $35
	!byte $37, $32, $33, $34, $35, $35, $36, $35
	!byte $35, $38, $39, $3a, $35, $3b, $37, $3c
	!byte $37, $32, $33, $34, $35, $35, $36, $35
	!byte $37, $3d, $33, $35, $37, $3e, $35, $3f
	!byte $37, $32, $33, $34, $35, $35, $36, $35
	!byte $37, $32, $33, $34, $35, $35, $36, $35
	!byte $37, $32, $33, $34, $35, $35, $36, $35
	!byte $35, $33, $33, $35, $40, $38, $3a, $34
	!byte $37, $32, $33, $34, $35, $35, $36, $35
	!byte $35, $32, $33, $3f, $35, $3e, $3b, $41
	!byte $37, $32, $33, $34, $35, $35, $36, $35
	!byte $ff, $08

s1_voice_01_pattern_list:
	!byte $42, $43, $35, $3e, $44, $45, $44, $40
	!byte $35, $43, $35, $3e, $44, $45, $44, $40
	!byte $44, $46, $47, $40, $40, $48, $35, $37
	!byte $35, $43, $35, $3e, $44, $45, $44, $40
	!byte $35, $3b, $40, $40, $35, $49, $44, $43
	!byte $35, $43, $35, $3e, $44, $45, $44, $40
	!byte $35, $43, $35, $3e, $44, $45, $44, $40
	!byte $35, $43, $35, $3e, $44, $45, $44, $40
	!byte $44, $35, $35, $40, $45, $3b, $33, $4a
	!byte $35, $43, $35, $3e, $44, $45, $44, $40
	!byte $44, $43, $35, $43, $44, $4b, $13, $4c
	!byte $35, $43, $35, $3e, $44, $45, $44, $40
	!byte $ff, $08

s1_voice_02_pattern_list:
	!byte $4d, $4e, $44, $4f, $50, $50, $50, $51
	!byte $44, $4e, $44, $4f, $50, $50, $50, $51
	!byte $50, $52, $4e, $50, $50, $53, $44, $40
	!byte $44, $4e, $44, $4f, $50, $50, $50, $51
	!byte $44, $49, $51, $50, $44, $54, $50, $54
	!byte $44, $4e, $44, $4f, $50, $50, $50, $51
	!byte $44, $4e, $44, $4f, $50, $50, $50, $51
	!byte $44, $4e, $44, $4f, $50, $50, $50, $51
	!byte $50, $44, $44, $44, $50, $49, $45, $55
	!byte $44, $4e, $44, $4f, $50, $50, $50, $51
	!byte $50, $4e, $40, $54, $50, $56, $13, $57
	!byte $44, $4e, $44, $4f, $50, $50, $50, $51
	!byte $ff, $08

s2_global_pattern_list:
	!byte $58, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $ff, $08

s2_voice_00_pattern_list:
	!byte $59, $01, $01, $01, $01, $01, $01, $13
	!byte $5a, $5b, $5a, $5b, $5a, $5b, $5a, $5b
	!byte $5c, $5c, $5c, $5d, $5c, $5c, $5c, $5d
	!byte $5a, $5b, $5a, $5b, $5a, $5b, $5a, $5b
	!byte $5c, $5c, $5c, $5d, $5c, $5c, $5c, $5d
	!byte $5a, $5b, $5a, $5b, $5a, $5b, $5a, $5b
	!byte $5a, $5b, $5a, $5b, $5a, $5b, $5a, $5e
	!byte $01, $01, $01, $01, $01, $01, $01, $13
	!byte $5c, $5c, $5c, $5d, $5c, $5c, $5c, $5d
	!byte $5a, $5b, $5a, $5b, $5a, $5b, $5a, $5b
	!byte $5c, $5c, $5c, $5d, $5c, $5c, $5c, $5d
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $ff, $08

s2_voice_01_pattern_list:
	!byte $5f, $01, $01, $01, $01, $01, $13, $60
	!byte $61, $61, $61, $61, $61, $61, $61, $61
	!byte $62, $63, $64, $63, $64, $63, $64, $65
	!byte $61, $61, $61, $61, $61, $61, $61, $61
	!byte $62, $63, $64, $63, $64, $63, $64, $65
	!byte $61, $61, $61, $61, $61, $61, $61, $61
	!byte $61, $61, $61, $61, $61, $61, $61, $61
	!byte $01, $01, $01, $01, $01, $01, $13, $60
	!byte $62, $63, $64, $63, $64, $63, $64, $65
	!byte $61, $61, $61, $61, $61, $61, $61, $61
	!byte $62, $63, $64, $63, $64, $63, $64, $65
	!byte $01, $01, $01, $01, $01, $01, $13, $60
	!byte $ff, $08

s2_voice_02_pattern_list:
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $ff, $08

s3_global_pattern_list:
	!byte $66, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $ff, $08

s3_voice_00_pattern_list:
	!byte $67, $01, $01, $01, $01, $01, $01, $13
	!byte $68, $69, $6a, $6b, $6c, $6d, $6e, $6f
	!byte $70, $71, $72, $73, $74, $71, $75, $76
	!byte $68, $69, $6a, $6b, $6c, $6d, $6e, $6f
	!byte $77, $78, $79, $7a, $7b, $7c, $7d, $7e
	!byte $68, $69, $6a, $6b, $6c, $6d, $6e, $6f
	!byte $68, $69, $6a, $6b, $6c, $6d, $6e, $6f
	!byte $7f, $80, $81, $82, $83, $84, $85, $86
	!byte $87, $88, $89, $8a, $8b, $88, $8c, $8a
	!byte $68, $69, $6a, $6b, $6c, $6d, $6e, $6b
	!byte $8d, $8e, $8f, $90, $91, $92, $93, $94
	!byte $7f, $80, $81, $82, $83, $84, $85, $86
	!byte $ff, $08

s3_voice_01_pattern_list:
	!byte $67, $01, $01, $01, $01, $01, $01, $13
	!byte $95, $96, $97, $98, $99, $9a, $9b, $9c
	!byte $9d, $9e, $9f, $a0, $a1, $9e, $a2, $a3
	!byte $95, $96, $97, $98, $99, $9a, $9b, $9c
	!byte $a4, $a5, $a6, $a7, $a8, $a9, $aa, $ab
	!byte $95, $96, $97, $98, $99, $9a, $9b, $9c
	!byte $95, $96, $97, $98, $99, $9a, $9b, $9c
	!byte $ac, $ad, $ae, $af, $b0, $b1, $b2, $b3
	!byte $b4, $b5, $b6, $b7, $b8, $b5, $b9, $b7
	!byte $95, $96, $97, $98, $99, $9a, $9b, $98
	!byte $ba, $bb, $bc, $bd, $be, $bf, $c0, $c1
	!byte $ac, $ad, $ae, $af, $b0, $b1, $b2, $b3
	!byte $ff, $08

s3_voice_02_pattern_list:
	!byte $c2, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $ff, $08

pattern_lookup_lo:
	!byte <pattern_00, <pattern_01, <pattern_02, <pattern_03
	!byte <pattern_04, <pattern_05, <pattern_06, <pattern_07
	!byte <pattern_08, <pattern_09, <pattern_0a, <pattern_0b
	!byte <pattern_0c, <pattern_0d, <pattern_0e, <pattern_0f
	!byte <pattern_10, <pattern_11, <pattern_12, <pattern_13
	!byte <pattern_14, <pattern_15, <pattern_16, <pattern_17
	!byte <pattern_18, <pattern_19, <pattern_1a, <pattern_1b
	!byte <pattern_1c, <pattern_1d, <pattern_1e, <pattern_1f
	!byte <pattern_20, <pattern_21, <pattern_22, <pattern_23
	!byte <pattern_24, <pattern_25, <pattern_26, <pattern_27
	!byte <pattern_28, <pattern_29, <pattern_2a, <pattern_2b
	!byte <pattern_2c, <pattern_2d, <pattern_2e, <pattern_2f
	!byte <pattern_30, <pattern_31, <pattern_32, <pattern_33
	!byte <pattern_34, <pattern_35, <pattern_36, <pattern_37
	!byte <pattern_38, <pattern_39, <pattern_3a, <pattern_3b
	!byte <pattern_3c, <pattern_3d, <pattern_3e, <pattern_3f
	!byte <pattern_40, <pattern_41, <pattern_42, <pattern_43
	!byte <pattern_44, <pattern_45, <pattern_46, <pattern_47
	!byte <pattern_48, <pattern_49, <pattern_4a, <pattern_4b
	!byte <pattern_4c, <pattern_4d, <pattern_4e, <pattern_4f
	!byte <pattern_50, <pattern_51, <pattern_52, <pattern_53
	!byte <pattern_54, <pattern_55, <pattern_56, <pattern_57
	!byte <pattern_58, <pattern_59, <pattern_5a, <pattern_5b
	!byte <pattern_5c, <pattern_5d, <pattern_5e, <pattern_5f
	!byte <pattern_60, <pattern_61, <pattern_62, <pattern_63
	!byte <pattern_64, <pattern_65, <pattern_66, <pattern_67
	!byte <pattern_68, <pattern_69, <pattern_6a, <pattern_6b
	!byte <pattern_6c, <pattern_6d, <pattern_6e, <pattern_6f
	!byte <pattern_70, <pattern_71, <pattern_72, <pattern_73
	!byte <pattern_74, <pattern_75, <pattern_76, <pattern_77
	!byte <pattern_78, <pattern_79, <pattern_7a, <pattern_7b
	!byte <pattern_7c, <pattern_7d, <pattern_7e, <pattern_7f
	!byte <pattern_80, <pattern_81, <pattern_82, <pattern_83
	!byte <pattern_84, <pattern_85, <pattern_86, <pattern_87
	!byte <pattern_88, <pattern_89, <pattern_8a, <pattern_8b
	!byte <pattern_8c, <pattern_8d, <pattern_8e, <pattern_8f
	!byte <pattern_90, <pattern_91, <pattern_92, <pattern_93
	!byte <pattern_94, <pattern_95, <pattern_96, <pattern_97
	!byte <pattern_98, <pattern_99, <pattern_9a, <pattern_9b
	!byte <pattern_9c, <pattern_9d, <pattern_9e, <pattern_9f
	!byte <pattern_a0, <pattern_a1, <pattern_a2, <pattern_a3
	!byte <pattern_a4, <pattern_a5, <pattern_a6, <pattern_a7
	!byte <pattern_a8, <pattern_a9, <pattern_aa, <pattern_ab
	!byte <pattern_ac, <pattern_ad, <pattern_ae, <pattern_af
	!byte <pattern_b0, <pattern_b1, <pattern_b2, <pattern_b3
	!byte <pattern_b4, <pattern_b5, <pattern_b6, <pattern_b7
	!byte <pattern_b8, <pattern_b9, <pattern_ba, <pattern_bb
	!byte <pattern_bc, <pattern_bd, <pattern_be, <pattern_bf
	!byte <pattern_c0, <pattern_c1, <pattern_c2

pattern_lookup_hi:
	!byte >pattern_00, >pattern_01, >pattern_02, >pattern_03
	!byte >pattern_04, >pattern_05, >pattern_06, >pattern_07
	!byte >pattern_08, >pattern_09, >pattern_0a, >pattern_0b
	!byte >pattern_0c, >pattern_0d, >pattern_0e, >pattern_0f
	!byte >pattern_10, >pattern_11, >pattern_12, >pattern_13
	!byte >pattern_14, >pattern_15, >pattern_16, >pattern_17
	!byte >pattern_18, >pattern_19, >pattern_1a, >pattern_1b
	!byte >pattern_1c, >pattern_1d, >pattern_1e, >pattern_1f
	!byte >pattern_20, >pattern_21, >pattern_22, >pattern_23
	!byte >pattern_24, >pattern_25, >pattern_26, >pattern_27
	!byte >pattern_28, >pattern_29, >pattern_2a, >pattern_2b
	!byte >pattern_2c, >pattern_2d, >pattern_2e, >pattern_2f
	!byte >pattern_30, >pattern_31, >pattern_32, >pattern_33
	!byte >pattern_34, >pattern_35, >pattern_36, >pattern_37
	!byte >pattern_38, >pattern_39, >pattern_3a, >pattern_3b
	!byte >pattern_3c, >pattern_3d, >pattern_3e, >pattern_3f
	!byte >pattern_40, >pattern_41, >pattern_42, >pattern_43
	!byte >pattern_44, >pattern_45, >pattern_46, >pattern_47
	!byte >pattern_48, >pattern_49, >pattern_4a, >pattern_4b
	!byte >pattern_4c, >pattern_4d, >pattern_4e, >pattern_4f
	!byte >pattern_50, >pattern_51, >pattern_52, >pattern_53
	!byte >pattern_54, >pattern_55, >pattern_56, >pattern_57
	!byte >pattern_58, >pattern_59, >pattern_5a, >pattern_5b
	!byte >pattern_5c, >pattern_5d, >pattern_5e, >pattern_5f
	!byte >pattern_60, >pattern_61, >pattern_62, >pattern_63
	!byte >pattern_64, >pattern_65, >pattern_66, >pattern_67
	!byte >pattern_68, >pattern_69, >pattern_6a, >pattern_6b
	!byte >pattern_6c, >pattern_6d, >pattern_6e, >pattern_6f
	!byte >pattern_70, >pattern_71, >pattern_72, >pattern_73
	!byte >pattern_74, >pattern_75, >pattern_76, >pattern_77
	!byte >pattern_78, >pattern_79, >pattern_7a, >pattern_7b
	!byte >pattern_7c, >pattern_7d, >pattern_7e, >pattern_7f
	!byte >pattern_80, >pattern_81, >pattern_82, >pattern_83
	!byte >pattern_84, >pattern_85, >pattern_86, >pattern_87
	!byte >pattern_88, >pattern_89, >pattern_8a, >pattern_8b
	!byte >pattern_8c, >pattern_8d, >pattern_8e, >pattern_8f
	!byte >pattern_90, >pattern_91, >pattern_92, >pattern_93
	!byte >pattern_94, >pattern_95, >pattern_96, >pattern_97
	!byte >pattern_98, >pattern_99, >pattern_9a, >pattern_9b
	!byte >pattern_9c, >pattern_9d, >pattern_9e, >pattern_9f
	!byte >pattern_a0, >pattern_a1, >pattern_a2, >pattern_a3
	!byte >pattern_a4, >pattern_a5, >pattern_a6, >pattern_a7
	!byte >pattern_a8, >pattern_a9, >pattern_aa, >pattern_ab
	!byte >pattern_ac, >pattern_ad, >pattern_ae, >pattern_af
	!byte >pattern_b0, >pattern_b1, >pattern_b2, >pattern_b3
	!byte >pattern_b4, >pattern_b5, >pattern_b6, >pattern_b7
	!byte >pattern_b8, >pattern_b9, >pattern_ba, >pattern_bb
	!byte >pattern_bc, >pattern_bd, >pattern_be, >pattern_bf
	!byte >pattern_c0, >pattern_c1, >pattern_c2

pattern_00:
	!byte %00001011, $f2, $3f, $50
	!byte $ff
pattern_01:
	!byte %00000001, $50
	!byte $ff
pattern_02:
	!byte %00000001, $14
	!byte %00000100, $0b
	!byte %00000100, $0c
	!byte %00000101, $0e, $09
	!byte %00000101, $10, $0a
	!byte %00000100, $12
	!byte %00000100, $14
	!byte %00000100, $16
	!byte %00000100, $18
	!byte %00000100, $1b
	!byte %00000100, $1e
	!byte %00000101, $1f, $03
	!byte %00000101, $20, $04
	!byte %00000100, $22
	!byte %00000100, $23
	!byte %00000100, $25
	!byte %00000100, $27
	!byte %00000100, $29
	!byte %00000100, $2b
	!byte %00000100, $32
	!byte %00000100, $3a
	!byte %00000101, $43, $07
	!byte %00000100, $39
	!byte %00000100, $30
	!byte %00000100, $29
	!byte %00000100, $1c
	!byte %00000100, $13
	!byte %00000100, $11
	!byte %00000101, $0f, $05
	!byte $ff
pattern_03:
	!byte %00000101, $0e, $08
	!byte %00000100, $10
	!byte %00000100, $13
	!byte %00000100, $16
	!byte %00000100, $18
	!byte %00000101, $17, $03
	!byte %00000100, $12
	!byte %00000100, $10
	!byte %00000101, $0f, $03
	!byte %00000101, $0e, $02
	!byte %00000100, $10
	!byte %00000100, $14
	!byte %00000100, $1a
	!byte %00000101, $1d, $05
	!byte %00000100, $1a
	!byte %00000100, $16
	!byte %00000100, $12
	!byte %00000100, $11
	!byte %00000100, $12
	!byte %00000100, $14
	!byte %00000100, $15
	!byte %00000100, $16
	!byte %00000100, $18
	!byte %00000100, $19
	!byte %00000100, $13
	!byte %00000101, $0f, $03
	!byte %00000101, $0e, $03
	!byte %00000100, $0d
	!byte %00000100, $0c
	!byte %00000100, $0b
	!byte %00000101, $0c, $02
	!byte %00000100, $0d
	!byte %00000100, $0e
	!byte %00000100, $10
	!byte %00000100, $12
	!byte %00000100, $14
	!byte %00000100, $17
	!byte %00000100, $1c
	!byte %00000100, $24
	!byte %00000100, $2e
	!byte %00000100, $3c
	!byte %00000100, $4d
	!byte %00000100, $51
	!byte %00000100, $56
	!byte %00000100, $5b
	!byte %00000101, $61, $02
	!byte %00000101, $62, $03
	!byte %00000101, $63, $03
	!byte %00000101, $64, $02
	!byte %00000100, $4d
	!byte %00000100, $3a
	!byte %00000100, $2b
	!byte %00000100, $20
	!byte $ff
pattern_04:
	!byte %00000100, $1c
	!byte %00000100, $18
	!byte %00000100, $15
	!byte %00000101, $12, $08
	!byte %00000100, $11
	!byte %00000100, $14
	!byte %00000100, $1a
	!byte %00000100, $21
	!byte %00000101, $2b, $04
	!byte %00000100, $26
	!byte %00000100, $1d
	!byte %00000100, $17
	!byte %00000100, $11
	!byte %00000100, $14
	!byte %00000100, $16
	!byte %00000100, $18
	!byte %00000101, $19, $02
	!byte %00000100, $1a
	!byte %00000100, $15
	!byte %00000100, $10
	!byte %00000101, $0f, $07
	!byte %00000101, $10, $02
	!byte %00000100, $0e
	!byte %00000100, $0b
	!byte %00000101, $09, $03
	!byte %00000101, $0a, $05
	!byte %00000100, $0e
	!byte %00000100, $14
	!byte %00000100, $1c
	!byte %00000100, $21
	!byte %00000101, $22, $02
	!byte %00000101, $23, $03
	!byte %00000100, $27
	!byte %00000100, $30
	!byte %00000100, $3f
	!byte %00000100, $52
	!byte %00000100, $5c
	!byte %00000100, $67
	!byte %00000100, $74
	!byte %00000100, $83
	!byte %00000100, $85
	!byte %00000100, $87
	!byte %00000100, $89
	!byte %00000100, $8b
	!byte %00000100, $8d
	!byte %00000100, $8f
	!byte %00000100, $91
	!byte %00000100, $93
	!byte %00000100, $95
	!byte %00000100, $6a
	!byte %00000100, $4a
	!byte %00000100, $3b
	!byte %00000100, $2f
	!byte $ff
pattern_05:
	!byte %00000100, $25
	!byte %00000100, $1e
	!byte %00000100, $18
	!byte %00000100, $17
	!byte %00000100, $16
	!byte %00000100, $15
	!byte %00000100, $14
	!byte %00000101, $15, $02
	!byte %00000101, $16, $02
	!byte %00000100, $17
	!byte %00000101, $18, $02
	!byte %00000100, $19
	!byte %00000100, $1e
	!byte %00000100, $24
	!byte %00000100, $2c
	!byte %00000101, $30, $03
	!byte %00000100, $25
	!byte %00000100, $16
	!byte %00000101, $11, $03
	!byte %00000100, $14
	!byte %00000100, $1b
	!byte %00000101, $23, $04
	!byte %00000100, $20
	!byte %00000100, $1c
	!byte %00000100, $19
	!byte %00000100, $16
	!byte %00000100, $15
	!byte %00000100, $13
	!byte %00000100, $12
	!byte %00000100, $11
	!byte %00000100, $10
	!byte %00000100, $0c
	!byte %00000100, $0b
	!byte %00000101, $0a, $02
	!byte %00000101, $09, $05
	!byte %00000100, $0b
	!byte %00000100, $0f
	!byte %00000100, $15
	!byte %00000100, $17
	!byte %00000100, $19
	!byte %00000100, $1c
	!byte %00000100, $1e
	!byte %00000100, $2d
	!byte %00000100, $38
	!byte %00000100, $44
	!byte %00000100, $54
	!byte %00000100, $64
	!byte %00000100, $73
	!byte %00000100, $85
	!byte %00000100, $99
	!byte %00000100, $b0
	!byte %00000100, $be
	!byte %00000100, $bf
	!byte %00000100, $c1
	!byte %00000100, $c2
	!byte %00000100, $99
	!byte %00000100, $5e
	!byte %00000100, $50
	!byte %00000100, $45
	!byte %00000100, $3b
	!byte %00000100, $2f
	!byte %00000100, $23
	!byte %00000100, $1a
	!byte %00000100, $14
	!byte %00000100, $11
	!byte $ff
pattern_06:
	!byte %00000100, $0e
	!byte %00000100, $0c
	!byte %00000101, $0a, $03
	!byte %00000100, $0c
	!byte %00000100, $12
	!byte %00000100, $17
	!byte %00000100, $1b
	!byte %00000100, $20
	!byte %00000100, $1f
	!byte %00000100, $1e
	!byte %00000101, $1d, $02
	!byte %00000100, $1c
	!byte %00000100, $1b
	!byte %00000100, $1a
	!byte %00000100, $1f
	!byte %00000100, $24
	!byte %00000100, $2a
	!byte %00000100, $1b
	!byte %00000100, $11
	!byte %00000100, $0b
	!byte %00000100, $0c
	!byte %00000100, $0d
	!byte %00000100, $0e
	!byte %00000100, $12
	!byte %00000100, $15
	!byte %00000101, $16, $03
	!byte %00000100, $10
	!byte %00000100, $0b
	!byte %00000101, $08, $02
	!byte %00000100, $07
	!byte %00000100, $08
	!byte %00000100, $0b
	!byte %00000101, $0c, $06
	!byte %00000100, $11
	!byte %00000100, $17
	!byte %00000100, $1e
	!byte %00000100, $24
	!byte %00000100, $26
	!byte %00000100, $29
	!byte %00000100, $2b
	!byte %00000100, $2d
	!byte %00000100, $30
	!byte %00000100, $33
	!byte %00000100, $35
	!byte %00000100, $3b
	!byte %00000100, $44
	!byte %00000100, $4e
	!byte %00000100, $5a
	!byte %00000100, $6f
	!byte %00000100, $93
	!byte %00000100, $c3
	!byte %00000100, $ce
	!byte %00000100, $d8
	!byte %00000100, $e4
	!byte %00000100, $f0
	!byte %00000100, $f7
	!byte %00000100, $f9
	!byte %00000100, $fa
	!byte %00000100, $fc
	!byte %00000100, $fd
	!byte %00000100, $fe
	!byte %00000100, $cb
	!byte %00000100, $a2
	!byte %00000100, $5b
	!byte %00000100, $4c
	!byte %00000100, $40
	!byte %00000100, $36
	!byte %00000100, $25
	!byte %00000100, $1c
	!byte $ff
pattern_07:
	!byte %00000100, $13
	!byte %00000100, $10
	!byte %00000100, $0d
	!byte %00000101, $0b, $04
	!byte %00000100, $0a
	!byte %00000100, $0e
	!byte %00000100, $18
	!byte %00000100, $1d
	!byte %00000101, $20, $03
	!byte %00000101, $21, $05
	!byte %00000100, $25
	!byte %00000100, $2a
	!byte %00000100, $2e
	!byte %00000100, $2a
	!byte %00000100, $10
	!byte %00000100, $0d
	!byte %00000100, $0b
	!byte %00000100, $0c
	!byte %00000100, $0e
	!byte %00000100, $14
	!byte %00000101, $1d, $02
	!byte %00000101, $1c, $02
	!byte %00000100, $17
	!byte %00000100, $11
	!byte %00000101, $0e, $07
	!byte %00000101, $10, $02
	!byte %00000100, $0f
	!byte %00000101, $0d, $04
	!byte %00000101, $0e, $02
	!byte %00000100, $0f
	!byte %00000100, $12
	!byte %00000100, $15
	!byte %00000100, $1f
	!byte %00000100, $2e
	!byte %00000100, $32
	!byte %00000100, $37
	!byte %00000100, $41
	!byte %00000100, $4d
	!byte %00000100, $5b
	!byte %00000100, $6d
	!byte %00000100, $98
	!byte %00000100, $a8
	!byte %00000100, $b7
	!byte %00000100, $c5
	!byte %00000100, $d4
	!byte %00000100, $e4
	!byte %00000100, $f5
	!byte %00000100, $fe
	!byte %00000100, $fc
	!byte %00000100, $fb
	!byte %00000100, $f9
	!byte %00000100, $f8
	!byte %00000100, $f6
	!byte %00000100, $ab
	!byte %00000100, $76
	!byte %00000100, $52
	!byte %00000100, $48
	!byte %00000100, $3f
	!byte $ff
pattern_08:
	!byte %00000100, $2a
	!byte %00000100, $15
	!byte %00000100, $10
	!byte %00000101, $0f, $05
	!byte %00000100, $10
	!byte %00000100, $13
	!byte %00000100, $1e
	!byte %00000100, $30
	!byte %00000101, $3d, $02
	!byte %00000100, $3e
	!byte %00000100, $3f
	!byte %00000100, $30
	!byte %00000100, $28
	!byte %00000100, $1c
	!byte %00000100, $10
	!byte %00000100, $11
	!byte %00000100, $12
	!byte %00000100, $19
	!byte %00000100, $22
	!byte %00000101, $2e, $03
	!byte %00000100, $22
	!byte %00000100, $19
	!byte %00000101, $12, $02
	!byte %00000100, $13
	!byte %00000100, $35
	!byte %00000100, $3b
	!byte %00000100, $3e
	!byte %00000100, $3d
	!byte %00000100, $2f
	!byte %00000100, $1c
	!byte %00000100, $1a
	!byte %00000100, $19
	!byte %00000100, $17
	!byte %00000100, $16
	!byte %00000100, $15
	!byte %00000100, $13
	!byte %00000101, $12, $02
	!byte %00000100, $11
	!byte %00000101, $10, $02
	!byte %00000100, $0f
	!byte %00000101, $10, $03
	!byte %00000100, $18
	!byte %00000100, $26
	!byte %00000100, $2a
	!byte %00000100, $2e
	!byte %00000100, $33
	!byte %00000100, $38
	!byte %00000100, $44
	!byte %00000100, $5b
	!byte %00000100, $7b
	!byte %00000100, $a5
	!byte %00000100, $b8
	!byte %00000100, $cd
	!byte %00000100, $e5
	!byte %00000100, $fe
	!byte %00000101, $ff, $08
	!byte %00000100, $fa
	!byte %00000100, $f2
	!byte %00000100, $6f
	!byte %00000100, $39
	!byte %00000100, $1d
	!byte $ff
pattern_09:
	!byte %00000100, $14
	!byte %00000101, $10, $02
	!byte %00000101, $0f, $03
	!byte %00000100, $0e
	!byte %00000100, $14
	!byte %00000100, $3f
	!byte %00000100, $43
	!byte %00000100, $46
	!byte %00000100, $4b
	!byte %00000101, $4f, $02
	!byte %00000100, $4e
	!byte %00000101, $4d, $02
	!byte %00000100, $31
	!byte %00000100, $1f
	!byte %00000101, $13, $02
	!byte %00000101, $14, $05
	!byte %00000100, $34
	!byte %00000100, $4a
	!byte %00000100, $45
	!byte %00000100, $41
	!byte %00000100, $1c
	!byte %00000100, $16
	!byte %00000101, $11, $02
	!byte %00000100, $16
	!byte %00000100, $22
	!byte %00000100, $24
	!byte %00000100, $25
	!byte %00000100, $26
	!byte %00000100, $27
	!byte %00000100, $17
	!byte %00000100, $11
	!byte %00000100, $0f
	!byte %00000100, $0e
	!byte %00000101, $0d, $02
	!byte %00000101, $0c, $04
	!byte %00000101, $0d, $06
	!byte %00000100, $0e
	!byte %00000100, $12
	!byte %00000100, $1d
	!byte %00000100, $25
	!byte %00000100, $28
	!byte %00000100, $2f
	!byte %00000100, $36
	!byte %00000100, $40
	!byte %00000100, $4b
	!byte %00000100, $57
	!byte %00000100, $5c
	!byte %00000100, $61
	!byte %00000100, $80
	!byte %00000100, $85
	!byte %00000100, $88
	!byte %00000100, $8d
	!byte %00000100, $91
	!byte %00000100, $95
	!byte %00000100, $76
	!byte %00000100, $5e
	!byte %00000100, $34
	!byte %00000100, $28
	!byte %00000101, $16, $02
	!byte $ff
pattern_0a:
	!byte %00000100, $09
	!byte %00000100, $07
	!byte %00000100, $06
	!byte %00000101, $05, $04
	!byte %00000101, $06, $02
	!byte %00000100, $0b
	!byte %00000101, $14, $05
	!byte %00000101, $15, $02
	!byte %00000100, $12
	!byte %00000100, $0f
	!byte %00000100, $0d
	!byte %00000101, $0c, $02
	!byte %00000100, $12
	!byte %00000100, $1d
	!byte %00000100, $22
	!byte %00000101, $21, $02
	!byte %00000100, $20
	!byte %00000100, $1f
	!byte %00000100, $1e
	!byte %00000100, $1d
	!byte %00000100, $1c
	!byte %00000100, $1b
	!byte %00000100, $17
	!byte %00000100, $13
	!byte %00000100, $10
	!byte %00000100, $0e
	!byte %00000100, $0d
	!byte %00000101, $0c, $02
	!byte %00000100, $0b
	!byte %00000101, $0a, $06
	!byte %00000100, $09
	!byte %00000101, $08, $0e
	!byte %00000100, $09
	!byte %00000100, $0a
	!byte %00000100, $0b
	!byte %00000100, $0c
	!byte %00000100, $0d
	!byte %00000101, $0e, $08
	!byte %00000100, $0d
	!byte %00000100, $0b
	!byte %00000101, $0a, $03
	!byte $ff
pattern_0b:
	!byte %00000000
	!byte %00000101, $09, $0f
	!byte %00000100, $0a
	!byte %00000101, $0c, $05
	!byte %00000101, $0d, $04
	!byte %00000101, $0e, $03
	!byte %00000101, $14, $02
	!byte %00000101, $15, $02
	!byte %00000101, $16, $03
	!byte %00000101, $17, $02
	!byte %00000100, $1c
	!byte %00000100, $26
	!byte %00000100, $27
	!byte %00000100, $28
	!byte %00000100, $29
	!byte %00000100, $2e
	!byte %00000100, $35
	!byte %00000100, $38
	!byte %00000100, $3b
	!byte %00000100, $3e
	!byte %00000100, $42
	!byte %00000100, $45
	!byte %00000100, $4e
	!byte %00000100, $57
	!byte %00000100, $62
	!byte %00000101, $67, $09
	!byte %00000101, $3b, $02
	!byte %00000100, $21
	!byte %00000100, $1f
	!byte %00000100, $1e
	!byte %00000100, $1b
	!byte %00000100, $17
	!byte %00000100, $14
	!byte %00000100, $12
	!byte %00000100, $11
	!byte %00000100, $10
	!byte %00000100, $0f
	!byte %00000100, $0e
	!byte %00000100, $0d
	!byte %00000100, $0c
	!byte %00000101, $0a, $03
	!byte $ff
pattern_0c:
	!byte %00000001, $02
	!byte %00000100, $09
	!byte %00000100, $08
	!byte %00000100, $07
	!byte %00000101, $06, $02
	!byte %00000101, $05, $05
	!byte %00000101, $06, $05
	!byte %00000100, $07
	!byte %00000101, $08, $02
	!byte %00000100, $09
	!byte %00000101, $14, $05
	!byte %00000101, $15, $03
	!byte %00000100, $13
	!byte %00000100, $10
	!byte %00000100, $0e
	!byte %00000100, $0c
	!byte %00000101, $0a, $05
	!byte %00000101, $09, $02
	!byte %00000101, $0a, $02
	!byte %00000100, $0b
	!byte %00000100, $0e
	!byte %00000100, $0f
	!byte %00000100, $0e
	!byte %00000100, $0d
	!byte %00000101, $0c, $09
	!byte %00000100, $0d
	!byte %00000100, $10
	!byte %00000101, $11, $04
	!byte %00000100, $0d
	!byte %00000100, $0b
	!byte %00000101, $0a, $02
	!byte %00000101, $09, $02
	!byte %00000101, $08, $05
	!byte %00000100, $0a
	!byte %00000101, $0f, $06
	!byte $ff
pattern_0d:
	!byte %00000001, $08
	!byte %00000101, $07, $04
	!byte %00000100, $08
	!byte %00000100, $09
	!byte %00000100, $0b
	!byte %00000100, $0c
	!byte %00000101, $0d, $04
	!byte %00000100, $0e
	!byte %00000100, $0f
	!byte %00000100, $10
	!byte %00000100, $11
	!byte %00000100, $10
	!byte %00000100, $0f
	!byte %00000101, $0d, $06
	!byte %00000101, $0c, $02
	!byte %00000101, $0b, $03
	!byte %00000100, $0a
	!byte %00000100, $11
	!byte %00000100, $15
	!byte %00000100, $16
	!byte %00000100, $17
	!byte %00000100, $18
	!byte %00000101, $23, $02
	!byte %00000100, $34
	!byte %00000100, $40
	!byte %00000100, $43
	!byte %00000100, $46
	!byte %00000100, $49
	!byte %00000100, $4d
	!byte %00000100, $50
	!byte %00000100, $54
	!byte %00000100, $57
	!byte %00000100, $5b
	!byte %00000100, $63
	!byte %00000100, $6f
	!byte %00000100, $7d
	!byte %00000101, $8c, $0b
	!byte %00000100, $83
	!byte %00000100, $72
	!byte %00000100, $37
	!byte %00000100, $33
	!byte %00000100, $30
	!byte %00000100, $26
	!byte %00000100, $1e
	!byte %00000100, $17
	!byte %00000100, $14
	!byte %00000100, $12
	!byte %00000100, $11
	!byte $ff
pattern_0e:
	!byte %00000100, $0f
	!byte %00000100, $0e
	!byte %00000100, $0d
	!byte %00000100, $0b
	!byte %00000101, $08, $04
	!byte %00000100, $15
	!byte %00000101, $23, $02
	!byte %00000100, $24
	!byte %00000100, $1f
	!byte %00000100, $1e
	!byte %00000100, $1d
	!byte %00000100, $1c
	!byte %00000100, $1b
	!byte %00000100, $19
	!byte %00000100, $17
	!byte %00000100, $15
	!byte %00000100, $13
	!byte %00000100, $16
	!byte %00000100, $18
	!byte %00000101, $19, $02
	!byte %00000101, $1a, $02
	!byte %00000100, $19
	!byte %00000101, $16, $02
	!byte %00000101, $17, $03
	!byte %00000101, $18, $04
	!byte %00000100, $17
	!byte %00000100, $15
	!byte %00000100, $14
	!byte %00000100, $13
	!byte %00000100, $16
	!byte %00000101, $1a, $0e
	!byte %00000100, $1f
	!byte %00000101, $20, $03
	!byte %00000101, $21, $02
	!byte %00000101, $22, $03
	!byte %00000100, $1c
	!byte %00000100, $17
	!byte %00000101, $13, $02
	!byte %00000101, $12, $03
	!byte %00000101, $11, $02
	!byte %00000101, $10, $06
	!byte $ff
pattern_0f:
	!byte %00000001, $0e
	!byte %00000101, $0e, $03
	!byte %00000101, $0d, $05
	!byte %00000101, $0c, $04
	!byte %00000100, $0d
	!byte %00000100, $0f
	!byte %00000100, $10
	!byte %00000101, $21, $02
	!byte %00000100, $1f
	!byte %00000100, $1d
	!byte %00000100, $1c
	!byte %00000100, $1a
	!byte %00000100, $18
	!byte %00000100, $17
	!byte %00000100, $16
	!byte %00000100, $15
	!byte %00000101, $0d, $02
	!byte %00000101, $0e, $04
	!byte %00000100, $12
	!byte %00000101, $1b, $03
	!byte %00000100, $25
	!byte %00000101, $32, $02
	!byte %00000100, $33
	!byte %00000100, $3e
	!byte %00000100, $42
	!byte %00000100, $45
	!byte %00000100, $49
	!byte %00000100, $4d
	!byte %00000100, $51
	!byte %00000100, $56
	!byte %00000100, $5b
	!byte %00000101, $67, $04
	!byte %00000100, $55
	!byte %00000100, $3a
	!byte %00000100, $2f
	!byte %00000100, $2d
	!byte %00000100, $2a
	!byte %00000100, $28
	!byte %00000100, $21
	!byte %00000100, $17
	!byte %00000100, $13
	!byte %00000101, $12, $02
	!byte %00000100, $10
	!byte %00000100, $0e
	!byte %00000100, $0d
	!byte %00000100, $0b
	!byte $ff
pattern_10:
	!byte %00000101, $0a, $03
	!byte %00000100, $1f
	!byte %00000100, $26
	!byte %00000101, $27, $02
	!byte %00000100, $28
	!byte %00000100, $23
	!byte %00000100, $1a
	!byte %00000100, $17
	!byte %00000101, $16, $03
	!byte %00000100, $19
	!byte %00000101, $23, $04
	!byte %00000100, $1d
	!byte %00000101, $14, $05
	!byte %00000101, $13, $02
	!byte %00000101, $11, $06
	!byte %00000100, $10
	!byte %00000101, $0f, $02
	!byte %00000101, $0e, $02
	!byte %00000101, $0d, $04
	!byte %00000101, $0c, $0b
	!byte %00000101, $0a, $02
	!byte %00000101, $09, $03
	!byte %00000101, $08, $0e
	!byte %00000100, $09
	!byte %00000100, $0d
	!byte %00000101, $10, $05
	!byte %00000100, $0d
	!byte $ff
pattern_11:
	!byte %00000100, $0b
	!byte %00000101, $09, $06
	!byte %00000100, $0b
	!byte %00000100, $0e
	!byte %00000101, $11, $03
	!byte %00000100, $0d
	!byte %00000101, $0b, $02
	!byte %00000101, $0a, $02
	!byte %00000100, $0b
	!byte %00000100, $0f
	!byte %00000100, $11
	!byte %00000100, $12
	!byte %00000100, $13
	!byte %00000100, $12
	!byte %00000100, $11
	!byte %00000100, $0f
	!byte %00000100, $0a
	!byte %00000101, $08, $02
	!byte %00000101, $07, $03
	!byte %00000100, $11
	!byte %00000101, $17, $02
	!byte %00000101, $22, $02
	!byte %00000101, $21, $03
	!byte %00000101, $20, $02
	!byte %00000100, $23
	!byte %00000100, $26
	!byte %00000100, $3f
	!byte %00000100, $42
	!byte %00000100, $46
	!byte %00000100, $4a
	!byte %00000100, $4f
	!byte %00000100, $53
	!byte %00000100, $59
	!byte %00000101, $5e, $09
	!byte %00000100, $4f
	!byte %00000100, $43
	!byte %00000100, $18
	!byte %00000100, $16
	!byte %00000100, $14
	!byte %00000100, $13
	!byte %00000101, $11, $02
	!byte %00000100, $10
	!byte %00000101, $0f, $02
	!byte %00000100, $1a
	!byte %00000100, $1d
	!byte %00000100, $1f
	!byte %00000100, $22
	!byte %00000100, $27
	!byte %00000100, $30
	!byte %00000101, $3b, $02
	!byte %00000100, $3c
	!byte %00000100, $09
	!byte $ff
pattern_12:
	!byte %00010001, $01, $50
	!byte $ff
pattern_13:
	!byte %00000001, $4e
	!byte %01000001, $02
	!byte $ff
pattern_14:
	!byte %00100001, $01, $30, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $2d, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $2d, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $2d, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $30, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $2d, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $2d, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $2b, $08
	!byte %01100001, $00, $02
	!byte $ff
pattern_15:
	!byte %00100001, $01, $2d, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $30, $05
	!byte %00100001, $00, $08
	!byte %01000001, $02
	!byte %00100001, $01, $32, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $30, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $32, $05
	!byte %00100001, $00, $08
	!byte %01000001, $02
	!byte %00100001, $01, $34, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $2d, $08
	!byte %01100001, $00, $02
	!byte $ff
pattern_16:
	!byte %00100001, $01, $30, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $2d, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $2d, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $2d, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $2d, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $30, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $2d, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $2d, $08
	!byte %01100001, $00, $02
	!byte $ff
pattern_17:
	!byte %00100001, $01, $2d, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $30, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $2d, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $2d, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $34, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $37, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $2d, $08
	!byte %01100001, $00, $02
	!byte $ff
pattern_18:
	!byte %00100001, $01, $30, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $2d, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $2d, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $2d, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $2d, $05
	!byte %00100001, $01, $30, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $2d, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $2d, $08
	!byte %01100001, $00, $02
	!byte $ff
pattern_19:
	!byte %00100001, $01, $2d, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $30, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $2d, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $2d, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $34, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $37, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $2d, $0a
	!byte $ff
pattern_1a:
	!byte %00100001, $01, $30, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $30, $05
	!byte %00100001, $00, $41
	!byte $ff
pattern_1b:
	!byte %00000001, $12
	!byte %01000001, $02
	!byte %00100001, $01, $30, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $30, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $30, $0a
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $0a
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $30, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_1c:
	!byte %00100001, $01, $30, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $30, $05
	!byte %00100001, $00, $3a
	!byte %01000001, $02
	!byte %00100001, $01, $30, $05
	!byte $ff
pattern_1d:
	!byte %00100001, $00, $12
	!byte %01000001, $02
	!byte %00100001, $01, $30, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $30, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $30, $0a
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $0a
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $30, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_1e:
	!byte %00000001, $12
	!byte %01000001, $02
	!byte %00100001, $01, $30, $06
	!byte %00100001, $00, $02
	!byte %01000001, $02
	!byte %00100001, $01, $30, $06
	!byte %00100001, $00, $02
	!byte %01000001, $02
	!byte %00100001, $01, $30, $0b
	!byte %00100001, $00, $02
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $0b
	!byte %00100001, $00, $02
	!byte %01000001, $02
	!byte %00100001, $01, $30, $06
	!byte %00100001, $00, $02
	!byte %01000001, $02
	!byte $ff
pattern_1f:
	!byte %00100001, $01, $2d, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $30, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $2d, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $2d, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $34, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $37, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $2d, $08
	!byte %01000001, $02
	!byte $ff
pattern_20:
	!byte %00001111, $f7, $05, $74, $03
	!byte %00000100, $06
	!byte %00000100, $09
	!byte %00000100, $0b
	!byte %00000100, $0f
	!byte %00000100, $13
	!byte %00000101, $18, $0f
	!byte %00000100, $1d
	!byte %00000100, $23
	!byte %00000101, $27, $04
	!byte %00000100, $1a
	!byte %00000100, $11
	!byte %00000100, $0c
	!byte %00000100, $0a
	!byte %00000100, $08
	!byte %00000100, $07
	!byte %00000100, $06
	!byte %00000100, $05
	!byte %00000101, $04, $02
	!byte %00000101, $03, $02
	!byte %00000101, $02, $02
	!byte %00000101, $01, $06
	!byte %00000101, $02, $02
	!byte %00000101, $03, $02
	!byte %00000100, $04
	!byte %00000100, $07
	!byte %00000101, $0b, $02
	!byte %00000101, $0c, $02
	!byte %00000101, $0d, $02
	!byte %00000101, $0e, $04
	!byte %00000100, $0b
	!byte %00000100, $07
	!byte %00000101, $05, $05
	!byte %00000100, $06
	!byte %00000100, $09
	!byte %00000100, $11
	!byte %00000100, $13
	!byte %00000101, $14, $04
	!byte $ff
pattern_21:
	!byte %00000000
	!byte %00000100, $0c
	!byte %00000100, $07
	!byte %00000101, $06, $03
	!byte %00000100, $08
	!byte %00000100, $0d
	!byte %00000100, $10
	!byte %00000100, $14
	!byte %00000100, $16
	!byte %00000100, $17
	!byte %00000101, $18, $02
	!byte %00000100, $0f
	!byte %00000100, $0c
	!byte %00000101, $09, $08
	!byte %00000100, $0b
	!byte %00000100, $11
	!byte %00000100, $18
	!byte %00000100, $1d
	!byte %00000100, $1e
	!byte %00000100, $1f
	!byte %00000100, $18
	!byte %00000100, $0f
	!byte %00000100, $0d
	!byte %00000100, $0b
	!byte %00000101, $0a, $07
	!byte %00000100, $0b
	!byte %00000101, $0e, $04
	!byte %00000101, $0f, $02
	!byte %00000100, $0a
	!byte %00000101, $08, $02
	!byte %00000101, $07, $02
	!byte %00000100, $0a
	!byte %00000100, $0e
	!byte %00000101, $11, $03
	!byte %00000101, $12, $02
	!byte %00000100, $0a
	!byte %00000100, $08
	!byte %00000101, $07, $04
	!byte %00000100, $08
	!byte %00000100, $0a
	!byte %00000100, $0d
	!byte %00000101, $10, $03
	!byte %00000100, $0e
	!byte %00000100, $0a
	!byte %00000101, $07, $06
	!byte $ff
pattern_22:
	!byte %00000001, $03
	!byte %00000100, $08
	!byte %00000100, $0e
	!byte %00000100, $13
	!byte %00000100, $18
	!byte %00000100, $1c
	!byte %00000100, $1e
	!byte %00000100, $22
	!byte %00000100, $25
	!byte %00000100, $29
	!byte %00000100, $2d
	!byte %00000100, $32
	!byte %00000100, $34
	!byte %00000100, $36
	!byte %00000100, $39
	!byte %00000100, $3b
	!byte %00000100, $42
	!byte %00000100, $4d
	!byte %00000100, $5b
	!byte %00000100, $5c
	!byte %00000100, $5d
	!byte %00000100, $4b
	!byte %00000100, $31
	!byte %00000100, $12
	!byte %00000100, $0f
	!byte %00000100, $0e
	!byte %00000101, $0d, $02
	!byte %00000100, $0c
	!byte %00000100, $0b
	!byte %00000100, $09
	!byte %00000101, $07, $09
	!byte %00000100, $0c
	!byte %00000100, $14
	!byte %00000100, $1b
	!byte %00000101, $1f, $02
	!byte %00000101, $1e, $02
	!byte %00000100, $12
	!byte %00000100, $0a
	!byte %00000101, $08, $06
	!byte %00000100, $10
	!byte %00000100, $14
	!byte %00000101, $17, $02
	!byte %00000100, $18
	!byte %00000100, $14
	!byte %00000100, $0f
	!byte %00000100, $0b
	!byte %00000100, $09
	!byte %00000101, $08, $05
	!byte %00000101, $09, $05
	!byte %00000100, $06
	!byte %00000100, $05
	!byte %00000101, $04, $02
	!byte $ff
pattern_23:
	!byte %00000100, $05
	!byte %00000100, $09
	!byte %00000101, $10, $02
	!byte %00000100, $11
	!byte %00000100, $12
	!byte %00000100, $13
	!byte %00000100, $18
	!byte %00000100, $1e
	!byte %00000100, $26
	!byte %00000100, $24
	!byte %00000100, $23
	!byte %00000100, $21
	!byte %00000100, $15
	!byte %00000100, $0d
	!byte %00000101, $08, $02
	!byte %00000100, $07
	!byte %00000101, $06, $02
	!byte %00000101, $07, $02
	!byte %00000100, $0b
	!byte %00000100, $12
	!byte %00000100, $1d
	!byte %00000100, $1c
	!byte %00000100, $1b
	!byte %00000100, $1a
	!byte %00000100, $0d
	!byte %00000100, $07
	!byte %00000101, $06, $04
	!byte %00000100, $0b
	!byte %00000100, $13
	!byte %00000100, $14
	!byte %00000101, $15, $02
	!byte %00000100, $0d
	!byte %00000100, $08
	!byte %00000100, $05
	!byte %00000101, $04, $03
	!byte %00000100, $07
	!byte %00000100, $0c
	!byte %00000100, $21
	!byte %00000100, $26
	!byte %00000100, $23
	!byte %00000100, $21
	!byte %00000100, $1f
	!byte %00000100, $0b
	!byte %00000101, $07, $03
	!byte %00000100, $09
	!byte %00000100, $0d
	!byte %00000100, $12
	!byte %00000101, $18, $04
	!byte %00000100, $13
	!byte %00000100, $0c
	!byte %00000101, $04, $04
	!byte %00000100, $07
	!byte %00000100, $0b
	!byte %00000101, $0f, $02
	!byte %00000100, $10
	!byte %00000100, $11
	!byte %00000100, $10
	!byte %00000100, $0e
	!byte %00000100, $07
	!byte %00000100, $06
	!byte %00000100, $04
	!byte $ff
pattern_24:
	!byte %00000001, $02
	!byte %00000101, $05, $03
	!byte %00000100, $08
	!byte %00000100, $12
	!byte %00000100, $23
	!byte %00000100, $2b
	!byte %00000101, $35, $05
	!byte %00000100, $30
	!byte %00000100, $11
	!byte %00000100, $0f
	!byte %00000100, $0d
	!byte %00000100, $0b
	!byte %00000100, $09
	!byte %00000100, $08
	!byte %00000101, $06, $04
	!byte %00000100, $09
	!byte %00000100, $13
	!byte %00000100, $1c
	!byte %00000100, $1e
	!byte %00000100, $1c
	!byte %00000100, $1b
	!byte %00000100, $1a
	!byte %00000100, $18
	!byte %00000100, $0d
	!byte %00000100, $07
	!byte %00000101, $06, $02
	!byte %00000101, $07, $02
	!byte %00000100, $0d
	!byte %00000100, $18
	!byte %00000100, $1c
	!byte %00000101, $1e, $02
	!byte %00000100, $14
	!byte %00000100, $09
	!byte %00000101, $08, $02
	!byte %00000100, $07
	!byte %00000100, $0b
	!byte %00000100, $14
	!byte %00000100, $30
	!byte %00000100, $31
	!byte %00000100, $32
	!byte %00000100, $33
	!byte %00000100, $22
	!byte %00000100, $0e
	!byte %00000101, $06, $02
	!byte %00000100, $05
	!byte %00000100, $06
	!byte %00000100, $08
	!byte %00000100, $18
	!byte %00000100, $30
	!byte %00000100, $35
	!byte %00000100, $31
	!byte %00000100, $2c
	!byte %00000100, $29
	!byte %00000100, $17
	!byte %00000100, $0d
	!byte %00000100, $09
	!byte %00000101, $08, $08
	!byte %00000100, $09
	!byte $ff
pattern_25:
	!byte %00000100, $0d
	!byte %00000100, $11
	!byte %00000100, $13
	!byte %00000100, $15
	!byte %00000100, $18
	!byte %00000101, $19, $03
	!byte %00000100, $0c
	!byte %00000100, $08
	!byte %00000100, $07
	!byte %00000100, $06
	!byte %00000100, $08
	!byte %00000100, $0f
	!byte %00000100, $1c
	!byte %00000100, $26
	!byte %00000101, $27, $02
	!byte %00000100, $18
	!byte %00000100, $0c
	!byte %00000101, $07, $03
	!byte %00000100, $08
	!byte %00000100, $0f
	!byte %00000100, $1e
	!byte %00000100, $1f
	!byte %00000100, $20
	!byte %00000100, $1d
	!byte %00000100, $17
	!byte %00000100, $0f
	!byte %00000101, $07, $03
	!byte %00000100, $08
	!byte %00000100, $0d
	!byte %00000100, $14
	!byte %00000100, $1e
	!byte %00000101, $1d, $02
	!byte %00000101, $1c, $02
	!byte %00000100, $0f
	!byte %00000101, $0a, $03
	!byte %00000100, $13
	!byte %00000100, $23
	!byte %00000100, $29
	!byte %00000100, $27
	!byte %00000100, $25
	!byte %00000100, $1c
	!byte %00000100, $10
	!byte %00000101, $0c, $03
	!byte %00000100, $16
	!byte %00000100, $2a
	!byte %00000100, $34
	!byte %00000100, $41
	!byte %00000101, $40, $03
	!byte %00000101, $3f, $03
	!byte %00000100, $18
	!byte %00000100, $15
	!byte %00000100, $12
	!byte %00000101, $10, $0b
	!byte $ff
pattern_26:
	!byte %00000001, $03
	!byte %00000100, $1b
	!byte %00000101, $22, $03
	!byte %00000100, $23
	!byte %00000100, $26
	!byte %00000100, $29
	!byte %00000100, $2b
	!byte %00000100, $2e
	!byte %00000100, $30
	!byte %00000101, $31, $02
	!byte %00000100, $35
	!byte %00000100, $3b
	!byte %00000100, $43
	!byte %00000100, $46
	!byte %00000100, $48
	!byte %00000100, $4b
	!byte %00000100, $4d
	!byte %00000100, $50
	!byte %00000100, $53
	!byte %00000100, $56
	!byte %00000101, $57, $03
	!byte %00000100, $48
	!byte %00000100, $31
	!byte %00000100, $21
	!byte %00000100, $1a
	!byte %00000101, $19, $02
	!byte %00000100, $15
	!byte %00000100, $10
	!byte %00000100, $0c
	!byte %00000100, $0a
	!byte %00000101, $09, $02
	!byte %00000100, $07
	!byte %00000100, $06
	!byte %00000100, $05
	!byte %00000100, $04
	!byte %00000101, $03, $05
	!byte %00000101, $02, $05
	!byte %00000100, $04
	!byte %00000100, $07
	!byte %00000100, $0a
	!byte %00000100, $0c
	!byte %00000100, $0e
	!byte %00000100, $0f
	!byte %00000100, $12
	!byte %00000100, $14
	!byte %00000101, $15, $02
	!byte %00000100, $14
	!byte %00000100, $10
	!byte %00000100, $0b
	!byte %00000101, $07, $02
	!byte %00000101, $06, $02
	!byte %00000101, $05, $04
	!byte %00000100, $07
	!byte %00000100, $09
	!byte %00000100, $0d
	!byte %00000101, $11, $02
	!byte $ff
pattern_27:
	!byte %00000101, $12, $0a
	!byte %00000100, $18
	!byte %00000100, $20
	!byte %00000100, $27
	!byte %00000100, $2c
	!byte %00000101, $32, $05
	!byte %00000100, $1f
	!byte %00000100, $13
	!byte %00000100, $0f
	!byte %00000100, $0d
	!byte %00000100, $0c
	!byte %00000100, $0b
	!byte %00000100, $0a
	!byte %00000100, $08
	!byte %00000101, $07, $02
	!byte %00000100, $09
	!byte %00000100, $0e
	!byte %00000100, $16
	!byte %00000100, $1d
	!byte %00000100, $20
	!byte %00000100, $23
	!byte %00000100, $26
	!byte %00000100, $2a
	!byte %00000100, $2e
	!byte %00000100, $2f
	!byte %00000100, $2c
	!byte %00000100, $2a
	!byte %00000100, $17
	!byte %00000100, $0d
	!byte %00000101, $0c, $04
	!byte %00000100, $0b
	!byte %00000100, $0a
	!byte %00000100, $09
	!byte %00000101, $08, $02
	!byte %00000100, $0c
	!byte %00000100, $12
	!byte %00000100, $1a
	!byte %00000100, $1c
	!byte %00000100, $1e
	!byte %00000100, $21
	!byte %00000100, $23
	!byte %00000101, $25, $04
	!byte %00000100, $1e
	!byte %00000100, $18
	!byte %00000100, $13
	!byte %00000100, $11
	!byte %00000100, $0f
	!byte %00000100, $0d
	!byte %00000100, $0b
	!byte %00000101, $0a, $05
	!byte %00000100, $0d
	!byte %00000100, $12
	!byte %00000100, $16
	!byte %00000100, $1c
	!byte %00000100, $05
	!byte $ff
pattern_28:
	!byte %00000001, $03
	!byte %00000100, $06
	!byte %00000100, $09
	!byte %00000100, $0b
	!byte %00000100, $0f
	!byte %00000100, $13
	!byte %00000101, $18, $0f
	!byte %00000100, $1d
	!byte %00000100, $23
	!byte %00000101, $27, $04
	!byte %00000100, $1a
	!byte %00000100, $11
	!byte %00000100, $0c
	!byte %00000100, $0a
	!byte %00000100, $08
	!byte %00000100, $07
	!byte %00000100, $06
	!byte %00000100, $05
	!byte %00000101, $04, $02
	!byte %00000101, $03, $02
	!byte %00000101, $02, $02
	!byte %00000101, $01, $06
	!byte %00000101, $02, $02
	!byte %00000101, $03, $02
	!byte %00000100, $04
	!byte %00000100, $07
	!byte %00000101, $0b, $02
	!byte %00000101, $0c, $02
	!byte %00000101, $0d, $02
	!byte %00000101, $0e, $04
	!byte %00000100, $0b
	!byte %00000100, $07
	!byte %00000101, $05, $05
	!byte %00000100, $06
	!byte %00000100, $09
	!byte %00000100, $11
	!byte %00000100, $13
	!byte %00000101, $14, $04
	!byte $ff
pattern_29:
	!byte %00000100, $2d
	!byte %00000100, $39
	!byte %00000100, $3d
	!byte %00000101, $3f, $03
	!byte %00000100, $32
	!byte %00000100, $1f
	!byte %00000100, $13
	!byte %00000100, $0e
	!byte %00000100, $0c
	!byte %00000100, $0b
	!byte %00000100, $09
	!byte %00000101, $08, $02
	!byte %00000101, $07, $02
	!byte %00000100, $09
	!byte %00000100, $0d
	!byte %00000100, $16
	!byte %00000100, $1e
	!byte %00000100, $20
	!byte %00000100, $22
	!byte %00000100, $24
	!byte %00000101, $26, $02
	!byte %00000100, $24
	!byte %00000100, $22
	!byte %00000100, $14
	!byte %00000101, $0b, $02
	!byte %00000101, $0a, $02
	!byte %00000101, $09, $04
	!byte %00000100, $0b
	!byte %00000100, $10
	!byte %00000101, $17, $02
	!byte %00000101, $18, $03
	!byte %00000101, $19, $02
	!byte %00000100, $18
	!byte %00000100, $16
	!byte %00000100, $0e
	!byte %00000100, $09
	!byte %00000101, $06, $02
	!byte %00000101, $05, $03
	!byte %00000100, $04
	!byte %00000101, $02, $08
	!byte %00000101, $01, $0b
	!byte %00000101, $03, $02
	!byte %00000100, $0a
	!byte %00000100, $0b
	!byte %00000100, $0c
	!byte $ff
pattern_2a:
	!byte %00000100, $0e
	!byte %00000100, $12
	!byte %00000101, $18, $02
	!byte %00000101, $17, $02
	!byte %00000100, $16
	!byte %00000100, $0d
	!byte %00000100, $08
	!byte %00000100, $07
	!byte %00000100, $06
	!byte %00000100, $05
	!byte %00000100, $04
	!byte %00000101, $03, $05
	!byte %00000100, $06
	!byte %00000100, $0a
	!byte %00000100, $0f
	!byte %00000100, $11
	!byte %00000100, $15
	!byte %00000100, $18
	!byte %00000100, $26
	!byte %00000100, $32
	!byte %00000100, $35
	!byte %00000100, $32
	!byte %00000100, $2e
	!byte %00000100, $1a
	!byte %00000101, $0e, $08
	!byte %00000101, $0d, $03
	!byte %00000100, $17
	!byte %00000100, $1f
	!byte %00000100, $30
	!byte %00000100, $39
	!byte %00000100, $45
	!byte %00000100, $53
	!byte %00000100, $76
	!byte %00000100, $ca
	!byte %00000100, $d0
	!byte %00000100, $d6
	!byte %00000100, $dc
	!byte %00000100, $a1
	!byte %00000100, $54
	!byte %00000100, $38
	!byte %00000100, $31
	!byte %00000100, $2a
	!byte %00000100, $1f
	!byte %00000100, $12
	!byte %00000100, $0a
	!byte %00000101, $09, $02
	!byte %00000100, $08
	!byte %00000100, $0d
	!byte %00000100, $13
	!byte %00000100, $1d
	!byte %00000100, $4a
	!byte %00000100, $4c
	!byte %00000100, $4d
	!byte %00000100, $4f
	!byte %00000100, $51
	!byte %00000100, $52
	!byte %00000100, $54
	!byte %00000100, $38
	!byte %00000100, $19
	!byte %00000100, $10
	!byte %00000100, $0e
	!byte %00000100, $0d
	!byte %00000100, $10
	!byte %00000100, $1a
	!byte $ff
pattern_2b:
	!byte %00000100, $2b
	!byte %00000100, $55
	!byte %00000100, $57
	!byte %00000100, $59
	!byte %00000100, $5a
	!byte %00000100, $3a
	!byte %00000100, $1d
	!byte %00000100, $13
	!byte %00000101, $0c, $02
	!byte %00000101, $0d, $02
	!byte %00000100, $17
	!byte %00000100, $45
	!byte %00000100, $5b
	!byte %00000101, $67, $02
	!byte %00000100, $66
	!byte %00000101, $65, $02
	!byte %00000100, $64
	!byte %00000100, $1f
	!byte %00000100, $14
	!byte %00000100, $15
	!byte %00000100, $16
	!byte %00000100, $18
	!byte %00000100, $19
	!byte %00000100, $20
	!byte %00000100, $2f
	!byte %00000100, $45
	!byte %00000100, $47
	!byte %00000100, $48
	!byte %00000100, $49
	!byte %00000100, $34
	!byte %00000100, $1a
	!byte %00000100, $19
	!byte %00000100, $18
	!byte %00000100, $17
	!byte %00000100, $1d
	!byte %00000100, $33
	!byte %00000100, $76
	!byte %00000100, $7e
	!byte %00000100, $85
	!byte %00000100, $8d
	!byte %00000100, $95
	!byte %00000100, $6a
	!byte %00000100, $4b
	!byte %00000100, $35
	!byte %00000100, $19
	!byte %00000100, $15
	!byte %00000100, $12
	!byte %00000100, $0f
	!byte %00000100, $0d
	!byte %00000101, $0c, $02
	!byte %00000100, $0b
	!byte %00000100, $0a
	!byte %00000100, $08
	!byte %00000100, $06
	!byte %00000101, $05, $03
	!byte %00000100, $08
	!byte %00000100, $0f
	!byte %00000100, $17
	!byte %00000101, $1c, $05
	!byte %00000101, $1d, $03
	!byte %00000101, $0f, $02
	!byte %00000101, $05, $03
	!byte %00000100, $06
	!byte %00000100, $07
	!byte $ff
pattern_2c:
	!byte %00000100, $09
	!byte %00000100, $0b
	!byte %00000100, $0f
	!byte %00000100, $14
	!byte %00000101, $17, $02
	!byte %00000100, $18
	!byte %00000100, $14
	!byte %00000100, $0f
	!byte %00000100, $0b
	!byte %00000100, $08
	!byte %00000101, $07, $04
	!byte %00000100, $0a
	!byte %00000100, $10
	!byte %00000100, $18
	!byte %00000101, $19, $02
	!byte %00000101, $1a, $02
	!byte %00000100, $16
	!byte %00000100, $0e
	!byte %00000100, $09
	!byte %00000101, $06, $04
	!byte %00000100, $0d
	!byte %00000100, $1c
	!byte %00000100, $1e
	!byte %00000100, $21
	!byte %00000101, $23, $02
	!byte %00000100, $21
	!byte %00000100, $13
	!byte %00000100, $0a
	!byte %00000100, $06
	!byte %00000101, $05, $02
	!byte %00000100, $06
	!byte %00000100, $0b
	!byte %00000100, $12
	!byte %00000100, $1a
	!byte %00000101, $20, $03
	!byte %00000100, $13
	!byte %00000101, $0e, $02
	!byte %00000100, $0d
	!byte %00000100, $12
	!byte %00000100, $19
	!byte %00000100, $22
	!byte %00000101, $27, $06
	!byte %00000100, $0b
	!byte %00000100, $09
	!byte %00000101, $08, $0c
	!byte %00000100, $0c
	!byte %00000100, $0e
	!byte %00000101, $10, $03
	!byte $ff
pattern_2d:
	!byte %00000100, $18
	!byte %00000100, $1b
	!byte %00000100, $1f
	!byte %00000100, $29
	!byte %00000100, $35
	!byte %00000101, $45, $0b
	!byte %00000101, $1e, $03
	!byte %00000101, $0d, $02
	!byte %00000101, $0c, $02
	!byte %00000100, $10
	!byte %00000100, $1f
	!byte %00000100, $24
	!byte %00000100, $2a
	!byte %00000100, $31
	!byte %00000101, $35, $05
	!byte %00000100, $32
	!byte %00000100, $2b
	!byte %00000100, $11
	!byte %00000100, $0f
	!byte %00000100, $10
	!byte %00000100, $11
	!byte %00000100, $13
	!byte %00000100, $14
	!byte %00000100, $15
	!byte %00000100, $1c
	!byte %00000100, $25
	!byte %00000100, $30
	!byte %00000101, $37, $03
	!byte %00000100, $2e
	!byte %00000100, $21
	!byte %00000100, $0d
	!byte %00000100, $0b
	!byte %00000101, $0a, $04
	!byte %00000100, $0e
	!byte %00000100, $1a
	!byte %00000100, $27
	!byte %00000100, $2e
	!byte %00000101, $32, $02
	!byte %00000100, $33
	!byte %00000101, $34, $02
	!byte %00000100, $35
	!byte %00000100, $25
	!byte %00000100, $13
	!byte %00000100, $10
	!byte %00000101, $0e, $08
	!byte %00000100, $11
	!byte %00000100, $19
	!byte %00000100, $25
	!byte $ff
pattern_2e:
	!byte %00000100, $2a
	!byte %00000100, $30
	!byte %00000100, $41
	!byte %00000100, $67
	!byte %00000100, $a5
	!byte %00000100, $d6
	!byte %00000100, $e0
	!byte %00000100, $eb
	!byte %00000100, $f6
	!byte %00000100, $c3
	!byte %00000100, $9b
	!byte %00000100, $7a
	!byte %00000100, $3b
	!byte %00000100, $2b
	!byte %00000100, $1f
	!byte %00000100, $1a
	!byte %00000100, $19
	!byte %00000100, $18
	!byte %00000100, $17
	!byte %00000100, $16
	!byte %00000100, $19
	!byte %00000100, $20
	!byte %00000100, $2c
	!byte %00000100, $3c
	!byte %00000100, $53
	!byte %00000100, $62
	!byte %00000100, $64
	!byte %00000100, $66
	!byte %00000100, $68
	!byte %00000100, $6a
	!byte %00000100, $67
	!byte %00000100, $5e
	!byte %00000100, $15
	!byte %00000100, $13
	!byte %00000100, $11
	!byte %00000100, $10
	!byte %00000100, $12
	!byte %00000100, $2d
	!byte %00000100, $48
	!byte %00000100, $72
	!byte %00000100, $9b
	!byte %00000100, $b0
	!byte %00000100, $ca
	!byte %00000100, $e7
	!byte %00000100, $e5
	!byte %00000100, $e3
	!byte %00000100, $e1
	!byte %00000100, $df
	!byte %00000100, $88
	!byte %00000100, $53
	!byte %00000100, $3d
	!byte %00000100, $35
	!byte %00000101, $32, $06
	!byte %00000101, $4d, $03
	!byte %00000101, $ca, $04
	!byte %00000100, $6d
	!byte %00000100, $3b
	!byte %00000100, $11
	!byte %00000100, $0c
	!byte %00000100, $0b
	!byte %00000100, $0c
	!byte %00000100, $0d
	!byte %00000100, $17
	!byte %00000100, $3f
	!byte %00000100, $6f
	!byte %00000100, $cf
	!byte %00000100, $f6
	!byte %00000100, $f4
	!byte %00000100, $f2
	!byte %00000100, $ef
	!byte $ff
pattern_2f:
	!byte %00000100, $ab
	!byte %00000100, $58
	!byte %00000100, $1e
	!byte %00000101, $14, $02
	!byte %00000101, $15, $03
	!byte %00000100, $16
	!byte %00000100, $20
	!byte %00000100, $43
	!byte %00000100, $65
	!byte %00000100, $6d
	!byte %00000100, $76
	!byte %00000100, $4c
	!byte %00000100, $27
	!byte %00000100, $10
	!byte %00000100, $0f
	!byte %00000101, $0e, $03
	!byte %00000100, $10
	!byte %00000100, $15
	!byte %00000100, $20
	!byte %00000100, $30
	!byte %00000100, $38
	!byte %00000100, $42
	!byte %00000100, $4d
	!byte %00000100, $4b
	!byte %00000100, $4a
	!byte %00000100, $48
	!byte %00000100, $3f
	!byte %00000100, $2f
	!byte %00000100, $24
	!byte %00000100, $1b
	!byte %00000100, $10
	!byte %00000100, $0b
	!byte %00000101, $09, $03
	!byte %00000101, $08, $0d
	!byte %00000101, $0c, $04
	!byte %00000100, $17
	!byte %00000100, $1b
	!byte %00000100, $21
	!byte %00000100, $28
	!byte %00000100, $2f
	!byte %00000100, $39
	!byte %00000100, $3b
	!byte %00000100, $3d
	!byte %00000100, $3f
	!byte %00000100, $41
	!byte %00000100, $43
	!byte %00000100, $45
	!byte %00000100, $31
	!byte %00000100, $23
	!byte %00000100, $1a
	!byte %00000100, $16
	!byte %00000100, $12
	!byte %00000100, $0f
	!byte %00000100, $0c
	!byte %00000101, $0a, $04
	!byte $ff
pattern_30:
	!byte %00000000
	!byte %00000100, $0b
	!byte %00000100, $0c
	!byte %00000100, $0f
	!byte %00000100, $11
	!byte %00000100, $16
	!byte %00000100, $1c
	!byte %00000100, $25
	!byte %00000100, $30
	!byte %00000100, $2f
	!byte %00000100, $2d
	!byte %00000100, $2c
	!byte %00000100, $1f
	!byte %00000100, $0f
	!byte %00000100, $0d
	!byte %00000101, $0c, $04
	!byte %00000100, $0e
	!byte %00000100, $12
	!byte %00000100, $18
	!byte %00000100, $1a
	!byte %00000100, $19
	!byte %00000100, $18
	!byte %00000100, $13
	!byte %00000100, $0c
	!byte %00000101, $09, $02
	!byte %00000100, $08
	!byte %00000100, $0b
	!byte %00000100, $10
	!byte %00000100, $1d
	!byte %00000100, $28
	!byte %00000100, $2b
	!byte %00000100, $2d
	!byte %00000100, $30
	!byte %00000100, $1c
	!byte %00000100, $0c
	!byte %00000100, $08
	!byte %00000101, $07, $03
	!byte %00000100, $04
	!byte %00000100, $03
	!byte %00000101, $02, $03
	!byte %00000100, $03
	!byte %00000100, $04
	!byte %00000100, $06
	!byte %00000100, $08
	!byte %00000100, $0b
	!byte %00000100, $12
	!byte %00000100, $1e
	!byte %00000100, $26
	!byte %00000100, $24
	!byte %00000100, $23
	!byte %00000100, $21
	!byte %00000100, $13
	!byte %00000100, $09
	!byte %00000100, $07
	!byte %00000101, $05, $04
	!byte %00000100, $06
	!byte %00000100, $0c
	!byte %00000101, $15, $05
	!byte %00000100, $10
	!byte %00000100, $0d
	!byte %00000100, $0a
	!byte %00000101, $09, $03
	!byte %00000100, $05
	!byte $ff
pattern_31:
	!byte %00110001, $02, $01, $39, $4b
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_32:
	!byte %00100001, $01, $38, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $38, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_33:
	!byte %00100001, $01, $3b, $4b
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_34:
	!byte %00100001, $01, $39, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $3b, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_35:
	!byte %00100001, $01, $3c, $4b
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_36:
	!byte %00100001, $01, $3a, $4b
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_37:
	!byte %00100001, $01, $39, $4b
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_38:
	!byte %00100001, $01, $39, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $39, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_39:
	!byte %00100001, $01, $3b, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $3b, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_3a:
	!byte %00100001, $01, $38, $4b
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_3b:
	!byte %00100001, $01, $3c, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $3b, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_3c:
	!byte %00100001, $01, $37, $4b
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_3d:
	!byte %00100001, $01, $39, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $38, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_3e:
	!byte %00100001, $01, $3e, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $3e, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_3f:
	!byte %00100001, $01, $3b, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_40:
	!byte %00100001, $01, $3e, $4b
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_41:
	!byte %00100001, $01, $3b, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $3a, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_42:
	!byte %00110001, $02, $01, $3c, $4b
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_43:
	!byte %00100001, $01, $3f, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $3e, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_44:
	!byte %00100001, $01, $40, $4b
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_45:
	!byte %00100001, $01, $3f, $4b
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_46:
	!byte %00100001, $01, $3c, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_47:
	!byte %00100001, $01, $3b, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $3d, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_48:
	!byte %00100001, $01, $40, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $3f, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_49:
	!byte %00100001, $01, $40, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $40, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_4a:
	!byte %00100001, $01, $3c, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $3f, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_4b:
	!byte %00100001, $01, $40, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $40, $23
	!byte %00100001, $00, $05
	!byte $ff
pattern_4c:
	!byte %00100001, $01, $3d, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $3e, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_4d:
	!byte %00110001, $02, $01, $40, $4b
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_4e:
	!byte %00100001, $01, $43, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $43, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_4f:
	!byte %00100001, $01, $42, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $42, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_50:
	!byte %00100001, $01, $43, $4b
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_51:
	!byte %00100001, $01, $41, $4b
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_52:
	!byte %00100001, $01, $41, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $42, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_53:
	!byte %00100001, $01, $44, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $45, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_54:
	!byte %00100001, $01, $45, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $43, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_55:
	!byte %00100001, $01, $41, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $43, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_56:
	!byte %00100001, $01, $45, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $43, $23
	!byte %00100001, $00, $05
	!byte $ff
pattern_57:
	!byte %00100001, $01, $41, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $40, $23
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_58:
	!byte %00001111, $f1, $05, $7f, $50
	!byte $ff
pattern_59:
	!byte %00010001, $03, $50
	!byte $ff
pattern_5a:
	!byte %00100001, $01, $3c, $18
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $3c, $13
	!byte %00100001, $00, $18
	!byte %01000001, $02
	!byte $ff
pattern_5b:
	!byte %00100001, $01, $3c, $18
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $3c, $13
	!byte %00100001, $00, $09
	!byte %01000001, $02
	!byte $ff
pattern_5c:
	!byte %00100001, $01, $3c, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_5d:
	!byte %00100001, $01, $3c, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_5e:
	!byte %00100001, $01, $3c, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $3c, $13
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $3c, $13
	!byte %00100001, $00, $0b
	!byte $ff
pattern_5f:
	!byte %00010001, $04, $50
	!byte $ff
pattern_60:
	!byte %00100001, $01, $3c, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $05
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $02
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $02
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $02
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $02
	!byte %00100001, $00, $03
	!byte $ff
pattern_61:
	!byte %00000001, $12
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $13
	!byte %00100001, $00, $13
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $13
	!byte %00100000, $00
	!byte $ff
pattern_62:
	!byte %00000001, $3a
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $13
	!byte %00100000, $00
	!byte $ff
pattern_63:
	!byte %00000001, $35
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $0a
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $0a
	!byte $ff
pattern_64:
	!byte %00000001, $09
	!byte %00100001, $00, $31
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $13
	!byte %00100000, $00
	!byte $ff
pattern_65:
	!byte %00000001, $35
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $0a
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $05
	!byte %00100001, $00, $05
	!byte $ff
pattern_66:
	!byte %00001111, $f3, $41, $2f, $50
	!byte $ff
pattern_67:
	!byte %00010001, $02, $50
	!byte $ff
pattern_68:
	!byte %00100001, $01, $56, $0f
	!byte %00100001, $00, $12
	!byte %01000001, $02
	!byte %00100001, $01, $58, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $59, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $5d, $05
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $59, $03
	!byte %01100001, $00, $02
	!byte $ff
pattern_69:
	!byte %00100001, $01, $4f, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $51, $05
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $54, $05
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $4f, $05
	!byte %00100001, $00, $12
	!byte %01000001, $02
	!byte $ff
pattern_6a:
	!byte %00100001, $01, $56, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $58, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $59, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $5d, $05
	!byte %00100001, $00, $14
	!byte $ff
pattern_6b:
	!byte %00000001, $26
	!byte %01000001, $02
	!byte %00100001, $01, $58, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $59, $13
	!byte %00100000, $00
	!byte $ff
pattern_6c:
	!byte %00000001, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $56, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $58, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $59, $05
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $5d, $05
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $59, $03
	!byte %01100001, $00, $02
	!byte $ff
pattern_6d:
	!byte %00100001, $01, $4f, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $51, $04
	!byte %00100001, $00, $0e
	!byte %01000001, $02
	!byte %00100001, $01, $54, $04
	!byte %00100001, $00, $0e
	!byte %01000001, $02
	!byte %00100001, $01, $4f, $05
	!byte %00100001, $00, $12
	!byte %01000001, $02
	!byte $ff
pattern_6e:
	!byte %00100001, $01, $56, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $58, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $59, $05
	!byte %00100001, $00, $12
	!byte %01000001, $02
	!byte %00100001, $01, $5d, $0f
	!byte %00100001, $00, $05
	!byte $ff
pattern_6f:
	!byte %00000001, $26
	!byte %01000001, $02
	!byte %00100001, $01, $58, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $59, $12
	!byte %01100001, $00, $02
	!byte $ff
pattern_70:
	!byte %00100001, $01, $51, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $54, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $56, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $58, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $51, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $54, $04
	!byte %00100001, $00, $0e
	!byte %01000001, $02
	!byte %00100001, $01, $51, $05
	!byte $ff
pattern_71:
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $57, $0a
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $56, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $54, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_72:
	!byte %00100001, $01, $51, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $54, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $56, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $58, $05
	!byte %00100001, $01, $51, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $54, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $51, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $54, $05
	!byte $ff
pattern_73:
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $4c, $0a
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $4f, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $51, $12
	!byte %01100001, $00, $02
	!byte $ff
pattern_74:
	!byte %00100001, $01, $51, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $54, $04
	!byte %00100001, $00, $0e
	!byte %01000001, $02
	!byte %00100001, $01, $56, $05
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $58, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $51, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $54, $05
	!byte $ff
pattern_75:
	!byte %00100001, $01, $51, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $54, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $56, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $58, $2d
	!byte $ff
pattern_76:
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $4c, $0a
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $4f, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $51, $14
	!byte $ff
pattern_77:
	!byte %00100001, $01, $54, $4e
	!byte %01100001, $00, $02
	!byte $ff
pattern_78:
	!byte %00100001, $01, $51, $3f
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4f, $08
	!byte %01100001, $00, $02
	!byte %00100001, $01, $51, $03
	!byte %01100001, $00, $02
	!byte $ff
pattern_79:
	!byte %00100001, $01, $54, $05
	!byte %00100001, $00, $08
	!byte %01000001, $02
	!byte %00100001, $01, $56, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $5b, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $58, $05
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %01100001, $00, $02
	!byte $ff
pattern_7a:
	!byte %00100001, $01, $54, $19
	!byte %00100001, $00, $08
	!byte %01000001, $02
	!byte %00100001, $01, $51, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $54, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $51, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $54, $05
	!byte $ff
pattern_7b:
	!byte %00000001, $0a
	!byte %00100001, $00, $3f
	!byte %01000001, $02
	!byte %00100001, $01, $54, $05
	!byte $ff
pattern_7c:
	!byte %00000001, $0f
	!byte %00100001, $00, $2b
	!byte %01000001, $02
	!byte %00100001, $01, $51, $08
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4f, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $51, $05
	!byte $ff
pattern_7d:
	!byte %00100001, $00, $08
	!byte %01000001, $02
	!byte %00100001, $01, $54, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $56, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $5b, $05
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $58, $0a
	!byte $ff
pattern_7e:
	!byte %00100001, $00, $1c
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $51, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $54, $0f
	!byte %00100001, $00, $08
	!byte %01000001, $02
	!byte $ff
pattern_7f:
	!byte %00100001, $01, $54, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $51, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4f, $17
	!byte %01100001, $00, $02
	!byte %00100001, $01, $51, $12
	!byte %01100001, $00, $02
	!byte $ff
pattern_80:
	!byte %00100001, $01, $58, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $56, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $58, $18
	!byte %00100001, $00, $0e
	!byte %01000001, $02
	!byte %00100001, $01, $58, $03
	!byte %01100001, $00, $02
	!byte $ff
pattern_81:
	!byte %00100001, $01, $54, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $57, $08
	!byte %01100001, $00, $02
	!byte %00100001, $01, $58, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $5b, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $5d, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $54, $03
	!byte %01100001, $00, $02
	!byte $ff
pattern_82:
	!byte %00100001, $01, $58, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $59, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $5d, $26
	!byte %01100001, $00, $02
	!byte %00100001, $01, $60, $03
	!byte %01100001, $00, $02
	!byte $ff
pattern_83:
	!byte %00100001, $01, $54, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $51, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4f, $17
	!byte %01100001, $00, $02
	!byte %00100001, $01, $51, $13
	!byte %00100000, $00
	!byte $ff
pattern_84:
	!byte %00000001, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $58, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $56, $18
	!byte %00100001, $00, $0e
	!byte %01000001, $02
	!byte %00100001, $01, $58, $08
	!byte %01100001, $00, $02
	!byte $ff
pattern_85:
	!byte %00100001, $01, $54, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $57, $08
	!byte %01100001, $00, $02
	!byte %00100001, $01, $58, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $5b, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $5d, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $54, $04
	!byte %00100000, $00
	!byte $ff
pattern_86:
	!byte %00000001, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $58, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $59, $27
	!byte %00100001, $00, $09
	!byte %01000001, $02
	!byte $ff
pattern_87:
	!byte %00100001, $01, $60, $0f
	!byte %00100001, $00, $12
	!byte %01000001, $02
	!byte %00100001, $01, $5f, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $5b, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $60, $05
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $5f, $03
	!byte %01100001, $00, $02
	!byte $ff
pattern_88:
	!byte %00100001, $01, $54, $21
	!byte %01100001, $00, $02
	!byte %00100001, $01, $51, $17
	!byte %01100001, $00, $02
	!byte %00100001, $01, $54, $12
	!byte %01100001, $00, $02
	!byte $ff
pattern_89:
	!byte %00100001, $01, $54, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $56, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $58, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $54, $05
	!byte %00100001, $00, $12
	!byte %01000001, $02
	!byte $ff
pattern_8a:
	!byte %00100001, $01, $54, $21
	!byte %01100001, $00, $02
	!byte %00100001, $01, $54, $17
	!byte %01100001, $00, $02
	!byte %00100001, $01, $59, $14
	!byte $ff
pattern_8b:
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $60, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $5f, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $5b, $05
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $60, $05
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $5f, $03
	!byte %01100001, $00, $02
	!byte $ff
pattern_8c:
	!byte %00100001, $01, $54, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $56, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $58, $05
	!byte %00100001, $00, $12
	!byte %01000001, $02
	!byte %00100001, $01, $54, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_8d:
	!byte %00000001, $21
	!byte %01000001, $02
	!byte %00100001, $01, $51, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $58, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $56, $12
	!byte %01100001, $00, $02
	!byte $ff
pattern_8e:
	!byte %00100001, $01, $54, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $50, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $54, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $54, $05
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $54, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $50, $05
	!byte $ff
pattern_8f:
	!byte %00100001, $00, $21
	!byte %01000001, $02
	!byte %00100001, $01, $4c, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4c, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4c, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4c, $05
	!byte $ff
pattern_90:
	!byte %00100001, $00, $26
	!byte %01000001, $02
	!byte %00100001, $01, $54, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $50, $14
	!byte $ff
pattern_91:
	!byte %00100001, $00, $21
	!byte %01000001, $02
	!byte %00100001, $01, $58, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $56, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $54, $12
	!byte %01100001, $00, $02
	!byte $ff
pattern_92:
	!byte %00100001, $01, $50, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $54, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $54, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $58, $05
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $50, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $54, $05
	!byte $ff
pattern_93:
	!byte %00100001, $00, $21
	!byte %01000001, $02
	!byte %00100001, $01, $4c, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $51, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4c, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $51, $05
	!byte $ff
pattern_94:
	!byte %00100001, $00, $26
	!byte %01000001, $02
	!byte %00100001, $01, $50, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $54, $14
	!byte $ff
pattern_95:
	!byte %00100001, $01, $4a, $0f
	!byte %00100001, $00, $12
	!byte %01000001, $02
	!byte %00100001, $01, $4c, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4d, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $51, $05
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $4d, $03
	!byte %01100001, $00, $02
	!byte $ff
pattern_96:
	!byte %00100001, $01, $43, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $45, $05
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $48, $05
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $43, $05
	!byte %00100001, $00, $12
	!byte %01000001, $02
	!byte $ff
pattern_97:
	!byte %00100001, $01, $4a, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $4c, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $4d, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $51, $05
	!byte %00100001, $00, $14
	!byte $ff
pattern_98:
	!byte %00000001, $26
	!byte %01000001, $02
	!byte %00100001, $01, $4c, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4d, $13
	!byte %00100000, $00
	!byte $ff
pattern_99:
	!byte %00000001, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $4a, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4c, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4d, $05
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $51, $05
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $4d, $03
	!byte %01100001, $00, $02
	!byte $ff
pattern_9a:
	!byte %00100001, $01, $43, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $45, $04
	!byte %00100001, $00, $0e
	!byte %01000001, $02
	!byte %00100001, $01, $48, $04
	!byte %00100001, $00, $0e
	!byte %01000001, $02
	!byte %00100001, $01, $43, $05
	!byte %00100001, $00, $12
	!byte %01000001, $02
	!byte $ff
pattern_9b:
	!byte %00100001, $01, $4a, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $4c, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4d, $05
	!byte %00100001, $00, $12
	!byte %01000001, $02
	!byte %00100001, $01, $51, $0f
	!byte %00100001, $00, $05
	!byte $ff
pattern_9c:
	!byte %00000001, $26
	!byte %01000001, $02
	!byte %00100001, $01, $4c, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4d, $12
	!byte %01100001, $00, $02
	!byte $ff
pattern_9d:
	!byte %00100001, $01, $45, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $48, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4a, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4c, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $45, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $48, $04
	!byte %00100001, $00, $0e
	!byte %01000001, $02
	!byte %00100001, $01, $45, $05
	!byte $ff
pattern_9e:
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $4b, $0a
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $4a, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $48, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_9f:
	!byte %00100001, $01, $45, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $48, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4a, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4c, $05
	!byte %00100001, $01, $45, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $48, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $45, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $48, $05
	!byte $ff
pattern_a0:
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $40, $0a
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $43, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $45, $12
	!byte %01100001, $00, $02
	!byte $ff
pattern_a1:
	!byte %00100001, $01, $45, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $48, $04
	!byte %00100001, $00, $0e
	!byte %01000001, $02
	!byte %00100001, $01, $4a, $05
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $4c, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $45, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $48, $05
	!byte $ff
pattern_a2:
	!byte %00100001, $01, $45, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $48, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4a, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4c, $2d
	!byte $ff
pattern_a3:
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $40, $0a
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $43, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $45, $14
	!byte $ff
pattern_a4:
	!byte %00100001, $01, $48, $4e
	!byte %01100001, $00, $02
	!byte $ff
pattern_a5:
	!byte %00100001, $01, $45, $3f
	!byte %01100001, $00, $02
	!byte %00100001, $01, $43, $08
	!byte %01100001, $00, $02
	!byte %00100001, $01, $45, $03
	!byte %01100001, $00, $02
	!byte $ff
pattern_a6:
	!byte %00100001, $01, $48, $05
	!byte %00100001, $00, $08
	!byte %01000001, $02
	!byte %00100001, $01, $4a, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4f, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4c, $05
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $48, $03
	!byte %01100001, $00, $02
	!byte $ff
pattern_a7:
	!byte %00100001, $01, $48, $19
	!byte %00100001, $00, $08
	!byte %01000001, $02
	!byte %00100001, $01, $45, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $48, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $45, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $48, $05
	!byte $ff
pattern_a8:
	!byte %00000001, $0a
	!byte %00100001, $00, $3f
	!byte %01000001, $02
	!byte %00100001, $01, $48, $05
	!byte $ff
pattern_a9:
	!byte %00000001, $0f
	!byte %00100001, $00, $2b
	!byte %01000001, $02
	!byte %00100001, $01, $45, $08
	!byte %01100001, $00, $02
	!byte %00100001, $01, $43, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $45, $05
	!byte $ff
pattern_aa:
	!byte %00100001, $00, $08
	!byte %01000001, $02
	!byte %00100001, $01, $48, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4a, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4f, $05
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $4c, $0a
	!byte $ff
pattern_ab:
	!byte %00100001, $00, $1c
	!byte %01000001, $02
	!byte %00100001, $01, $48, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $45, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $48, $0f
	!byte %00100001, $00, $08
	!byte %01000001, $02
	!byte $ff
pattern_ac:
	!byte %00100001, $01, $48, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $45, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $43, $17
	!byte %01100001, $00, $02
	!byte %00100001, $01, $45, $12
	!byte %01100001, $00, $02
	!byte $ff
pattern_ad:
	!byte %00100001, $01, $4c, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4a, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4c, $18
	!byte %00100001, $00, $0e
	!byte %01000001, $02
	!byte %00100001, $01, $4c, $03
	!byte %01100001, $00, $02
	!byte $ff
pattern_ae:
	!byte %00100001, $01, $48, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4b, $08
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4c, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4f, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $51, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $48, $03
	!byte %01100001, $00, $02
	!byte $ff
pattern_af:
	!byte %00100001, $01, $4c, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4d, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $51, $26
	!byte %01100001, $00, $02
	!byte %00100001, $01, $54, $03
	!byte %01100001, $00, $02
	!byte $ff
pattern_b0:
	!byte %00100001, $01, $48, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $45, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $43, $17
	!byte %01100001, $00, $02
	!byte %00100001, $01, $45, $13
	!byte %00100000, $00
	!byte $ff
pattern_b1:
	!byte %00000001, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $4c, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4a, $18
	!byte %00100001, $00, $0e
	!byte %01000001, $02
	!byte %00100001, $01, $4c, $08
	!byte %01100001, $00, $02
	!byte $ff
pattern_b2:
	!byte %00100001, $01, $48, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4b, $08
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4c, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4f, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $51, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $48, $04
	!byte %00100000, $00
	!byte $ff
pattern_b3:
	!byte %00000001, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $4c, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4d, $27
	!byte %00100001, $00, $09
	!byte %01000001, $02
	!byte $ff
pattern_b4:
	!byte %00100001, $01, $54, $0f
	!byte %00100001, $00, $12
	!byte %01000001, $02
	!byte %00100001, $01, $53, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4f, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $54, $05
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $53, $03
	!byte %01100001, $00, $02
	!byte $ff
pattern_b5:
	!byte %00100001, $01, $48, $21
	!byte %01100001, $00, $02
	!byte %00100001, $01, $45, $17
	!byte %01100001, $00, $02
	!byte %00100001, $01, $48, $12
	!byte %01100001, $00, $02
	!byte $ff
pattern_b6:
	!byte %00100001, $01, $48, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $4a, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $4c, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $48, $05
	!byte %00100001, $00, $12
	!byte %01000001, $02
	!byte $ff
pattern_b7:
	!byte %00100001, $01, $48, $21
	!byte %01100001, $00, $02
	!byte %00100001, $01, $48, $17
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4d, $14
	!byte $ff
pattern_b8:
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $53, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4f, $05
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $54, $05
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $53, $03
	!byte %01100001, $00, $02
	!byte $ff
pattern_b9:
	!byte %00100001, $01, $48, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $4a, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4c, $05
	!byte %00100001, $00, $12
	!byte %01000001, $02
	!byte %00100001, $01, $48, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte $ff
pattern_ba:
	!byte %00000001, $21
	!byte %01000001, $02
	!byte %00100001, $01, $45, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4c, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4a, $12
	!byte %01100001, $00, $02
	!byte $ff
pattern_bb:
	!byte %00100001, $01, $48, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $44, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $48, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $48, $05
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $48, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $44, $05
	!byte $ff
pattern_bc:
	!byte %00100001, $00, $21
	!byte %01000001, $02
	!byte %00100001, $01, $40, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $40, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $40, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $40, $05
	!byte $ff
pattern_bd:
	!byte %00100001, $00, $26
	!byte %01000001, $02
	!byte %00100001, $01, $48, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $44, $14
	!byte $ff
pattern_be:
	!byte %00100001, $00, $21
	!byte %01000001, $02
	!byte %00100001, $01, $4c, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4a, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $48, $12
	!byte %01100001, $00, $02
	!byte $ff
pattern_bf:
	!byte %00100001, $01, $44, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $48, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $48, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $4c, $05
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $44, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $48, $05
	!byte $ff
pattern_c0:
	!byte %00100001, $00, $21
	!byte %01000001, $02
	!byte %00100001, $01, $40, $12
	!byte %01100001, $00, $02
	!byte %00100001, $01, $45, $03
	!byte %01100001, $00, $02
	!byte %00100001, $01, $40, $0d
	!byte %01100001, $00, $02
	!byte %00100001, $01, $45, $05
	!byte $ff
pattern_c1:
	!byte %00100001, $00, $26
	!byte %01000001, $02
	!byte %00100001, $01, $44, $0f
	!byte %00100001, $00, $03
	!byte %01000001, $02
	!byte %00100001, $01, $48, $14
	!byte $ff
pattern_c2:
	!byte %00010001, $00, $50
	!byte $ff

nt_lookup_lo:
	!byte <notetable_00, <notetable_01, <notetable_02, <notetable_03
	!byte <notetable_04, <notetable_05
nt_lookup_hi:
	!byte >notetable_00, >notetable_01, >notetable_02, >notetable_03
	!byte >notetable_04, >notetable_05

pt_lookup_lo:
	!byte <pulsetable_00, <pulsetable_01, <pulsetable_02, <pulsetable_03
	!byte <pulsetable_04, <pulsetable_05
pt_lookup_hi:
	!byte >pulsetable_00, >pulsetable_01, >pulsetable_02, >pulsetable_03
	!byte >pulsetable_04, >pulsetable_05

wt_lookup_lo:
	!byte <wavetable_00, <wavetable_01, <wavetable_02, <wavetable_03
	!byte <wavetable_04, <wavetable_05
wt_lookup_hi:
	!byte >wavetable_00, >wavetable_01, >wavetable_02, >wavetable_03
	!byte >wavetable_04, >wavetable_05


program_ad:
	!byte $34,$09,$00,$00,$00,$06

program_sr:
	!byte $f3,$90,$a2,$f8,$f9,$00

wavetable_00:
	!byte $00, $41, $21, $00
notetable_00:
	!byte $00, $00, $00, $21, $00, $00
pulsetable_00:
	!byte $08, $00, $21, $00

wavetable_01:
	!byte $00, $21, $21, $00
notetable_01:
	!byte $00, $00, $00, $21, $00, $00
pulsetable_01:
	!byte $08, $00, $21, $00

wavetable_02:
	!byte $00, $41, $21, $00
notetable_02:
	!byte $00, $00, $00, $21, $00, $00
pulsetable_02:
	!byte $08, $00, $21, $00

wavetable_03:
	!byte $00, $81, $00, $11, $21, $00
notetable_03:
	!byte $01, $f7, $de, $01, $fb, $07, $01, $fc, $06, $01, $fd, $05, $01, $fd, $04, $01, $fe, $03, $01, $fe, $02, $01, $ff, $01, $01, $ff, $00, $01, $00, $00, $01, $ff, $00, $01, $00, $00, $21, $00, $00
pulsetable_03:
	!byte $08, $00, $21, $00

wavetable_04:
	!byte $00, $81, $00, $41, $00, $80, $00, $40, $00, $80, $21, $00
notetable_04:
	!byte $01, $f4, $4f, $01, $f9, $0c, $01, $fe, $5c, $01, $00, $00, $01, $f6, $fe, $21, $00, $00
pulsetable_04:
	!byte $08, $00, $21, $00

wavetable_05:
	!byte $00, $11, $00, $11, $00, $81, $21, $00
notetable_05:
	!byte $01, $dc, $02, $01, $87, $02, $01, $37, $17, $01, $cc, $01, $01, $37, $17, $21, $00, $00
pulsetable_05:
	!byte $08, $00, $21, $00
