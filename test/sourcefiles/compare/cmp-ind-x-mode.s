LDX #$10    ; load X with offset of 0x10
CMP ($32,X) ; A = 0x00

; calculate zero-page read address
; 0x32 + X = 0x32 + 0x10 = 0x42 so read from $0042
; real address is stored at $0042 - real address is $0100
; use data (0xFF) at real address $0100 to perform operation