ADC #$42 ; A = 0x42
ADC #$FF ; A = 0x41, carry set
ADC #$40 ; A = 0x82, negative set, overflow set, carry reset
ADC #$7E ; A = 0x00, negative reset, overflow reset, zero set, carry set