	.rtmodel version,"1"
	.rtmodel codeModel,"plain"
	.rtmodel core,"45gs02"
	.rtmodel target,"mega65"
	.extern _Zp
	.extern fl_set_filename
	.extern fastload_request
	.extern fl_waiting
	.extern fl_iffl_currentfile
	.extern fastload_iffl_start_address_and_size
	.extern fastload_address
	.extern fl_iffl_sizeremaining
	.extern decrunch

;------------------------------------------------------------------------------

	.section code,text
	.public floppy_iffl_fast_load_init
floppy_iffl_fast_load_init:
	jsr fl_set_filename

	lda #0x01										; Request fastload job
	sta fastload_request
	jsr fl_waiting
	rts

;------------------------------------------------------------------------------

	.section code,text
	.public floppy_iffl_fast_load
floppy_iffl_fast_load:
	lda fl_iffl_currentfile
	asl a
	asl a
	asl a
	tax
	lda fastload_iffl_start_address_and_size+0,x
	sta fastload_address+0
	sta _Zp+1
	lda fastload_iffl_start_address_and_size+1,x
	sta fastload_address+1
	sta _Zp+2
	lda fastload_iffl_start_address_and_size+2,x
	sta fastload_address+2
	sta _Zp+3
	lda fastload_iffl_start_address_and_size+3,x
	sta fastload_address+3
	sta _Zp+4

	lda fastload_iffl_start_address_and_size+4,x
	sta fl_iffl_sizeremaining+0
	lda fastload_iffl_start_address_and_size+5,x
	sta fl_iffl_sizeremaining+1
	lda fastload_iffl_start_address_and_size+6,x
	sta fl_iffl_sizeremaining+2
	lda fastload_iffl_start_address_and_size+7,x
	sta fl_iffl_sizeremaining+3

	lda #0x07
	sta fastload_request
	inc fl_iffl_currentfile
	jsr fl_waiting
	jsr decrunch
	rts
