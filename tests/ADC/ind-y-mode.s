LDY #$10    ; load Y with offset of 0x10
ADC ($32),Y ; A = 0xFF

; read zero page address $0032
; find stored address of $00F0
; calculate real address of $00F0 + Y
; use data (0xFF) at real address $0100 to perform operation