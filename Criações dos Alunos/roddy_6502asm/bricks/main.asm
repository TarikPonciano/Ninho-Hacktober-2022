.segment "HEADER"
    ; iNES header. Header is 16-bytes long.
    .byte "NES"             ; $00-$02 = Constant $4E $45 $53
    .byte $1A               ; $03 = Followed by a MS-DOS end-of-file symbol
    .byte 02                ; $04 = Size of PRG ROM in 16 KB units
    .byte 04                ; $05 = Size of CHR ROM in 8 KB units
    .byte %01010011         ; $06 = Flags 6 - Lo-Mapper, Mirroring, Battery, Trainer
    .byte %00000000         ; $07 = Flags 7 - Hi-Mapper, VS/Playchoice, NES 2.0
    .byte $00               ; $08 = Flags 8 - PRG-RAM size (rarely used extension)
    .byte $00               ; $09 = Flags 9 - TV system (rarely used extension)
    .byte $00               ; $0A = Flags 10 - TV system, PRG-RAM presence (unofficial, rarely used extension)

    ; $0B - $0F = Unused padding to fill the 16 byte header. Guess what I filled it with?
    .byte $52, $4F, $44, $44, $59

; Declaring some constants and macros. Mostly PPU constants for easier access.
.SEGMENT "ZEROPAGE"
    .define ObjArea 4
    .define MAX_OBJECTS 16
    .define version "rewrite 1"
    .define date "April 22, 2022"

    .include "var_and_consts.asm"


.include "ROM_BANKS/ROM_FIXED.asm"    

.include "ROM_BANKS/ROM_BANK0.asm"

.SEGMENT "VECTORS"
    .word NMI               ; NMI vector interrupt. NMI is VBlank interrupt.
    .word reset             ; Reset vector. This is where the CPU jumps to during startup.
    .word reset             ; IRQ/BRK vector. Software interrupt.

.SEGMENT "CHARS"
    .INCBIN "cruel_bricks.chr"