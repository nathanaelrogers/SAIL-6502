;=================ASL========================
; accumulator mode
;=================

asl ; 2

; zero page mode
;=================

asl $42 ; 5

; zero page x mode
;=================

asl $32,X ; 6

; absolute mode
;=================

asl $0042 ; 6

; absolute-x mode
;=================

asl $0032,X ; 7

jmp *