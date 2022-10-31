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

.segment "ZEROPAGE"
    .define last_update "Sep 8, 2022"
    .define update_string_length .strlen(.concat("Last update: ", last_update))
    .define print(test_message)   .out    test_message
    .define BUILD_DATE .time 

    ; DRIVER BUILD OPTIONS
    .define debug_mode 1
    .define test_variables 1
    .define driver_on_zp 0

    .if driver_on_zp = 1
        .define RMD_VERSION "1.1zp"
    .else 
        .define RMD_VERSION "1.1  "
    .endif 

    ; macros
    .include "vars_and_consts.asm"

; ROM BANK 0
.include "BANKS/ROM_BANK0.asm"

; ROM BANK 1
.include "BANKS/ROM_BANK1.asm"

; FIXED BANK
.include "BANKS/ROM_FIXED.asm"

; build time
.asciiz .concat("BUILD TIME: ", .string(.time))

.segment "VECTORS"
    .word NMI               ; NMI vector interrupt. NMI is VBlank interrupt.
    .word reset             ; Reset vector. This is where the CPU jumps to during startup.
    .word reset             ; IRQ/BRK vector. Software interrupt

.segment "CHARS"
    .incbin "ascii_with_hex.chr"