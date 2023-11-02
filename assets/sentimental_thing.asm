!to "sentimental_thing.prg", plain
!cpu m65

!set title = "sentimental thing"
!set author = "deathy/bas"

;!set include_stub = 1
!set ghost_registers = 1

!set looping = 1
!set uses_fmode_volume = 1
!set uses_cutoff = 1
!set uses_res_routing = 1
!set uses_pulsewidth = 1

!set nt_uses_susto = 0
!set nt_uses_goto = 0
!set nt_uses_end = 1
!set pt_uses_goto = 1
!set pt_uses_end = 1
!set wt_uses_end = 1

!addr cmd_delay = bit_01
!addr cmd_fmode_volume = bit_02
!addr cmd_cutoff = bit_04
!addr cmd_resonance_routing = bit_08
!addr cmd_programchange = bit_10
!addr cmd_noteon = bit_20
!addr cmd_hardrestart = bit_40
!addr cmd_pulsewidth = bit_80
!set changeover = "byte"

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
	sta $d030
	
	;lda #$00
	tax
	tay
	taz
	map
	eom

	lda #%00110111
	sta $00
	lda #%00110110
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
	ldx #$00
	stx $d020
	stx $d021
	
	lda #$40
.loop2
	cmp $d012
	beq .loop2
	
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
	
	; set SIDs to 6581
	; The 8580 is the preferred sound chip, but at this time, it is not working
	; properly on real hardware.  If you are still seeing this after the fix is
	; in, you can change the value to $0f to switch to 8580s and remind me to
	; fix it in the exporter.
	lda #$01
	sta $d63c
	
	lda #$01
	sta pattern_delays, x
	;sta hard_restarting, x
	
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
!ifdef command_word {
	sta current_command_word
}
	inz

!ifdef command_word {
	lda (zp), z
	sta current_command_word+1
	inz
	lda current_command
}
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

!ifdef uses_finetune {
	lda program_finetune_lo, y
	sta current_finetune_lo, x
	lda program_finetune_hi, y
	sta current_finetune_hi, x
}
	
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
	
	lda vt_lookup_lo, y
	sta vt_ptr_lo, x
	lda vt_lookup_hi, y
	sta vt_ptr_hi, x
	lda program_vibrato_delay, y
	sta vt_start_delay, x
	
!ifdef uses_pulsewidth {
	lda program_default_pw_lo, y
	sta current_pw_lo, x
	lda program_default_pw_hi, y
	sta current_pw_hi, x
}
	
	lda #$01
	sta ad_changed, x
	sta sr_changed, x
	
!ifdef uses_pitchbend {
	lsr
	
	sta current_pb_lo, x
	sta current_pb_hi, x
}
	
	inz
	lda current_command
	
+
note_on:
	; note on
	bit cmd_noteon
	beq +++
	
	; load the arp length
+	lda (zp), z
	bne +
	
	; zero length - release note
	inz
	lda #$00
	sta sustaining, x
	beq ++

+
	lda sustaining, x
	bne +
	
	lda #$01
	sta vt_indices, x
	
	lsr
	
	sta hard_restarting, x
	sta nt_indices, x
	sta pt_indices, x
	sta wt_indices, x
	
	lda vt_start_delay, x
	sta vt_current_delay, x

+
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

!ifdef uses_pitchbend {
pitchbend:
	bit cmd_pitchbend
	beq +
	
	lda (zp), z
	sta current_pb_lo, x
	inz
	lda (zp), z
	sta current_pb_hi, x
	inz
	
!if changeover != "pulsewidth" {
	lda current_command
}
	
+
}

!if changeover = "pulsewidth" {
	lda current_command_word+1
	sta current_command
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

!if changeover != "attackdecay" {	
	lda current_command
}

+
}

!if changeover = "attackdecay" {
	lda current_command_word+1
	sta current_command
}

!ifdef uses_attackdecay {
	bit cmd_attackdecay
	beq +
	
	lda (zp), z
	inz
	sta current_ad, x
	
	lda #$01
	sta ad_changed, x
	
!if changeover != "sustainrelease" {	
	lda current_command
}
+
}

!if changeover = "sustainrelease" {
	lda current_command_word+1
	sta current_command
}

!ifdef uses_sustainrelease {
	bit cmd_sustainrelease
	beq +
	
	lda (zp), z
	inz
	sta current_sr, x
	
	lda #$01
	sta sr_changed, x
	
!if changeover != "vibratotable" {	
	lda current_command
}
+
}

!if changeover = "vibratotable" {
	lda current_command_word+1
	sta current_command
}

!ifdef uses_vibratotable {
vibrato_table:
	bit cmd_vibratotable
	beq +
	
	tza
	clc
	adc zp
	sta vt_ptr_lo, x
	lda #$00
	adc zp+1
	sta vt_ptr_hi, x

	tza
	clc
	adc (zp), y
	taz
	inz
	
!if changeover != "vibratodelay" {	
	lda current_command
}
+
}

!if changeover = "vibratodelay" {
	lda current_command_word+1
	sta current_command
}

!ifdef uses_vibratodelay {
	bit cmd_vibratodelay
	beq +
	
	lda (zp), z
	sta vt_start_delay, x
	inz
	
!ifndef command_word {
	lda current_command
}
+
}
!ifdef command_word {
	lda current_command_word
}

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
	bne +
	
	lda hard_restarting, x
	beq ++

+
	dex
	bne update_loop
	rts
	
++
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

!ifdef uses_finetune {
	clc
	adc current_finetune_lo, x
}

	pha
	
	iny
	lda (zp2), y
	
!ifdef uses_finetune {
	adc current_finetune_hi, x
}
	
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
	jmp pulse_table
	
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
	lbeq pulse_table
	sta zp2+1
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
	
	lda freq_lo, y
	sta tword
	lda freq_hi, y
	sta tword+1

vibratotable:
	; update vibrato
	lda vt_current_delay, x
	bne +++
	
	lda vt_ptr_hi, x
	beq ++++
	sta zp+1
	lda vt_ptr_lo, x
	sta zp
	
	ldy #$00
	lda (zp), y
	beq ++++
	
	cmp vt_indices, x
	bmi +
	bne ++
	
+	lda #$01
	sta vt_indices, x
	
++	ldy vt_indices, x
	
	lda (zp), y
	clc
	adc tword
	sta tword
	iny
	lda (zp), y
	adc tword+1
	sta tword+1
	iny
	
	tya
	sta vt_indices, x
	bra ++++
	
+++	dec vt_current_delay, x

++++

!ifdef uses_finetune {
	clc
	lda current_finetune_lo, x
	adc tword
	sta tword
	lda current_finetune_hi, x
	adc tword+1
	sta tword+1
}

!ifdef uses_pitchbend {
	clc
	lda current_pb_lo, x
	adc tword
	sta tword
	lda current_pb_hi, x
	adc tword+1
	sta tword+1
}

	ldy #$00
	lda tword
	sta (sidzp), y
	iny
	lda tword+1
	sta (sidzp), y
	
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
!ifdef uses_pulsewidth {
	clc
	adc current_pw_lo, x
}
	sta (sidzp), y
	iny
	pla
!ifdef uses_pulsewidth {
	adc current_pw_hi, x
}
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
	
+

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
!ifdef command_word {
current_command_word:
	!word $00
}

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

!ifdef uses_finetune {
current_finetune_lo:
	!fill $10
current_finetune_hi:
	!fill $10
}

!ifdef uses_pulsewidth {	
current_pw_lo:
	!fill $10
current_pw_hi:
	!fill $10
}

!ifdef uses_pitchbend {
current_pb_lo:
	!fill $10
current_pb_hi:
	!fill $10
}

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
vt_start_delay:
	!fill $10
vt_current_delay:
	!fill $10
vt_indices:
	!fill $10
vt_ptr_lo:
	!fill $10
vt_ptr_hi:
	!fill $10

temp:
	!byte $00
tword:
	!word $0000

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
	!byte $02, $02, $02, $02, $02, $02, $02, $02
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $02, $02, $02, $02, $02, $02, $02, $02
	!byte $03, $03, $03, $03, $03, $03, $03, $03
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $02, $02, $02, $02, $02, $02, $02, $02
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $04, $04, $04, $04, $04, $04, $04, $04
	!byte $02, $02, $02, $02, $02, $02, $02, $02
	!byte $02, $02, $02, $02, $02, $02, $02, $02
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $02, $02, $02, $02, $02, $02, $02, $05
	!byte $01, $01, $01, $01, $01, $01, $01, $01
	!byte $ff, $08

s0_voice_00_pattern_list:
	!byte $06, $07, $07, $07, $07, $07, $07, $07
	!byte $08, $09, $08, $0a, $08, $09, $08, $0a
	!byte $07, $07, $07, $07, $07, $07, $07, $07
	!byte $08, $09, $08, $0a, $08, $09, $08, $0a
	!byte $0b, $0b, $0b, $0c, $0b, $0b, $0b, $0c
	!byte $07, $07, $07, $07, $07, $07, $07, $07
	!byte $08, $09, $08, $0a, $08, $09, $08, $0a
	!byte $07, $07, $07, $07, $07, $07, $07, $07
	!byte $0d, $0e, $0d, $0e, $0d, $0e, $0d, $0e
	!byte $08, $09, $08, $0a, $08, $09, $08, $0a
	!byte $08, $09, $08, $0a, $08, $09, $08, $0a
	!byte $07, $07, $07, $07, $07, $07, $07, $07
	!byte $08, $09, $08, $0a, $08, $09, $08, $0a
	!byte $07, $07, $07, $07, $07, $07, $07, $07
	!byte $ff, $08

s0_voice_01_pattern_list:
	!byte $0f, $10, $10, $10, $10, $10, $10, $10
	!byte $11, $11, $11, $11, $11, $11, $11, $11
	!byte $11, $11, $11, $11, $11, $11, $11, $11
	!byte $11, $11, $11, $11, $11, $11, $11, $11
	!byte $11, $11, $11, $11, $11, $11, $11, $11
	!byte $11, $11, $11, $11, $11, $11, $11, $11
	!byte $10, $10, $10, $10, $10, $10, $10, $10
	!byte $11, $11, $11, $11, $11, $11, $11, $11
	!byte $11, $11, $11, $11, $11, $11, $11, $11
	!byte $11, $11, $11, $11, $11, $11, $11, $11
	!byte $11, $11, $11, $11, $11, $11, $11, $11
	!byte $11, $11, $11, $11, $11, $11, $11, $11
	!byte $11, $11, $11, $11, $11, $11, $11, $11
	!byte $10, $10, $10, $10, $10, $10, $10, $10
	!byte $ff, $08

s0_voice_02_pattern_list:
	!byte $12, $13, $13, $13, $13, $13, $13, $13
	!byte $14, $14, $14, $14, $14, $14, $14, $14
	!byte $13, $13, $13, $13, $13, $13, $13, $13
	!byte $14, $14, $14, $14, $14, $14, $14, $14
	!byte $15, $15, $15, $15, $15, $15, $15, $15
	!byte $13, $13, $13, $13, $13, $13, $13, $13
	!byte $14, $14, $14, $14, $14, $14, $14, $14
	!byte $13, $13, $13, $13, $13, $13, $13, $13
	!byte $16, $16, $16, $16, $16, $16, $16, $16
	!byte $14, $14, $14, $14, $14, $14, $14, $14
	!byte $14, $14, $14, $14, $14, $14, $14, $14
	!byte $13, $13, $13, $13, $13, $13, $13, $13
	!byte $14, $14, $14, $14, $14, $14, $14, $14
	!byte $13, $13, $13, $13, $13, $13, $13, $13
	!byte $ff, $08

s1_global_pattern_list:
	!byte $17, $10, $10, $10, $10, $10, $10, $10
	!byte $18, $19, $1a, $1b, $1c, $1d, $1e, $1f
	!byte $18, $19, $1a, $1b, $1c, $1d, $1e, $1f
	!byte $18, $19, $1a, $1b, $1c, $1d, $1e, $1f
	!byte $18, $19, $1a, $1b, $1c, $1d, $1e, $1f
	!byte $18, $19, $1a, $1b, $1c, $1d, $1e, $1f
	!byte $18, $19, $1a, $1b, $1c, $1d, $1e, $1f
	!byte $18, $19, $1a, $1b, $1c, $1d, $1e, $1f
	!byte $18, $19, $1a, $1b, $1c, $1d, $1e, $1f
	!byte $18, $19, $1a, $1b, $1c, $1d, $1e, $1f
	!byte $18, $19, $1a, $1b, $1c, $1d, $1e, $1f
	!byte $18, $19, $1a, $1b, $1c, $1d, $1e, $1f
	!byte $18, $19, $1a, $1b, $1c, $1d, $1e, $1f
	!byte $18, $19, $1a, $1b, $1c, $1d, $1e, $1f
	!byte $ff, $08

s1_voice_00_pattern_list:
	!byte $20, $10, $10, $10, $10, $10, $10, $21
	!byte $22, $23, $22, $24, $25, $23, $25, $24
	!byte $26, $27, $26, $28, $26, $27, $26, $28
	!byte $29, $2a, $29, $2b, $29, $2a, $29, $2b
	!byte $2c, $2d, $2e, $2f, $2e, $2d, $2e, $2f
	!byte $26, $27, $26, $28, $26, $27, $26, $28
	!byte $30, $31, $32, $33, $34, $35, $34, $36
	!byte $26, $27, $26, $28, $26, $27, $26, $28
	!byte $37, $38, $39, $3a, $37, $38, $39, $3a
	!byte $3b, $3c, $3d, $3e, $3b, $3f, $3d, $40
	!byte $41, $42, $43, $44, $41, $42, $43, $44
	!byte $26, $27, $26, $28, $26, $27, $26, $28
	!byte $45, $46, $47, $48, $49, $4a, $4b, $48
	!byte $4c, $4d, $4c, $4e, $4c, $4d, $4c, $4f
	!byte $ff, $08

s1_voice_01_pattern_list:
	!byte $50, $10, $10, $10, $10, $10, $10, $21
	!byte $51, $52, $51, $53, $54, $52, $54, $53
	!byte $55, $56, $55, $57, $55, $56, $55, $57
	!byte $58, $59, $58, $5a, $58, $59, $58, $5a
	!byte $5b, $5c, $5d, $5e, $5d, $5c, $5d, $5e
	!byte $55, $56, $55, $57, $55, $56, $55, $57
	!byte $5f, $60, $61, $62, $63, $64, $63, $65
	!byte $55, $56, $55, $57, $55, $56, $55, $57
	!byte $66, $67, $68, $69, $66, $67, $68, $69
	!byte $6a, $6b, $6c, $6d, $6a, $6e, $6c, $6f
	!byte $70, $71, $72, $73, $70, $71, $72, $73
	!byte $55, $56, $55, $57, $55, $56, $55, $57
	!byte $74, $75, $76, $77, $78, $79, $7a, $77
	!byte $7b, $7c, $7b, $7d, $7b, $7c, $7b, $7e
	!byte $ff, $08

s1_voice_02_pattern_list:
	!byte $7f, $10, $10, $10, $10, $10, $10, $21
	!byte $80, $81, $80, $82, $80, $81, $80, $83
	!byte $84, $85, $86, $85, $86, $85, $86, $87
	!byte $80, $81, $80, $82, $80, $81, $80, $83
	!byte $88, $89, $8a, $89, $8a, $89, $8a, $89
	!byte $86, $85, $86, $85, $86, $85, $86, $85
	!byte $10, $10, $10, $10, $10, $10, $10, $10
	!byte $86, $85, $86, $85, $86, $85, $86, $85
	!byte $8b, $8c, $8c, $8d, $8b, $8c, $8c, $8e
	!byte $80, $81, $80, $82, $80, $81, $80, $82
	!byte $80, $81, $80, $82, $80, $81, $80, $83
	!byte $84, $85, $86, $85, $86, $85, $86, $87
	!byte $80, $81, $80, $82, $80, $81, $80, $83
	!byte $8f, $10, $10, $10, $10, $10, $10, $10
	!byte $ff, $08

s2_global_pattern_list:
	!byte $90, $91, $91, $91, $91, $91, $91, $91
	!byte $91, $91, $91, $91, $91, $91, $91, $91
	!byte $91, $91, $91, $91, $91, $91, $91, $91
	!byte $91, $91, $91, $91, $91, $91, $91, $91
	!byte $91, $91, $91, $91, $91, $91, $91, $91
	!byte $91, $91, $91, $91, $91, $91, $91, $91
	!byte $91, $91, $91, $91, $91, $91, $91, $91
	!byte $91, $91, $91, $91, $91, $91, $91, $91
	!byte $91, $91, $91, $91, $91, $91, $91, $91
	!byte $91, $91, $91, $91, $91, $91, $91, $91
	!byte $91, $91, $91, $91, $91, $91, $91, $91
	!byte $91, $91, $91, $91, $91, $91, $91, $91
	!byte $91, $91, $91, $91, $91, $91, $91, $91
	!byte $91, $91, $91, $91, $91, $91, $91, $91
	!byte $ff, $08

s2_voice_00_pattern_list:
	!byte $92, $93, $94, $95, $96, $97, $98, $99
	!byte $98, $9a, $9b, $9c, $9d, $9e, $9f, $a0
	!byte $a1, $93, $94, $95, $96, $97, $98, $99
	!byte $98, $9a, $9b, $9c, $9d, $9e, $9f, $a0
	!byte $a1, $a2, $a3, $96, $a4, $a5, $a6, $9c
	!byte $a1, $93, $94, $95, $96, $97, $98, $99
	!byte $98, $9a, $9b, $9c, $9d, $9e, $9f, $a0
	!byte $a1, $93, $94, $95, $96, $97, $98, $99
	!byte $a4, $a7, $a8, $a9, $96, $aa, $ab, $95
	!byte $98, $9a, $9b, $9c, $9d, $9e, $9f, $a0
	!byte $98, $9a, $9b, $9c, $9d, $9e, $9f, $a0
	!byte $a1, $93, $94, $95, $96, $97, $98, $99
	!byte $98, $9a, $9b, $9c, $9d, $9e, $9f, $a0
	!byte $a1, $93, $94, $95, $96, $97, $98, $99
	!byte $ff, $08

s2_voice_01_pattern_list:
	!byte $ac, $10, $10, $10, $10, $10, $10, $21
	!byte $ad, $ae, $af, $b0, $b1, $b2, $b3, $b4
	!byte $b5, $b6, $b7, $b8, $b9, $ba, $ad, $bb
	!byte $ad, $ae, $af, $b0, $b1, $b2, $b3, $b4
	!byte $b5, $bc, $bd, $b9, $be, $bf, $c0, $b0
	!byte $b5, $b6, $b7, $b8, $b9, $ba, $ad, $c1
	!byte $10, $10, $10, $10, $10, $10, $10, $21
	!byte $b5, $b6, $b7, $b8, $b9, $ba, $ad, $bb
	!byte $be, $c2, $c3, $c4, $b9, $c5, $c6, $b8
	!byte $ad, $ae, $af, $b0, $b1, $b2, $b3, $b4
	!byte $ad, $ae, $af, $b0, $b1, $b2, $b3, $b4
	!byte $b5, $b6, $b7, $b8, $b9, $ba, $ad, $bb
	!byte $ad, $ae, $af, $b0, $b1, $b2, $b3, $b4
	!byte $10, $10, $10, $10, $10, $10, $10, $10
	!byte $ff, $08

s2_voice_02_pattern_list:
	!byte $0f, $10, $10, $10, $10, $10, $10, $10
	!byte $11, $11, $11, $11, $11, $11, $11, $11
	!byte $11, $11, $11, $11, $11, $11, $11, $11
	!byte $11, $11, $11, $11, $11, $11, $11, $11
	!byte $11, $11, $11, $11, $11, $11, $11, $11
	!byte $11, $11, $11, $11, $11, $11, $11, $11
	!byte $10, $10, $10, $10, $10, $10, $10, $10
	!byte $11, $11, $11, $11, $11, $11, $11, $11
	!byte $11, $11, $11, $11, $11, $11, $11, $11
	!byte $11, $11, $11, $11, $11, $11, $11, $11
	!byte $11, $11, $11, $11, $11, $11, $11, $11
	!byte $11, $11, $11, $11, $11, $11, $11, $11
	!byte $11, $11, $11, $11, $11, $11, $11, $11
	!byte $10, $10, $10, $10, $10, $10, $10, $10
	!byte $ff, $08

s3_global_pattern_list:
	!byte $c7, $10, $10, $10, $10, $10, $10, $10
	!byte $c8, $c9, $c8, $ca, $c8, $cb, $c8, $cc
	!byte $cd, $ce, $cf, $d0, $d1, $d2, $d3, $d4
	!byte $c8, $c9, $c8, $ca, $c8, $cb, $c8, $cc
	!byte $d5, $d6, $d5, $d7, $d8, $d6, $d8, $d7
	!byte $cd, $ce, $cf, $d0, $d1, $d2, $d3, $d4
	!byte $10, $10, $10, $10, $10, $10, $10, $10
	!byte $cd, $ce, $cf, $d0, $d1, $d2, $d3, $d4
	!byte $d9, $da, $db, $da, $dc, $dd, $db, $da
	!byte $c8, $c9, $c8, $ca, $c8, $cb, $c8, $cc
	!byte $c8, $c9, $c8, $ca, $c8, $cb, $c8, $cc
	!byte $cd, $ce, $cf, $d0, $d1, $d2, $d3, $d4
	!byte $c8, $c9, $c8, $ca, $c8, $cb, $c8, $cc
	!byte $10, $10, $10, $10, $10, $10, $10, $10
	!byte $ff, $08

s3_voice_00_pattern_list:
	!byte $06, $07, $07, $07, $07, $07, $07, $07
	!byte $08, $09, $08, $0a, $08, $09, $08, $0a
	!byte $07, $07, $07, $07, $07, $07, $07, $07
	!byte $08, $09, $08, $0a, $08, $09, $08, $0a
	!byte $0b, $0b, $0b, $0c, $0b, $0b, $0b, $0c
	!byte $07, $07, $07, $07, $07, $07, $07, $07
	!byte $08, $09, $08, $0a, $08, $09, $08, $0a
	!byte $07, $07, $07, $07, $07, $07, $07, $07
	!byte $0d, $0e, $0d, $0e, $0d, $0e, $0d, $0e
	!byte $08, $09, $08, $0a, $08, $09, $08, $0a
	!byte $08, $09, $08, $0a, $08, $09, $08, $0a
	!byte $07, $07, $07, $07, $07, $07, $07, $07
	!byte $08, $09, $08, $0a, $08, $09, $08, $0a
	!byte $07, $07, $07, $07, $07, $07, $07, $07
	!byte $ff, $08

s3_voice_01_pattern_list:
	!byte $de, $10, $10, $10, $10, $10, $10, $21
	!byte $df, $e0, $df, $e1, $df, $e2, $df, $e3
	!byte $e4, $e5, $e6, $e7, $e8, $e9, $ea, $eb
	!byte $df, $e0, $df, $e1, $df, $e2, $df, $e3
	!byte $ec, $ed, $ee, $ef, $f0, $ed, $f1, $ef
	!byte $e4, $e5, $e6, $e7, $e8, $e9, $ea, $f2
	!byte $10, $10, $10, $10, $10, $10, $10, $21
	!byte $e4, $e5, $e6, $e7, $e8, $e9, $ea, $eb
	!byte $f3, $f4, $f5, $f6, $f7, $f4, $f5, $f6
	!byte $df, $e0, $df, $e1, $df, $e2, $df, $e3
	!byte $df, $e0, $df, $e1, $df, $e2, $df, $e3
	!byte $e4, $e5, $e6, $e7, $e8, $e9, $ea, $eb
	!byte $df, $e0, $df, $e1, $df, $e2, $df, $e3
	!byte $10, $10, $10, $10, $10, $10, $10, $10
	!byte $ff, $08

s3_voice_02_pattern_list:
	!byte $ac, $10, $10, $10, $10, $10, $10, $21
	!byte $df, $e0, $df, $e1, $df, $e2, $df, $e3
	!byte $e4, $e5, $e6, $e7, $e8, $e9, $ea, $eb
	!byte $df, $e0, $df, $e1, $df, $e2, $df, $e3
	!byte $ec, $ed, $ee, $ef, $f0, $ed, $f1, $ef
	!byte $e4, $e5, $e6, $e7, $e8, $e9, $ea, $f2
	!byte $10, $10, $10, $10, $10, $10, $10, $21
	!byte $e4, $e5, $e6, $e7, $e8, $e9, $ea, $eb
	!byte $f3, $f4, $f5, $f6, $f7, $f4, $f5, $f6
	!byte $df, $e0, $df, $e1, $df, $e2, $df, $e3
	!byte $df, $e0, $df, $e1, $df, $e2, $df, $e3
	!byte $e4, $e5, $e6, $e7, $e8, $e9, $ea, $eb
	!byte $df, $e0, $df, $e1, $df, $e2, $df, $e3
	!byte $10, $10, $10, $10, $10, $10, $10, $10
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
	!byte <pattern_c0, <pattern_c1, <pattern_c2, <pattern_c3
	!byte <pattern_c4, <pattern_c5, <pattern_c6, <pattern_c7
	!byte <pattern_c8, <pattern_c9, <pattern_ca, <pattern_cb
	!byte <pattern_cc, <pattern_cd, <pattern_ce, <pattern_cf
	!byte <pattern_d0, <pattern_d1, <pattern_d2, <pattern_d3
	!byte <pattern_d4, <pattern_d5, <pattern_d6, <pattern_d7
	!byte <pattern_d8, <pattern_d9, <pattern_da, <pattern_db
	!byte <pattern_dc, <pattern_dd, <pattern_de, <pattern_df
	!byte <pattern_e0, <pattern_e1, <pattern_e2, <pattern_e3
	!byte <pattern_e4, <pattern_e5, <pattern_e6, <pattern_e7
	!byte <pattern_e8, <pattern_e9, <pattern_ea, <pattern_eb
	!byte <pattern_ec, <pattern_ed, <pattern_ee, <pattern_ef
	!byte <pattern_f0, <pattern_f1, <pattern_f2, <pattern_f3
	!byte <pattern_f4, <pattern_f5, <pattern_f6, <pattern_f7

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
	!byte >pattern_c0, >pattern_c1, >pattern_c2, >pattern_c3
	!byte >pattern_c4, >pattern_c5, >pattern_c6, >pattern_c7
	!byte >pattern_c8, >pattern_c9, >pattern_ca, >pattern_cb
	!byte >pattern_cc, >pattern_cd, >pattern_ce, >pattern_cf
	!byte >pattern_d0, >pattern_d1, >pattern_d2, >pattern_d3
	!byte >pattern_d4, >pattern_d5, >pattern_d6, >pattern_d7
	!byte >pattern_d8, >pattern_d9, >pattern_da, >pattern_db
	!byte >pattern_dc, >pattern_dd, >pattern_de, >pattern_df
	!byte >pattern_e0, >pattern_e1, >pattern_e2, >pattern_e3
	!byte >pattern_e4, >pattern_e5, >pattern_e6, >pattern_e7
	!byte >pattern_e8, >pattern_e9, >pattern_ea, >pattern_eb
	!byte >pattern_ec, >pattern_ed, >pattern_ee, >pattern_ef
	!byte >pattern_f0, >pattern_f1, >pattern_f2, >pattern_f3
	!byte >pattern_f4, >pattern_f5, >pattern_f6, >pattern_f7

pattern_00:
	!byte %00001111, $f4, $ff, $6f, $03
	!byte %00000101, $29, $04
	!byte %00000101, $53, $04
	!byte %00000101, $f5, $04
	!byte %00000101, $27, $04
	!byte %00000101, $46, $04
	!byte %00000101, $33, $04
	!byte %00000101, $29, $04
	!byte %00000101, $53, $04
	!byte %00000101, $34, $04
	!byte %00000101, $56, $04
	!byte %00000101, $9d, $04
	!byte %00000101, $ff, $04
	!byte %00000101, $29, $04
	!byte %00000101, $53, $04
	!byte %00000101, $f5, $04
	!byte %00000101, $27, $04
	!byte %00000101, $46, $04
	!byte %00000101, $33, $04
	!byte %00000101, $29, $04
	!byte %00000101, $53, $04
	!byte %00000101, $34, $04
	!byte %00000101, $56, $04
	!byte %00000101, $9d, $04
	!byte %00000100, $ff
	!byte $ff
pattern_01:
	!byte %00000101, $96, $04
	!byte %00000101, $2b, $04
	!byte %00000101, $29, $04
	!byte %00000101, $b1, $04
	!byte %00000101, $2d, $04
	!byte %00000101, $31, $04
	!byte %00000101, $96, $04
	!byte %00000101, $2b, $04
	!byte %00000101, $29, $04
	!byte %00000101, $38, $04
	!byte %00000101, $64, $04
	!byte %00000101, $a9, $04
	!byte %00000101, $96, $04
	!byte %00000101, $2b, $04
	!byte %00000101, $29, $04
	!byte %00000101, $b1, $04
	!byte %00000101, $2d, $04
	!byte %00000101, $31, $04
	!byte %00000101, $96, $04
	!byte %00000101, $2b, $04
	!byte %00000101, $29, $04
	!byte %00000101, $38, $04
	!byte %00000101, $64, $04
	!byte %00000101, $a9, $04
	!byte $ff
pattern_02:
	!byte %00000101, $9d, $04
	!byte %00000101, $2d, $04
	!byte %00000101, $2b, $04
	!byte %00000101, $3a, $04
	!byte %00000101, $66, $04
	!byte %00000101, $ab, $04
	!byte %00000101, $9d, $04
	!byte %00000101, $2d, $04
	!byte %00000101, $2b, $04
	!byte %00000101, $3a, $04
	!byte %00000101, $66, $04
	!byte %00000101, $ab, $04
	!byte %00000101, $9d, $04
	!byte %00000101, $30, $04
	!byte %00000101, $29, $04
	!byte %00000101, $3b, $04
	!byte %00000101, $67, $04
	!byte %00000101, $ad, $04
	!byte %00000101, $96, $04
	!byte %00000101, $2e, $04
	!byte %00000101, $29, $04
	!byte %00000101, $3b, $04
	!byte %00000101, $67, $04
	!byte %00000101, $ad, $04
	!byte $ff
pattern_03:
	!byte %00000101, $9d, $04
	!byte %00000101, $0d, $04
	!byte %00000101, $5b, $07
	!byte %00000101, $75, $04
	!byte %00000101, $9e, $04
	!byte %00000101, $d0, $04
	!byte %00000101, $13, $04
	!byte %00000101, $5a, $07
	!byte %00000101, $6d, $04
	!byte %00000101, $92, $04
	!byte %00000101, $c0, $04
	!byte %00000101, $27, $04
	!byte %00000101, $1f, $07
	!byte %00000101, $65, $04
	!byte %00000101, $88, $04
	!byte %00000101, $b3, $04
	!byte %00000101, $4c, $05
	!byte %00000101, $21, $08
	!byte %00000101, $6d, $04
	!byte %00000101, $93, $04
	!byte %00000101, $c2, $02
	!byte $ff
pattern_04:
	!byte %00000101, $9d, $04
	!byte %00000101, $0d, $04
	!byte %00000101, $5b, $04
	!byte %00000101, $73, $04
	!byte %00000101, $9b, $04
	!byte %00000101, $33, $04
	!byte %00000101, $9d, $04
	!byte %00000101, $0d, $04
	!byte %00000101, $5b, $04
	!byte %00000101, $73, $04
	!byte %00000101, $9b, $04
	!byte %00000101, $33, $04
	!byte %00000101, $9d, $04
	!byte %00000101, $0d, $04
	!byte %00000101, $5b, $04
	!byte %00000101, $73, $04
	!byte %00000101, $9c, $04
	!byte %00000101, $31, $04
	!byte %00000101, $96, $04
	!byte %00000101, $0c, $06
	!byte %00000101, $68, $04
	!byte %00000101, $86, $04
	!byte %00000101, $8a, $04
	!byte %00000101, $2e, $02
	!byte $ff
pattern_05:
	!byte %00000101, $96, $04
	!byte %00000101, $2e, $04
	!byte %00000101, $29, $04
	!byte %00000101, $3b, $04
	!byte %00000101, $67, $04
	!byte %00000101, $ad, $04
	!byte %00000101, $96, $04
	!byte %00000101, $2e, $04
	!byte %00000101, $29, $04
	!byte %00000101, $3b, $04
	!byte %00000101, $67, $04
	!byte %00000101, $ad, $04
	!byte %00000101, $96, $04
	!byte %00000101, $2e, $04
	!byte %00000101, $29, $04
	!byte %00000101, $3b, $04
	!byte %00000101, $67, $04
	!byte %00000101, $ad, $04
	!byte %00000101, $96, $04
	!byte %00000101, $2e, $04
	!byte %00000101, $29, $04
	!byte %00000101, $3b, $04
	!byte %00000101, $67, $04
	!byte %00000101, $ad, $04
	!byte $ff
pattern_06:
	!byte %00110001, $00, $01, $3c, $0c
	!byte %00100001, $00, $0a
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $0c
	!byte %00100001, $00, $0a
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $0c
	!byte %00100001, $00, $0a
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $0c
	!byte %00100001, $00, $0a
	!byte %01000001, $02
	!byte $ff
pattern_07:
	!byte %00100001, $01, $3c, $0c
	!byte %00100001, $00, $0a
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $0c
	!byte %00100001, $00, $0a
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $0c
	!byte %00100001, $00, $0a
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $0c
	!byte %00100001, $00, $0a
	!byte %01000001, $02
	!byte $ff
pattern_08:
	!byte %00100001, $01, $3c, $0c
	!byte %00100001, $00, $16
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $0c
	!byte %00100001, $00, $22
	!byte %01000001, $02
	!byte $ff
pattern_09:
	!byte %00100001, $01, $3c, $0c
	!byte %00100001, $00, $16
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $0c
	!byte %00100001, $00, $0a
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte $ff
pattern_0a:
	!byte %00100001, $01, $3c, $0c
	!byte %00100001, $00, $1c
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $0c
	!byte %00100001, $00, $16
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte $ff
pattern_0b:
	!byte %00100001, $01, $3c, $0c
	!byte %00100001, $00, $1c
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $0c
	!byte %00100001, $00, $22
	!byte %01000001, $02
	!byte $ff
pattern_0c:
	!byte %00100001, $01, $3c, $0c
	!byte %00100001, $00, $1c
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $0c
	!byte %00100001, $00, $16
	!byte %01000001, $02
	!byte $ff
pattern_0d:
	!byte %00100001, $01, $3c, $0c
	!byte %00100001, $00, $22
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $0c
	!byte %00100001, $00, $0a
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $0c
	!byte $ff
pattern_0e:
	!byte %00100001, $00, $2e
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $0c
	!byte %00100001, $00, $16
	!byte %01000001, $02
	!byte $ff
pattern_0f:
	!byte %00010001, $01, $60
	!byte $ff
pattern_10:
	!byte %00000001, $60
	!byte $ff
pattern_11:
	!byte %00000001, $16
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $0c
	!byte %00100001, $00, $22
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $0c
	!byte %00100001, $00, $0c
	!byte $ff
pattern_12:
	!byte %00110001, $02, $01, $54, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte $ff
pattern_13:
	!byte %00100001, $01, $54, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte $ff
pattern_14:
	!byte %00100001, $01, $54, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte $ff
pattern_15:
	!byte %00100001, $01, $54, $0c
	!byte %00100001, $00, $0a
	!byte %01000001, $02
	!byte %00100001, $01, $54, $0c
	!byte %00100001, $00, $0a
	!byte %01000001, $02
	!byte %00100001, $01, $54, $0c
	!byte %00100001, $00, $0a
	!byte %01000001, $02
	!byte %00100001, $01, $54, $0c
	!byte %00100001, $00, $0a
	!byte %01000001, $02
	!byte $ff
pattern_16:
	!byte %00100001, $01, $54, $09
	!byte %00100001, $00, $07
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $54, $09
	!byte %00100001, $00, $07
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $54, $09
	!byte %00100001, $00, $07
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $54, $09
	!byte %00100001, $00, $07
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte $ff
pattern_17:
	!byte %00001011, $a3, $6a, $60
	!byte $ff
pattern_18:
	!byte %00000000
	!byte %00000101, $48, $0c
	!byte %00000101, $44, $0e
	!byte %00000101, $40, $10
	!byte %00000101, $3c, $0f
	!byte %00000101, $38, $11
	!byte %00000101, $34, $12
	!byte %00000101, $30, $03
	!byte $ff
pattern_19:
	!byte %00000001, $02
	!byte %00000101, $2f, $14
	!byte %00000101, $2b, $17
	!byte %00000101, $27, $18
	!byte %00000101, $23, $1b
	!byte $ff
pattern_1a:
	!byte %00000101, $1f, $1f
	!byte %00000101, $1b, $24
	!byte %00000101, $17, $1d
	!byte $ff
pattern_1b:
	!byte %00000001, $02
	!byte %00000101, $14, $30
	!byte %00000101, $10, $2e
	!byte $ff
pattern_1c:
	!byte %00000001, $11
	!byte %00000101, $0c, $4f
	!byte $ff
pattern_1d:
	!byte %00000001, $06
	!byte %00000101, $08, $5a
	!byte $ff
pattern_1e:
	!byte %00000001, $05
	!byte %00000101, $05, $5b
	!byte $ff
pattern_1f:
	!byte %00000001, $06
	!byte %00000101, $05, $14
	!byte %00000101, $09, $0c
	!byte %00000101, $0d, $09
	!byte %00000101, $11, $07
	!byte %00000101, $15, $06
	!byte %00000101, $19, $05
	!byte %00000101, $1d, $04
	!byte %00000101, $21, $04
	!byte %00000101, $25, $04
	!byte %00000101, $2a, $04
	!byte %00000101, $30, $04
	!byte %00000101, $36, $04
	!byte %00000101, $3d, $04
	!byte %00000101, $44, $03
	!byte $ff
pattern_20:
	!byte %00010001, $07, $60
	!byte $ff
pattern_21:
	!byte %00000001, $5e
	!byte %01000001, $02
	!byte $ff
pattern_22:
	!byte %10100001, $01, $4c, $61, $00, $03
	!byte %00100000, $00
	!byte %10000001, $d4, $01, $04
	!byte %10000001, $f8, $00, $02
	!byte %01000001, $02
	!byte %10100001, $01, $45, $93, $00, $04
	!byte %10000001, $6d, $03, $04
	!byte %10000000, $88, $05
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %10100001, $01, $48, $61, $00, $03
	!byte %00100000, $00
	!byte %10000001, $d4, $01, $04
	!byte %10000001, $f8, $00, $02
	!byte %01000001, $02
	!byte %10100001, $01, $4a, $93, $00, $04
	!byte %10000001, $6d, $03, $04
	!byte %10000000, $88, $05
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %10100001, $01, $48, $61, $00, $03
	!byte %00100000, $00
	!byte %10000001, $d4, $01, $04
	!byte %10000001, $f8, $00, $02
	!byte %01000001, $02
	!byte %10100001, $01, $4a, $93, $00, $04
	!byte %10000001, $6d, $03, $04
	!byte %10000000, $88, $05
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %10100001, $01, $4a, $61, $00, $04
	!byte %10000001, $a4, $03, $04
	!byte %10000000, $9f, $05
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %10100001, $01, $48, $93, $00, $04
	!byte %10000001, $6d, $03, $04
	!byte %10000000, $88, $05
	!byte %00100000, $00
	!byte %01000001, $02
	!byte $ff
pattern_23:
	!byte %10100001, $01, $48, $61, $00, $03
	!byte %00100000, $00
	!byte %10000001, $d4, $01, $04
	!byte %10000001, $f8, $00, $02
	!byte %01000001, $02
	!byte %10100001, $01, $45, $93, $00, $03
	!byte %00100000, $00
	!byte %10000001, $e3, $01, $04
	!byte %10000001, $e7, $00, $04
	!byte %10000001, $00, $00, $0a
	!byte %01000001, $02
	!byte %00100001, $01, $43, $03
	!byte %10000001, $00, $03, $04
	!byte %10000001, $e3, $05, $04
	!byte %10000001, $68, $04, $04
	!byte %10000001, $01, $03, $12
	!byte %00100000, $00
	!byte %11000001, $c8, $01, $02
	!byte %00100001, $01, $45, $02
	!byte %10000001, $f7, $01, $04
	!byte %10100001, $01, $48, $ab, $00, $03
	!byte %00100000, $00
	!byte %11000001, $dc, $01, $02
	!byte %00100001, $01, $45, $02
	!byte %10000001, $2b, $02, $04
	!byte %10000001, $2f, $05, $03
	!byte %00100000, $00
	!byte %11000001, $6d, $04, $02
	!byte $ff
pattern_24:
	!byte %10100001, $01, $48, $61, $00, $03
	!byte %00100000, $00
	!byte %10000001, $d4, $01, $04
	!byte %10000001, $f8, $00, $02
	!byte %01000001, $02
	!byte %10100001, $01, $4a, $93, $00, $03
	!byte %00100000, $00
	!byte %10000001, $e3, $01, $04
	!byte %10000001, $e7, $00, $04
	!byte %10000001, $00, $00, $0a
	!byte %01000001, $02
	!byte %00100001, $01, $48, $03
	!byte %10000001, $00, $03, $04
	!byte %10000001, $e3, $05, $04
	!byte %10000001, $68, $04, $04
	!byte %10000001, $01, $03, $06
	!byte %00100000, $00
	!byte %11000001, $d7, $01, $02
	!byte %00100001, $01, $4a, $02
	!byte %10000001, $2b, $02, $04
	!byte %10000001, $2f, $05, $03
	!byte %00100000, $00
	!byte %11000001, $6d, $04, $02
	!byte %00100001, $01, $48, $02
	!byte %10000001, $f7, $01, $04
	!byte %10100001, $01, $4a, $ab, $00, $03
	!byte %00100000, $00
	!byte %11000001, $dc, $01, $02
	!byte %00100001, $01, $48, $02
	!byte %10000001, $2b, $02, $04
	!byte %10000001, $2f, $05, $03
	!byte %00100000, $00
	!byte %11000001, $6d, $04, $02
	!byte $ff
pattern_25:
	!byte %10100001, $01, $45, $61, $00, $03
	!byte %00100000, $00
	!byte %10000001, $d4, $01, $04
	!byte %10000001, $f8, $00, $02
	!byte %01000001, $02
	!byte %10100001, $01, $48, $93, $00, $04
	!byte %10000001, $6d, $03, $04
	!byte %10000000, $88, $05
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %10100001, $01, $4a, $61, $00, $03
	!byte %00100000, $00
	!byte %10000001, $d4, $01, $04
	!byte %10000001, $f8, $00, $02
	!byte %01000001, $02
	!byte %10100001, $01, $48, $93, $00, $04
	!byte %10000001, $6d, $03, $04
	!byte %10000000, $88, $05
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %10100001, $01, $4a, $61, $00, $03
	!byte %00100000, $00
	!byte %10000001, $d4, $01, $04
	!byte %10000001, $f8, $00, $02
	!byte %01000001, $02
	!byte %10100001, $01, $4a, $93, $00, $04
	!byte %10000001, $6d, $03, $04
	!byte %10000000, $88, $05
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %10100001, $01, $48, $61, $00, $04
	!byte %10000001, $a4, $03, $04
	!byte %10000000, $9f, $05
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %10100001, $01, $4a, $93, $00, $04
	!byte %10000001, $6d, $03, $04
	!byte %10000000, $88, $05
	!byte %00100000, $00
	!byte %01000001, $02
	!byte $ff
pattern_26:
	!byte %10100001, $01, $45, $61, $00, $04
	!byte %10000001, $a4, $03, $04
	!byte %10000001, $9f, $05, $04
	!byte %10100001, $00, $11, $04, $04
	!byte %10000001, $65, $02, $04
	!byte %10000001, $50, $00, $02
	!byte %01000001, $02
	!byte %00100001, $01, $45, $02
	!byte %10000001, $f7, $01, $04
	!byte %10000001, $6a, $05, $04
	!byte %10000001, $e2, $04, $02
	!byte %00100001, $00, $02
	!byte %10000001, $20, $03, $04
	!byte %10000001, $61, $01, $04
	!byte %01000001, $02
	!byte %10100001, $01, $51, $61, $00, $04
	!byte %10000001, $a4, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $78, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $4f, $93, $00, $04
	!byte %10000001, $6d, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $58, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $51, $61, $00, $04
	!byte %10000001, $a4, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $78, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $4c, $93, $00, $04
	!byte %10000001, $6d, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $58, $03, $02
	!byte %01000001, $02
	!byte $ff
pattern_27:
	!byte %10100001, $01, $45, $61, $00, $04
	!byte %10000001, $a4, $03, $02
	!byte %00100001, $01, $43, $02
	!byte %10000001, $dd, $01, $04
	!byte %10100001, $00, $44, $04, $04
	!byte %11000001, $83, $02, $02
	!byte %00100001, $01, $45, $02
	!byte %10000001, $11, $02, $04
	!byte %10100001, $00, $63, $04, $04
	!byte %11000001, $62, $02, $02
	!byte %00100001, $01, $48, $02
	!byte %10000001, $dd, $01, $04
	!byte %10100001, $00, $44, $04, $04
	!byte %11000001, $83, $02, $02
	!byte %00100001, $01, $4a, $02
	!byte %10000001, $11, $02, $04
	!byte %10000001, $13, $05, $04
	!byte %10000001, $d6, $04, $04
	!byte %10000001, $77, $03, $04
	!byte %10100001, $01, $45, $93, $00, $04
	!byte %10000001, $6d, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $58, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $43, $61, $00, $04
	!byte %10000001, $a4, $03, $02
	!byte %00100001, $01, $45, $02
	!byte %10000001, $dd, $01, $04
	!byte %10100001, $01, $48, $93, $00, $04
	!byte %10000001, $6d, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $58, $03, $02
	!byte %01000001, $02
	!byte $ff
pattern_28:
	!byte %10100001, $01, $45, $61, $00, $04
	!byte %10000001, $a4, $03, $02
	!byte %00100001, $01, $4f, $02
	!byte %10000001, $dd, $01, $04
	!byte %10100001, $00, $44, $04, $04
	!byte %11000001, $83, $02, $02
	!byte %00100001, $01, $4e, $02
	!byte %10000001, $11, $02, $04
	!byte %10100001, $00, $63, $04, $04
	!byte %11000001, $62, $02, $02
	!byte %00100001, $01, $4c, $02
	!byte %10000001, $dd, $01, $04
	!byte %10100001, $00, $44, $04, $04
	!byte %11000001, $83, $02, $02
	!byte %00100001, $01, $4a, $02
	!byte %10000001, $11, $02, $04
	!byte %10000001, $13, $05, $04
	!byte %10000001, $d6, $04, $04
	!byte %10000001, $77, $03, $04
	!byte %10100001, $01, $45, $93, $00, $04
	!byte %10000001, $6d, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $58, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $4f, $61, $00, $04
	!byte %10000001, $a4, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $78, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $4e, $93, $00, $04
	!byte %10000001, $6d, $03, $04
	!byte %10000001, $88, $05, $04
	!byte $ff
pattern_29:
	!byte %10100001, $01, $45, $61, $00, $04
	!byte %10000001, $a4, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $78, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $4c, $93, $00, $04
	!byte %10000001, $6d, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $58, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $4a, $61, $00, $04
	!byte %10000001, $a4, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $78, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $48, $93, $00, $04
	!byte %10000001, $6d, $03, $02
	!byte %00100001, $01, $4a, $02
	!byte %10000001, $11, $02, $04
	!byte %10100001, $00, $63, $04, $04
	!byte %11000001, $62, $02, $02
	!byte %00100001, $01, $48, $02
	!byte %10000001, $dd, $01, $04
	!byte %10100001, $01, $4a, $93, $00, $04
	!byte %10000001, $6d, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $58, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $48, $61, $00, $04
	!byte %10000001, $a4, $03, $02
	!byte %00100001, $01, $4a, $02
	!byte %10000001, $dd, $01, $04
	!byte %10100001, $00, $44, $04, $04
	!byte %11000001, $83, $02, $02
	!byte %00100001, $01, $48, $02
	!byte %10000001, $11, $02, $04
	!byte $ff
pattern_2a:
	!byte %10100001, $00, $63, $04, $04
	!byte %10000001, $62, $02, $04
	!byte %10000001, $79, $00, $02
	!byte %01000001, $02
	!byte %00100001, $01, $4a, $02
	!byte %10000001, $2b, $02, $04
	!byte %10000001, $2f, $05, $04
	!byte %10000001, $ca, $04, $02
	!byte %00100001, $01, $48, $02
	!byte %10000001, $f7, $01, $04
	!byte %10000001, $6a, $05, $04
	!byte %10000001, $e2, $04, $02
	!byte %00100001, $01, $4a, $02
	!byte %10000001, $2b, $02, $04
	!byte %10000001, $2f, $05, $04
	!byte %10000001, $ca, $04, $02
	!byte %00100001, $01, $4f, $02
	!byte %10000001, $f7, $01, $04
	!byte %10000001, $6a, $05, $04
	!byte %10000001, $e2, $04, $02
	!byte %00100001, $01, $4e, $02
	!byte %10000001, $2b, $02, $04
	!byte %10000001, $2f, $05, $04
	!byte %10000001, $ca, $04, $02
	!byte %00100001, $01, $4f, $02
	!byte %10000001, $f7, $01, $04
	!byte %10000001, $6a, $05, $04
	!byte %10000001, $e2, $04, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $2b, $02, $04
	!byte %10000001, $2f, $05, $04
	!byte %10000001, $ca, $04, $02
	!byte $ff
pattern_2b:
	!byte %10100001, $00, $63, $04, $04
	!byte %10000001, $62, $02, $04
	!byte %10000001, $79, $00, $02
	!byte %01000001, $02
	!byte %00100001, $01, $56, $02
	!byte %10000001, $2b, $02, $04
	!byte %10000001, $2f, $05, $04
	!byte %10000001, $ca, $04, $02
	!byte %00100001, $01, $58, $02
	!byte %10000001, $f7, $01, $04
	!byte %10000001, $6a, $05, $04
	!byte %10000001, $e2, $04, $02
	!byte %00100001, $01, $54, $02
	!byte %10000001, $2b, $02, $04
	!byte %10000001, $2f, $05, $04
	!byte %10000001, $ca, $04, $02
	!byte %00100001, $01, $4f, $02
	!byte %10000001, $f7, $01, $04
	!byte %10100001, $00, $35, $04, $04
	!byte %11000001, $73, $02, $02
	!byte %00100001, $01, $54, $02
	!byte %10000001, $2b, $02, $04
	!byte %10000001, $2f, $05, $04
	!byte %10000001, $ca, $04, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $f7, $01, $04
	!byte %10000001, $6a, $05, $04
	!byte %10000001, $e2, $04, $04
	!byte %10000001, $50, $03, $04
	!byte %10000001, $33, $02, $06
	!byte $ff
pattern_2c:
	!byte %10100001, $00, $16, $02, $04
	!byte %10000001, $22, $01, $04
	!byte %10000001, $39, $00, $02
	!byte %01000001, $02
	!byte %00100001, $01, $4c, $02
	!byte %10000001, $2b, $02, $04
	!byte %10100001, $01, $4c, $7a, $00, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $68, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $4c, $ab, $00, $04
	!byte %10000001, $88, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $48, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $4a, $7a, $00, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $01, $48, $02
	!byte %10000001, $f7, $01, $04
	!byte %10000001, $6a, $05, $04
	!byte %10000001, $e2, $04, $02
	!byte %00100001, $01, $45, $02
	!byte %10000001, $2b, $02, $04
	!byte %10100001, $00, $54, $04, $04
	!byte %10000001, $51, $02, $04
	!byte %10000001, $66, $00, $08
	!byte %01000001, $02
	!byte %00100001, $01, $4c, $02
	!byte %10000001, $2b, $02, $04
	!byte %10100001, $00, $54, $04, $04
	!byte %11000001, $51, $02, $02
	!byte $ff
pattern_2d:
	!byte %10100001, $01, $4f, $61, $00, $04
	!byte %10000001, $a4, $03, $04
	!byte %10000001, $9f, $05, $04
	!byte %10000001, $1d, $04, $04
	!byte %10000001, $b1, $02, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $11, $02, $04
	!byte %10100001, $00, $63, $04, $04
	!byte %10000001, $62, $02, $04
	!byte %10000001, $79, $00, $02
	!byte %01000001, $02
	!byte %00100001, $01, $54, $02
	!byte %10000001, $2b, $02, $04
	!byte %10000001, $2f, $05, $04
	!byte %10000001, $ca, $04, $04
	!byte %10000001, $6a, $03, $0a
	!byte %10100001, $01, $51, $93, $00, $04
	!byte %10000001, $6d, $03, $02
	!byte %00100001, $01, $4f, $02
	!byte %10000001, $11, $02, $04
	!byte %10100001, $01, $4c, $61, $00, $04
	!byte %10000001, $a4, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $78, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $4f, $93, $00, $04
	!byte %10000001, $6d, $03, $04
	!byte %10000001, $88, $05, $04
	!byte $ff
pattern_2e:
	!byte %10100001, $00, $2e, $04, $04
	!byte %10000001, $45, $02, $04
	!byte %10000001, $73, $00, $02
	!byte %01000001, $02
	!byte %00100001, $01, $4c, $02
	!byte %10000001, $2b, $02, $04
	!byte %10100001, $01, $4c, $7a, $00, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $68, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $4c, $ab, $00, $04
	!byte %10000001, $88, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $48, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $4a, $7a, $00, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $01, $48, $02
	!byte %10000001, $f7, $01, $04
	!byte %10000001, $6a, $05, $04
	!byte %10000001, $e2, $04, $02
	!byte %00100001, $01, $45, $02
	!byte %10000001, $2b, $02, $04
	!byte %10100001, $00, $54, $04, $04
	!byte %10000001, $51, $02, $04
	!byte %10000001, $66, $00, $08
	!byte %01000001, $02
	!byte %00100001, $01, $4c, $02
	!byte %10000001, $2b, $02, $04
	!byte %10100001, $00, $54, $04, $04
	!byte %11000001, $51, $02, $02
	!byte $ff
pattern_2f:
	!byte %10100001, $01, $4f, $61, $00, $04
	!byte %10000001, $a4, $03, $04
	!byte %10000001, $9f, $05, $04
	!byte %10000001, $1d, $04, $04
	!byte %10000001, $b1, $02, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $11, $02, $04
	!byte %10100001, $00, $63, $04, $04
	!byte %10000001, $62, $02, $04
	!byte %10000001, $79, $00, $02
	!byte %01000001, $02
	!byte %00100001, $01, $56, $02
	!byte %10000001, $2b, $02, $04
	!byte %10000001, $2f, $05, $04
	!byte %10000001, $ca, $04, $04
	!byte %10000001, $6a, $03, $0a
	!byte %10100001, $01, $58, $93, $00, $04
	!byte %10000001, $6d, $03, $02
	!byte %00100001, $01, $54, $02
	!byte %10000001, $11, $02, $04
	!byte %10100001, $01, $51, $61, $00, $04
	!byte %10000001, $a4, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $78, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $4f, $93, $00, $04
	!byte %10000001, $6d, $03, $04
	!byte %10000001, $88, $05, $04
	!byte $ff
pattern_30:
	!byte %10100001, $00, $2e, $04, $04
	!byte %10000001, $45, $02, $04
	!byte %10000001, $73, $00, $02
	!byte %01000001, $02
	!byte %00100001, $01, $45, $02
	!byte %10000001, $2b, $02, $04
	!byte %10000001, $2f, $05, $03
	!byte %00100000, $00
	!byte %11000001, $6d, $04, $02
	!byte %00100001, $01, $48, $02
	!byte %10000000, $f7, $01
	!byte %00100001, $00, $03
	!byte %10000001, $58, $01, $04
	!byte %10000001, $72, $00, $0c
	!byte %01000001, $02
	!byte %00100000, $01, $48
	!byte %10000001, $29, $01, $02
	!byte %00100001, $00, $02
	!byte %10000001, $97, $01, $04
	!byte %10000001, $b6, $00, $19
	!byte %01000001, $02
	!byte %10100001, $01, $48, $93, $00, $04
	!byte %10000001, $6d, $03, $04
	!byte %10000000, $88, $05
	!byte %00100000, $00
	!byte %01000001, $02
	!byte $ff
pattern_31:
	!byte %10100001, $01, $48, $61, $00, $03
	!byte %00100000, $00
	!byte %10000001, $d4, $01, $04
	!byte %10000001, $f8, $00, $02
	!byte %01000001, $02
	!byte %10100001, $01, $45, $93, $00, $03
	!byte %00100000, $00
	!byte %10000001, $e3, $01, $04
	!byte %10000001, $e7, $00, $04
	!byte %10000001, $00, $00, $2e
	!byte %01000001, $02
	!byte %00100001, $01, $45, $03
	!byte %10000001, $ca, $02, $03
	!byte %00100000, $01, $48
	!byte %10000001, $75, $01, $02
	!byte %00100000, $00
	!byte %01000000
	!byte %10000000, $9f, $01
	!byte %00100001, $01, $45, $03
	!byte %10000001, $00, $03, $04
	!byte %10000001, $e3, $05, $02
	!byte %00100001, $00, $02
	!byte %10000000, $d6, $03
	!byte $ff
pattern_32:
	!byte %10000001, $8a, $03, $04
	!byte %10000001, $04, $01, $06
	!byte %01000001, $02
	!byte %00100000, $01, $45
	!byte %10000001, $5c, $01, $04
	!byte %10000001, $4b, $04, $04
	!byte %10100000, $00, $01, $05
	!byte %01000001, $02
	!byte %00100000, $01, $48
	!byte %10000001, $29, $01, $02
	!byte %00100001, $00, $02
	!byte %10000001, $97, $01, $04
	!byte %10000001, $b6, $00, $0d
	!byte %01000001, $02
	!byte %10100001, $01, $48, $61, $00, $03
	!byte %00100000, $00
	!byte %10000001, $d4, $01, $04
	!byte %10000001, $f8, $00, $04
	!byte %10000001, $00, $00, $16
	!byte %01000001, $02
	!byte %00100001, $01, $48, $03
	!byte %10000001, $00, $03, $04
	!byte %10000001, $e3, $05, $02
	!byte %00100000, $00
	!byte %01000000
	!byte %10000000, $d6, $03
	!byte $ff
pattern_33:
	!byte %10100001, $01, $48, $61, $00, $03
	!byte %00100000, $00
	!byte %10000001, $d4, $01, $04
	!byte %10000001, $f8, $00, $04
	!byte %10000001, $00, $00, $16
	!byte %01000001, $02
	!byte %00100001, $01, $48, $03
	!byte %10000001, $00, $03, $04
	!byte %10000001, $e3, $05, $04
	!byte %10000001, $68, $04, $04
	!byte %10000001, $01, $03, $06
	!byte %00100000, $00
	!byte %10000001, $d7, $01, $04
	!byte %10000001, $dd, $00, $04
	!byte %10000001, $00, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $48, $03
	!byte %10000001, $ca, $02, $03
	!byte %00100000, $00
	!byte %10000001, $ef, $02, $03
	!byte %01000000
	!byte %10000000, $58, $01
	!byte %00100001, $01, $48, $03
	!byte %10000001, $00, $03, $04
	!byte %10000001, $e3, $05, $02
	!byte %00100000, $00
	!byte %01000000
	!byte %10000000, $d6, $03
	!byte $ff
pattern_34:
	!byte %10100001, $01, $45, $61, $00, $03
	!byte %00100000, $00
	!byte %10000001, $d4, $01, $04
	!byte %10000001, $f8, $00, $02
	!byte %01000001, $02
	!byte %10100001, $01, $48, $93, $00, $04
	!byte %10000001, $6d, $03, $04
	!byte %10000000, $88, $05
	!byte %00100001, $00, $03
	!byte %10000001, $8a, $03, $04
	!byte %10000001, $04, $01, $06
	!byte %01000001, $02
	!byte %00100000, $01, $48
	!byte %10000001, $5c, $01, $04
	!byte %10000001, $4b, $04, $04
	!byte %10100001, $00, $01, $05, $04
	!byte %10000001, $ee, $02, $04
	!byte %10000001, $59, $00, $11
	!byte %01000001, $02
	!byte %00100001, $01, $48, $02
	!byte %10000001, $f7, $01, $04
	!byte %10000001, $6a, $05, $03
	!byte %00100000, $00
	!byte %10000001, $92, $04, $04
	!byte %10000001, $26, $02, $04
	!byte %10000001, $00, $00, $04
	!byte %01000001, $02
	!byte $ff
pattern_35:
	!byte %10100001, $01, $48, $61, $00, $03
	!byte %00100000, $00
	!byte %10000001, $d4, $01, $04
	!byte %10000001, $f8, $00, $02
	!byte %01000001, $02
	!byte %10100001, $01, $45, $93, $00, $03
	!byte %00100000, $00
	!byte %10000001, $e3, $01, $04
	!byte %10000001, $e7, $00, $04
	!byte %10000001, $00, $00, $2e
	!byte %01000001, $02
	!byte %00100001, $01, $45, $03
	!byte %10000001, $ca, $02, $03
	!byte %00100000, $01, $48
	!byte %10000001, $75, $01, $02
	!byte %00100000, $00
	!byte %01000000
	!byte %10000000, $9f, $01
	!byte %00100001, $01, $45, $03
	!byte %10000001, $00, $03, $04
	!byte %10000001, $e3, $05, $02
	!byte %00100000, $00
	!byte %01000000
	!byte %10000000, $d6, $03
	!byte $ff
pattern_36:
	!byte %10100001, $01, $48, $61, $00, $03
	!byte %00100000, $00
	!byte %10000001, $d4, $01, $04
	!byte %10000001, $f8, $00, $04
	!byte %10000001, $00, $00, $16
	!byte %01000001, $02
	!byte %00100001, $01, $48, $03
	!byte %10000001, $00, $03, $04
	!byte %10000001, $e3, $05, $04
	!byte %10000001, $68, $04, $04
	!byte %10000001, $01, $03, $06
	!byte %00100000, $00
	!byte %11000001, $d7, $01, $02
	!byte %00100001, $01, $4a, $02
	!byte %10000001, $2b, $02, $04
	!byte %10000001, $2f, $05, $03
	!byte %00100000, $00
	!byte %11000001, $6d, $04, $02
	!byte %00100001, $01, $48, $02
	!byte %10000001, $f7, $01, $04
	!byte %10100001, $01, $4a, $ab, $00, $03
	!byte %00100000, $00
	!byte %11000001, $dc, $01, $02
	!byte %00100001, $01, $48, $02
	!byte %10000001, $2b, $02, $04
	!byte %10000001, $2f, $05, $03
	!byte %00100000, $00
	!byte %11000001, $6d, $04, $02
	!byte $ff
pattern_37:
	!byte %10100001, $01, $4f, $61, $00, $04
	!byte %10000001, $a4, $03, $04
	!byte %10000001, $9f, $05, $04
	!byte %10000001, $1d, $04, $04
	!byte %10000001, $b1, $02, $38
	!byte %00100000, $01, $51
	!byte %10000001, $29, $01, $04
	!byte %10000000, $83, $04
	!byte %00100001, $00, $03
	!byte %10000000, $f7, $02
	!byte %01000001, $02
	!byte %00100000, $01, $4c
	!byte %10000001, $5c, $01, $04
	!byte %10000001, $4b, $04, $04
	!byte %10000001, $2a, $05, $03
	!byte $ff
pattern_38:
	!byte %10100001, $00, $2e, $04, $04
	!byte %10000001, $45, $02, $04
	!byte %10000001, $73, $00, $02
	!byte %01000001, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $2b, $02, $04
	!byte %10100001, $01, $45, $7a, $00, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $01, $48, $02
	!byte %10000001, $f7, $01, $04
	!byte %10100001, $01, $4a, $ab, $00, $04
	!byte %10000001, $88, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $48, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $4a, $7a, $00, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $68, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $4c, $ab, $00, $04
	!byte %10000001, $88, $03, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $2b, $02, $04
	!byte %10100001, $00, $54, $04, $04
	!byte %11000001, $51, $02, $02
	!byte %00100001, $01, $45, $02
	!byte %10000001, $f7, $01, $04
	!byte %10000001, $6a, $05, $04
	!byte %10000001, $e2, $04, $02
	!byte %00100001, $01, $48, $02
	!byte %10000001, $2b, $02, $04
	!byte %10100001, $01, $4a, $7a, $00, $04
	!byte %10000001, $bf, $03, $02
	!byte $ff
pattern_39:
	!byte %10100001, $00, $63, $04, $04
	!byte %10000001, $62, $02, $04
	!byte %10000001, $79, $00, $3e
	!byte %01000001, $02
	!byte %00100001, $01, $4f, $02
	!byte %10000001, $f7, $01, $04
	!byte %10100001, $00, $35, $04, $04
	!byte %11000001, $73, $02, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $2b, $02, $04
	!byte %10000001, $2f, $05, $04
	!byte %10000001, $ca, $04, $02
	!byte $ff
pattern_3a:
	!byte %10100001, $00, $2e, $04, $04
	!byte %10000001, $45, $02, $04
	!byte %10000001, $73, $00, $02
	!byte %01000001, $02
	!byte %00100001, $01, $4f, $02
	!byte %10000000, $2b, $02
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %10100001, $01, $4f, $7a, $00, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $01, $4c, $02
	!byte %10000001, $f7, $01, $04
	!byte %10100001, $01, $4f, $ab, $00, $04
	!byte %10000001, $88, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $48, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $4c, $7a, $00, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $68, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $4f, $ab, $00, $04
	!byte %10000001, $88, $03, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $2b, $02, $04
	!byte %10100001, $00, $54, $04, $04
	!byte %11000001, $51, $02, $02
	!byte %00100001, $01, $4f, $02
	!byte %10000001, $f7, $01, $04
	!byte %10000001, $6a, $05, $03
	!byte %00100000, $00
	!byte %11000001, $92, $04, $02
	!byte %00100001, $01, $4f, $02
	!byte %10000001, $2b, $02, $04
	!byte %10100001, $01, $4c, $7a, $00, $04
	!byte %10000001, $bf, $03, $02
	!byte $ff
pattern_3b:
	!byte %10100001, $01, $39, $61, $00, $04
	!byte %10000001, $a4, $03, $02
	!byte %00100001, $01, $45, $02
	!byte %10000001, $dd, $01, $04
	!byte %10100001, $00, $44, $04, $04
	!byte %11000001, $83, $02, $02
	!byte %00100001, $01, $40, $02
	!byte %10000001, $11, $02, $04
	!byte %10100001, $01, $43, $61, $00, $03
	!byte %00100000, $00
	!byte %11000001, $d4, $01, $02
	!byte %00100001, $01, $43, $02
	!byte %10000001, $dd, $01, $04
	!byte %10100001, $00, $44, $04, $04
	!byte %10000001, $83, $02, $04
	!byte %10000001, $54, $00, $1a
	!byte %01000001, $02
	!byte %00100001, $01, $45, $02
	!byte %10000001, $f7, $01, $04
	!byte %10100001, $01, $43, $ab, $00, $04
	!byte %10000001, $88, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $48, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $40, $7a, $00, $04
	!byte %10000001, $bf, $03, $02
	!byte $ff
pattern_3c:
	!byte %10100001, $00, $63, $04, $04
	!byte %10000001, $62, $02, $04
	!byte %10000001, $79, $00, $02
	!byte %01000001, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $2b, $02, $04
	!byte %10100001, $00, $54, $04, $04
	!byte %11000001, $51, $02, $02
	!byte %00100001, $01, $4f, $02
	!byte %10000001, $f7, $01, $04
	!byte %10100001, $00, $35, $04, $04
	!byte %11000001, $73, $02, $02
	!byte %00100001, $01, $4c, $02
	!byte %10000001, $2b, $02, $04
	!byte %10000001, $2f, $05, $04
	!byte %10000001, $ca, $04, $04
	!byte %10000001, $6a, $03, $16
	!byte %10100001, $01, $4f, $61, $00, $04
	!byte %10000001, $a4, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $78, $03, $04
	!byte %10000001, $61, $01, $0a
	!byte %01000001, $02
	!byte $ff
pattern_3d:
	!byte %10100001, $01, $39, $61, $00, $04
	!byte %10000001, $a4, $03, $02
	!byte %00100001, $01, $45, $02
	!byte %10000001, $dd, $01, $04
	!byte %10100001, $00, $44, $04, $04
	!byte %11000001, $83, $02, $02
	!byte %00100001, $01, $40, $02
	!byte %10000001, $11, $02, $04
	!byte %10100001, $01, $43, $61, $00, $03
	!byte %00100000, $00
	!byte %11000001, $d4, $01, $02
	!byte %00100001, $01, $43, $02
	!byte %10000001, $dd, $01, $04
	!byte %10100001, $00, $44, $04, $04
	!byte %10000001, $83, $02, $04
	!byte %10000001, $54, $00, $1a
	!byte %01000001, $02
	!byte %00100001, $01, $45, $02
	!byte %10000001, $f7, $01, $04
	!byte %10100001, $01, $48, $ab, $00, $04
	!byte %10000001, $88, $03, $02
	!byte %00100001, $01, $45, $02
	!byte %10000001, $2b, $02, $04
	!byte %10100001, $01, $39, $7a, $00, $04
	!byte %10000001, $bf, $03, $02
	!byte $ff
pattern_3e:
	!byte %10100001, $01, $4a, $61, $00, $04
	!byte %10000001, $a4, $03, $04
	!byte %10000001, $9f, $05, $04
	!byte %10000001, $1d, $04, $04
	!byte %10000001, $b1, $02, $02
	!byte %00100001, $01, $48, $02
	!byte %10000001, $11, $02, $04
	!byte %10100001, $00, $63, $04, $04
	!byte %11000001, $62, $02, $02
	!byte %00100001, $01, $45, $02
	!byte %10000001, $dd, $01, $04
	!byte %10000001, $4c, $05, $04
	!byte %10000001, $ee, $04, $04
	!byte %10000001, $5d, $03, $04
	!byte %10100001, $01, $48, $61, $00, $04
	!byte %10000001, $a4, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $78, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $4a, $93, $00, $04
	!byte %10000001, $6d, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $58, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $4a, $61, $00, $04
	!byte %10000001, $a4, $03, $02
	!byte %00100001, $01, $48, $02
	!byte %10000001, $dd, $01, $04
	!byte %10000001, $4c, $05, $04
	!byte %10000001, $ee, $04, $04
	!byte %10000001, $5d, $03, $04
	!byte $ff
pattern_3f:
	!byte %10100001, $00, $63, $04, $04
	!byte %10000001, $62, $02, $04
	!byte %10000001, $79, $00, $02
	!byte %01000001, $02
	!byte %00100001, $01, $4f, $02
	!byte %10000001, $2b, $02, $04
	!byte %10100001, $00, $54, $04, $04
	!byte %11000001, $51, $02, $02
	!byte %00100001, $01, $4c, $02
	!byte %10000001, $f7, $01, $04
	!byte %10100001, $00, $35, $04, $04
	!byte %11000001, $73, $02, $02
	!byte %00100001, $01, $4f, $02
	!byte %10000001, $2b, $02, $04
	!byte %10000001, $2f, $05, $04
	!byte %10000001, $ca, $04, $04
	!byte %10000001, $6a, $03, $16
	!byte %10100001, $01, $4c, $61, $00, $04
	!byte %10000001, $a4, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $78, $03, $04
	!byte %10000001, $61, $01, $0a
	!byte %01000001, $02
	!byte $ff
pattern_40:
	!byte %10100001, $01, $48, $61, $00, $04
	!byte %10000001, $a4, $03, $04
	!byte %10000001, $9f, $05, $04
	!byte %10000001, $1d, $04, $04
	!byte %10000001, $b1, $02, $02
	!byte %00100001, $01, $45, $02
	!byte %10000001, $11, $02, $04
	!byte %10100001, $00, $63, $04, $04
	!byte %11000001, $62, $02, $02
	!byte %00100001, $01, $48, $02
	!byte %10000001, $dd, $01, $04
	!byte %10000001, $4c, $05, $04
	!byte %10000001, $ee, $04, $04
	!byte %10000001, $5d, $03, $04
	!byte %10100001, $01, $4a, $61, $00, $04
	!byte %10000001, $a4, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $78, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $48, $93, $00, $04
	!byte %10000001, $6d, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $58, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $45, $61, $00, $04
	!byte %10000001, $a4, $03, $02
	!byte %00100001, $01, $48, $02
	!byte %10000001, $dd, $01, $04
	!byte %10000001, $4c, $05, $04
	!byte %10000001, $ee, $04, $04
	!byte %10000001, $5d, $03, $04
	!byte $ff
pattern_41:
	!byte %10100001, $01, $4f, $61, $00, $04
	!byte %10000001, $a4, $03, $04
	!byte %10000001, $9f, $05, $04
	!byte %10000001, $1d, $04, $04
	!byte %10000001, $b1, $02, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $11, $02, $04
	!byte %10100001, $00, $63, $04, $04
	!byte %10000001, $62, $02, $04
	!byte %10000001, $79, $00, $0e
	!byte %01000001, $02
	!byte %00100001, $01, $4f, $02
	!byte %10000001, $f7, $01, $04
	!byte %10100001, $01, $51, $ab, $00, $04
	!byte %10000001, $88, $03, $02
	!byte %00100001, $01, $4f, $02
	!byte %10000001, $2b, $02, $04
	!byte %10100001, $01, $51, $7a, $00, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $01, $4f, $02
	!byte %10000001, $f7, $01, $04
	!byte %10100001, $01, $51, $ab, $00, $04
	!byte %10000001, $88, $03, $04
	!byte %10000001, $7c, $05, $04
	!byte %10100001, $00, $1f, $04, $04
	!byte %11000001, $35, $02, $02
	!byte $ff
pattern_42:
	!byte %10100001, $01, $4c, $61, $00, $04
	!byte %10000001, $a4, $03, $02
	!byte %00100001, $01, $45, $02
	!byte %10000001, $dd, $01, $04
	!byte %10100001, $01, $4c, $93, $00, $04
	!byte %10000001, $6d, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $58, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $4a, $61, $00, $04
	!byte %10000001, $a4, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $78, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $48, $93, $00, $04
	!byte %10000001, $6d, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $58, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $4a, $61, $00, $04
	!byte %10000001, $a4, $03, $02
	!byte %00100001, $01, $4c, $02
	!byte %10000001, $dd, $01, $04
	!byte %10100001, $00, $44, $04, $04
	!byte %11000001, $83, $02, $02
	!byte %00100001, $01, $45, $02
	!byte %10000001, $11, $02, $04
	!byte %10100001, $00, $63, $04, $04
	!byte %11000001, $62, $02, $02
	!byte %00100001, $01, $4c, $02
	!byte %10000001, $dd, $01, $04
	!byte %10100001, $00, $44, $04, $04
	!byte %11000001, $83, $02, $02
	!byte %00100001, $01, $4a, $02
	!byte %10000001, $11, $02, $04
	!byte $ff
pattern_43:
	!byte %10100001, $01, $4f, $61, $00, $04
	!byte %10000001, $a4, $03, $04
	!byte %10000001, $9f, $05, $04
	!byte %10000001, $1d, $04, $04
	!byte %10000001, $b1, $02, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $11, $02, $04
	!byte %10100001, $00, $63, $04, $04
	!byte %10000001, $62, $02, $04
	!byte %10000001, $79, $00, $0e
	!byte %01000001, $02
	!byte %00100001, $01, $4c, $02
	!byte %10000001, $f7, $01, $04
	!byte %10100001, $01, $4f, $ab, $00, $04
	!byte %10000001, $88, $03, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $2b, $02, $04
	!byte %10100001, $01, $4c, $7a, $00, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $01, $4f, $02
	!byte %10000001, $f7, $01, $04
	!byte %10100001, $01, $51, $ab, $00, $04
	!byte %10000001, $88, $03, $04
	!byte %10000001, $7c, $05, $04
	!byte %10100001, $00, $1f, $04, $04
	!byte %11000001, $35, $02, $02
	!byte $ff
pattern_44:
	!byte %10100001, $01, $4c, $61, $00, $04
	!byte %10000001, $a4, $03, $04
	!byte %10000001, $9f, $05, $04
	!byte %10000001, $1d, $04, $04
	!byte %10000001, $b1, $02, $02
	!byte %00100001, $01, $45, $02
	!byte %10000001, $11, $02, $04
	!byte %10100001, $00, $63, $04, $04
	!byte %10000001, $62, $02, $04
	!byte %10000001, $79, $00, $02
	!byte %01000001, $02
	!byte %00100001, $01, $4a, $02
	!byte %10000001, $2b, $02, $04
	!byte %10000001, $2f, $05, $04
	!byte %10000001, $ca, $04, $04
	!byte %10000001, $6a, $03, $0a
	!byte %10100001, $01, $48, $93, $00, $04
	!byte %10000001, $6d, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $58, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $43, $61, $00, $04
	!byte %10000001, $a4, $03, $02
	!byte %00100001, $01, $45, $02
	!byte %10000001, $dd, $01, $04
	!byte %10000001, $4c, $05, $04
	!byte %10000001, $ee, $04, $04
	!byte %10000001, $5d, $03, $04
	!byte $ff
pattern_45:
	!byte %10100001, $01, $48, $61, $00, $04
	!byte %10000001, $a4, $03, $04
	!byte %10000001, $9f, $05, $04
	!byte %10000001, $1d, $04, $04
	!byte %10000001, $b1, $02, $02
	!byte %00100001, $01, $4a, $02
	!byte %10000001, $11, $02, $04
	!byte %10100001, $00, $63, $04, $04
	!byte %10000001, $62, $02, $04
	!byte %10000001, $79, $00, $0e
	!byte %01000001, $02
	!byte %00100001, $01, $43, $02
	!byte %10000001, $f7, $01, $04
	!byte %10100001, $01, $45, $ab, $00, $04
	!byte %10000001, $88, $03, $02
	!byte %00100001, $01, $48, $02
	!byte %10000001, $2b, $02, $04
	!byte %10100001, $01, $4a, $7a, $00, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $01, $48, $02
	!byte %10000001, $f7, $01, $04
	!byte %10100001, $01, $4a, $ab, $00, $04
	!byte %10000001, $88, $03, $04
	!byte %10000001, $7c, $05, $04
	!byte %10100001, $00, $1f, $04, $04
	!byte %10000001, $35, $02, $02
	!byte $ff
pattern_46:
	!byte %10000001, $71, $01, $16
	!byte %01000001, $02
	!byte %10100001, $01, $4a, $61, $00, $04
	!byte %10000001, $a4, $03, $02
	!byte %00100001, $01, $48, $02
	!byte %10000001, $dd, $01, $04
	!byte %10100001, $01, $4a, $93, $00, $04
	!byte %10000001, $6d, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $58, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $48, $61, $00, $04
	!byte %10000001, $a4, $03, $02
	!byte %00100001, $01, $4c, $02
	!byte %10000000, $dd, $01
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %10100001, $01, $4c, $93, $00, $04
	!byte %10000001, $6d, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $58, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $4a, $61, $00, $04
	!byte %10000001, $a4, $03, $04
	!byte %10000001, $9f, $05, $04
	!byte %10100001, $01, $48, $93, $00, $04
	!byte %10000001, $6d, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $58, $03, $02
	!byte %01000001, $02
	!byte $ff
pattern_47:
	!byte %10100001, $01, $48, $61, $00, $04
	!byte %10000001, $a4, $03, $04
	!byte %10000001, $9f, $05, $04
	!byte %10000001, $1d, $04, $04
	!byte %10000001, $b1, $02, $02
	!byte %00100001, $01, $4a, $02
	!byte %10000001, $11, $02, $04
	!byte %10100001, $00, $63, $04, $04
	!byte %10000001, $62, $02, $04
	!byte %10000001, $79, $00, $0e
	!byte %01000001, $02
	!byte %00100001, $01, $43, $02
	!byte %10000001, $f7, $01, $04
	!byte %10100001, $01, $45, $ab, $00, $04
	!byte %10000001, $88, $03, $02
	!byte %00100001, $01, $48, $02
	!byte %10000001, $2b, $02, $04
	!byte %10100001, $01, $4a, $7a, $00, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $f7, $01, $04
	!byte %10100001, $01, $4c, $ab, $00, $04
	!byte %10000001, $88, $03, $04
	!byte %10000001, $7c, $05, $04
	!byte %10100001, $00, $1f, $04, $04
	!byte %10000001, $35, $02, $02
	!byte $ff
pattern_48:
	!byte %10000001, $71, $01, $16
	!byte %01000001, $02
	!byte %10100001, $01, $4a, $61, $00, $04
	!byte %10000001, $a4, $03, $02
	!byte %00100001, $01, $48, $02
	!byte %10000001, $dd, $01, $04
	!byte %10100001, $01, $4a, $93, $00, $04
	!byte %10000001, $6d, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $58, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $4c, $61, $00, $04
	!byte %10000001, $a4, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $78, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $45, $93, $00, $04
	!byte %10000001, $6d, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $58, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $43, $61, $00, $04
	!byte %10000001, $a4, $03, $04
	!byte %10000001, $9f, $05, $04
	!byte %10100001, $01, $45, $93, $00, $04
	!byte %10000001, $6d, $03, $04
	!byte %10000001, $88, $05, $04
	!byte $ff
pattern_49:
	!byte %10100001, $01, $43, $61, $00, $04
	!byte %10000001, $a4, $03, $04
	!byte %10000001, $9f, $05, $04
	!byte %10000001, $1d, $04, $04
	!byte %10000001, $b1, $02, $02
	!byte %00100001, $01, $45, $02
	!byte %10000001, $11, $02, $04
	!byte %10100001, $00, $63, $04, $04
	!byte %10000001, $62, $02, $04
	!byte %10000001, $79, $00, $0e
	!byte %01000001, $02
	!byte %00100001, $01, $48, $02
	!byte %10000001, $f7, $01, $04
	!byte %10100001, $01, $4a, $ab, $00, $04
	!byte %10000001, $88, $03, $02
	!byte %00100001, $01, $48, $02
	!byte %10000001, $2b, $02, $04
	!byte %10100001, $01, $4a, $7a, $00, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $01, $43, $02
	!byte %10000001, $f7, $01, $04
	!byte %10100001, $01, $45, $ab, $00, $04
	!byte %10000001, $88, $03, $04
	!byte %10000001, $7c, $05, $04
	!byte %10100001, $00, $1f, $04, $04
	!byte %10000001, $35, $02, $02
	!byte $ff
pattern_4a:
	!byte %10000001, $71, $01, $16
	!byte %01000001, $02
	!byte %10100001, $01, $4a, $61, $00, $04
	!byte %10000001, $a4, $03, $02
	!byte %00100001, $01, $48, $02
	!byte %10000001, $dd, $01, $04
	!byte %10100001, $01, $4a, $93, $00, $04
	!byte %10000001, $6d, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $58, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $48, $61, $00, $04
	!byte %10000001, $a4, $03, $02
	!byte %00100001, $01, $4c, $02
	!byte %10000000, $dd, $01
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %10100001, $01, $4c, $93, $00, $04
	!byte %10000001, $6d, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $58, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $4a, $61, $00, $04
	!byte %10000001, $a4, $03, $04
	!byte %10000001, $9f, $05, $04
	!byte %10100001, $01, $48, $93, $00, $04
	!byte %10000001, $6d, $03, $04
	!byte %10000001, $88, $05, $04
	!byte $ff
pattern_4b:
	!byte %10100001, $01, $43, $61, $00, $04
	!byte %10000001, $a4, $03, $04
	!byte %10000001, $9f, $05, $04
	!byte %10000001, $1d, $04, $04
	!byte %10000001, $b1, $02, $02
	!byte %00100001, $01, $45, $02
	!byte %10000001, $11, $02, $04
	!byte %10100001, $00, $63, $04, $04
	!byte %10000001, $62, $02, $04
	!byte %10000001, $79, $00, $0e
	!byte %01000001, $02
	!byte %00100001, $01, $48, $02
	!byte %10000001, $f7, $01, $04
	!byte %10100001, $01, $4a, $ab, $00, $04
	!byte %10000001, $88, $03, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $2b, $02, $04
	!byte %10100001, $01, $4c, $7a, $00, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $01, $43, $02
	!byte %10000001, $f7, $01, $04
	!byte %10100001, $01, $45, $ab, $00, $04
	!byte %10000001, $88, $03, $04
	!byte %10000001, $7c, $05, $04
	!byte %10100001, $00, $1f, $04, $04
	!byte %10000001, $35, $02, $02
	!byte $ff
pattern_4c:
	!byte %10100001, $01, $45, $61, $00, $04
	!byte %10000001, $a4, $03, $04
	!byte %10000001, $9f, $05, $04
	!byte %10100001, $00, $11, $04, $04
	!byte %10000001, $65, $02, $04
	!byte %10000001, $50, $00, $02
	!byte %01000001, $02
	!byte %00100001, $01, $45, $02
	!byte %10000001, $f7, $01, $04
	!byte %10000001, $6a, $05, $04
	!byte %10000001, $e2, $04, $02
	!byte %00100001, $00, $02
	!byte %10000001, $20, $03, $04
	!byte %10000001, $61, $01, $34
	!byte %01000001, $02
	!byte $ff
pattern_4d:
	!byte %10100001, $01, $45, $61, $00, $04
	!byte %10000001, $a4, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $78, $03, $04
	!byte %10000001, $61, $01, $04
	!byte %01000001, $02
	!byte %10100001, $01, $45, $7a, $00, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $68, $03, $04
	!byte %10000001, $4f, $01, $1c
	!byte %01000001, $02
	!byte %10100001, $01, $45, $93, $00, $04
	!byte %10000001, $6d, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $58, $03, $04
	!byte %10000001, $84, $01, $04
	!byte %01000001, $02
	!byte %10100001, $01, $45, $ab, $00, $04
	!byte %10000001, $88, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $48, $03, $04
	!byte %10000001, $72, $01, $04
	!byte %01000001, $02
	!byte $ff
pattern_4e:
	!byte %10100001, $01, $45, $61, $00, $04
	!byte %10000001, $a4, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $78, $03, $04
	!byte %10000001, $61, $01, $2e
	!byte %01000001, $02
	!byte %10100001, $01, $45, $93, $00, $04
	!byte %10000001, $6d, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $58, $03, $04
	!byte %10000001, $84, $01, $16
	!byte %01000001, $02
	!byte $ff
pattern_4f:
	!byte %10100001, $01, $45, $61, $00, $04
	!byte %10000001, $a4, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $78, $03, $04
	!byte %10000001, $61, $01, $1c
	!byte %01000001, $02
	!byte %10100001, $01, $4a, $7a, $00, $04
	!byte %10000001, $bf, $03, $04
	!byte %10000001, $93, $05, $04
	!byte %10000001, $11, $04, $04
	!byte %10000001, $a3, $02, $02
	!byte %00100001, $01, $45, $02
	!byte %10000001, $2b, $02, $04
	!byte %10100001, $00, $54, $04, $04
	!byte %11000001, $51, $02, $02
	!byte %00100001, $01, $4f, $02
	!byte %10000001, $f7, $01, $04
	!byte %10100001, $00, $35, $04, $04
	!byte %11000001, $73, $02, $02
	!byte %00100001, $01, $4e, $02
	!byte %10000001, $2b, $02, $04
	!byte %10000001, $2f, $05, $04
	!byte %11000001, $ca, $04, $02
	!byte $ff
pattern_50:
	!byte %00010001, $08, $60
	!byte $ff
pattern_51:
	!byte %10100001, $01, $58, $d5, $06, $03
	!byte %00100000, $00
	!byte %10000001, $75, $05, $04
	!byte %10000001, $46, $06, $02
	!byte %01000001, $02
	!byte %10100001, $01, $51, $a6, $06, $04
	!byte %10000001, $f3, $03, $04
	!byte %10000000, $62, $01
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %10100001, $01, $54, $d5, $06, $03
	!byte %00100000, $00
	!byte %10000001, $75, $05, $04
	!byte %10000001, $46, $06, $02
	!byte %01000001, $02
	!byte %10100001, $01, $56, $a6, $06, $04
	!byte %10000001, $f3, $03, $04
	!byte %10000000, $62, $01
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %10100001, $01, $54, $d5, $06, $03
	!byte %00100000, $00
	!byte %10000001, $75, $05, $04
	!byte %10000001, $46, $06, $02
	!byte %01000001, $02
	!byte %10100001, $01, $56, $a6, $06, $04
	!byte %10000001, $f3, $03, $04
	!byte %10000000, $62, $01
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %10100001, $01, $56, $d5, $06, $04
	!byte %10000001, $bf, $03, $04
	!byte %10000000, $57, $01
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %10100001, $01, $54, $a6, $06, $04
	!byte %10000001, $f3, $03, $04
	!byte %10000000, $62, $01
	!byte %00100000, $00
	!byte %01000001, $02
	!byte $ff
pattern_52:
	!byte %10100001, $01, $54, $d5, $06, $03
	!byte %00100000, $00
	!byte %10000001, $75, $05, $04
	!byte %10000001, $46, $06, $02
	!byte %01000001, $02
	!byte %10100001, $01, $51, $a6, $06, $03
	!byte %00100000, $00
	!byte %10000001, $67, $05, $04
	!byte %10000001, $56, $06, $04
	!byte %10000001, $32, $07, $0a
	!byte %01000001, $02
	!byte %00100001, $01, $4f, $03
	!byte %10000001, $5a, $04, $04
	!byte %10000001, $6c, $01, $04
	!byte %10000001, $ea, $01, $04
	!byte %10000001, $90, $02, $04
	!byte %10000001, $57, $03, $04
	!byte %10000001, $0f, $04, $0a
	!byte %00100000, $00
	!byte %01000000
	!byte %10000000, $05, $05
	!byte %00100001, $01, $51, $03
	!byte %10000001, $8d, $04, $03
	!byte %00100000, $01, $54
	!byte %10000001, $cf, $05, $02
	!byte %00100000, $00
	!byte %01000000
	!byte %10000000, $a8, $05
	!byte %00100001, $01, $51, $03
	!byte %10000001, $5a, $04, $04
	!byte %10000001, $6c, $01, $02
	!byte %00100000, $00
	!byte %01000000
	!byte %10000000, $22, $03
	!byte $ff
pattern_53:
	!byte %10100001, $01, $54, $d5, $06, $03
	!byte %00100000, $00
	!byte %10000001, $75, $05, $04
	!byte %10000001, $46, $06, $02
	!byte %01000001, $02
	!byte %10100001, $01, $56, $a6, $06, $03
	!byte %00100000, $00
	!byte %10000001, $67, $05, $04
	!byte %10000001, $56, $06, $04
	!byte %10000001, $32, $07, $0a
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %10000001, $5a, $04, $04
	!byte %10000001, $6c, $01, $04
	!byte %10000001, $ea, $01, $04
	!byte %10000001, $90, $02, $04
	!byte %10000001, $57, $03, $02
	!byte %00100000, $00
	!byte %01000000
	!byte %10000000, $85, $04
	!byte %00100001, $01, $56, $03
	!byte %10000001, $5a, $04, $04
	!byte %10000001, $6c, $01, $02
	!byte %00100000, $00
	!byte %01000000
	!byte %10000000, $22, $03
	!byte %00100001, $01, $54, $03
	!byte %10000001, $8d, $04, $03
	!byte %00100000, $01, $56
	!byte %10000001, $cf, $05, $02
	!byte %00100000, $00
	!byte %01000000
	!byte %10000000, $a8, $05
	!byte %00100001, $01, $54, $03
	!byte %10000001, $5a, $04, $04
	!byte %10000001, $6c, $01, $02
	!byte %00100000, $00
	!byte %01000000
	!byte %10000000, $22, $03
	!byte $ff
pattern_54:
	!byte %10100001, $01, $51, $d5, $06, $03
	!byte %00100000, $00
	!byte %10000001, $75, $05, $04
	!byte %10000001, $46, $06, $02
	!byte %01000001, $02
	!byte %10100001, $01, $54, $a6, $06, $04
	!byte %10000001, $f3, $03, $04
	!byte %10000000, $62, $01
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %10100001, $01, $56, $d5, $06, $03
	!byte %00100000, $00
	!byte %10000001, $75, $05, $04
	!byte %10000001, $46, $06, $02
	!byte %01000001, $02
	!byte %10100001, $01, $54, $a6, $06, $04
	!byte %10000001, $f3, $03, $04
	!byte %10000000, $62, $01
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %10100001, $01, $56, $d5, $06, $03
	!byte %00100000, $00
	!byte %10000001, $75, $05, $04
	!byte %10000001, $46, $06, $02
	!byte %01000001, $02
	!byte %10100001, $01, $56, $a6, $06, $04
	!byte %10000001, $f3, $03, $04
	!byte %10000000, $62, $01
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %10100001, $01, $54, $d5, $06, $04
	!byte %10000001, $bf, $03, $04
	!byte %10000000, $57, $01
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %10100001, $01, $56, $a6, $06, $04
	!byte %10000001, $f3, $03, $04
	!byte %10000000, $62, $01
	!byte %00100000, $00
	!byte %01000001, $02
	!byte $ff
pattern_55:
	!byte %10100001, $01, $51, $d5, $06, $04
	!byte %10000001, $bf, $03, $04
	!byte %10000001, $57, $01, $04
	!byte %10100001, $00, $53, $02, $04
	!byte %10000001, $53, $04, $04
	!byte %10000001, $d1, $06, $02
	!byte %01000001, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $55, $05, $04
	!byte %10000001, $13, $02, $04
	!byte %10000001, $b1, $01, $02
	!byte %00100001, $00, $02
	!byte %10000001, $73, $03, $04
	!byte %10000001, $8b, $05, $04
	!byte %01000001, $02
	!byte %10100001, $01, $5d, $d5, $06, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $e9, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $5b, $a6, $06, $04
	!byte %10000001, $f3, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $07, $04, $02
	!byte %01000001, $02
	!byte %10100001, $01, $5d, $d5, $06, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $e9, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $58, $a6, $06, $04
	!byte %10000001, $f3, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $07, $04, $02
	!byte %01000001, $02
	!byte $ff
pattern_56:
	!byte %10100001, $01, $51, $d5, $06, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $01, $4f, $02
	!byte %10000001, $6d, $05, $04
	!byte %10100001, $00, $28, $03, $04
	!byte %11000001, $d1, $04, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $3c, $05, $04
	!byte %10100001, $00, $0a, $03, $04
	!byte %11000001, $f0, $04, $02
	!byte %00100001, $01, $54, $02
	!byte %10000001, $6d, $05, $04
	!byte %10100001, $00, $28, $03, $04
	!byte %11000001, $d1, $04, $02
	!byte %00100001, $01, $56, $02
	!byte %10000001, $3c, $05, $04
	!byte %10000001, $65, $02, $04
	!byte %10000001, $b6, $01, $04
	!byte %10000001, $5a, $02, $04
	!byte %10100001, $01, $51, $a6, $06, $04
	!byte %10000001, $f3, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $07, $04, $02
	!byte %01000001, $02
	!byte %10100001, $01, $4f, $d5, $06, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $6d, $05, $04
	!byte %10100001, $01, $54, $a6, $06, $04
	!byte %10000001, $f3, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $07, $04, $02
	!byte %01000001, $02
	!byte $ff
pattern_57:
	!byte %10100001, $01, $51, $d5, $06, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $01, $5b, $02
	!byte %10000001, $6d, $05, $04
	!byte %10100001, $00, $28, $03, $04
	!byte %11000001, $d1, $04, $02
	!byte %00100001, $01, $5a, $02
	!byte %10000001, $3c, $05, $04
	!byte %10100001, $00, $0a, $03, $04
	!byte %11000001, $f0, $04, $02
	!byte %00100001, $01, $58, $02
	!byte %10000001, $6d, $05, $04
	!byte %10100001, $00, $28, $03, $04
	!byte %11000001, $d1, $04, $02
	!byte %00100001, $01, $56, $02
	!byte %10000001, $3c, $05, $04
	!byte %10000001, $65, $02, $04
	!byte %10000001, $b6, $01, $04
	!byte %10000001, $5a, $02, $04
	!byte %10100001, $01, $51, $a6, $06, $04
	!byte %10000001, $f3, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $07, $04, $02
	!byte %01000001, $02
	!byte %10100001, $01, $5b, $d5, $06, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $e9, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $5a, $a6, $06, $04
	!byte %10000001, $f3, $03, $04
	!byte %10000001, $62, $01, $04
	!byte $ff
pattern_58:
	!byte %10100001, $01, $51, $d5, $06, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $e9, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $58, $a6, $06, $04
	!byte %10000001, $f3, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $07, $04, $02
	!byte %01000001, $02
	!byte %10100001, $01, $56, $d5, $06, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $e9, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $54, $a6, $06, $04
	!byte %10000001, $f3, $03, $02
	!byte %00100001, $01, $56, $02
	!byte %10000001, $3c, $05, $04
	!byte %10100001, $00, $0a, $03, $04
	!byte %11000001, $f0, $04, $02
	!byte %00100001, $01, $54, $02
	!byte %10000001, $6d, $05, $04
	!byte %10100001, $01, $56, $a6, $06, $04
	!byte %10000001, $f3, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $07, $04, $02
	!byte %01000001, $02
	!byte %10100001, $01, $54, $d5, $06, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $01, $56, $02
	!byte %10000001, $6d, $05, $04
	!byte %10100001, $00, $28, $03, $04
	!byte %11000001, $d1, $04, $02
	!byte %00100001, $01, $54, $02
	!byte %10000001, $3c, $05, $04
	!byte $ff
pattern_59:
	!byte %10100001, $00, $0a, $03, $04
	!byte %10000001, $f0, $04, $04
	!byte %10000001, $bf, $06, $02
	!byte %01000001, $02
	!byte %00100001, $01, $56, $02
	!byte %10000001, $23, $05, $04
	!byte %10000001, $4a, $02, $04
	!byte %10000001, $bc, $01, $02
	!byte %00100001, $01, $54, $02
	!byte %10000001, $55, $05, $04
	!byte %10000001, $13, $02, $04
	!byte %10000001, $b1, $01, $02
	!byte %00100001, $01, $56, $02
	!byte %10000001, $23, $05, $04
	!byte %10000001, $4a, $02, $04
	!byte %10000001, $bc, $01, $02
	!byte %00100001, $01, $5b, $02
	!byte %10000001, $55, $05, $04
	!byte %10000001, $13, $02, $04
	!byte %10000001, $b1, $01, $02
	!byte %00100001, $01, $5a, $02
	!byte %10000001, $23, $05, $04
	!byte %10000001, $4a, $02, $04
	!byte %10000001, $bc, $01, $02
	!byte %00100001, $01, $5b, $02
	!byte %10000001, $55, $05, $04
	!byte %10000001, $13, $02, $04
	!byte %10000001, $b1, $01, $02
	!byte %00100001, $01, $5d, $02
	!byte %10000001, $23, $05, $04
	!byte %10000001, $4a, $02, $04
	!byte %10000001, $bc, $01, $02
	!byte $ff
pattern_5a:
	!byte %10100001, $00, $0a, $03, $04
	!byte %10000001, $f0, $04, $04
	!byte %10000001, $bf, $06, $02
	!byte %01000001, $02
	!byte %00100001, $01, $62, $02
	!byte %10000001, $23, $05, $04
	!byte %10000001, $4a, $02, $04
	!byte %10000001, $bc, $01, $02
	!byte %00100001, $01, $64, $02
	!byte %10000001, $55, $05, $04
	!byte %10000001, $13, $02, $04
	!byte %10000001, $b1, $01, $02
	!byte %00100001, $01, $60, $02
	!byte %10000001, $23, $05, $04
	!byte %10000001, $4a, $02, $04
	!byte %10000001, $bc, $01, $02
	!byte %00100001, $01, $5b, $02
	!byte %10000001, $55, $05, $04
	!byte %10100001, $00, $36, $03, $04
	!byte %11000001, $e0, $04, $02
	!byte %00100001, $01, $60, $02
	!byte %10000001, $23, $05, $04
	!byte %10000001, $4a, $02, $04
	!byte %10000001, $bc, $01, $02
	!byte %00100001, $01, $5d, $02
	!byte %10000001, $55, $05, $04
	!byte %10000001, $13, $02, $04
	!byte %10000001, $b1, $01, $04
	!byte %10000001, $6c, $02, $04
	!byte %10000001, $18, $03, $04
	!byte %10000001, $e7, $03, $02
	!byte $ff
pattern_5b:
	!byte %10100001, $00, $43, $04, $04
	!byte %10000001, $9a, $05, $04
	!byte %10000001, $e1, $06, $02
	!byte %01000001, $02
	!byte %00100001, $01, $58, $02
	!byte %10000001, $23, $05, $04
	!byte %10100001, $01, $58, $be, $06, $04
	!byte %10000001, $a5, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $f8, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $58, $8f, $06, $04
	!byte %10000001, $d9, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $16, $04, $02
	!byte %01000001, $02
	!byte %10100001, $01, $56, $be, $06, $04
	!byte %10000001, $a5, $03, $02
	!byte %00100001, $01, $54, $02
	!byte %10000001, $55, $05, $04
	!byte %10000001, $13, $02, $04
	!byte %10000001, $b1, $01, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $23, $05, $04
	!byte %10100001, $00, $19, $03, $04
	!byte %10000001, $00, $05, $04
	!byte %10000001, $d0, $06, $08
	!byte %01000001, $02
	!byte %00100001, $01, $58, $02
	!byte %10000001, $23, $05, $04
	!byte %10100001, $00, $19, $03, $04
	!byte %11000001, $00, $05, $02
	!byte $ff
pattern_5c:
	!byte %10100001, $01, $5b, $d5, $06, $04
	!byte %10000001, $bf, $03, $04
	!byte %10000001, $57, $01, $04
	!byte %10000001, $0d, $02, $04
	!byte %10000001, $b5, $02, $02
	!byte %00100001, $01, $5d, $02
	!byte %10000001, $3c, $05, $04
	!byte %10100001, $00, $0a, $03, $04
	!byte %10000001, $f0, $04, $04
	!byte %10000001, $bf, $06, $02
	!byte %01000001, $02
	!byte %00100001, $01, $60, $02
	!byte %10000001, $23, $05, $04
	!byte %10000001, $4a, $02, $04
	!byte %10000001, $bc, $01, $04
	!byte %10000001, $60, $02, $04
	!byte %10000001, $25, $03, $04
	!byte %10000001, $da, $03, $02
	!byte %00100001, $01, $5d, $02
	!byte %10000001, $23, $05, $04
	!byte %10100001, $01, $5b, $be, $06, $04
	!byte %10000001, $a5, $03, $02
	!byte %00100001, $01, $58, $02
	!byte %10000001, $55, $05, $04
	!byte %10100001, $00, $36, $03, $04
	!byte %11000001, $e0, $04, $02
	!byte %00100001, $01, $5b, $02
	!byte %10000001, $23, $05, $04
	!byte %10000001, $4a, $02, $04
	!byte %10000001, $bc, $01, $02
	!byte $ff
pattern_5d:
	!byte %10100001, $00, $30, $02, $04
	!byte %10000001, $79, $04, $04
	!byte %10000001, $a8, $06, $02
	!byte %01000001, $02
	!byte %00100001, $01, $58, $02
	!byte %10000001, $23, $05, $04
	!byte %10100001, $01, $58, $be, $06, $04
	!byte %10000001, $a5, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $f8, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $58, $8f, $06, $04
	!byte %10000001, $d9, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $16, $04, $02
	!byte %01000001, $02
	!byte %10100001, $01, $56, $be, $06, $04
	!byte %10000001, $a5, $03, $02
	!byte %00100001, $01, $54, $02
	!byte %10000001, $55, $05, $04
	!byte %10000001, $13, $02, $04
	!byte %10000001, $b1, $01, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $23, $05, $04
	!byte %10100001, $00, $19, $03, $04
	!byte %10000001, $00, $05, $04
	!byte %10000001, $d0, $06, $08
	!byte %01000001, $02
	!byte %00100001, $01, $58, $02
	!byte %10000001, $23, $05, $04
	!byte %10100001, $00, $19, $03, $04
	!byte %11000001, $00, $05, $02
	!byte $ff
pattern_5e:
	!byte %10100001, $01, $5b, $d5, $06, $04
	!byte %10000001, $bf, $03, $04
	!byte %10000001, $57, $01, $04
	!byte %10000001, $0d, $02, $04
	!byte %10000001, $b5, $02, $02
	!byte %00100001, $01, $5d, $02
	!byte %10000001, $3c, $05, $04
	!byte %10100001, $00, $0a, $03, $04
	!byte %10000001, $f0, $04, $04
	!byte %10000001, $bf, $06, $02
	!byte %01000001, $02
	!byte %00100001, $01, $62, $02
	!byte %10000001, $23, $05, $04
	!byte %10000001, $4a, $02, $04
	!byte %10000001, $bc, $01, $04
	!byte %10000001, $60, $02, $04
	!byte %10000001, $25, $03, $04
	!byte %10000001, $da, $03, $02
	!byte %00100001, $01, $64, $02
	!byte %10000001, $23, $05, $04
	!byte %10100001, $01, $60, $be, $06, $04
	!byte %10000001, $a5, $03, $02
	!byte %00100001, $01, $5d, $02
	!byte %10000001, $55, $05, $04
	!byte %10100001, $00, $36, $03, $04
	!byte %11000001, $e0, $04, $02
	!byte %00100001, $01, $5b, $02
	!byte %10000001, $23, $05, $04
	!byte %10000001, $4a, $02, $04
	!byte %10000001, $bc, $01, $02
	!byte $ff
pattern_5f:
	!byte %10100001, $00, $30, $02, $04
	!byte %10000001, $79, $04, $04
	!byte %10000001, $a8, $06, $02
	!byte %01000001, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $23, $05, $04
	!byte %10000001, $4a, $02, $03
	!byte %00100000, $00
	!byte %11000001, $82, $02, $02
	!byte %00100001, $01, $54, $02
	!byte %10000000, $55, $05
	!byte %00100001, $00, $03
	!byte %10000001, $eb, $05, $04
	!byte %10000001, $c5, $06, $0c
	!byte %01000001, $02
	!byte %00100000, $01, $54
	!byte %10000001, $17, $06, $02
	!byte %00100001, $00, $02
	!byte %10000001, $af, $05, $04
	!byte %10000001, $85, $06, $19
	!byte %01000001, $02
	!byte %10100001, $01, $54, $a6, $06, $04
	!byte %10000001, $f3, $03, $04
	!byte %10000000, $62, $01
	!byte %00100000, $00
	!byte %01000001, $02
	!byte $ff
pattern_60:
	!byte %10100001, $01, $54, $d5, $06, $03
	!byte %00100000, $00
	!byte %10000001, $75, $05, $04
	!byte %10000001, $46, $06, $02
	!byte %01000001, $02
	!byte %10100001, $01, $51, $a6, $06, $03
	!byte %00100000, $00
	!byte %10000001, $67, $05, $04
	!byte %10000001, $56, $06, $04
	!byte %10000001, $32, $07, $2e
	!byte %01000001, $02
	!byte %00100001, $01, $51, $03
	!byte %10000001, $8d, $04, $03
	!byte %00100000, $01, $54
	!byte %10000001, $cf, $05, $02
	!byte %00100000, $00
	!byte %01000000
	!byte %10000000, $a8, $05
	!byte %00100001, $01, $51, $03
	!byte %10000001, $5a, $04, $04
	!byte %10000001, $6c, $01, $02
	!byte %00100001, $00, $02
	!byte %10000000, $22, $03
	!byte $ff
pattern_61:
	!byte %10000001, $73, $03, $04
	!byte %10000001, $1f, $06, $06
	!byte %01000001, $02
	!byte %00100000, $01, $51
	!byte %10000001, $e7, $05, $04
	!byte %10000001, $21, $03, $04
	!byte %10100000, $00, $e6, $01
	!byte %01000001, $02
	!byte %00100000, $01, $54
	!byte %10000001, $17, $06, $02
	!byte %00100001, $00, $02
	!byte %10000001, $af, $05, $04
	!byte %10000001, $85, $06, $0d
	!byte %01000001, $02
	!byte %10100001, $01, $54, $d5, $06, $03
	!byte %00100000, $00
	!byte %10000001, $75, $05, $04
	!byte %10000001, $46, $06, $04
	!byte %10000001, $32, $07, $16
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %10000001, $5a, $04, $04
	!byte %10000001, $6c, $01, $02
	!byte %00100000, $00
	!byte %01000000
	!byte %10000000, $22, $03
	!byte $ff
pattern_62:
	!byte %10100001, $01, $54, $d5, $06, $03
	!byte %00100000, $00
	!byte %10000001, $75, $05, $04
	!byte %10000001, $46, $06, $04
	!byte %10000001, $32, $07, $16
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %10000001, $5a, $04, $04
	!byte %10000001, $6c, $01, $04
	!byte %10000001, $ea, $01, $04
	!byte %10000001, $90, $02, $04
	!byte %10000001, $57, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $85, $04, $04
	!byte %10000001, $2f, $06, $07
	!byte %01000001, $02
	!byte %10100001, $01, $54, $d5, $06, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $9f, $04, $02
	!byte %01000001, $02
	!byte %10100001, $01, $54, $a6, $06, $04
	!byte %10000001, $f3, $03, $04
	!byte %10000000, $62, $01
	!byte %00100000, $00
	!byte %01000001, $02
	!byte $ff
pattern_63:
	!byte %10100001, $01, $51, $d5, $06, $03
	!byte %00100000, $00
	!byte %10000001, $75, $05, $04
	!byte %10000001, $46, $06, $02
	!byte %01000001, $02
	!byte %10100001, $01, $54, $a6, $06, $04
	!byte %10000001, $f3, $03, $04
	!byte %10000000, $62, $01
	!byte %00100001, $00, $03
	!byte %10000001, $73, $03, $04
	!byte %10000001, $1f, $06, $06
	!byte %01000001, $02
	!byte %00100000, $01, $54
	!byte %10000001, $e7, $05, $04
	!byte %10000001, $21, $03, $04
	!byte %10100001, $00, $e6, $01, $04
	!byte %10000001, $18, $04, $04
	!byte %10000001, $d3, $06, $11
	!byte %01000001, $02
	!byte %00100001, $01, $54, $02
	!byte %10000001, $55, $05, $04
	!byte %10000001, $13, $02, $03
	!byte %00100000, $00
	!byte %10000001, $5b, $02, $04
	!byte %10000001, $ec, $04, $04
	!byte %10000001, $32, $07, $04
	!byte %01000001, $02
	!byte $ff
pattern_64:
	!byte %10100001, $01, $54, $d5, $06, $03
	!byte %00100000, $00
	!byte %10000001, $75, $05, $04
	!byte %10000001, $46, $06, $02
	!byte %01000001, $02
	!byte %10100001, $01, $51, $a6, $06, $03
	!byte %00100000, $00
	!byte %10000001, $67, $05, $04
	!byte %10000001, $56, $06, $04
	!byte %10000001, $32, $07, $2e
	!byte %01000001, $02
	!byte %00100001, $01, $51, $03
	!byte %10000001, $8d, $04, $03
	!byte %00100000, $01, $54
	!byte %10000001, $cf, $05, $02
	!byte %00100000, $00
	!byte %01000000
	!byte %10000000, $a8, $05
	!byte %00100001, $01, $51, $03
	!byte %10000001, $5a, $04, $04
	!byte %10000001, $6c, $01, $02
	!byte %00100000, $00
	!byte %01000000
	!byte %10000000, $22, $03
	!byte $ff
pattern_65:
	!byte %10100001, $01, $54, $d5, $06, $03
	!byte %00100000, $00
	!byte %10000001, $75, $05, $04
	!byte %10000001, $46, $06, $04
	!byte %10000001, $32, $07, $16
	!byte %01000001, $02
	!byte %00100001, $01, $54, $03
	!byte %10000001, $5a, $04, $04
	!byte %10000001, $6c, $01, $04
	!byte %10000001, $ea, $01, $04
	!byte %10000001, $90, $02, $04
	!byte %10000001, $57, $03, $02
	!byte %00100000, $00
	!byte %01000000
	!byte %10000000, $85, $04
	!byte %00100001, $01, $56, $03
	!byte %10000001, $5a, $04, $04
	!byte %10000001, $6c, $01, $02
	!byte %00100000, $00
	!byte %01000000
	!byte %10000000, $22, $03
	!byte %00100001, $01, $54, $03
	!byte %10000001, $8d, $04, $03
	!byte %00100000, $01, $56
	!byte %10000001, $cf, $05, $02
	!byte %00100000, $00
	!byte %01000000
	!byte %10000000, $a8, $05
	!byte %00100001, $01, $54, $03
	!byte %10000001, $5a, $04, $04
	!byte %10000001, $6c, $01, $02
	!byte %00100000, $00
	!byte %01000000
	!byte %10000000, $22, $03
	!byte $ff
pattern_66:
	!byte %10100001, $01, $5b, $d5, $06, $04
	!byte %10000001, $bf, $03, $04
	!byte %10000001, $57, $01, $04
	!byte %10000001, $0d, $02, $04
	!byte %10000001, $b5, $02, $04
	!byte %10000001, $7e, $03, $34
	!byte %10100001, $01, $5d, $d5, $06, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $e9, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $58, $a6, $06, $04
	!byte %10000001, $f3, $03, $04
	!byte %10000001, $62, $01, $04
	!byte $ff
pattern_67:
	!byte %10100001, $00, $30, $02, $04
	!byte %10000001, $79, $04, $04
	!byte %10000001, $a8, $06, $02
	!byte %01000001, $02
	!byte %00100001, $01, $5d, $02
	!byte %10000001, $23, $05, $04
	!byte %10100001, $01, $51, $be, $06, $04
	!byte %10000001, $a5, $03, $02
	!byte %00100001, $01, $54, $02
	!byte %10000001, $55, $05, $04
	!byte %10100001, $01, $56, $8f, $06, $04
	!byte %10000001, $d9, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $16, $04, $02
	!byte %01000001, $02
	!byte %10100001, $01, $56, $be, $06, $04
	!byte %10000001, $a5, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $f8, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $58, $8f, $06, $04
	!byte %10000001, $d9, $03, $02
	!byte %00100001, $01, $5d, $02
	!byte %10000001, $23, $05, $04
	!byte %10100001, $00, $19, $03, $04
	!byte %11000001, $00, $05, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $55, $05, $04
	!byte %10000001, $13, $02, $04
	!byte %10000001, $b1, $01, $02
	!byte %00100001, $01, $54, $02
	!byte %10000001, $23, $05, $04
	!byte %10100001, $01, $56, $be, $06, $04
	!byte %10000001, $a5, $03, $02
	!byte $ff
pattern_68:
	!byte %10100001, $00, $0a, $03, $04
	!byte %10000001, $f0, $04, $04
	!byte %10000001, $bf, $06, $3e
	!byte %01000001, $02
	!byte %00100001, $01, $5b, $02
	!byte %10000001, $55, $05, $04
	!byte %10100001, $00, $36, $03, $04
	!byte %11000001, $e0, $04, $02
	!byte %00100001, $01, $5d, $02
	!byte %10000001, $23, $05, $04
	!byte %10000001, $4a, $02, $04
	!byte %10000001, $bc, $01, $02
	!byte $ff
pattern_69:
	!byte %10100001, $00, $30, $02, $04
	!byte %10000001, $79, $04, $04
	!byte %10000001, $a8, $06, $02
	!byte %01000001, $02
	!byte %00100001, $01, $5b, $02
	!byte %10000000, $23, $05
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %10100001, $01, $5b, $be, $06, $04
	!byte %10000001, $a5, $03, $02
	!byte %00100001, $01, $58, $02
	!byte %10000001, $55, $05, $04
	!byte %10100001, $01, $5b, $8f, $06, $04
	!byte %10000001, $d9, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $16, $04, $02
	!byte %01000001, $02
	!byte %10100001, $01, $58, $be, $06, $04
	!byte %10000001, $a5, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $f8, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $5b, $8f, $06, $04
	!byte %10000001, $d9, $03, $02
	!byte %00100001, $01, $5d, $02
	!byte %10000001, $23, $05, $04
	!byte %10100001, $00, $19, $03, $04
	!byte %11000001, $00, $05, $02
	!byte %00100001, $01, $5b, $02
	!byte %10000001, $55, $05, $04
	!byte %10000001, $13, $02, $03
	!byte %00100000, $00
	!byte %11000001, $5b, $02, $02
	!byte %00100001, $01, $5b, $02
	!byte %10000001, $23, $05, $04
	!byte %10100001, $01, $58, $be, $06, $04
	!byte %10000001, $a5, $03, $02
	!byte $ff
pattern_6a:
	!byte %10100001, $01, $45, $d5, $06, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $6d, $05, $04
	!byte %10100001, $00, $28, $03, $04
	!byte %11000001, $d1, $04, $02
	!byte %00100001, $01, $4c, $02
	!byte %10000001, $3c, $05, $04
	!byte %10100001, $01, $4f, $d5, $06, $03
	!byte %00100000, $00
	!byte %11000001, $75, $05, $02
	!byte %00100001, $01, $4f, $02
	!byte %10000001, $6d, $05, $04
	!byte %10100001, $00, $28, $03, $04
	!byte %10000001, $d1, $04, $04
	!byte %10000001, $e2, $06, $1a
	!byte %01000001, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $55, $05, $04
	!byte %10100001, $01, $4f, $8f, $06, $04
	!byte %10000001, $d9, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $16, $04, $02
	!byte %01000001, $02
	!byte %10100001, $01, $4c, $be, $06, $04
	!byte %10000001, $a5, $03, $02
	!byte $ff
pattern_6b:
	!byte %10100001, $00, $0a, $03, $04
	!byte %10000001, $f0, $04, $04
	!byte %10000001, $bf, $06, $02
	!byte %01000001, $02
	!byte %00100001, $01, $5d, $02
	!byte %10000001, $23, $05, $04
	!byte %10100001, $00, $19, $03, $04
	!byte %11000001, $00, $05, $02
	!byte %00100001, $01, $5b, $02
	!byte %10000001, $55, $05, $04
	!byte %10100001, $00, $36, $03, $04
	!byte %11000001, $e0, $04, $02
	!byte %00100001, $01, $58, $02
	!byte %10000001, $23, $05, $04
	!byte %10000001, $4a, $02, $04
	!byte %10000001, $bc, $01, $04
	!byte %10000001, $60, $02, $04
	!byte %10000001, $25, $03, $04
	!byte %10000001, $da, $03, $0e
	!byte %00100000, $01, $5b
	!byte %10000001, $17, $06, $04
	!byte %10000000, $ec, $02
	!byte %00100001, $00, $03
	!byte %10000001, $63, $04, $04
	!byte %10000001, $6a, $06, $09
	!byte %01000001, $02
	!byte $ff
pattern_6c:
	!byte %10100001, $01, $45, $d5, $06, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $6d, $05, $04
	!byte %10100001, $00, $28, $03, $04
	!byte %11000001, $d1, $04, $02
	!byte %00100001, $01, $4c, $02
	!byte %10000001, $3c, $05, $04
	!byte %10100001, $01, $4f, $d5, $06, $03
	!byte %00100000, $00
	!byte %11000001, $75, $05, $02
	!byte %00100001, $01, $4f, $02
	!byte %10000001, $6d, $05, $04
	!byte %10100001, $00, $28, $03, $04
	!byte %10000001, $d1, $04, $04
	!byte %10000001, $e2, $06, $1a
	!byte %01000001, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $55, $05, $04
	!byte %10100001, $01, $54, $8f, $06, $04
	!byte %10000001, $d9, $03, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $23, $05, $04
	!byte %10100001, $01, $45, $be, $06, $04
	!byte %10000001, $a5, $03, $02
	!byte $ff
pattern_6d:
	!byte %10100001, $01, $56, $d5, $06, $04
	!byte %10000001, $bf, $03, $04
	!byte %10000001, $57, $01, $04
	!byte %10000001, $0d, $02, $04
	!byte %10000001, $b5, $02, $02
	!byte %00100001, $01, $54, $02
	!byte %10000001, $3c, $05, $04
	!byte %10100001, $00, $0a, $03, $04
	!byte %11000001, $f0, $04, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $6d, $05, $04
	!byte %10000001, $2e, $02, $04
	!byte %10000001, $ab, $01, $04
	!byte %10000001, $66, $02, $04
	!byte %10100001, $01, $54, $d5, $06, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $e9, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $56, $a6, $06, $04
	!byte %10000001, $f3, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $07, $04, $02
	!byte %01000001, $02
	!byte %10100001, $01, $56, $d5, $06, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $01, $54, $02
	!byte %10000001, $6d, $05, $04
	!byte %10000001, $2e, $02, $04
	!byte %10000001, $ab, $01, $04
	!byte %10000001, $66, $02, $04
	!byte $ff
pattern_6e:
	!byte %10100001, $00, $0a, $03, $04
	!byte %10000001, $f0, $04, $04
	!byte %10000001, $bf, $06, $02
	!byte %01000001, $02
	!byte %00100001, $01, $5b, $02
	!byte %10000001, $23, $05, $04
	!byte %10100001, $00, $19, $03, $04
	!byte %11000001, $00, $05, $02
	!byte %00100001, $01, $58, $02
	!byte %10000001, $55, $05, $04
	!byte %10100001, $00, $36, $03, $04
	!byte %11000001, $e0, $04, $02
	!byte %00100001, $01, $5b, $02
	!byte %10000001, $23, $05, $04
	!byte %10000001, $4a, $02, $04
	!byte %10000001, $bc, $01, $04
	!byte %10000001, $60, $02, $04
	!byte %10000001, $25, $03, $04
	!byte %10000001, $da, $03, $0e
	!byte %00100000, $01, $58
	!byte %10000001, $17, $06, $04
	!byte %10000000, $ec, $02
	!byte %00100001, $00, $03
	!byte %10000001, $63, $04, $04
	!byte %10000001, $6a, $06, $09
	!byte %01000001, $02
	!byte $ff
pattern_6f:
	!byte %10100001, $01, $54, $d5, $06, $04
	!byte %10000001, $bf, $03, $04
	!byte %10000001, $57, $01, $04
	!byte %10000001, $0d, $02, $04
	!byte %10000001, $b5, $02, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $3c, $05, $04
	!byte %10100001, $00, $0a, $03, $04
	!byte %11000001, $f0, $04, $02
	!byte %00100001, $01, $54, $02
	!byte %10000001, $6d, $05, $04
	!byte %10000001, $2e, $02, $04
	!byte %10000001, $ab, $01, $04
	!byte %10000001, $66, $02, $04
	!byte %10100001, $01, $56, $d5, $06, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $e9, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $54, $a6, $06, $04
	!byte %10000001, $f3, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $07, $04, $02
	!byte %01000001, $02
	!byte %10100001, $01, $51, $d5, $06, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $01, $54, $02
	!byte %10000001, $6d, $05, $04
	!byte %10000001, $2e, $02, $04
	!byte %10000001, $ab, $01, $04
	!byte %10000001, $66, $02, $04
	!byte $ff
pattern_70:
	!byte %10100001, $01, $5b, $d5, $06, $04
	!byte %10000001, $bf, $03, $04
	!byte %10000001, $57, $01, $04
	!byte %10000001, $0d, $02, $04
	!byte %10000001, $b5, $02, $02
	!byte %00100001, $01, $5d, $02
	!byte %10000001, $3c, $05, $04
	!byte %10100001, $00, $0a, $03, $04
	!byte %10000001, $f0, $04, $04
	!byte %10000001, $bf, $06, $0e
	!byte %01000001, $02
	!byte %00100001, $01, $5b, $02
	!byte %10000001, $55, $05, $04
	!byte %10100001, $01, $5d, $8f, $06, $04
	!byte %10000001, $d9, $03, $02
	!byte %00100001, $01, $5b, $02
	!byte %10000001, $23, $05, $04
	!byte %10100001, $01, $5d, $be, $06, $04
	!byte %10000001, $a5, $03, $02
	!byte %00100001, $01, $5b, $02
	!byte %10000001, $55, $05, $04
	!byte %10100001, $01, $5d, $8f, $06, $04
	!byte %10000001, $d9, $03, $04
	!byte %10000001, $67, $01, $04
	!byte %10100001, $00, $41, $02, $04
	!byte %11000001, $8d, $04, $02
	!byte $ff
pattern_71:
	!byte %10100001, $01, $58, $d5, $06, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $6d, $05, $04
	!byte %10100001, $01, $58, $a6, $06, $04
	!byte %10000001, $f3, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $07, $04, $02
	!byte %01000001, $02
	!byte %10100001, $01, $56, $d5, $06, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $e9, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $54, $a6, $06, $04
	!byte %10000001, $f3, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $07, $04, $02
	!byte %01000001, $02
	!byte %10100001, $01, $56, $d5, $06, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $01, $58, $02
	!byte %10000001, $6d, $05, $04
	!byte %10100001, $00, $28, $03, $04
	!byte %11000001, $d1, $04, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $3c, $05, $04
	!byte %10100001, $00, $0a, $03, $04
	!byte %11000001, $f0, $04, $02
	!byte %00100001, $01, $58, $02
	!byte %10000001, $6d, $05, $04
	!byte %10100001, $00, $28, $03, $04
	!byte %11000001, $d1, $04, $02
	!byte %00100001, $01, $56, $02
	!byte %10000001, $3c, $05, $04
	!byte $ff
pattern_72:
	!byte %10100001, $01, $5b, $d5, $06, $04
	!byte %10000001, $bf, $03, $04
	!byte %10000001, $57, $01, $04
	!byte %10000001, $0d, $02, $04
	!byte %10000001, $b5, $02, $02
	!byte %00100001, $01, $5d, $02
	!byte %10000001, $3c, $05, $04
	!byte %10100001, $00, $0a, $03, $04
	!byte %10000001, $f0, $04, $04
	!byte %10000001, $bf, $06, $0e
	!byte %01000001, $02
	!byte %00100001, $01, $58, $02
	!byte %10000001, $55, $05, $04
	!byte %10100001, $01, $5b, $8f, $06, $04
	!byte %10000001, $d9, $03, $02
	!byte %00100001, $01, $5d, $02
	!byte %10000001, $23, $05, $04
	!byte %10100001, $01, $58, $be, $06, $04
	!byte %10000001, $a5, $03, $02
	!byte %00100001, $01, $5b, $02
	!byte %10000001, $55, $05, $04
	!byte %10100001, $01, $5d, $8f, $06, $04
	!byte %10000001, $d9, $03, $04
	!byte %10000001, $67, $01, $04
	!byte %10100001, $00, $41, $02, $04
	!byte %11000001, $8d, $04, $02
	!byte $ff
pattern_73:
	!byte %10100001, $01, $58, $d5, $06, $04
	!byte %10000001, $bf, $03, $04
	!byte %10000001, $57, $01, $04
	!byte %10000001, $0d, $02, $04
	!byte %10000001, $b5, $02, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $3c, $05, $04
	!byte %10100001, $00, $0a, $03, $04
	!byte %10000001, $f0, $04, $04
	!byte %10000001, $bf, $06, $02
	!byte %01000001, $02
	!byte %00100001, $01, $56, $02
	!byte %10000001, $23, $05, $04
	!byte %10000001, $4a, $02, $04
	!byte %10000001, $bc, $01, $04
	!byte %10000001, $60, $02, $04
	!byte %10000001, $25, $03, $04
	!byte %10000001, $da, $03, $02
	!byte %00100001, $01, $54, $02
	!byte %10000001, $23, $05, $04
	!byte %10100001, $00, $19, $03, $04
	!byte %11000001, $00, $05, $02
	!byte %00100001, $01, $4f, $02
	!byte %10000001, $55, $05, $04
	!byte %10100001, $01, $51, $8f, $06, $04
	!byte %10000001, $d9, $03, $04
	!byte %10000001, $67, $01, $04
	!byte %10000001, $07, $02, $04
	!byte %10000001, $c7, $02, $02
	!byte $ff
pattern_74:
	!byte %10100001, $01, $54, $d5, $06, $04
	!byte %10000001, $bf, $03, $04
	!byte %10000001, $57, $01, $04
	!byte %10000001, $0d, $02, $04
	!byte %10000001, $b5, $02, $02
	!byte %00100001, $01, $56, $02
	!byte %10000001, $3c, $05, $04
	!byte %10100001, $00, $0a, $03, $04
	!byte %10000001, $f0, $04, $04
	!byte %10000001, $bf, $06, $0e
	!byte %01000001, $02
	!byte %00100001, $01, $4f, $02
	!byte %10000001, $55, $05, $04
	!byte %10100001, $01, $51, $8f, $06, $04
	!byte %10000001, $d9, $03, $02
	!byte %00100001, $01, $54, $02
	!byte %10000001, $23, $05, $04
	!byte %10100001, $01, $56, $be, $06, $04
	!byte %10000001, $a5, $03, $02
	!byte %00100001, $01, $54, $02
	!byte %10000001, $55, $05, $04
	!byte %10100001, $01, $56, $8f, $06, $04
	!byte %10000001, $d9, $03, $04
	!byte %10000001, $67, $01, $04
	!byte %10100001, $00, $41, $02, $04
	!byte %10000001, $8d, $04, $02
	!byte $ff
pattern_75:
	!byte %10000001, $77, $05, $16
	!byte %01000001, $02
	!byte %10100001, $01, $56, $d5, $06, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $01, $54, $02
	!byte %10000001, $6d, $05, $04
	!byte %10100001, $01, $56, $a6, $06, $04
	!byte %10000001, $f3, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $07, $04, $02
	!byte %01000001, $02
	!byte %10100001, $01, $54, $d5, $06, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $01, $58, $02
	!byte %10000000, $6d, $05
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %10100001, $01, $58, $a6, $06, $04
	!byte %10000001, $f3, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $07, $04, $02
	!byte %01000001, $02
	!byte %10100001, $01, $56, $d5, $06, $04
	!byte %10000001, $bf, $03, $04
	!byte %10000001, $57, $01, $04
	!byte %10100001, $01, $54, $a6, $06, $04
	!byte %10000001, $f3, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $07, $04, $02
	!byte %01000001, $02
	!byte $ff
pattern_76:
	!byte %10100001, $01, $54, $d5, $06, $04
	!byte %10000001, $bf, $03, $04
	!byte %10000001, $57, $01, $04
	!byte %10000001, $0d, $02, $04
	!byte %10000001, $b5, $02, $02
	!byte %00100001, $01, $56, $02
	!byte %10000001, $3c, $05, $04
	!byte %10100001, $00, $0a, $03, $04
	!byte %10000001, $f0, $04, $04
	!byte %10000001, $bf, $06, $0e
	!byte %01000001, $02
	!byte %00100001, $01, $4f, $02
	!byte %10000001, $55, $05, $04
	!byte %10100001, $01, $51, $8f, $06, $04
	!byte %10000001, $d9, $03, $02
	!byte %00100001, $01, $54, $02
	!byte %10000001, $23, $05, $04
	!byte %10100001, $01, $56, $be, $06, $04
	!byte %10000001, $a5, $03, $02
	!byte %00100001, $01, $5d, $02
	!byte %10000001, $55, $05, $04
	!byte %10100001, $01, $58, $8f, $06, $04
	!byte %10000001, $d9, $03, $04
	!byte %10000001, $67, $01, $04
	!byte %10100001, $00, $41, $02, $04
	!byte %10000001, $8d, $04, $02
	!byte $ff
pattern_77:
	!byte %10000001, $77, $05, $16
	!byte %01000001, $02
	!byte %10100001, $01, $56, $d5, $06, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $01, $54, $02
	!byte %10000001, $6d, $05, $04
	!byte %10100001, $01, $56, $a6, $06, $04
	!byte %10000001, $f3, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $07, $04, $02
	!byte %01000001, $02
	!byte %10100001, $01, $58, $d5, $06, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $e9, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $51, $a6, $06, $04
	!byte %10000001, $f3, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $07, $04, $02
	!byte %01000001, $02
	!byte %10100001, $01, $4f, $d5, $06, $04
	!byte %10000001, $bf, $03, $04
	!byte %10000001, $57, $01, $04
	!byte %10100001, $01, $51, $a6, $06, $04
	!byte %10000001, $f3, $03, $04
	!byte %10000001, $62, $01, $04
	!byte $ff
pattern_78:
	!byte %10100001, $01, $4f, $d5, $06, $04
	!byte %10000001, $bf, $03, $04
	!byte %10000001, $57, $01, $04
	!byte %10000001, $0d, $02, $04
	!byte %10000001, $b5, $02, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $3c, $05, $04
	!byte %10100001, $00, $0a, $03, $04
	!byte %10000001, $f0, $04, $04
	!byte %10000001, $bf, $06, $0e
	!byte %01000001, $02
	!byte %00100001, $01, $54, $02
	!byte %10000001, $55, $05, $04
	!byte %10100001, $01, $56, $8f, $06, $04
	!byte %10000001, $d9, $03, $02
	!byte %00100001, $01, $54, $02
	!byte %10000001, $23, $05, $04
	!byte %10100001, $01, $56, $be, $06, $04
	!byte %10000001, $a5, $03, $02
	!byte %00100001, $01, $4f, $02
	!byte %10000001, $55, $05, $04
	!byte %10100001, $01, $51, $8f, $06, $04
	!byte %10000001, $d9, $03, $04
	!byte %10000001, $67, $01, $04
	!byte %10100001, $00, $41, $02, $04
	!byte %10000001, $8d, $04, $02
	!byte $ff
pattern_79:
	!byte %10000001, $77, $05, $16
	!byte %01000001, $02
	!byte %10100001, $01, $56, $d5, $06, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $01, $54, $02
	!byte %10000001, $6d, $05, $04
	!byte %10100001, $01, $56, $a6, $06, $04
	!byte %10000001, $f3, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $07, $04, $02
	!byte %01000001, $02
	!byte %10100001, $01, $54, $d5, $06, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $01, $58, $02
	!byte %10000000, $6d, $05
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %10100001, $01, $58, $a6, $06, $04
	!byte %10000001, $f3, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $07, $04, $02
	!byte %01000001, $02
	!byte %10100001, $01, $56, $d5, $06, $04
	!byte %10000001, $bf, $03, $04
	!byte %10000001, $57, $01, $04
	!byte %10100001, $01, $54, $a6, $06, $04
	!byte %10000001, $f3, $03, $04
	!byte %10000001, $62, $01, $04
	!byte $ff
pattern_7a:
	!byte %10100001, $01, $4f, $d5, $06, $04
	!byte %10000001, $bf, $03, $04
	!byte %10000001, $57, $01, $04
	!byte %10000001, $0d, $02, $04
	!byte %10000001, $b5, $02, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $3c, $05, $04
	!byte %10100001, $00, $0a, $03, $04
	!byte %10000001, $f0, $04, $04
	!byte %10000001, $bf, $06, $0e
	!byte %01000001, $02
	!byte %00100001, $01, $54, $02
	!byte %10000001, $55, $05, $04
	!byte %10100001, $01, $56, $8f, $06, $04
	!byte %10000001, $d9, $03, $02
	!byte %00100001, $01, $5d, $02
	!byte %10000001, $23, $05, $04
	!byte %10100001, $01, $58, $be, $06, $04
	!byte %10000001, $a5, $03, $02
	!byte %00100001, $01, $4f, $02
	!byte %10000001, $55, $05, $04
	!byte %10100001, $01, $51, $8f, $06, $04
	!byte %10000001, $d9, $03, $04
	!byte %10000001, $67, $01, $04
	!byte %10100001, $00, $41, $02, $04
	!byte %10000001, $8d, $04, $02
	!byte $ff
pattern_7b:
	!byte %10100001, $01, $51, $d5, $06, $04
	!byte %10000001, $bf, $03, $04
	!byte %10000001, $57, $01, $04
	!byte %10100001, $00, $53, $02, $04
	!byte %10000001, $53, $04, $04
	!byte %10000001, $d1, $06, $02
	!byte %01000001, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $55, $05, $04
	!byte %10000001, $13, $02, $04
	!byte %10000001, $b1, $01, $02
	!byte %00100001, $00, $02
	!byte %10000001, $73, $03, $04
	!byte %10000001, $8b, $05, $34
	!byte %01000001, $02
	!byte $ff
pattern_7c:
	!byte %10100001, $01, $51, $d5, $06, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $e9, $03, $04
	!byte %10000001, $e4, $05, $04
	!byte %01000001, $02
	!byte %10100001, $01, $51, $be, $06, $04
	!byte %10000001, $a5, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $f8, $03, $04
	!byte %10000001, $f4, $05, $1c
	!byte %01000001, $02
	!byte %10100001, $01, $51, $a6, $06, $04
	!byte %10000001, $f3, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $07, $04, $04
	!byte %10000001, $c3, $05, $04
	!byte %01000001, $02
	!byte %10100001, $01, $51, $8f, $06, $04
	!byte %10000001, $d9, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $16, $04, $04
	!byte %10000001, $d3, $05, $04
	!byte %01000001, $02
	!byte $ff
pattern_7d:
	!byte %10100001, $01, $51, $d5, $06, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $e9, $03, $04
	!byte %10000001, $e4, $05, $2e
	!byte %01000001, $02
	!byte %10100001, $01, $51, $a6, $06, $04
	!byte %10000001, $f3, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $07, $04, $04
	!byte %10000001, $c3, $05, $16
	!byte %01000001, $02
	!byte $ff
pattern_7e:
	!byte %10100001, $01, $51, $d5, $06, $04
	!byte %10000001, $bf, $03, $02
	!byte %00100001, $00, $02
	!byte %10000001, $e9, $03, $04
	!byte %10000001, $e4, $05, $1c
	!byte %01000001, $02
	!byte %10100001, $01, $56, $be, $06, $04
	!byte %10000001, $a5, $03, $04
	!byte %10000001, $5c, $01, $04
	!byte %10000001, $13, $02, $04
	!byte %10000001, $bb, $02, $02
	!byte %00100001, $01, $51, $02
	!byte %10000001, $23, $05, $04
	!byte %10100001, $00, $19, $03, $04
	!byte %11000001, $00, $05, $02
	!byte %00100001, $01, $5b, $02
	!byte %10000001, $55, $05, $04
	!byte %10100001, $00, $36, $03, $04
	!byte %11000001, $e0, $04, $02
	!byte %00100001, $01, $5a, $02
	!byte %10000001, $23, $05, $04
	!byte %10000001, $4a, $02, $04
	!byte %11000001, $bc, $01, $02
	!byte $ff
pattern_7f:
	!byte %00010001, $03, $60
	!byte $ff
pattern_80:
	!byte %00100001, $01, $3c, $06
	!byte %00100001, $00, $10
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $06
	!byte %00100001, $00, $10
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $06
	!byte %00100001, $00, $28
	!byte %01000001, $02
	!byte $ff
pattern_81:
	!byte %00100001, $01, $3c, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $06
	!byte %00100001, $00, $10
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $06
	!byte %00100001, $00, $34
	!byte %01000001, $02
	!byte $ff
pattern_82:
	!byte %00100001, $01, $3c, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $06
	!byte %00100001, $00, $10
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $06
	!byte %00100001, $00, $10
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte $ff
pattern_83:
	!byte %00100001, $01, $3c, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $06
	!byte %00100001, $00, $10
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $06
	!byte %00100001, $00, $10
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $06
	!byte %00100001, $00, $06
	!byte $ff
pattern_84:
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $09
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $09
	!byte %00100001, $00, $13
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $09
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $09
	!byte %00100001, $00, $0f
	!byte $ff
pattern_85:
	!byte %00000001, $04
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $09
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $09
	!byte %00100001, $00, $13
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $09
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %00100001, $00, $09
	!byte $ff
pattern_86:
	!byte %00000001, $04
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $09
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $09
	!byte %00100001, $00, $13
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $09
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $09
	!byte %00100001, $00, $0f
	!byte $ff
pattern_87:
	!byte %00000001, $04
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $09
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $09
	!byte %00100001, $00, $13
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $09
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %00100001, $00, $07
	!byte %01000001, $02
	!byte $ff
pattern_88:
	!byte %00100001, $00, $52
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %00100001, $00, $09
	!byte $ff
pattern_89:
	!byte %00000001, $52
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %00100001, $00, $03
	!byte $ff
pattern_8a:
	!byte %00000001, $52
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %00100001, $00, $09
	!byte $ff
pattern_8b:
	!byte %00000001, $0a
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $09
	!byte %00100001, $00, $07
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $09
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $09
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $06
	!byte $ff
pattern_8c:
	!byte %00000001, $03
	!byte %00100001, $00, $07
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $09
	!byte %00100001, $00, $07
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $09
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $09
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $06
	!byte $ff
pattern_8d:
	!byte %00000001, $03
	!byte %00100001, $00, $07
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $09
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $09
	!byte %00100001, $00, $07
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $09
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $09
	!byte %00100001, $00, $07
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $09
	!byte %00100001, $00, $0f
	!byte $ff
pattern_8e:
	!byte %00000001, $03
	!byte %00100001, $00, $07
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $09
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $09
	!byte %00100001, $00, $07
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $09
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $09
	!byte %00100001, $00, $07
	!byte %01000001, $02
	!byte %00100001, $01, $3c, $09
	!byte %00100001, $00, $0d
	!byte %01000001, $02
	!byte $ff
pattern_8f:
	!byte %00100001, $00, $5e
	!byte %01000001, $02
	!byte $ff
pattern_90:
	!byte %00001111, $b3, $ff, $2b, $03
	!byte %00000101, $36, $04
	!byte %00000101, $18, $04
	!byte %00000101, $73, $04
	!byte %00000101, $31, $04
	!byte %00000101, $1a, $04
	!byte %00000101, $67, $04
	!byte %00000101, $36, $04
	!byte %00000101, $18, $04
	!byte %00000101, $73, $04
	!byte %00000101, $31, $04
	!byte %00000101, $1a, $04
	!byte %00000101, $67, $04
	!byte %00000101, $36, $04
	!byte %00000101, $18, $04
	!byte %00000101, $73, $04
	!byte %00000101, $31, $04
	!byte %00000101, $1a, $04
	!byte %00000101, $67, $04
	!byte %00000101, $36, $04
	!byte %00000101, $18, $04
	!byte %00000101, $73, $04
	!byte %00000101, $31, $04
	!byte %00000101, $1a, $04
	!byte %00000100, $67
	!byte $ff
pattern_91:
	!byte %00000101, $3d, $04
	!byte %00000101, $42, $04
	!byte %00000101, $23, $04
	!byte %00000101, $64, $04
	!byte %00000101, $48, $04
	!byte %00000101, $20, $04
	!byte %00000101, $3d, $04
	!byte %00000101, $42, $04
	!byte %00000101, $23, $04
	!byte %00000101, $64, $04
	!byte %00000101, $48, $04
	!byte %00000101, $20, $04
	!byte %00000101, $3d, $04
	!byte %00000101, $42, $04
	!byte %00000101, $23, $04
	!byte %00000101, $64, $04
	!byte %00000101, $48, $04
	!byte %00000101, $20, $04
	!byte %00000101, $3d, $04
	!byte %00000101, $42, $04
	!byte %00000101, $23, $04
	!byte %00000101, $64, $04
	!byte %00000101, $48, $04
	!byte %00000101, $20, $04
	!byte $ff
pattern_92:
	!byte %10110001, $06, $01, $2d, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $39, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3c, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $39, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4c, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $45, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $4c, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $48, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4c, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $2d, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $39, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte $ff
pattern_93:
	!byte %10100001, $01, $2b, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $43, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $37, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $43, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3b, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $43, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3e, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $43, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $37, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $4f, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $43, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4f, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $47, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $4f, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $4a, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4f, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte $ff
pattern_94:
	!byte %10100001, $01, $26, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $39, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3c, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3e, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $28, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $37, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3b, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3e, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte $ff
pattern_95:
	!byte %10100001, $01, $27, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $3f, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $37, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $3f, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3a, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $3f, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $33, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4b, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $29, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $39, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3c, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $35, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4d, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte $ff
pattern_96:
	!byte %10100001, $01, $24, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $37, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3c, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $30, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4c, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $43, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $4c, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $48, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4c, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $24, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $37, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte $ff
pattern_97:
	!byte %10100001, $01, $26, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $3c, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $35, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $3c, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $39, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $3c, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $32, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $48, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $2b, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $3c, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $35, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $3c, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $39, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $3c, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $37, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $48, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte $ff
pattern_98:
	!byte %10100001, $01, $24, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $3c, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $34, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $3c, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $37, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $3c, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $30, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $48, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $40, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $48, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $43, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $48, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $24, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $3c, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $34, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $3c, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte $ff
pattern_99:
	!byte %10100001, $01, $2b, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $45, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $32, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $45, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $37, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $45, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3c, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $45, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $41, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $45, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $37, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $51, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3e, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $51, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $43, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $51, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte $ff
pattern_9a:
	!byte %10100001, $01, $24, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $39, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3c, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $30, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4d, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $45, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $4d, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $48, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4d, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $24, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $39, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte $ff
pattern_9b:
	!byte %10100001, $01, $29, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $3c, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $35, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $3c, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $39, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $3c, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $35, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $48, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $41, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $48, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $45, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $48, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $29, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $3c, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $35, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $3c, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte $ff
pattern_9c:
	!byte %10100001, $01, $24, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $37, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3a, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3c, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $24, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $37, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3a, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3c, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte $ff
pattern_9d:
	!byte %10100001, $01, $24, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $37, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3b, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $30, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4c, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $24, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $37, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3c, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $30, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4c, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte $ff
pattern_9e:
	!byte %10100001, $01, $28, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $3e, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $37, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $3e, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3b, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $3e, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $34, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4a, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $43, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $4a, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $47, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4a, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $28, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $3e, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $37, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $3e, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte $ff
pattern_9f:
	!byte %10100001, $01, $29, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $39, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3c, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $35, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4d, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $2b, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $37, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3b, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $37, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4c, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte $ff
pattern_a0:
	!byte %10100001, $01, $26, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $39, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3c, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $32, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4d, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $24, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $37, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3c, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $30, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4c, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte $ff
pattern_a1:
	!byte %10100001, $01, $2d, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $39, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3c, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $39, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4c, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $45, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $4c, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $48, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4c, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $2d, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $39, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte $ff
pattern_a2:
	!byte %10100001, $01, $28, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $43, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3b, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $43, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3e, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $43, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $40, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $43, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $34, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $4f, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $47, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4f, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $27, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $42, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3a, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $42, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte $ff
pattern_a3:
	!byte %10100001, $01, $26, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $3c, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $35, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $3c, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $39, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $3c, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $32, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $48, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $2b, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $43, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $35, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $43, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $39, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $43, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3c, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $43, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte $ff
pattern_a4:
	!byte %10100001, $01, $2d, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $43, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $39, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $43, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3c, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $43, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $40, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $43, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $39, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $4f, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $45, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4f, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $48, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $4f, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $4c, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4f, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte $ff
pattern_a5:
	!byte %10100001, $01, $2b, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $3e, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $37, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $3e, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3c, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $3e, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $37, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4a, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $2b, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $3e, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $37, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $3e, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3b, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $3e, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $37, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4a, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte $ff
pattern_a6:
	!byte %10100001, $01, $29, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $35, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $39, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3c, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $2b, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $3e, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $37, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $3e, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3b, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $3e, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $37, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4a, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte $ff
pattern_a7:
	!byte %10100001, $01, $2c, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $38, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3b, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3e, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $2d, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $39, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3c, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $39, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4c, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte $ff
pattern_a8:
	!byte %10100001, $01, $24, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $37, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3c, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $30, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4c, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $24, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $39, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3c, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $30, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4d, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte $ff
pattern_a9:
	!byte %10100001, $01, $2b, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $39, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3c, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $37, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4d, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $45, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $4d, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $48, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4d, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $2b, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $39, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $41, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte $ff
pattern_aa:
	!byte %10100001, $01, $24, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $37, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3c, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $30, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4c, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $27, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $3f, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $37, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $3f, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3a, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $3f, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $33, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4b, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte $ff
pattern_ab:
	!byte %10100001, $01, $2d, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $37, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $3c, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $39, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4c, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $43, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $4c, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $48, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $4c, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $2d, $56, $01, $02
	!byte %00100001, $00, $02
	!byte %11000001, $c7, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $2d, $03, $02
	!byte %01000001, $02
	!byte %10100001, $01, $37, $06, $02, $02
	!byte %00100001, $00, $02
	!byte %11000001, $f3, $01, $02
	!byte %00100001, $01, $40, $02
	!byte %10100001, $00, $05, $03, $02
	!byte %01000001, $02
	!byte $ff
pattern_ac:
	!byte %00010001, $05, $60
	!byte $ff
pattern_ad:
	!byte %00100001, $01, $0c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $0c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $0c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte $ff
pattern_ae:
	!byte %00100001, $01, $0c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $21, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $0c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $21, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $0c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $21, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte $ff
pattern_af:
	!byte %00100001, $01, $11, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1d, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $21, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $11, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1d, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $21, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $11, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1d, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte $ff
pattern_b0:
	!byte %00100001, $01, $0c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $22, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $0c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $22, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte $ff
pattern_b1:
	!byte %00100001, $01, $0c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $23, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $0c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $0c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $0c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte $ff
pattern_b2:
	!byte %00100001, $01, $10, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $26, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $26, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $23, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $26, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $10, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $26, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $26, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $23, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $26, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $10, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $26, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $26, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte $ff
pattern_b3:
	!byte %00100001, $01, $11, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $21, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $11, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $13, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $23, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $13, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte $ff
pattern_b4:
	!byte %00100001, $01, $0e, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $21, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $0e, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $0c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $0c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte $ff
pattern_b5:
	!byte %00100001, $01, $15, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $21, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $15, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $21, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $15, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $21, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte $ff
pattern_b6:
	!byte %00100001, $01, $13, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $23, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $26, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $13, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $23, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $26, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte $ff
pattern_b7:
	!byte %00100001, $01, $0e, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $21, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $26, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $10, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $23, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $26, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte $ff
pattern_b8:
	!byte %00100001, $01, $0f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $27, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $27, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $22, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $27, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $0f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $27, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $11, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $21, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $11, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte $ff
pattern_b9:
	!byte %00100001, $01, $0c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $0c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $0c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte $ff
pattern_ba:
	!byte %00100001, $01, $0e, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1d, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $21, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $0e, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $13, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1d, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $21, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $13, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte $ff
pattern_bb:
	!byte %00100001, $01, $13, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2d, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1a, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2d, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2d, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2d, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2d, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $13, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2d, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1a, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2d, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2d, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte $ff
pattern_bc:
	!byte %00100001, $01, $10, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $23, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $26, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $10, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $23, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $0f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2a, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $22, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2a, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte $ff
pattern_bd:
	!byte %00100001, $01, $0e, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1d, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $21, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $0e, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $13, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1d, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $21, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte $ff
pattern_be:
	!byte %00100001, $01, $15, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $21, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $15, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $21, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte $ff
pattern_bf:
	!byte %00100001, $01, $13, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $26, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $26, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $26, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $13, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $26, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $13, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $26, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $26, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $23, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $26, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $13, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $26, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte $ff
pattern_c0:
	!byte %00100001, $01, $11, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1d, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $21, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $13, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $26, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $26, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $23, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $26, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $13, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $26, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte $ff
pattern_c1:
	!byte %00100001, $01, $13, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2d, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1a, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2d, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2d, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2d, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2d, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $13, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2d, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1a, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2d, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $2d, $03
	!byte %00100001, $00, $03
	!byte $ff
pattern_c2:
	!byte %00100001, $01, $14, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $20, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $23, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $26, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $15, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $21, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $15, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte $ff
pattern_c3:
	!byte %00100001, $01, $0c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $0c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $0c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $21, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $0c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte $ff
pattern_c4:
	!byte %00100001, $01, $13, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $21, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $13, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $21, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $13, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $21, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $29, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte $ff
pattern_c5:
	!byte %00100001, $01, $0c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $0c, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $0f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $27, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $27, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $22, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $27, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $0f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $27, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte $ff
pattern_c6:
	!byte %00100001, $01, $15, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $15, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $24, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $15, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $1f, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $28, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte $ff
pattern_c7:
	!byte %00001111, $b6, $01, $3b, $60
	!byte $ff
pattern_c8:
	!byte %00000101, $11, $04
	!byte %00000101, $17, $04
	!byte %00000101, $21, $04
	!byte %00000101, $2e, $04
	!byte %00000101, $44, $04
	!byte %00000101, $46, $34
	!byte %00000101, $11, $04
	!byte %00000101, $17, $04
	!byte %00000101, $21, $04
	!byte %00000101, $11, $04
	!byte %00000101, $18, $04
	!byte %00000101, $20, $04
	!byte $ff
pattern_c9:
	!byte %00000101, $2a, $04
	!byte %00000101, $20, $04
	!byte %00000101, $16, $05
	!byte %00000101, $12, $04
	!byte %00000101, $1a, $04
	!byte %00000101, $24, $04
	!byte %00000101, $13, $04
	!byte %00000101, $19, $04
	!byte %00000101, $24, $04
	!byte %00000101, $12, $04
	!byte %00000101, $1a, $04
	!byte %00000101, $24, $04
	!byte %00000101, $13, $04
	!byte %00000101, $19, $04
	!byte %00000101, $17, $05
	!byte %00000101, $13, $0a
	!byte %00000101, $11, $04
	!byte %00000101, $17, $04
	!byte %00000101, $21, $04
	!byte %00000101, $2e, $04
	!byte %00000101, $44, $04
	!byte %00000101, $3a, $04
	!byte $ff
pattern_ca:
	!byte %00000101, $2a, $04
	!byte %00000101, $20, $04
	!byte %00000101, $16, $05
	!byte %00000101, $12, $04
	!byte %00000101, $1a, $04
	!byte %00000101, $24, $04
	!byte %00000101, $13, $04
	!byte %00000101, $19, $04
	!byte %00000101, $24, $04
	!byte %00000101, $12, $04
	!byte %00000101, $1a, $04
	!byte %00000101, $24, $04
	!byte %00000101, $34, $04
	!byte %00000101, $49, $04
	!byte %00000101, $3a, $10
	!byte %00000101, $13, $04
	!byte %00000101, $19, $04
	!byte %00000101, $24, $04
	!byte %00000101, $12, $04
	!byte %00000101, $1a, $04
	!byte %00000101, $24, $03
	!byte $ff
pattern_cb:
	!byte %00000101, $11, $04
	!byte %00000101, $17, $04
	!byte %00000101, $21, $04
	!byte %00000101, $11, $04
	!byte %00000101, $18, $04
	!byte %00000101, $20, $04
	!byte %00000101, $11, $04
	!byte %00000101, $17, $04
	!byte %00000101, $18, $05
	!byte %00000101, $14, $05
	!byte %00000101, $10, $09
	!byte %00000101, $16, $04
	!byte %00000101, $1e, $04
	!byte %00000101, $2c, $04
	!byte %00000101, $3e, $04
	!byte %00000101, $3d, $04
	!byte %00000101, $28, $04
	!byte %00000101, $16, $04
	!byte %00000101, $19, $04
	!byte %00000101, $15, $04
	!byte %00000101, $16, $04
	!byte %00000101, $1f, $04
	!byte %00000100, $2b
	!byte $ff
pattern_cc:
	!byte %00000101, $11, $04
	!byte %00000101, $17, $04
	!byte %00000101, $21, $04
	!byte %00000101, $11, $04
	!byte %00000101, $18, $04
	!byte %00000101, $20, $04
	!byte %00000101, $2f, $04
	!byte %00000101, $43, $04
	!byte %00000101, $43, $10
	!byte %00000101, $2a, $04
	!byte %00000101, $20, $04
	!byte %00000101, $17, $04
	!byte %00000101, $10, $24
	!byte $ff
pattern_cd:
	!byte %00000101, $11, $04
	!byte %00000101, $17, $04
	!byte %00000101, $21, $04
	!byte %00000101, $2e, $04
	!byte %00000101, $44, $04
	!byte %00000101, $46, $28
	!byte %00000101, $11, $04
	!byte %00000101, $18, $04
	!byte %00000101, $20, $04
	!byte %00000101, $11, $04
	!byte %00000101, $17, $04
	!byte %00000101, $21, $04
	!byte %00000101, $11, $04
	!byte %00000101, $18, $04
	!byte %00000101, $20, $04
	!byte $ff
pattern_ce:
	!byte %00000101, $2a, $04
	!byte %00000101, $20, $04
	!byte %00000101, $16, $05
	!byte %00000101, $12, $04
	!byte %00000101, $1a, $05
	!byte %00000101, $16, $05
	!byte %00000101, $12, $16
	!byte %00000101, $13, $04
	!byte %00000101, $19, $04
	!byte %00000101, $16, $04
	!byte %00000101, $12, $04
	!byte %00000101, $1a, $05
	!byte %00000101, $16, $04
	!byte %00000101, $14, $04
	!byte %00000101, $1a, $04
	!byte %00000101, $16, $04
	!byte %00000101, $14, $04
	!byte %00000101, $1c, $04
	!byte %00000101, $27, $02
	!byte $ff
pattern_cf:
	!byte %00000101, $11, $04
	!byte %00000101, $17, $04
	!byte %00000101, $21, $04
	!byte %00000101, $2a, $04
	!byte %00000101, $1f, $04
	!byte %00000101, $17, $04
	!byte %00000101, $11, $04
	!byte %00000101, $17, $04
	!byte %00000101, $21, $04
	!byte %00000101, $11, $04
	!byte %00000101, $18, $04
	!byte %00000101, $20, $04
	!byte %00000101, $11, $04
	!byte %00000101, $17, $04
	!byte %00000101, $21, $04
	!byte %00000101, $11, $04
	!byte %00000101, $18, $04
	!byte %00000101, $20, $04
	!byte %00000101, $2a, $04
	!byte %00000101, $20, $04
	!byte %00000101, $16, $05
	!byte %00000101, $12, $04
	!byte %00000101, $1a, $04
	!byte %00000101, $24, $03
	!byte $ff
pattern_d0:
	!byte %00000101, $2a, $04
	!byte %00000101, $20, $04
	!byte %00000101, $16, $04
	!byte %00000101, $10, $0f
	!byte %00000101, $16, $04
	!byte %00000101, $12, $04
	!byte %00000101, $1a, $04
	!byte %00000101, $16, $04
	!byte %00000101, $1f, $04
	!byte %00000101, $2b, $04
	!byte %00000101, $3f, $04
	!byte %00000101, $4d, $04
	!byte %00000101, $2d, $10
	!byte %00000101, $16, $04
	!byte %00000101, $19, $04
	!byte %00000101, $15, $05
	!byte %00000101, $11, $08
	!byte $ff
pattern_d1:
	!byte %00000001, $24
	!byte %00000101, $11, $04
	!byte %00000101, $18, $04
	!byte %00000101, $20, $04
	!byte %00000101, $11, $04
	!byte %00000101, $17, $04
	!byte %00000101, $21, $04
	!byte %00000101, $11, $04
	!byte %00000101, $18, $04
	!byte %00000101, $20, $04
	!byte %00000101, $2f, $04
	!byte %00000101, $43, $04
	!byte %00000101, $43, $04
	!byte %00000101, $11, $04
	!byte %00000101, $18, $04
	!byte %00000101, $20, $04
	!byte $ff
pattern_d2:
	!byte %00000101, $2a, $04
	!byte %00000101, $20, $04
	!byte %00000101, $16, $04
	!byte %00000101, $10, $0f
	!byte %00000101, $16, $04
	!byte %00000101, $12, $04
	!byte %00000101, $1a, $04
	!byte %00000101, $16, $04
	!byte %00000101, $18, $05
	!byte %00000101, $11, $04
	!byte %00000101, $17, $04
	!byte %00000101, $18, $04
	!byte %00000101, $11, $04
	!byte %00000101, $18, $04
	!byte %00000101, $20, $04
	!byte %00000101, $11, $04
	!byte %00000101, $17, $04
	!byte %00000101, $18, $05
	!byte %00000101, $14, $05
	!byte %00000101, $10, $06
	!byte $ff
pattern_d3:
	!byte %00000101, $11, $04
	!byte %00000101, $17, $04
	!byte %00000101, $21, $04
	!byte %00000101, $11, $04
	!byte %00000101, $18, $04
	!byte %00000101, $20, $04
	!byte %00000101, $11, $04
	!byte %00000101, $17, $04
	!byte %00000101, $21, $04
	!byte %00000101, $11, $04
	!byte %00000101, $18, $04
	!byte %00000101, $20, $04
	!byte %00000101, $2a, $04
	!byte %00000101, $20, $04
	!byte %00000101, $16, $05
	!byte %00000101, $12, $04
	!byte %00000101, $1a, $04
	!byte %00000101, $24, $04
	!byte %00000101, $34, $04
	!byte %00000101, $49, $04
	!byte %00000101, $3a, $04
	!byte %00000101, $12, $04
	!byte %00000101, $1a, $04
	!byte %00000101, $24, $03
	!byte $ff
pattern_d4:
	!byte %00000101, $11, $04
	!byte %00000101, $17, $04
	!byte %00000101, $14, $04
	!byte %00000101, $11, $04
	!byte %00000101, $18, $04
	!byte %00000101, $20, $04
	!byte %00000101, $2f, $04
	!byte %00000101, $43, $04
	!byte %00000101, $43, $10
	!byte %00000101, $2a, $04
	!byte %00000101, $20, $04
	!byte %00000101, $17, $04
	!byte %00000101, $10, $24
	!byte $ff
pattern_d5:
	!byte %00000101, $11, $04
	!byte %00000101, $17, $04
	!byte %00000101, $14, $06
	!byte %00000101, $14, $04
	!byte %00000101, $11, $04
	!byte %00000101, $17, $05
	!byte %00000101, $17, $04
	!byte %00000101, $12, $04
	!byte %00000101, $1a, $04
	!byte %00000101, $16, $04
	!byte %00000101, $13, $04
	!byte %00000101, $1a, $04
	!byte %00000101, $16, $04
	!byte %00000101, $19, $04
	!byte %00000101, $15, $04
	!byte %00000101, $16, $04
	!byte %00000101, $18, $05
	!byte %00000101, $11, $04
	!byte %00000101, $17, $04
	!byte %00000101, $14, $05
	!byte %00000101, $19, $04
	!byte %00000101, $15, $06
	!byte %00000100, $11
	!byte $ff
pattern_d6:
	!byte %00000000
	!byte %00000101, $13, $04
	!byte %00000101, $19, $04
	!byte %00000101, $24, $04
	!byte %00000101, $33, $04
	!byte %00000101, $4b, $04
	!byte %00000101, $3c, $40
	!byte %00000101, $28, $04
	!byte %00000101, $1d, $04
	!byte %00000101, $15, $03
	!byte $ff
pattern_d7:
	!byte %00000000
	!byte %00000101, $13, $04
	!byte %00000101, $19, $04
	!byte %00000101, $24, $04
	!byte %00000101, $33, $04
	!byte %00000101, $4b, $04
	!byte %00000101, $3c, $04
	!byte %00000101, $13, $04
	!byte %00000101, $19, $04
	!byte %00000101, $24, $04
	!byte %00000101, $33, $04
	!byte %00000101, $4b, $04
	!byte %00000101, $3c, $04
	!byte %00000101, $13, $04
	!byte %00000101, $19, $04
	!byte %00000101, $24, $04
	!byte %00000101, $12, $04
	!byte %00000101, $1a, $05
	!byte %00000101, $16, $04
	!byte %00000101, $14, $04
	!byte %00000101, $1c, $04
	!byte %00000101, $28, $04
	!byte %00000101, $14, $04
	!byte %00000101, $1c, $04
	!byte %00000101, $27, $02
	!byte $ff
pattern_d8:
	!byte %00000101, $11, $04
	!byte %00000101, $17, $04
	!byte %00000101, $14, $04
	!byte %00000101, $11, $04
	!byte %00000101, $18, $04
	!byte %00000101, $14, $04
	!byte %00000101, $19, $05
	!byte %00000101, $15, $04
	!byte %00000101, $16, $04
	!byte %00000101, $12, $04
	!byte %00000101, $1a, $04
	!byte %00000101, $15, $04
	!byte %00000101, $13, $04
	!byte %00000101, $19, $04
	!byte %00000101, $17, $04
	!byte %00000101, $12, $04
	!byte %00000101, $1a, $05
	!byte %00000101, $16, $04
	!byte %00000101, $14, $04
	!byte %00000101, $11, $04
	!byte %00000101, $18, $05
	!byte %00000101, $17, $05
	!byte %00000101, $13, $04
	!byte $ff
pattern_d9:
	!byte %00000101, $11, $04
	!byte %00000101, $17, $04
	!byte %00000101, $14, $04
	!byte %00000101, $11, $04
	!byte %00000101, $18, $05
	!byte %00000101, $17, $04
	!byte %00000101, $13, $04
	!byte %00000101, $19, $04
	!byte %00000101, $17, $04
	!byte %00000101, $12, $04
	!byte %00000101, $1a, $05
	!byte %00000101, $16, $04
	!byte %00000101, $14, $04
	!byte %00000101, $1c, $04
	!byte %00000101, $28, $04
	!byte %00000101, $38, $04
	!byte %00000101, $53, $04
	!byte %00000101, $33, $04
	!byte %00000101, $14, $04
	!byte %00000101, $1c, $04
	!byte %00000101, $28, $04
	!byte %00000101, $38, $04
	!byte %00000101, $53, $04
	!byte %00000101, $33, $02
	!byte $ff
pattern_da:
	!byte %00000101, $2a, $04
	!byte %00000101, $20, $04
	!byte %00000101, $14, $04
	!byte %00000101, $11, $04
	!byte %00000101, $18, $05
	!byte %00000101, $17, $04
	!byte %00000101, $13, $04
	!byte %00000101, $19, $04
	!byte %00000101, $17, $04
	!byte %00000101, $12, $04
	!byte %00000101, $1a, $05
	!byte %00000101, $16, $04
	!byte %00000101, $14, $04
	!byte %00000101, $1a, $04
	!byte %00000101, $16, $05
	!byte %00000101, $12, $06
	!byte %00000101, $15, $04
	!byte %00000101, $18, $05
	!byte %00000101, $11, $04
	!byte %00000101, $18, $04
	!byte %00000101, $14, $04
	!byte %00000101, $11, $04
	!byte %00000101, $17, $02
	!byte $ff
pattern_db:
	!byte %00000101, $11, $04
	!byte %00000101, $17, $04
	!byte %00000101, $21, $04
	!byte %00000101, $11, $04
	!byte %00000101, $18, $04
	!byte %00000101, $20, $04
	!byte %00000101, $11, $04
	!byte %00000101, $17, $04
	!byte %00000101, $21, $04
	!byte %00000101, $11, $04
	!byte %00000101, $18, $04
	!byte %00000101, $20, $04
	!byte %00000101, $11, $04
	!byte %00000101, $17, $04
	!byte %00000101, $21, $04
	!byte %00000101, $11, $04
	!byte %00000101, $18, $04
	!byte %00000101, $20, $04
	!byte %00000101, $11, $04
	!byte %00000101, $17, $04
	!byte %00000101, $21, $04
	!byte %00000101, $11, $04
	!byte %00000101, $18, $04
	!byte %00000101, $20, $04
	!byte $ff
pattern_dc:
	!byte %00000101, $11, $04
	!byte %00000101, $17, $04
	!byte %00000101, $18, $04
	!byte %00000101, $11, $04
	!byte %00000101, $18, $05
	!byte %00000101, $17, $04
	!byte %00000101, $13, $04
	!byte %00000101, $19, $04
	!byte %00000101, $17, $04
	!byte %00000101, $12, $04
	!byte %00000101, $1a, $04
	!byte %00000101, $24, $04
	!byte %00000101, $34, $04
	!byte %00000101, $49, $04
	!byte %00000101, $3a, $04
	!byte %00000101, $12, $04
	!byte %00000101, $1a, $04
	!byte %00000101, $24, $04
	!byte %00000101, $34, $04
	!byte %00000101, $49, $04
	!byte %00000101, $3a, $04
	!byte %00000101, $12, $04
	!byte %00000101, $1a, $04
	!byte %00000101, $15, $03
	!byte $ff
pattern_dd:
	!byte %00000101, $19, $05
	!byte %00000101, $15, $04
	!byte %00000101, $16, $04
	!byte %00000101, $12, $04
	!byte %00000101, $1a, $05
	!byte %00000101, $16, $04
	!byte %00000101, $14, $04
	!byte %00000101, $1a, $04
	!byte %00000101, $16, $04
	!byte %00000101, $14, $04
	!byte %00000101, $19, $05
	!byte %00000101, $15, $04
	!byte %00000101, $16, $04
	!byte %00000101, $19, $04
	!byte %00000101, $15, $05
	!byte %00000101, $11, $06
	!byte %00000101, $17, $05
	!byte %00000101, $17, $04
	!byte %00000101, $12, $04
	!byte %00000101, $1a, $04
	!byte %00000101, $16, $04
	!byte %00000101, $13, $04
	!byte %00000100, $1a
	!byte $ff
pattern_de:
	!byte %00010001, $04, $60
	!byte $ff
pattern_df:
	!byte %00100001, $01, $28, $48
	!byte %00100001, $01, $1f, $0c
	!byte %00100001, $01, $21, $0c
	!byte $ff
pattern_e0:
	!byte %00100001, $00, $0a
	!byte %01000001, $02
	!byte %00100001, $01, $24, $0c
	!byte %00100001, $01, $26, $0c
	!byte %00100001, $01, $24, $0c
	!byte %00100001, $01, $28, $06
	!byte %00100001, $00, $10
	!byte %01000001, $02
	!byte %00100001, $01, $26, $12
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte $ff
pattern_e1:
	!byte %00100001, $00, $0a
	!byte %01000001, $02
	!byte %00100001, $01, $26, $0c
	!byte %00100001, $01, $29, $0c
	!byte %00100001, $01, $2d, $24
	!byte %00100001, $01, $2b, $0c
	!byte %00100001, $01, $2d, $0c
	!byte $ff
pattern_e2:
	!byte %00100001, $01, $26, $0c
	!byte %00100001, $01, $24, $0c
	!byte %00100001, $01, $28, $06
	!byte %00100001, $00, $10
	!byte %01000001, $02
	!byte %00100001, $01, $26, $12
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $21, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $21, $0c
	!byte $ff
pattern_e3:
	!byte %00100001, $01, $26, $0c
	!byte %00100001, $01, $29, $24
	!byte %00100001, $00, $2e
	!byte %01000001, $02
	!byte $ff
pattern_e4:
	!byte %00100001, $01, $21, $3c
	!byte %00100001, $01, $2b, $0c
	!byte %00100001, $01, $28, $0c
	!byte %00100001, $01, $26, $0c
	!byte $ff
pattern_e5:
	!byte %00100001, $00, $0a
	!byte %01000001, $02
	!byte %00100001, $01, $26, $06
	!byte %00100001, $00, $1c
	!byte %01000001, $02
	!byte %00100001, $01, $22, $06
	!byte %00100001, $01, $26, $06
	!byte %00100001, $01, $22, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $29, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $24, $0c
	!byte $ff
pattern_e6:
	!byte %00100001, $01, $21, $0c
	!byte %00100001, $00, $0a
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $0c
	!byte %00100001, $01, $28, $0c
	!byte %00100001, $01, $26, $0c
	!byte %00100001, $01, $24, $0c
	!byte %00100001, $00, $0a
	!byte %01000001, $02
	!byte %00100001, $01, $21, $0c
	!byte $ff
pattern_e7:
	!byte %00100001, $00, $16
	!byte %01000001, $02
	!byte %00100001, $01, $28, $06
	!byte %00100001, $01, $24, $06
	!byte %00100001, $01, $29, $24
	!byte %00100001, $01, $26, $06
	!byte %00100001, $00, $12
	!byte $ff
pattern_e8:
	!byte %00000001, $22
	!byte %01000001, $02
	!byte %00100001, $01, $21, $0c
	!byte %00100001, $01, $2b, $0c
	!byte %00100001, $01, $28, $18
	!byte %00100001, $01, $26, $0c
	!byte $ff
pattern_e9:
	!byte %00100001, $00, $16
	!byte %01000001, $02
	!byte %00100001, $01, $26, $06
	!byte %00100001, $01, $22, $06
	!byte %00100001, $01, $26, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $22, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $29, $0c
	!byte %00100001, $01, $24, $06
	!byte %00100001, $00, $10
	!byte %01000001, $02
	!byte $ff
pattern_ea:
	!byte %00100001, $01, $21, $0c
	!byte %00100001, $01, $2b, $0c
	!byte %00100001, $01, $28, $0c
	!byte %00100001, $01, $26, $0c
	!byte %00100001, $00, $0a
	!byte %01000001, $02
	!byte %00100001, $01, $24, $18
	!byte %00100001, $01, $21, $0c
	!byte $ff
pattern_eb:
	!byte %00100001, $01, $28, $06
	!byte %00100001, $01, $24, $06
	!byte %00100001, $01, $29, $24
	!byte %00100001, $00, $2e
	!byte %01000001, $02
	!byte $ff
pattern_ec:
	!byte %00100001, $01, $24, $06
	!byte %00100001, $01, $21, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $21, $06
	!byte %00100001, $01, $28, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $21, $06
	!byte %00100001, $01, $28, $06
	!byte %00100001, $01, $21, $06
	!byte %00100001, $01, $27, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $21, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $28, $06
	!byte %00100001, $01, $21, $06
	!byte %00100001, $00, $0a
	!byte %01000001, $02
	!byte $ff
pattern_ed:
	!byte %00100001, $01, $21, $54
	!byte %00100001, $00, $0a
	!byte %01000001, $02
	!byte $ff
pattern_ee:
	!byte %00100001, $01, $24, $06
	!byte %00100001, $01, $21, $03
	!byte %00100000, $00
	!byte %01000001, $02
	!byte %00100001, $01, $21, $06
	!byte %00100001, $01, $28, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $21, $06
	!byte %00100001, $01, $28, $06
	!byte %00100001, $01, $21, $06
	!byte %00100001, $01, $27, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $21, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $28, $06
	!byte %00100001, $01, $23, $06
	!byte %00100001, $00, $0a
	!byte %01000001, $02
	!byte $ff
pattern_ef:
	!byte %00100001, $01, $22, $18
	!byte %00100001, $01, $24, $18
	!byte %00100001, $01, $26, $0c
	!byte %00100001, $01, $22, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $22, $0c
	!byte %00100001, $01, $24, $0c
	!byte $ff
pattern_f0:
	!byte %00100001, $01, $21, $06
	!byte %00100001, $01, $28, $06
	!byte %00100001, $01, $21, $06
	!byte %00100001, $01, $27, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $21, $06
	!byte %00100001, $01, $28, $06
	!byte %00100001, $01, $21, $06
	!byte %00100001, $01, $28, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $21, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $28, $06
	!byte %00100001, $01, $21, $06
	!byte %00100001, $00, $0a
	!byte %01000001, $02
	!byte $ff
pattern_f1:
	!byte %00100001, $01, $21, $06
	!byte %00100001, $01, $28, $06
	!byte %00100001, $01, $21, $06
	!byte %00100001, $01, $27, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $21, $06
	!byte %00100001, $01, $28, $06
	!byte %00100001, $01, $23, $06
	!byte %00100001, $01, $2b, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $23, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $06
	!byte %00100001, $01, $21, $06
	!byte %00100001, $00, $0a
	!byte %01000001, $02
	!byte $ff
pattern_f2:
	!byte %00100001, $01, $28, $06
	!byte %00100001, $01, $24, $06
	!byte %00100001, $01, $29, $24
	!byte %00100001, $00, $30
	!byte $ff
pattern_f3:
	!byte %00100001, $01, $28, $06
	!byte %00100001, $01, $24, $06
	!byte %00100001, $01, $28, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $24, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $28, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $24, $18
	!byte %00100001, $01, $26, $18
	!byte $ff
pattern_f4:
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $28, $06
	!byte %00100001, $01, $26, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $28, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $28, $06
	!byte %00100001, $00, $0a
	!byte %01000001, $02
	!byte %00100001, $01, $28, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $28, $06
	!byte %00100001, $01, $26, $06
	!byte %00100001, $01, $24, $06
	!byte $ff
pattern_f5:
	!byte %00100001, $01, $26, $0c
	!byte %00100001, $01, $29, $0c
	!byte %00100001, $01, $26, $0c
	!byte %00100001, $01, $2d, $0c
	!byte %00100001, $01, $26, $0c
	!byte %00100001, $01, $29, $0c
	!byte %00100001, $01, $26, $0c
	!byte %00100001, $01, $2d, $0c
	!byte $ff
pattern_f6:
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $26, $06
	!byte %00100001, $01, $29, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $2c, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $2b, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $2c, $06
	!byte %00100001, $00, $0a
	!byte %01000001, $02
	!byte %00100001, $01, $2e, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $26, $06
	!byte %00100001, $01, $29, $06
	!byte %00100001, $01, $2c, $06
	!byte $ff
pattern_f7:
	!byte %00100001, $01, $28, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $24, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $28, $06
	!byte %00100001, $00, $04
	!byte %01000001, $02
	!byte %00100001, $01, $24, $18
	!byte %00100001, $01, $28, $18
	!byte %00100001, $01, $24, $06
	!byte %00100001, $01, $26, $06
	!byte $ff

nt_lookup_lo:
	!byte <notetable_00, <notetable_01, <notetable_02, <notetable_03
	!byte <notetable_04, <notetable_05, <notetable_06, <notetable_07
	!byte <notetable_08
nt_lookup_hi:
	!byte >notetable_00, >notetable_01, >notetable_02, >notetable_03
	!byte >notetable_04, >notetable_05, >notetable_06, >notetable_07
	!byte >notetable_08

pt_lookup_lo:
	!byte <pulsetable_00, <pulsetable_01, <pulsetable_02, <pulsetable_03
	!byte <pulsetable_04, <pulsetable_05, <pulsetable_06, <pulsetable_07
	!byte <pulsetable_08
pt_lookup_hi:
	!byte >pulsetable_00, >pulsetable_01, >pulsetable_02, >pulsetable_03
	!byte >pulsetable_04, >pulsetable_05, >pulsetable_06, >pulsetable_07
	!byte >pulsetable_08

wt_lookup_lo:
	!byte <wavetable_00, <wavetable_01, <wavetable_02, <wavetable_03
	!byte <wavetable_04, <wavetable_05, <wavetable_06, <wavetable_07
	!byte <wavetable_08
wt_lookup_hi:
	!byte >wavetable_00, >wavetable_01, >wavetable_02, >wavetable_03
	!byte >wavetable_04, >wavetable_05, >wavetable_06, >wavetable_07
	!byte >wavetable_08

vt_lookup_lo:
	!byte <vibratotable_00, <vibratotable_01, <vibratotable_02, <vibratotable_03
	!byte <vibratotable_04, <vibratotable_05, <vibratotable_06, <vibratotable_07
	!byte <vibratotable_08
vt_lookup_hi:
	!byte >vibratotable_00, >vibratotable_01, >vibratotable_02, >vibratotable_03
	!byte >vibratotable_04, >vibratotable_05, >vibratotable_06, >vibratotable_07
	!byte >vibratotable_08


program_ad:
	!byte $00,$00,$03,$00,$00,$00,$44,$08,$00

program_sr:
	!byte $f8,$a7,$00,$f8,$f8,$f0,$48,$89,$79

program_default_pw_lo:
	!byte $00,$00,$00,$00,$00,$00,$00,$00,$00

program_default_pw_hi:
	!byte $00,$00,$00,$00,$00,$00,$00,$00,$00

program_vibrato_delay:
	!byte $00,$00,$00,$00,$00,$00,$00,$04,$0f

!ifdef uses_finetune {
program_finetune_lo:
	!byte $00,$00,$00,$00,$00,$00,$00,$00,$00
program_finetune_hi:
	!byte $00,$00,$00,$00,$00,$00,$00,$00,$00
}

wavetable_00:
	!byte $00, $81, $00, $11, $21, $00
notetable_00:
	!byte $01, $f7, $de, $01, $fb, $07, $01, $fc, $06, $01, $fd, $05, $01, $fd, $04, $01, $fe, $03, $01, $fe, $02, $01, $ff, $01, $01, $ff, $00, $01, $00, $00, $01, $ff, $00, $01, $00, $00, $21, $00, $00
pulsetable_00:
	!byte $08, $00, $21, $00
vibratotable_00:
	!byte $00

wavetable_01:
	!byte $00, $41, $00, $81, $00, $41, $00, $80, $21, $00
notetable_01:
	!byte $01, $dd, $01, $01, $ec, $f2, $01, $08, $0f, $01, $27, $32, $21, $00, $00
pulsetable_01:
	!byte $08, $08, $21, $00
vibratotable_01:
	!byte $00

wavetable_02:
	!byte $00, $81, $21, $00
notetable_02:
	!byte $00, $00, $00, $21, $00, $00
pulsetable_02:
	!byte $08, $00, $21, $00
vibratotable_02:
	!byte $00

wavetable_03:
	!byte $00, $81, $00, $15, $00, $15, $00, $13, $00, $f0, $21, $00
notetable_03:
	!byte $01, $2a, $fd, $01, $4f, $29, $01, $45, $1d, $01, $45, $1d, $01, $ba, $02, $21, $00, $00
pulsetable_03:
	!byte $08, $00, $21, $00
vibratotable_03:
	!byte $00

wavetable_04:
	!byte $00, $41, $21, $00
notetable_04:
	!byte $00, $00, $00, $21, $00, $00
pulsetable_04:
	!byte $04, $70, $04, $c0, $05, $10, $05, $60, $05, $b0, $06, $00, $06, $30, $06, $60, $06, $90, $06, $c0, $06, $f0, $07, $20, $07, $50, $07, $80, $07, $b0, $07, $e0, $08, $10, $08, $40, $08, $70, $08, $a0, $08, $d0, $09, $00, $09, $30, $09, $60, $09, $90, $09, $c0, $09, $f0, $0a, $20, $09, $f0, $09, $c0, $09, $90, $09, $60, $09, $30, $09, $00, $08, $d0, $08, $a0, $08, $70, $08, $40, $08, $10, $07, $e0, $07, $b0, $07, $80, $07, $50, $07, $20, $22, $0a
vibratotable_04:
	!byte $00

wavetable_05:
	!byte $00, $11, $21, $00
notetable_05:
	!byte $00, $00, $00, $21, $00, $00
pulsetable_05:
	!byte $08, $00, $21, $00
vibratotable_05:
	!byte $00

wavetable_06:
	!byte $00, $41, $21, $00
notetable_06:
	!byte $00, $00, $00, $21, $00, $00
pulsetable_06:
	!byte $08, $00, $21, $00, $21, $00
vibratotable_06:
	!byte $00

wavetable_07:
	!byte $00, $41, $21, $00
notetable_07:
	!byte $00, $00, $00, $21, $00, $00
pulsetable_07:
	!byte $00, $c0, $00, $e4, $01, $08, $01, $2c, $01, $50, $01, $74, $01, $98, $01, $bc, $01, $e0, $02, $04, $02, $28, $02, $4c, $02, $70, $02, $94, $02, $b8, $02, $dc, $03, $00, $03, $24, $03, $48, $03, $6c, $03, $90, $03, $b4, $03, $d8, $03, $fc, $04, $20, $04, $44, $04, $68, $04, $8c, $04, $b0, $04, $d4, $04, $f8, $05, $1c, $05, $40, $05, $64, $05, $88, $05, $ac, $05, $d0, $05, $f4, $06, $18, $06, $3c, $06, $60, $06, $84, $06, $a8, $06, $cc, $06, $f0, $07, $14, $07, $38, $07, $5c, $07, $80, $07, $a4, $07, $c8, $07, $ec, $08, $10, $08, $34, $08, $58, $08, $7c, $08, $a0, $08, $c4, $08, $e8, $09, $0c, $09, $30, $09, $54, $09, $78, $09, $9c, $09, $c0, $09, $e4, $0a, $08, $0a, $2c, $0a, $50, $0a, $74, $0a, $98, $0a, $bc, $0a, $e0, $0b, $04, $0b, $28, $0b, $4c, $0b, $70, $0b, $94, $0b, $b8, $0b, $dc, $0c, $00, $0c, $24, $0c, $48, $0c, $6c, $0c, $90, $0c, $b4, $0c, $d8, $0c, $fc, $0d, $20, $0d, $44, $0d, $68, $0d, $8c, $0d, $b0, $0d, $d4, $0d, $f8, $0e, $1c, $0e, $40, $0e, $64, $0e, $88, $0e, $ac, $0e, $d0, $0e, $f4, $0f, $18, $0f, $3c, $0f, $18, $0e, $f4, $0e, $d0, $0e, $ac, $0e, $88, $0e, $64, $0e, $40, $0e, $1c, $0d, $f8, $0d, $d4, $0d, $b0, $0d, $8c, $0d, $68, $0d, $44, $0d, $20, $0c, $fc, $0c, $d8, $0c, $b4, $0c, $90, $0c, $6c, $0c, $48, $0c, $24, $0c, $00, $0b, $dc, $0b, $b8, $0b, $94, $0b, $70, $0b, $4c, $0b, $28, $0b, $04, $0a, $e0, $0a, $bc, $0a, $98, $0a, $74, $0a, $50, $0a, $2c, $0a, $08, $09, $e4, $09, $c0, $09, $9c, $09, $78, $09, $54, $09, $30, $09, $0c, $08, $e8, $08, $c4, $08, $a0, $08, $7c, $08, $58, $08, $34, $08, $10, $07, $ec, $07, $c8, $07, $a4, $07, $80, $07, $5c, $07, $38, $07, $14, $06, $f0, $06, $cc, $06, $a8, $06, $84, $06, $60, $06, $3c, $06, $18, $05, $f4, $05, $d0, $05, $ac, $05, $88, $05, $64, $05, $40, $05, $1c, $04, $f8, $04, $d4, $04, $b0, $04, $8c, $04, $68, $04, $44, $04, $20, $03, $fc, $03, $d8, $03, $b4, $03, $90, $03, $6c, $03, $48, $03, $24, $03, $00, $02, $dc, $02, $b8, $02, $94, $02, $70, $02, $4c, $02, $28, $02, $04, $01, $e0, $01, $bc, $01, $98, $01, $74, $01, $50, $01, $2c, $01, $08, $00, $e4, $22, $00
vibratotable_07:
	!byte $07, $00, $00, $32, $00, $3e, $00, $1c, $00, $e5, $ff, $c2, $ff, $cf, $ff

wavetable_08:
	!byte $00, $41, $21, $00
notetable_08:
	!byte $00, $00, $00, $21, $00, $00
pulsetable_08:
	!byte $07, $38, $07, $69, $07, $9a, $07, $cb, $07, $fc, $08, $2d, $08, $5e, $08, $8f, $08, $c0, $08, $f1, $09, $22, $09, $53, $09, $84, $09, $b5, $09, $e6, $0a, $17, $0a, $48, $0a, $79, $0a, $aa, $0a, $db, $0b, $0c, $0b, $3d, $0b, $6e, $0b, $9f, $0b, $d0, $0c, $01, $0c, $32, $0c, $63, $0c, $32, $0c, $01, $0b, $d0, $0b, $9f, $0b, $6e, $0b, $3d, $0b, $0c, $0a, $db, $0a, $aa, $0a, $79, $0a, $48, $0a, $17, $09, $e6, $09, $b5, $09, $84, $09, $53, $09, $22, $08, $f1, $08, $c0, $08, $8f, $08, $5e, $08, $2d, $07, $fc, $07, $cb, $07, $9a, $07, $69, $07, $38, $07, $07, $06, $d6, $06, $a5, $06, $74, $04, $04, $06, $74, $06, $a5, $06, $d6, $07, $07, $22, $00
vibratotable_08:
	!byte $05, $00, $00, $1c, $00, $11, $00, $ef, $ff, $e4, $ff
