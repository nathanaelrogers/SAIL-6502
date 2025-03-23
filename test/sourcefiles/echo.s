loop:

lda $8401 ; load the value in the control register

and $08   ; mask out bit 3

cmp #$08  ; compare with bit 3

bne loop  ; if bit 3 isn't set there's nothing to read

lda $8400 ; load from the input register

sta $8400 ; output it back

jmp loop  ; go to the start