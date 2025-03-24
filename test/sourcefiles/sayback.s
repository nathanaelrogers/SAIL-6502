rw     = $8400
status = $8401

start:

lda status ; load the status reg
cmp #$08   ; check if the ready bit is set
beq print  ; if ready then print a character

jmp start  ; keep looping and checking

print:

lda rw     ; load the buffered input
sta rw     ; print

lda #$0d   ; carriage return
sta rw     ; print

lda #$0a   ; line feed
sta rw     ; print

jmp start