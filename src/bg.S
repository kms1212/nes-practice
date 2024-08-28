.include "common.inc"
.include "bg.inc"

.segment "ZEROPAGE"
SCROLLX:    .res 1
SCROLLY:    .res 1
SCROLLHIGH: .res 1

.segment "CODE"
UPDATE_SCROLL:
    LDA     SCROLLHIGH
    ORA     #%10010000
    STA     PPUCTRL

    LDA     PPUSTATUS                   ; reset PPU state
    LDA     SCROLLX
    STA     PPUSCROLL
    LDA     SCROLLY
    STA     PPUSCROLL

    RTS
