;=================LSR========================
; accumulator mode
;=================

lsr ; 2

; zero page mode
;=================

lsr $42 ; 5

; zero page x mode
;=================

lsr $32,X ; 6

; absolute mode
;=================

lsr $0042 ; 6

; absolute-x mode
;=================

lsr $0032,X ; 7

jmp *