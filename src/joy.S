.include "common.inc"
.include "joy.inc"

.segment "ZEROPAGE"
JOY1DATA:   .res 1

.segment "CODE"
LOAD_JOYSTICK:
    ; get controller 1 input
    LDA     #$01
    STA     JOY1DATA

    ; latch input
    STA     JOY_STROBE
    LDA     #0
    STA     JOY_STROBE

    ; load data
:
    LDA     JOY1
    LSR     A
    ROL     JOY1DATA
    BCC     :-

    RTS
