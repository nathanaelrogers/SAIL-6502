		BCC ADD  ; we should branch
		BRK
		BRK
		BRK
ADD		ADC #$42 ; A = 0x42
		ADC #$FF ; A = 0x41, carry set
		BCC SUB  ; we should not branch
		BRK
		BRK
		BRK
SUB		SBC #$41 ; if this instruction happens something went wrong!