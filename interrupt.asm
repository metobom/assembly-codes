	LIST	    p=16f877a
	INCLUDE	    "p16f877a.inc"
	__CONFIG    h'3F31'

; Allocate memory fror w_temp, count1, count2 from 0x20
cblock	h'20'
	w_temp, count1, count2
endc
	
	constant sayac1 = h'FF' ; movlw .255 = movlw sayac1
	constant sayac2 = h'FF' ; movlw .255 = movlw sayac2
	
	org 0x00
	; goto ???
	goto main
	org 0x04 ; built-in interrupt address
	; goto ISR
	goto isr

main
	banksel TRISB
	; define the first bit as input of port B
	bsf	TRISB, 0
	;define all bits of PORTD as output, you should make necessary adjustments to TRISD
	banksel	TRISD
	clrf	TRISD
	;Don't forget to select bank which contains OPTION_REG.
	banksel	OPTION_REG
	;Set interrupt on rising edge of RB0/INT pin.
	bsf	OPTION_REG, 6
	;Disable internal pull-ups of PORTB.
	bsf	OPTION_REG, 7
	;Clear PORTB and PORTD.
	banksel PORTB
	clrf PORTB
	banksel PORTD
	clrf PORTD
	;Enable Global Interrupt
	banksel INTCON
	bsf    INTCON, 7
	;Enable RB0/INT External Interrupt.
	bsf    INTCON, 4
	;Load 0xF0 to w_temp.
	banksel w_temp
	movlw	h'F0'
	movwf	w_temp

inf_loop
	banksel PORTD
	movwf	PORTD
	goto inf_loop

isr
	;Load 0x0F to PORTD
	banksel PORTD
	movlw	h'0F'
	movwf	PORTD
	;Call delay subroutine.
	call	delay
	;Copy w_temp to working register in order to prevent data loss.
	banksel w_temp
	movfw	w_temp
	;Clear the external interrupt flag
	banksel INTCON
	bcf	INTCON, 1
	;Return from interrupt
	RETFIE
delay
	; movlw .255
	movlw	sayac1	
	movwf	count1	; this subroutine does 255x255 loop
loop1
	; movlw .255
	movlw	sayac2
	movwf	count2	
loop2
	decfsz	count2, F
	goto loop2
	decfsz count1, F
	goto loop1
	return
	end
	goto
