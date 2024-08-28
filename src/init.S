.include "common.inc"
.include "object.inc"
.include "bg.inc"

.segment "STARTUP"
RESET:
    SEI                                 ; mask interrupts
    CLD                                 ; disable decimal mode

    ; init stack
    LDX     #$FF
    TXS

    ; init APU
    LDX     #$13
:
    LDA     APUREG_INIT, X
    STA     SQ1_VOL, X
    DEX
    BPL     :-

    LDA     #$0F
    STA     SND_CHANNEL

    LDA     #$40
    STA     FRAMECOUNTER

    ; init PPU
    LDX     #$00
    STX     PPUCTRL
    STX     PPUMASK

    ; wait for vblank
:
    BIT     PPUSTATUS
    BPL     :-

    ; clear memory, fill $FF to sprite data area, $00 to others
    TXA
:
    STA     $0000, X
    STA     $0100, X
    STA     $0300, X
    STA     $0400, X
    STA     $0500, X
    STA     $0600, X
    STA     $0700, X
    LDA     #$FF
    STA     $0200, X
    LDA     #$00
    INX
    CPX     #$00
    BNE     :-

    ; wait for vblank
:
    BIT     PPUSTATUS
    BPL     :-

    ; initialize OAM
    LDA     #.HIBYTE(OAMBUFFER)
    STA     OAMDMA

    ; load palettes
    LDA     PPUSTATUS
    LDA     #.HIBYTE(PALETTE)
    STA     PPUADDR
    LDA     #.LOBYTE(PALETTE)
    STA     PPUADDR

    LDX     #$00
:
    LDA     PALETTEDATA_INIT, X
    STA     PPUDATA
    INX
    CPX     #$20
    BNE     :-
    
    ; load sprites
    LDX     #$00
:
    LDA     OAMBUFFER_INIT, X
    STA     OAMBUFFER, X
    INX
    CPX     #$20
    BNE     :-

    ; load background
    LDA     PPUSTATUS
    LDA     #.HIBYTE(NTABLE0)
    STA     PPUADDR
    LDA     #.LOBYTE(NTABLE0)
    STA     PPUADDR

    LDX     #$00
:
    LDA     BACKGROUNDDATA_INIT, X
    STA     PPUDATA
    INX 
    CPX     #$00
    BNE     :-
:
    LDA     BACKGROUNDDATA_INIT + $100, X
    STA     PPUDATA
    INX 
    CPX     #$00
    BNE     :-
:
    LDA     BACKGROUNDDATA_INIT + $200, X
    STA     PPUDATA
    INX 
    CPX     #$00
    BNE     :-
:
    LDA     BACKGROUNDDATA_INIT + $300, X
    STA     PPUDATA
    INX 
    CPX     #$C0
    BNE     :-

    ; load background attributes
    LDA     PPUSTATUS
    LDA     #.HIBYTE(NTABLE0_ATTR)
    STA     PPUADDR
    LDA     #.LOBYTE(NTABLE0_ATTR)
    STA     PPUADDR

    LDX     #$00
:
    LDA     BACKGROUNDATTR_INIT, X
    STA     PPUDATA
    INX
    CPX     #$40
    BNE     :-

    ; load background
    LDA     PPUSTATUS
    LDA     #.HIBYTE(NTABLE1)
    STA     PPUADDR
    LDA     #.LOBYTE(NTABLE1)
    STA     PPUADDR

    LDX     #$00
:
    LDA     BACKGROUNDDATA_INIT, X
    STA     PPUDATA
    INX 
    CPX     #$00
    BNE     :-
:
    LDA     BACKGROUNDDATA_INIT + $100, X
    STA     PPUDATA
    INX 
    CPX     #$00
    BNE     :-
:
    LDA     BACKGROUNDDATA_INIT + $200, X
    STA     PPUDATA
    INX 
    CPX     #$00
    BNE     :-
:
    LDA     BACKGROUNDDATA_INIT + $300, X
    STA     PPUDATA
    INX 
    CPX     #$C0
    BNE     :-

    ; load background attributes
    LDA     PPUSTATUS
    LDA     #.HIBYTE(NTABLE0_ATTR)
    STA     PPUADDR
    LDA     #.LOBYTE(NTABLE0_ATTR)
    STA     PPUADDR

    LDX     #$00
:
    LDA     BACKGROUNDATTR_INIT, X
    STA     PPUDATA
    INX
    CPX     #$40
    BNE     :-

    ; reset x, y scroll
    LDA     #$00
    STA     SCROLLX
    STA     SCROLLY
    STA     SCROLLHIGH
    JSR     UPDATE_SCROLL

    ; set default position
    LDA     #$40
    STA     OBJ1X
    STA     OBJ1Y

    CLI

    ; enable NMI on VBLANK
    LDA     #%10010000
    STA     PPUCTRL

    ; show sprites and background
    LDA     #%00011110
    STA     PPUMASK

    ; do loop
:
    LDA     FIRSTLOOP
    BEQ     :+
    LDA     #$00
    STA     FIRSTLOOP
    JSR     LOOP
:
    JMP     :--
