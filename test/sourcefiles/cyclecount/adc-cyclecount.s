;=================ADC========================
; immediate mode
;=================

adc #$42 ; 2

; zero page mode
;=================

adc $42 ; 3

; zero page x mode
;=================

ldx #$10
adc $32,X ; 4

; absolute mode
;=================

adc $0042 ; 4

; absolute-x mode
;=================

ldx #$10
adc $0032,X ; 4
adc $00F0,X ; 5 (should cause page boundary cross)

; absolute-y mode
;=================

ldy #$10
adc $0032,Y ; 4
adc $00F0,Y ; 5 (should cause page boundary cross)

; indirect-x mode
;=================

; Place a real address of $0100 at read location $0042 (calculated by 0x32 + X).
lda #$00
sta $42
lda #$01
sta $43

ldx #$10
adc ($32,X) ; 6


; indirect-y mode
;=================

; Place address of $00F0 at read location $0032. Real addresses $00FF and $0100 (calculated by $00F0 + Y)
lda #$F0
sta $32
lda #$00
sta $33

ldy #$0F    ; (won't cause page boundary crossing from $00F0)
adc ($32),Y ; 5

ldy #$10    ; (will cause page boundary crossing from $00F0)
adc ($32),Y ; 6