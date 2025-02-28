;=================LDX========================
; immediate mode
;=================

ldx #$42 ; 2

; zero page mode
;=================

ldx $42 ; 3

; zero page y mode
;=================

ldy #$10
ldx $32,Y ; 4

; absolute mode
;=================

ldx $0042 ; 4

; absolute-y mode
;=================

ldy #$10
ldx $0032,Y ; 4
ldx $00F0,Y ; 5 (should cause page boundary cross)

jmp *