; NES system registers
PPUCTRL             = $2000
PPUMASK             = $2001
PPUSTATUS           = $2002
OAMADDR             = $2003
OAMDATA             = $2004
PPUSCROLL           = $2005
PPUADDR             = $2006
PPUDATA             = $2007

SQ1_VOL             = $4000
SQ1_SWEEP           = $4001
SQ1_LO              = $4002
SQ1_HI              = $4003
SQ2_VOL             = $4004
SQ2_SWEEP           = $4005
SQ2_LO              = $4006
SQ2_HI              = $4007
TRI_LINEAR          = $4008
TRI_LO              = $400A
TRI_HI              = $400B
NOISE_VOL           = $400C
NOISE_LO            = $400E
NOISE_HI            = $400F
DMC_FREQ            = $4010
DMC_RAW             = $4011
DMC_START           = $4012
DMC_LEN             = $4013
OAMDMA              = $4014
SND_CHANNEL         = $4015
SND_STATUS          = $4015
JOY1                = $4016
JOY_STROBE          = $4016
JOY2                = $4017
FRAMECOUNTER        = $4017

; PPU memory map pointers
PTABLE0             = $0000
PTABLE1             = $1000
NTABLE0             = $2000
NTABLE0_ATTR        = $23C0
NTABLE1             = $2400
NTABLE1_ATTR        = $27C0
NTABLE2             = $2800
NTABLE2_ATTR        = $2BC0
NTABLE3             = $2C00
NTABLE3_ATTR        = $2FC0
PALETTE             = $3F00

; non-zeropage global variables
OAMBUFFER           = $0200

.segment "VECTORS"
.global NMI
.global RESET
.global LOOP

.segment "ZEROPAGE"
.global FIRSTLOOP

.segment "CODE"
.global PALETTEDATA_INIT
.global OAMBUFFER_INIT
.global APUREG_INIT
.global BACKGROUNDDATA_INIT
.global BACKGROUNDATTR_INIT
