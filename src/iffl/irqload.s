	.rtmodel version,"1"
	.rtmodel codeModel,"plain"
	.rtmodel core,"45gs02"
	.rtmodel target,"mega65"
	.extern _Zp

; 0. fastload_request = 1 (fl_new_request)
; 1. fastload_request = 2 (fl_directory_scan)
; 2. fastload_request = 3 (fl_read_file_block)
; 3. jump to 2

; ----------------------------------------------------------------------------------------------------

; D080        IRQ     LED     MOTOR   SWAP    SIDE    DS      DS      DS      
;
; IRQ         The floppy controller has generated an interrupt (read only). Note that interrupts are not currently implemented on the 45GS27
; LED         Drive LED blinks when set
; MOTOR       Activates drive motor and LED (unless LED signal is also set, causing the drive LED to blink)
; SWAP        Swap upper and lower halves of data buffer (i.e. invert bit 8 of the sector buffer)
; DS          Drive select (0 to 7). Internal drive is 0. Second floppy drive on internal cable is 1. Other values reserved for C1565 external drive interface

; ----------------------------------------------------------------------------------------------------

; D081        WRCMD   RDCMD   FREE    STEP    DIR     ALGO    ALT     NOBUF   
;
; WRCMD       Command is a write operation if set
; RDCMD       Command is a read operation if set
; FREE        Command is a free-format (low level) operation
; STEP        Writing 1 causes the head to step in the indicated direction
; DIR         Sets the stepping direction (inward vs
; ALGO        Selects reading and writing algorithm (currently ignored)
; ALT         Selects alternate DPLL read recovery method (not implemented)
; NOBUF       Reset the sector buffer read/write pointers

; ----------------------------------------------------------------------------------------------------

; D082        BUSY    DRQ     EQ      RNF     CRC     LOST    PROT    TK0     
;
; BUSY        F011 FDC busy flag (command is being executed) (read only)
; DRQ         F011 FDC DRQ flag (one or more bytes of data are ready) (read only)
; EQ          F011 FDC CPU and disk pointers to sector buffer are equal, indicating that the sector buffer is either full or empty. (read only)
; RNF         F011 FDC Request Not Found (RNF), i.e., a sector read or write operation did not find the requested sector (read only)
; CRC         F011 FDC CRC check failure flag (read only)
; LOST        F011 LOST flag (data was lost during transfer, i.e., CPU did not read data fast enough) (read only)
; PROT        F011 Disk write protect flag (read only)
; TK0         F011 Head is over track 0 flag (read only)

; ----------------------------------------------------------------------------------------------------

; D083        RDREQ   WTREQ   RUN     WGATE   DISKIN  INDEX   IRQ     DSKCHG  
; 
; RDREQ       F011 Read Request flag, i.e., the requested sector was found during a read operation (read only)
; WTREQ       F011 Write Request flag, i.e., the requested sector was found during a write operation (read only
; RUN         F011 Successive match. A synonym of RDREQ on the 45IO47 (read only)
; WGATE       F011 write gate flag. Indicates that the drive is currently writing to media. Bad things may happen if a write transaction is aborted (read only)
; DISKIN      F011 Disk sense (read only)
; INDEX       F011 Index hole sense (read only)
; IRQ         The floppy controller has generated an interrupt (read only). Note that interrupts are not currently implemented on the 45GS27.
; DSKCHG      G F011 disk change sense (read only)

; ----------------------------------------------------------------------------------------------------

; D084        TRACK
; D085        SECTOR
; D086        SIDE
; D087        DATA
; D088        CLOCK
; D089        STEP
; D08A        PCODE

; ----------------------------------------------------------------------------------------------------

;.feature pc_assignment
;.feature labels_without_colons
;.feature c_comments

; ----------------------------------------------------------------------------------------------------

	.section code,text
	.public fl_init
fl_init:
	lda #0x60										; Start motor
	sta 0xd080

	rts

; ----------------------------------------------------------------------------------------------------

	.section code,text
	.public fl_exit
fl_exit:
	lda #0x00										; Stop motor
	sta 0xd080

	rts

; ----------------------------------------------------------------------------------------------------

	.section code,text
	.public fl_set_filename
fl_set_filename:
	ldx _Zp
	ldy _Zp+1
	stx fl_fnptr+1
	sty fl_fnptr+2

	ldx #0x0f
	lda #0xa0
loop$:	
	sta fastload_filename,x
	dex
	bpl loop$

	ldx #0xff
filenamecopyloop:
	inx
	cpx #0x10
	beq endofname
fl_fnptr:
	lda 0x1000,x
	beq endofname
	sta fastload_filename,x
	bne filenamecopyloop

endofname:
	inx
	stx fastload_filename_len

	rts


; ----------------------------------------------------------------------------------------------------

	.section code,text
	.public fl_waiting
fl_waiting:
	jsr fastload_irq
	lda fastload_request							; Then just wait for the request byte to
	bmi fl_error									; go back to 0x00, or to report an error by having the MSB
	bne fl_waiting									; set. The request value will continually update based on the
	beq fl_waiting_done								; state of the loading.

fl_error:
	lda #0x02
	sta 0xd020
	lda #0x07
	sta 0xd020
	jmp fl_error

fl_waiting_done:
	rts

; ----------------------------------------------------------------------------------------------------

;	.section `0x0xinterruptVector_0xfffe`,text
;	.public fastload_irq_handler
;	.word   fastload_irq_handler
;	.section code,text
;fastload_irq_handler:
;	;php
;	pha
;	;txa
;	;phx
;	;tya
;	;phy
;
;	inc 0xd020
;	inc 0xd021
;
;	lda 0xd012
;	adc #0x20
;	sta 0xd012
;
;	; nop
;
;	;pla
;	;tay
;	;pla
;	;tax
;	pla
;	;plp
;	asl 0xd019
;	rti

; ------------------------------------------------------------------------------------------------------------------------------
; Actual fast-loader code
; ------------------------------------------------------------------------------------------------------------------------------

fastload_filename:
	.space 16 , 0
;.repeat 16
;	.byte 0
;.endrepeat

fastload_filename_len:
	.byte 0

	.public fastload_address
fastload_address:
	.long 0

fastload_iffl_counter:
	.long 0

	.public fastload_request
fastload_request:
	.byte 4											; Start with seeking to track 0

	; 0x00 = fl_idle									; idle
	; 0x01 = fl_new_request							; requested
	; 0x02 = fl_directory_scan						; scan directory
	; 0x03 = fl_read_file_block						; read file block
	; 0x04 = fl_seek_track_0							; seek to track 0
	; 0x05 = fl_reading_sector						; track stepping/sector reading state
	; 0x06 = fl_iffl_read_file_block_init
	; 0x07 = fl_iffl_read_file_block
	; 0x80 = File not found							; file not found

fastload_request_stashed:								; Remember the state that requested a sector read
	.byte 0

	; Variables for the logical track and sector of the next 256 byte block of the file.
	; These have to get translated into the physical track and sector of the drive, which like the 1581,
	; stores two blocks in each physical sector.

fl_current_track:
	.byte 0
fl_file_next_track:
	.byte 0
fl_file_next_sector:
	.byte 0

fl_prev_track:
	.byte 0
fl_prev_sector:
	.byte 0
fl_prev_side:
	.byte 0

	.align 256
	.public fastload_sector_buffer
fastload_sector_buffer:
	.space 512 , 0
;.repeat 512
;	.byte 0
;.endrepeat

	.public fastload_iffl_start_address_and_size
fastload_iffl_start_address_and_size:
fastload_directory_entries:
	.space 256 , 0
;.repeat 256
;	.byte 0
;.endrepeat

fl_iffl_numfiles:
	.byte 0

	.public fl_iffl_currentfile
fl_iffl_currentfile:
	.byte 0

	.public fl_iffl_sizeremaining
fl_iffl_sizeremaining:
	.long 0

fl_iffl_bytecounter:
	.byte 0

fastload_irq:
	lda fastload_request							; are we in idle state?
	bne todo										; nope, go and check if the FDC is busy
	rts												; yep, back out

todo:	
	lda 0xd082										; is the FDC busy?
	bpl fl_fdc_not_busy								; nope, continue with request
	rts												; yep, back out

fl_fdc_not_busy:
	lda fastload_request							; are we in error state?
	bpl fl_not_in_error_state						; nope, continue
	rts												; yep, back out

fl_not_in_error_state:
	cmp #8											; is the request smaller than 8?
	bcc fl_job_ok									; yep, continue
	rts												; nope, something must have gone wrong (0x80 (file not found) is bigger than 8)

fl_job_ok:
	asl a												; shift state left one bit, so that we can use it as a lookup
	tax												; into a jump table. Everything else is handled by the jump table
	jmp (fl_jumptable,x)

fl_jumptable:
	.word fl_idle									; 0
	.word fl_new_request							; 1
	.word fl_directory_scan							; 2
	.word fl_read_file_block						; 3
	.word fl_seek_track_0							; 4
	.word fl_reading_sector							; 5
	.word fl_iffl_read_file_block_init				; 6
	.word fl_iffl_read_file_block					; 7

fl_idle:
	rts

fl_seek_track_0:
	lda 0xd082
	and #0x01										; TK0 - F011 Head is over track 0 flag (read only)
	beq fl_not_on_track_0
	lda #0x00
	sta fastload_request
	sta fl_current_track
	rts

fl_not_on_track_0:
	lda #0x10										; Step back towards track 0
	sta 0xd081
	rts

fl_select_side1:
	lda #0x01
	sta 0xd086										; requested side
	lda #0x60										; Sides are inverted on the 1581
	sta 0xd080										; physical side selected of mechanical drive
	rts

fl_select_side0:
	lda #0x00
	sta 0xd086										; requested side
	lda #0x68										; Sides are inverted on the 1581
	sta 0xd080										; physical side selected of mechanical drive
	rts

fl_new_request:
	lda #2											; Acknowledge fastload request
	sta fastload_request

	lda #40-1										; Request Track 40 Sector 3 to start directory scan
	sta 0xd084										; (remember we have to do silly translation to real sectors)
	lda #(3/2)+1
	sta 0xd085
	jsr fl_select_side0

	jsr fl_read_sector								; Request read
	rts

fl_read_dir_for_ui:

	lda #40-1										; Request Track 40 Sector 3 to start directory scan
	sta 0xd084										; (remember we have to do silly translation to real sectors)
	lda #(3/2)+1
	sta 0xd085
	jsr fl_select_side0

	jsr fl_read_sector								; Request read
	rts
	
; ------------------------------------------------------------------------------------------------------------------------------

fl_directory_scan:

	jsr fl_copy_sector_to_buffer					; Check if our filename we want is in this sector

													; (XXX we scan the last BAM sector as well, to keep the code simple.)
													; filenames are at offset 4 in each 32-byte directory entry, padded at
													; the end with 0xA0
	lda #.byte0 fastload_sector_buffer
	sta fl_buffaddr+1
	lda #.byte1 fastload_sector_buffer
	sta fl_buffaddr+2

fl_check_logical_sector:
	ldx #0x05
fl_filenamecheckloop:
	ldy #0x00

fl_check_loop_inner:

fl_buffaddr:
	lda fastload_sector_buffer+0x100,x

	cmp fastload_filename,y	
	bne fl_filename_differs
	inx
	iny
	cpy #0x10
	bne fl_check_loop_inner

fl_found_file:											; Filename matches

	txa
	sec
	sbc #0x12
	tax
	lda fl_buffaddr+2
	cmp #.byte1 fastload_sector_buffer
	bne fl_file_in_2nd_logical_sector

	lda fastload_sector_buffer,x					; Y=Track, A=Sector
	tay
	lda fastload_sector_buffer+1,x
	jmp fl_got_file_track_and_sector

fl_file_in_2nd_logical_sector:

	lda fastload_sector_buffer+0x100,x				; Y=Track, A=Sector
	tay
	lda fastload_sector_buffer+0x101,x

fl_got_file_track_and_sector:
	sty fl_file_next_track							; Store track and sector of file
	sta fl_file_next_sector

	lda #6											; Advance to next state (6=fl_iffl_read_file_block_init)
	sta fastload_request

	jsr fl_read_next_sector							; Request reading of next track and sector

	rts

fl_filename_differs:
	cpy #0x10										; Skip same number of chars as though we had matched
	beq fl_end_of_name
	inx
	iny
	jmp fl_filename_differs
	.public fl_end_of_name
fl_end_of_name:
	txa												; Advance to next directory entry
	clc
	adc #0x10
	tax
	bcc fl_filenamecheckloop
	inc fl_buffaddr+2
	lda fl_buffaddr+2
	cmp #.byte1 (fastload_sector_buffer+0x100)
	bne fl_checked_both_halves
	jmp fl_check_logical_sector

fl_checked_both_halves:
	inc 0xd085										; No matching name in this 512 byte sector.
	lda 0xd085										; Load the next one, or give up the search
	cmp #11
	bne fl_load_next_dir_sector
													; Ran out of sectors in directory track
													; (XXX only checks side 0, and assumes DD disk)

	lda #0x80 										; Mark load as failed. 0x80 = File not found
	sta fastload_request
	rts

fl_load_next_dir_sector:
	jsr fl_read_sector								; Request read. No need to change state
	rts

; ------------------------------------------------------------------------------------------------------------------------------

fl_read_sector:

	lda fastload_request							; Remember the state that we need to return to
	sta fastload_request_stashed

	lda #5											; and then set ourselves to the track stepping/sector reading state
	sta fastload_request
													; FALLTHROUGH

	; ----------------------------------------------------------------------------------------------------------------------

fl_reading_sector:
	lda 0xd084										; Check if we are already on the correct track/side
	cmp fl_current_track							; and if not, select/step as required
	beq fl_on_correct_track
	bcc fl_step_in

fl_step_out:
	lda #0x18										; We need to step first
	sta 0xd081
	inc fl_current_track
	rts

fl_step_in:
	lda #0x10										; We need to step first
	sta 0xd081
	dec fl_current_track
	rts

fl_on_correct_track:
	lda 0xd084
	cmp fl_prev_track
	bne fl_not_prev_sector
	lda 0xd086
	cmp fl_prev_side
	bne fl_not_prev_sector
	lda 0xd085
	cmp fl_prev_sector
	bne fl_not_prev_sector

	lda fastload_request_stashed					; We are being asked to read the sector we already have in the buffer
	sta fastload_request							; Jump immediately to the correct routine
	jmp fl_fdc_not_busy

fl_not_prev_sector:
	lda #0x40										; ISSUE ACTUAL READ COMMAND
	sta 0xd081

	lda fastload_request_stashed					; Now that we are finally reading the sector,
	sta fastload_request							; restore the stashed state ID

	rts

fl_step_track:
	lda #3											; advance to next state (3=fl_read_file_block)
	sta fastload_request
													; FALL THROUGH

fl_read_next_sector:
	lda fl_file_next_track							; Check if we reached the end of the file first
	bne fl_not_end_of_file
	rts

fl_not_end_of_file:
	jsr fl_logical_to_physical_sector				; Read next sector of file	
	jsr fl_read_sector
	rts

fl_logical_to_physical_sector:
	lda 0xd084										; Remember current loaded sector, so that we can optimise when asked
	sta fl_prev_track								; to read other half of same physical sector
	lda 0xd085
	sta fl_prev_sector
	lda 0xd086
	sta fl_prev_side
													; Convert 1581 sector numbers to physical ones on the disk.
	jsr fl_select_side0								; Side = 0
	lda fl_file_next_track
	dec	a											; Track = Track - 1
	sta 0xd084

	lda fl_file_next_sector							; Sector = 1 + (Sector/2)
	lsr a
	inc a
	cmp #11											; If sector > 10, then sector=sector-10, side=1
	bcs fl_on_second_side							; but sides are inverted
	sta 0xd085

	rts

fl_on_second_side:
	sec
	sbc #10
	sta 0xd085
	jsr fl_select_side1
	rts

; ------------------------------------------------------------------------------------------------------------------------------

fl_iffl_read_file_block_init:

	lda #0x07										; Set state to fl_iffl_read_file_block
	sta fastload_request

	jsr fl_copy_sector_to_buffer					; Get sector from FDC

	lda fl_file_next_sector							; Work out which half we care about
	and #0x01
	bne fl_iffl_init_read_from_second_half			; odd next sector number, so second half

	lda fastload_sector_buffer+2					; read number of file entries in iffl from first sector
	sta fl_iffl_numfiles

	ldx #0x00

	ldy #0x00
loop$:		
	lda fastload_sector_buffer+0x003,x					; get start addresses for files in iffl
	sta fastload_iffl_start_address_and_size+0,x
	lda fastload_sector_buffer+0x004,x
	sta fastload_iffl_start_address_and_size+1,x
	lda fastload_sector_buffer+0x005,x
	sta fastload_iffl_start_address_and_size+2,x
	lda fastload_sector_buffer+0x006,x
	sta fastload_iffl_start_address_and_size+3,x
	lda fastload_sector_buffer+0x007,x					; get sizes for files in iffl
	sta fastload_iffl_start_address_and_size+4,x
	lda fastload_sector_buffer+0x008,x
	sta fastload_iffl_start_address_and_size+5,x
	lda fastload_sector_buffer+0x009,x
	sta fastload_iffl_start_address_and_size+6,x
	lda fastload_sector_buffer+0x00a,x
	sta fastload_iffl_start_address_and_size+7,x
	clc
	txa
	adc #0x08
	tax
	iny
	cpy fl_iffl_numfiles
	bne loop$

	jmp fl_iffl_read_file_block_init_end

fl_iffl_init_read_from_second_half:
	lda fastload_sector_buffer+0x102					; read number of file entries in iffl from second sector
	sta fl_iffl_numfiles

	ldx #0x00

	ldy #0x00
loop$:		
	lda fastload_sector_buffer+0x103,x				; get start addresses for files in iffl
	sta fastload_iffl_start_address_and_size+0,x
	lda fastload_sector_buffer+0x104,x
	sta fastload_iffl_start_address_and_size+1,x
	lda fastload_sector_buffer+0x105,x
	sta fastload_iffl_start_address_and_size+2,x
	lda fastload_sector_buffer+0x106,x
	sta fastload_iffl_start_address_and_size+3,x
	lda fastload_sector_buffer+0x107,x				; get sizes for files in iffl
	sta fastload_iffl_start_address_and_size+4,x
	lda fastload_sector_buffer+0x108,x
	sta fastload_iffl_start_address_and_size+5,x
	lda fastload_sector_buffer+0x109,x
	sta fastload_iffl_start_address_and_size+6,x
	lda fastload_sector_buffer+0x10a,x
	sta fastload_iffl_start_address_and_size+7,x
	clc
	txa
	adc #0x08
	tax
	iny
	cpy fl_iffl_numfiles
	bne loop$

	jmp fl_iffl_read_file_block_init_end

fl_iffl_read_file_block_init_end:

	clc												; set iffl byte counter to 1(nexttrack)+1(nextsector)+1(numfiles)+numfiles*8
	lda fl_iffl_numfiles
	asl a
	asl a
	asl a
	adc #0x03
	sta fl_iffl_bytecounter

	ldx #0x00
	stx fl_iffl_currentfile

	lda fastload_iffl_start_address_and_size+0
	sta fastload_address+0
	lda fastload_iffl_start_address_and_size+1
	sta fastload_address+1
	lda fastload_iffl_start_address_and_size+2
	sta fastload_address+2
	lda fastload_iffl_start_address_and_size+3
	sta fastload_address+3
	lda fastload_iffl_start_address_and_size+4
	sta fl_iffl_sizeremaining+0
	lda fastload_iffl_start_address_and_size+5
	sta fl_iffl_sizeremaining+1
	lda fastload_iffl_start_address_and_size+6
	sta fl_iffl_sizeremaining+2
	lda fastload_iffl_start_address_and_size+7
	sta fl_iffl_sizeremaining+3

	lda #0x00										; Mark end of loading
	sta fastload_request

	rts

; ------------------------------------------------------------------------------------------------------------------------------

fl_iffl_read_file_block:

	jsr fl_copy_sector_to_buffer					; Get sector from FDC

	lda fl_iffl_sizeremaining+3
	bne fl_iffl_fullcopy
	lda fl_iffl_sizeremaining+2
	bne fl_iffl_fullcopy
	lda fl_iffl_sizeremaining+1
	bne fl_iffl_fullcopy
	sec
	lda #0											; (256 - counter) > sizeremaining?
	sbc fl_iffl_bytecounter
	sec
	sbc fl_iffl_sizeremaining+0
	bcc fl_iffl_fullcopy							; yes, copy remaining buffer

fl_iffl_partialcopy:										; no, copy until remaining size

	lda fl_file_next_sector							; Work out which half we care about
	and #0x01
	bne fl_iffl_partial_read_from_second_half		; odd next sector number, so second half
	lda #.byte1 fastload_sector_buffer
	sta fl_read_page+1
	bra fl_iffl_dopartialcopy
fl_iffl_partial_read_from_second_half:
	lda #.byte1 (fastload_sector_buffer+0x100)
	sta fl_read_page+1

fl_iffl_dopartialcopy:

	lda fl_iffl_bytecounter							; set offset for DMA copy
	sta fl_read_page+0

	lda fl_iffl_sizeremaining+0
	sta fl_bytes_to_copy

	clc
	lda fl_iffl_bytecounter
	adc fl_bytes_to_copy
	sta fl_iffl_bytecounter

	lda #0x00										; Mark end of loading
	sta fastload_request
	jsr fl_iffl_performcopy

	rts

fl_iffl_fullcopy:

	lda fl_file_next_sector							; Work out which half we care about
	and #0x01
	bne fl_iffl_read_from_second_half				; odd next sector number, so second half

	lda #.byte1 fastload_sector_buffer				; fl_read_from_first_half
	sta fl_read_page+1
	lda fastload_sector_buffer+1
	sta fl_file_next_sector
	lda fastload_sector_buffer+0
	sta fl_file_next_track
	jmp fl_iffl_dma_read_bytes

fl_iffl_read_from_second_half:
	lda #.byte1 (fastload_sector_buffer+0x100)
	sta fl_read_page+1
	lda fastload_sector_buffer+0x101
	sta fl_file_next_sector
	lda fastload_sector_buffer+0x100
	sta fl_file_next_track
	jmp fl_iffl_dma_read_bytes

fl_iffl_dma_read_bytes:

	sec
	lda #0
	sbc fl_iffl_bytecounter
	sta fl_bytes_to_copy
	sec
	lda fl_iffl_sizeremaining+0
	sbc fl_bytes_to_copy
	sta fl_iffl_sizeremaining+0
	lda fl_iffl_sizeremaining+1
	sbc #0
	sta fl_iffl_sizeremaining+1
	lda fl_iffl_sizeremaining+2
	sbc #0
	sta fl_iffl_sizeremaining+2
	lda fl_iffl_sizeremaining+3
	sbc #0
	sta fl_iffl_sizeremaining+3

	lda fl_iffl_bytecounter							; set offset for DMA copy
	sta fl_read_page+0
	jsr fl_iffl_performcopy

	clc
	lda fl_iffl_bytecounter
	adc fl_bytes_to_copy
	sta fl_iffl_bytecounter
	clc
	lda fl_iffl_bytecounter
	adc #0x02
	sta fl_iffl_bytecounter

	jsr fl_read_next_sector							; Schedule reading of next block

	rts

fl_iffl_performcopy:

	lda fastload_address+3							; Update destination address
	asl a
	asl a
	asl a
	asl a
	sta fl_data_read_dmalist+2						; update destination MB
	lda fastload_address+2
	lsr a
	lsr a
	lsr a
	lsr a
	ora fl_data_read_dmalist+2
	sta fl_data_read_dmalist+2						; update destination MB
	lda fastload_address+2
	and #0x0f
	sta fl_data_read_dmalist+12						; update Dest bank
	lda fastload_address+1
	sta fl_data_read_dmalist+11						; update Dest Address high
	lda fastload_address+0
	sta fl_data_read_dmalist+10						; update Dest Address low

	lda #0x00										; Copy sector buffer data to final address
	sta 0xd704
	lda #.byte1 fl_data_read_dmalist
	sta 0xd701
	lda #.byte0 fl_data_read_dmalist
	sta 0xd705

	clc
	lda fastload_address+0							; Update load address
	adc fl_bytes_to_copy
	sta fastload_address+0
	lda fastload_address+1
	adc #0
	sta fastload_address+1
	lda fastload_address+2
	adc #0
	sta fastload_address+2
	lda fastload_address+3
	adc #0
	sta fastload_address+3

	rts

; ------------------------------------------------------------------------------------------------------------------------------

fl_read_file_block:
													; We have a sector from the floppy drive.
													; Work out which half and how many bytes, and copy them into place.

	jsr fl_copy_sector_to_buffer					; Get sector from FDC

	sec
	lda #0x00										; Assume full sector initially (256 bytes)
	sbc #0x02										; subtract 2 for track and sector bytes
	sta fl_bytes_to_copy

	lda fl_file_next_sector							; Work out which half we care about
	and #0x01
	bne fl_read_from_second_half					; odd next sector number, so second half

	lda #.byte1 fastload_sector_buffer				; fl_read_from_first_half
	sta fl_read_page+1
	lda fastload_sector_buffer+1
	sta fl_file_next_sector
	lda fastload_sector_buffer+0
	sta fl_file_next_track
	bne fl_dma_read_bytes							; if next track is 0 then this is a partial sector and 'sector' now becomes the number of bytes left in this sector

	lda fastload_sector_buffer+1					; fl_1st_half_partial_sector. track is 0, so sector contains number of bytes left
	sec												; subtract 1, because the byte that contains the size is included
	sbc #0x01
	sta fl_bytes_to_copy	
	lda #0x00										; Mark end of loading
	sta fastload_request
	jmp fl_dma_read_bytes

fl_read_from_second_half:
	lda #.byte1 (fastload_sector_buffer+0x100)
	sta fl_read_page+1
	lda fastload_sector_buffer+0x101
	sta fl_file_next_sector
	lda fastload_sector_buffer+0x100
	sta fl_file_next_track
	bne fl_dma_read_bytes							; if next track is 0 then this is a partial sector and 'sector' now becomes the number of bytes left in this sector

	lda fastload_sector_buffer+0x101					; fl_2nd_half_partial_sector. track is 0, so sector contains number of bytes left
	sec												; subtract 1, because the byte that contains the size is included
	sbc #0x01
	sta fl_bytes_to_copy
	lda #0x00										; Mark end of loading
	sta fastload_request
	jmp fl_dma_read_bytes

; ------------------------------------------------------------------------------------------------------------------------------

fl_dma_read_bytes:
	lda fastload_address+3							; Update destination address
	asl a
	asl a
	asl a
	asl a
	sta fl_data_read_dmalist+2						; update destination MB
	lda fastload_address+2
	lsr a
	lsr a
	lsr a
	lsr a
	ora fl_data_read_dmalist+2
	sta fl_data_read_dmalist+2						; update destination MB
	lda fastload_address+2
	and #0x0f
	sta fl_data_read_dmalist+12						; update Dest bank
	lda fastload_address+1
	sta fl_data_read_dmalist+11						; update Dest Address high
	lda fastload_address+0
	sta fl_data_read_dmalist+10						; update Dest Address low

	lda #0x00										; Copy sector buffer data to final address
	sta 0xd704
	lda #.byte1 fl_data_read_dmalist
	sta 0xd701
	lda #.byte0 fl_data_read_dmalist
	sta 0xd705

	clc
	lda fastload_address+0							; Update load address
	adc fl_bytes_to_copy
	sta fastload_address+0
	lda fastload_address+1
	adc #0
	sta fastload_address+1
	lda fastload_address+2
	adc #0
	sta fastload_address+2
	lda fastload_address+3
	adc #0
	sta fastload_address+3

	jsr fl_read_next_sector							; Schedule reading of next block

	rts

; ------------------------------------------------------------------------------------------------------------------------------

fl_data_read_dmalist:
	.byte 0x0b										; F011A type list
	.byte 0x81,0x00									; Destination MB
	.byte 0											; no more options
	.byte 0											; copy
fl_bytes_to_copy:
	.word 0											; size of copy
fl_read_page:
	.word fastload_sector_buffer+2					; Source address. +2 is to skip track/header link
	.byte 0x00										; Source bank
	.word 0											; Dest address
	.byte 0x00										; Dest bank
	.byte 0x00										; sub-command
	.word 0											; modulo (unused)
	; rts

; ------------------------------------------------------------------------------------------------------------------------------

fl_copy_sector_to_buffer
	lda #0x80										; Make sure FDC sector buffer is selected
	trb 0xd689
	lda #0x00										; Copy FDC data to our buffer
	sta 0xd704
	lda #.byte1 fl_sector_read_dmalist
	sta 0xd701
	lda #.byte0 fl_sector_read_dmalist
	sta 0xd705
	rts

fl_sector_read_dmalist
	.byte 0x0b	 									; F011A type list
	.byte 0x80,0xff									; MB of FDC sector buffer address (0xFFD6C00)
	.byte 0											; no more options
	.byte 0											; copy
	.word 512										; size of copy
	.word 0x6c00										; low 16 bits of FDC sector buffer address
	.byte 0x0d										; next 4 bits of FDC sector buffer address
	.word fastload_sector_buffer					; Dest address	
	.byte 0x00										; Dest bank
	.byte 0x00										; sub-command
	.word 0											; modulo (unused)

; ------------------------------------------------------------------------------------------------------------------------------
