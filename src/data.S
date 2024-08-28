.include "common.inc"

.segment "HEADER"                       ; iNES header
    .byte   "NES", $1A
    .byte   $02                         ; 16K * 1 PRG
    .byte   $01                         ; 8K * 1 CHR
    .byte   $01                         ; vertically mirrored
    .byte   $00, $00, $00, $00          ; extensions
    .byte   $00, $00, $00, $00, $00     ; unused

.segment "CHARS"
    .incbin "rsrc/rom.chr"

.segment "VECTORS"
    .word NMI
    .word RESET

.segment "CODE"
PALETTEDATA_INIT:
    ;background palettes
	.byte   $00, $0F, $00, $10
    .byte   $00, $0A, $15, $01
    .byte   $00, $29, $28, $27
    .byte   $00, $34, $24, $14
    ;sprite palettes          
	.byte   $31, $0F, $15, $30
    .byte   $0F, $15, $20, $27
    .byte   $00, $0F, $30, $27
    .byte   $00, $3C, $2C, $1C

OAMBUFFER_INIT:
;Y, SPRITE NUM, attributes, X
;765xxx10
;|||   ||
;|||   ++- Palette (4 to 7) of sprite
;||+------ Priority (0: in front of background; 1: behind background)
;|+------- Flip sprite horizontally
;+-------- Flip sprite vertically
    ; smw mushroom
    .byte   $40, $00, $00, $40
    .byte   $40, $01, $00, $48
    .byte   $48, $10, $00, $40
    .byte   $48, $11, $00, $48

    ; smb mushroom
    .byte   $40, $04, $01, $80
    .byte   $40, $05, $01, $88
    .byte   $48, $14, $01, $80
    .byte   $48, $15, $01, $88

APUREG_INIT:
    .byte   $30, $08, $00, $00
    .byte   $30, $08, $00, $00
    .byte   $80, $00, $00, $00
    .byte   $30, $00, $00, $00
    .byte   $00, $00, $00, $00

BACKGROUNDDATA_INIT:
    ; 960 bytes
	.byte $00, $01, $02, $03, $04, $05, $06, $07
    .byte $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
	.byte $10, $11, $12, $13, $14, $15, $16, $17
    .byte $18, $19, $1A, $1B, $1C, $1D, $1E, $1F
	.byte $20, $21, $22, $23, $24, $25, $26, $27
    .byte $28, $29, $2A, $2B, $2C, $2D, $2E, $2F
	.byte $30, $31, $32, $33, $34, $35, $36, $37
    .byte $38, $39, $3A, $3B, $3C, $3D, $3E, $3F
	.byte $40, $41, $42, $43, $44, $45, $46, $47
    .byte $48, $49, $4A, $4B, $4C, $4D, $4E, $4F
	.byte $50, $51, $52, $53, $54, $55, $56, $57
    .byte $58, $59, $5A, $5B, $5C, $5D, $5E, $5F
	.byte $60, $61, $62, $63, $64, $65, $66, $67
    .byte $68, $69, $6A, $6B, $6C, $6D, $6E, $6F
	.byte $70, $71, $72, $73, $74, $75, $76, $77
    .byte $78, $79, $7A, $7B, $7C, $7D, $7E, $7F
	.byte $80, $81, $82, $83, $84, $85, $86, $87
    .byte $88, $89, $8A, $8B, $8C, $8D, $8E, $8F
	.byte $90, $91, $92, $93, $94, $95, $96, $97
    .byte $98, $99, $9A, $9B, $9C, $9D, $9E, $9F
	.byte $A0, $A1, $A2, $A3, $A4, $A5, $A6, $A7
    .byte $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF
	.byte $B0, $B1, $B2, $B3, $B4, $B5, $B6, $B7
    .byte $B8, $B9, $BA, $BB, $BC, $BD, $BE, $BF
	.byte $C0, $C1, $C2, $C3, $C4, $C5, $C6, $C7
    .byte $C8, $C9, $CA, $CB, $CC, $CD, $CE, $CF
	.byte $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7
    .byte $D8, $D9, $DA, $DB, $DC, $DD, $DE, $DF
	.byte $E0, $E1, $E2, $E3, $E4, $E5, $E6, $E7
    .byte $E8, $E9, $EA, $EB, $EC, $ED, $EE, $EF
	.byte $F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7
    .byte $F8, $F9, $FA, $FB, $FC, $FD, $FE, $FF
	.byte $00, $01, $02, $03, $04, $05, $06, $07
    .byte $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
	.byte $10, $11, $12, $13, $14, $15, $16, $17
    .byte $18, $19, $1A, $1B, $1C, $1D, $1E, $1F
	.byte $20, $21, $22, $23, $24, $25, $26, $27
    .byte $28, $29, $2A, $2B, $2C, $2D, $2E, $2F
	.byte $30, $31, $32, $33, $34, $35, $36, $37
    .byte $38, $39, $3A, $3B, $3C, $3D, $3E, $3F
	.byte $40, $41, $42, $43, $44, $45, $46, $47
    .byte $48, $49, $4A, $4B, $4C, $4D, $4E, $4F
	.byte $50, $51, $52, $53, $54, $55, $56, $57
    .byte $58, $59, $5A, $5B, $5C, $5D, $5E, $5F
	.byte $60, $61, $62, $63, $64, $65, $66, $67
    .byte $68, $69, $6A, $6B, $6C, $6D, $6E, $6F
	.byte $70, $71, $72, $73, $74, $75, $76, $77
    .byte $78, $79, $7A, $7B, $7C, $7D, $7E, $7F
	.byte $80, $81, $82, $83, $84, $85, $86, $87
    .byte $88, $89, $8A, $8B, $8C, $8D, $8E, $8F
	.byte $90, $91, $92, $93, $94, $95, $96, $97
    .byte $98, $99, $9A, $9B, $9C, $9D, $9E, $9F
	.byte $A0, $A1, $A2, $A3, $A4, $A5, $A6, $A7
    .byte $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF
	.byte $B0, $B1, $B2, $B3, $B4, $B5, $B6, $B7
    .byte $B8, $B9, $BA, $BB, $BC, $BD, $BE, $BF
	.byte $C0, $C1, $C2, $C3, $C4, $C5, $C6, $C7
    .byte $C8, $C9, $CA, $CB, $CC, $CD, $CE, $CF
	.byte $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7
    .byte $D8, $D9, $DA, $DB, $DC, $DD, $DE, $DF
	.byte $E0, $E1, $E2, $E3, $E4, $E5, $E6, $E7
    .byte $E8, $E9, $EA, $EB, $EC, $ED, $EE, $EF
	.byte $F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7
    .byte $F8, $F9, $FA, $FB, $FC, $FD, $FE, $FF
	.byte $00, $01, $02, $03, $04, $05, $06, $07
    .byte $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
	.byte $10, $11, $12, $13, $14, $15, $16, $17
    .byte $18, $19, $1A, $1B, $1C, $1D, $1E, $1F
	.byte $20, $21, $22, $23, $24, $25, $26, $27
    .byte $28, $29, $2A, $2B, $2C, $2D, $2E, $2F
	.byte $30, $31, $32, $33, $34, $35, $36, $37
    .byte $38, $39, $3A, $3B, $3C, $3D, $3E, $3F
	.byte $40, $41, $42, $43, $44, $45, $46, $47
    .byte $48, $49, $4A, $4B, $4C, $4D, $4E, $4F
	.byte $50, $51, $52, $53, $54, $55, $56, $57
    .byte $58, $59, $5A, $5B, $5C, $5D, $5E, $5F
	.byte $60, $61, $62, $63, $64, $65, $66, $67
    .byte $68, $69, $6A, $6B, $6C, $6D, $6E, $6F
	.byte $70, $71, $72, $73, $74, $75, $76, $77
    .byte $78, $79, $7A, $7B, $7C, $7D, $7E, $7F
	.byte $80, $81, $82, $83, $84, $85, $86, $87
    .byte $88, $89, $8A, $8B, $8C, $8D, $8E, $8F
	.byte $90, $91, $92, $93, $94, $95, $96, $97
    .byte $98, $99, $9A, $9B, $9C, $9D, $9E, $9F
	.byte $A0, $A1, $A2, $A3, $A4, $A5, $A6, $A7
    .byte $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF
	.byte $B0, $B1, $B2, $B3, $B4, $B5, $B6, $B7
    .byte $B8, $B9, $BA, $BB, $BC, $BD, $BE, $BF
	.byte $C0, $C1, $C2, $C3, $C4, $C5, $C6, $C7
    .byte $C8, $C9, $CA, $CB, $CC, $CD, $CE, $CF
	.byte $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7
    .byte $D8, $D9, $DA, $DB, $DC, $DD, $DE, $DF
	.byte $E0, $E1, $E2, $E3, $E4, $E5, $E6, $E7
    .byte $E8, $E9, $EA, $EB, $EC, $ED, $EE, $EF
	.byte $F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7
    .byte $F8, $F9, $FA, $FB, $FC, $FD, $FE, $FF
	.byte $00, $01, $02, $03, $04, $05, $06, $07
    .byte $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
	.byte $10, $11, $12, $13, $14, $15, $16, $17
    .byte $18, $19, $1A, $1B, $1C, $1D, $1E, $1F
	.byte $20, $21, $22, $23, $24, $25, $26, $27
    .byte $28, $29, $2A, $2B, $2C, $2D, $2E, $2F
	.byte $30, $31, $32, $33, $34, $35, $36, $37
    .byte $38, $39, $3A, $3B, $3C, $3D, $3E, $3F
	.byte $40, $41, $42, $43, $44, $45, $46, $47
    .byte $48, $49, $4A, $4B, $4C, $4D, $4E, $4F
	.byte $50, $51, $52, $53, $54, $55, $56, $57
    .byte $58, $59, $5A, $5B, $5C, $5D, $5E, $5F
	.byte $60, $61, $62, $63, $64, $65, $66, $67
    .byte $68, $69, $6A, $6B, $6C, $6D, $6E, $6F
	.byte $70, $71, $72, $73, $74, $75, $76, $77
    .byte $78, $79, $7A, $7B, $7C, $7D, $7E, $7F
	.byte $80, $81, $82, $83, $84, $85, $86, $87
    .byte $88, $89, $8A, $8B, $8C, $8D, $8E, $8F
	.byte $90, $91, $92, $93, $94, $95, $96, $97
    .byte $98, $99, $9A, $9B, $9C, $9D, $9E, $9F
	.byte $A0, $A1, $A2, $A3, $A4, $A5, $A6, $A7
    .byte $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF
	.byte $B0, $B1, $B2, $B3, $B4, $B5, $B6, $B7
    .byte $B8, $B9, $BA, $BB, $BC, $BD, $BE, $BF
	.byte $C0, $C1, $C2, $C3, $C4, $C5, $C6, $C7
    .byte $C8, $C9, $CA, $CB, $CC, $CD, $CE, $CF
	.byte $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7
    .byte $D8, $D9, $DA, $DB, $DC, $DD, $DE, $DF
	.byte $E0, $E1, $E2, $E3, $E4, $E5, $E6, $E7
    .byte $E8, $E9, $EA, $EB, $EC, $ED, $EE, $EF
	.byte $F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7
    .byte $F8, $F9, $FA, $FB, $FC, $FD, $FE, $FF

BACKGROUNDATTR_INIT:
    ; 64 bytes
	.byte $55, $55, $55, $55, $55, $55, $55, $55
    .byte $55, $55, $55, $55, $55, $55, $55, $55
	.byte $55, $55, $55, $55, $55, $55, $55, $55
    .byte $55, $55, $55, $55, $55, $55, $55, $55
	.byte $55, $55, $55, $55, $55, $55, $55, $55
    .byte $55, $55, $55, $55, $55, $55, $55, $55
	.byte $55, $55, $55, $55, $55, $55, $55, $55
    .byte $55, $55, $55, $55, $55, $55, $55, $55
