	LIST	    p=16f877a
	INCLUDE	    "p16f877a.inc"
	__CONFIG    h'3F31'
	
myReg	equ	0x20
	org	0x00
main		   
	clrf	myReg
loop	incf	myReg, f
	movfw	myReg
	xorlw	.5	;xor 5 and working reg
	btfss	STATUS, Z
	goto	loop
	call subfoo
	call subfoo1
	call subfoo
	
subfoo
	movlw .255
	nop
	return
	
subfoo1
	movlw .100
	nop
	end
	
