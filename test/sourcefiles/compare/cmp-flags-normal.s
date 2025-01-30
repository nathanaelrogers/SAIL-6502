LDA #$FF   ; load A with immediate 0xFF, n=1, z=0
STA $00    ; store 0xFF at address $0000
CMP $00    ; compare A with $0000, c=1 since 0xFF (A) >= 0xFF ($0000), z=1 since 0xFF == 0xFF, n=0 since result non-neg (0xFF (A) !< 0xFF ($0000))
LDA #$7F   ; load A with immediate 0x7F, n=0, z=0
CMP $00    ; compare A with $0000, c=0 since 0x7F !>= 0xFF, z=0 since 0x7F !== 0xff, n=1 since result negative (0x7F < 0xFF)