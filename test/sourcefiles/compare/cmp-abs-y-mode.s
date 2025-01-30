LDY #$10    ; load Y with offset of 0x10
CMP $0032,Y ; A = 0x00 (0x42 stored at $0042)
CMP $00F0,Y ; A = 0x00 (0x42 stored at $0100) (causes page boundary crossing)