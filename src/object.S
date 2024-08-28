.include "common.inc"
.include "object.inc"


.segment "ZEROPAGE"
OBJ1X:      .res 1
OBJ1Y:      .res 1

.segment "CODE"
UPDATE_SPRITE_POS:
    ; load object X pos
    LDX     #$3
    LDY     OBJ1X

:
    TYA
    STA     OAMBUFFER, X
    TXA
    CLC
    ADC     #4
    TAX
    TYA
    CLC
    ADC     #8
    STA     OAMBUFFER, X
    TXA
    CLC
    ADC     #4
    TAX
    CPX     #$13
    BNE     :-

    ; load object Y pos
    LDX     #$0
    LDY     OBJ1Y

:
    TYA
    STA     OAMBUFFER, X
    TXA
    CLC
    ADC     #4
    TAX
    TYA
    STA     OAMBUFFER, X
    TXA
    CLC
    ADC     #4
    TAX

    CPX     #$10
    BEQ     :+
    TYA
    CLC
    ADC     #8
    TAY
    JMP     :-
:

    RTS
