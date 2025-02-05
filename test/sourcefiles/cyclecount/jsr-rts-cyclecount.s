		nop
		jsr test
		lda #$FF
		jmp *

test:	nop
		rts