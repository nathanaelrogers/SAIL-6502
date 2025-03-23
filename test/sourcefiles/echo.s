control = $8401
readwrite = $8400

cr = $0d
lf = $0a

start:

lda control   ; load the control reg
and #$08      ; mask the ready bit
cmp #$08      ; check it

beq print     ; go to printout if a character is ready

jmp start     ; loop back

print:

lda readwrite ; load the buffered input char
sta readwrite ; print out the buffered input char

lda cr
sta cr

lda lf
sta lf

lda control   ; load the control reg
and #$F7      ; unset the ready bit
sta control   ; store the control reg

jmp start