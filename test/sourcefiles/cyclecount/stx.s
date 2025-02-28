; zero page mode
;=================

stx $42 ; 3

; zero page y mode
;=================

ldx #$10
stx $32,Y ; 4

; absolute mode
;=================

stx $0042 ; 4

jmp *