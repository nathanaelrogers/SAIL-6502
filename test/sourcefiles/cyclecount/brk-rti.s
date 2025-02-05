IRQL = $FFFE
IRQH = $FFFF

lda #$00
sta IRQH
lda #$11
sta IRQL

brk
nop
lda #$FF
jmp *

rti