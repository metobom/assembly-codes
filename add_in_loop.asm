 	LIST	    p = 16f877a
	INCLUDE	    "p16f877a.inc"
	__CONFIG    h'3F31'

out_reg equ	    0x20    ; output register in address 0x20

        org	    0x00	    ; starting point of code
	
	clrw			    ; clear working register
loop	addlw	    b'00000001'
	goto	    loop

	end










	


