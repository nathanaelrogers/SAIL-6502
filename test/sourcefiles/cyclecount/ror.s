;=================ROR========================
; accumulator mode
;=================

ror ; 2

; zero page mode
;=================

ror $42 ; 5

; zero page x mode
;=================

ror $32,X ; 6

; absolute mode
;=================

ror $0042 ; 6

; absolute-x mode
;=================

ror $0032,X ; 7

jmp *