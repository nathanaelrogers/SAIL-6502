; zero page mode
;=================

sty $42 ; 3

; zero page x mode
;=================

ldx #$10
sty $32,X ; 4

; absolute mode
;=================

sty $0042 ; 4

jmp *