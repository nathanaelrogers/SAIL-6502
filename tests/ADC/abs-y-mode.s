LDY #$10    ; load Y with offset of 0x10
ADC $0032,Y ; A = 0x42 (0x42 stored at $0042)
ADC $00F0,Y ; A = 0x84 (0x42 stored at $0100) (causes page boundary crossing)