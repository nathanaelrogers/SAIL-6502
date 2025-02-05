ADDR  = $0800
ADDRL = $0800
ADDRH = $0801

        lda #$0D
        sta ADDRL
        lda #$02
        sta ADDRH

        jmp next
        jmp *

next:   jmp (ADDR)