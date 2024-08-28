.include "common.inc"
.include "object.inc"
.include "joy.inc"
.include "bg.inc"


.segment "ZEROPAGE"
FIRSTLOOP:  .res 1

.segment "CODE"
NMI:
    ; push registers to stack
    PHP
    PHA
    TXA
    PHA
    TYA
    PHA

    ; set first loop flag
    LDA     #$FF
    STA     FIRSTLOOP

    ; initialize OAM
    LDA     #.HIBYTE(OAMBUFFER)
    STA     OAMDMA

    ; update sprites
    JSR     UPDATE_SPRITE_POS

    ; update background scroll
    JSR     UPDATE_SCROLL

    ; pop registers from stack
    PLA
    TAY
    PLA
    TAX
    PLA
    PLP

    RTI

LOOP:
    ; load joystick status
    JSR     LOAD_JOYSTICK

    ; move sprite
    LDA     JOY1DATA
    CLC

    ; a
    ASL     A
    
    ; b
    ASL     A

    ;select
    ASL     A

    ; start
    ASL     A

    ; up
    ASL     A
    TAX
    BCC     :+++
    LDA     OBJ1Y
    CMP     #$18
    BMI     :+
    SEC
    SBC     #$4
    STA     OBJ1Y
    JMP     :+++
:
    LDA     SCROLLY
    SEC
    SBC     #$4
    CMP     #$F0
    BMI     :+
    BCC     :+
    LDA     SCROLLHIGH
    EOR     #$02
    STA     SCROLLHIGH
    LDA     #$EC
:
    STA     SCROLLY
:
    TXA

    ; down
    ASL     A
    TAX
    BCC     :+++
    LDA     OBJ1Y
    CMP     #$98
    BMI     :+
    CLC
    ADC     #$4
    STA     OBJ1Y
    JMP     :+++
:
    LDA     SCROLLY
    CLC
    ADC     #$4
    CMP     #$F0
    BMI     :+
    BCC     :+
    LDA     SCROLLHIGH
    EOR     #$02
    STA     SCROLLHIGH
    LDA     #$00
:
    STA     SCROLLY
:
    TXA
    
    ; left
    ASL     A
    TAX
    BCC     :++
    LDA     OBJ1X
    CMP     #$38
    BMI     :+
    BCC     :+
    SEC
    SBC     #$4
    STA     OBJ1X
    JMP     :++
:
    LDA     SCROLLX
    SEC
    SBC     #$4
    STA     SCROLLX
    BCS     :+
    LDA     SCROLLHIGH
    EOR     #$01
    STA     SCROLLHIGH
:
    TXA

    ; right
    ASL     A
    TAX
    BCC     :++
    LDA     OBJ1X
    CMP     #$B8
    BPL     :+
    CLC
    ADC     #$4
    STA     OBJ1X
    JMP     :++
:
    LDA     SCROLLX
    CLC
    ADC     #$4
    STA     SCROLLX
    BCC     :+
    LDA     SCROLLHIGH
    EOR     #$01
    STA     SCROLLHIGH
:
    TXA

    RTS

