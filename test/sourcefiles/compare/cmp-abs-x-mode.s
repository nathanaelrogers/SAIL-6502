LDX #$10    ; load X with offset of 0x10
CMP $0032,X ; A = 0x00 (0x42 stored at $0042)
CMP $00F0,X ; A = 0x00 (0x42 stored at $0100) (causes page boundary crossing)