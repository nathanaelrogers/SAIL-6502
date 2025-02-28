;=================ROL========================
; accumulator mode
;=================

rol ; 2

; zero page mode
;=================

rol $42 ; 5

; zero page x mode
;=================

rol $32,X ; 6

; absolute mode
;=================

rol $0042 ; 6

; absolute-x mode
;=================

rol $0032,X ; 7

jmp *