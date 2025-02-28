;=================LDY========================
; immediate mode
;=================

ldy #$42 ; 2

; zero page mode
;=================

ldy $42 ; 3

; zero page x mode
;=================

ldx #$10
ldy $32,X ; 4

; absolute mode
;=================

ldy $0042 ; 4

; absolute-x mode
;=================

ldx #$10
ldy $0032,X ; 4
ldy $00F0,X ; 5 (should cause page boundary cross)

jmp *