RMD_DATA_BEGIN:         ; MUSIC DATA BEGIN
    ; Music module pointers
    MusicModulesLo: .byte <test_module_new, <module_coolbricks, <module_spoopy
    MusicModulesHi:
        .byte >test_module_new, >module_coolbricks, >module_spoopy

    .define total_bgm   .sizeof(MusicModulesLo)

    ; SFX module pointers
    SFXModulesLo:
    SFXModulesHi:

    .define total_sfx   .sizeof(SFXModulesLo)

    ; Instrument pointers
    InstrumentNamesLo:  .byte <inst_PlainChicken, <inst_Flipbass, <inst_InvArp47B, <inst_Blop, <inst_TriKick, <inst_DoubleBlop, <inst_SneezeSnare, <inst_InvArpPlain47B, <inst_InvArpPlain46B, <inst_ShortHit, <inst_Arpy59, <inst_Flicktar, <inst_InvArp37A, <inst_FastArp37A, <inst_FastArp47B, <InvArpPlain46A, <cb_000, <cb_001, <cb_002, <cb_003
    InstrumentNamesHi:
        .byte >inst_PlainChicken, >inst_Flipbass, >inst_InvArp47B, >inst_Blop, >inst_TriKick, >inst_DoubleBlop, >inst_SneezeSnare
        .byte >inst_InvArpPlain47B, >inst_InvArpPlain46B, >inst_ShortHit, >inst_Arpy59, >inst_Flicktar, >inst_InvArp37A
        .byte >inst_FastArp37A, >inst_FastArp47B, >InvArpPlain46A, >cb_000, >cb_001, >cb_002, >cb_003

    .define total_instruments   .sizeof(InstrumentNamesLo)

    ; Instrument ID enums
    .enum inst 
        PlainChicken
        testArp 
        Flipbass
        InvArp47B
        Blop
        TriKick
        DoubleBlop
        SneezeSnare
        InvArpPlain47B
        InvArpPlain46B
        ShortHit
        Arpy59
        Flicktar
        InvArp37A
        FastArp37A
        FastArp47B
        InvArpPlain46A
        cb_000
        cb_001
        cb_002
        cb_003
    .endenum

    ; Instrument envelope indexes
    ; Volume envelope index / Arpeggio envelope index / Pitch envelope index / Hi-Pitch envelope index / Duty envelope index
    ; -1 ($FF) means that the envelope is disabled.
    inst_PlainChicken:
        .byte $FF, $FF, $FF, $FF, $FF

    inst_Flipbass:
        .byte $FF, $00, $FF, $FF, $FF

    inst_InvArp47B:
        .byte $00, $01, $FF, $FF, $FF

    inst_Blop:
        .byte $01, $FF, $FF, $FF, $FF

    inst_TriKick:
        .byte $02, $02, $FF, $FF, $FF

    inst_DoubleBlop:
        .byte $03, $FF, $FF, $FF, $FF

    inst_SneezeSnare:
        .byte $04, $03, $FF, $FF, $FF

    inst_InvArpPlain47B:
        .byte $FF, $01, $FF, $FF, $FF

    inst_InvArpPlain46B:
        .byte $FF, $04, $FF, $FF, $FF

    inst_ShortHit:
        .byte $05, $FF, $FF, $FF, $FF

    inst_Arpy59:
        .byte $00, $05, $FF, $FF, $FF

    inst_Flicktar:
        .byte $FF, $FF, $FF, $FF, $00

    inst_InvArp37A:
        .byte $00, $06, $FF, $FF, $FF

    inst_FastArp37A:
        .byte $06, $07, $FF, $FF, $FF

    inst_FastArp47B:
        .byte $06, $08, $FF, $FF, $FF

    InvArpPlain46A:
        .byte $FF, $09, $FF, $FF, $FF

    cb_000:
        .byte $FF, $FF, $FF, $FF, $FF 

    cb_001:
        .byte $FF, $0A, $FF, $FF, $FF 

    cb_002:
        .byte $FF, $0B, $FF, $FF, $FF 

    cb_003:
        .byte $07, $0C, $FF, $FF, $FF 


    

    ; ; Instrument macro list pointers
    ;     .word macro_volume, macro_arpeggio, macro_pitch, macro_hipitch, macro_duty

    ; Instrument macro data pointers
        ; each macro list can handle up to 255 macros.
        macro_volumeLo:
            .byte <macro_vol00, <macro_vol01, <macro_vol02, <macro_vol03
            .byte <macro_vol04, <macro_vol05, <macro_vol06, <macro_vol07 

        macro_volumeHi:
            .byte >macro_vol00, >macro_vol01, >macro_vol02, >macro_vol03
            .byte >macro_vol04, >macro_vol05, >macro_vol06, >macro_vol07

        macro_arpeggioLo: 
            .byte <macro_arp00, <macro_arp01, <macro_arp02, <macro_arp03
            .byte <macro_arp04, <macro_arp05, <macro_arp06, <macro_arp07
            .byte <macro_arp08, <macro_arp09, <macro_arp0A, <macro_arp0B
            .byte <macro_arp0C
        macro_arpeggioHi: 
            .byte >macro_arp00, >macro_arp01, >macro_arp02, >macro_arp03
            .byte >macro_arp04, >macro_arp05, >macro_arp06, >macro_arp07
            .byte >macro_arp08, >macro_arp09, >macro_arp0A, >macro_arp0B
            .byte >macro_arp0C

        macro_pitchLo:
        macro_pitchHi:

        macro_hipitchLo:
        macro_hipitchHi:

        macro_dutyLo:
            .byte <macro_duty00
        macro_dutyHi:
            .byte >macro_duty00


    ; HOW THE MACRO DATA WORKS
    ; Length / Loop index (or total length) / Release index / Data Pointer / Data
    ; -1 ($FF) means that there is no release.
    ; If there's no loop, the loop point should be the same as the total data length.
    ; So that it doesn't need to check for a Loop Enable flag.


    ; Volume Macro Data
        macro_vol00:
            .byte 24, 24, $FF, <@Data, >@Data
            @Data: 
                .byte 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 6, 6, 5, 5, 5, 4, 4, 4, 3, 3, 3, 2, 2, 2, 1 

        macro_vol01:
            .byte 1, 1, $FF, <@Data, >@Data
            @Data: 
                .byte 15, 0

        macro_vol02:
            .byte 5, 5, $FF, <@Data, >@Data
            @Data: 
                .byte 15, 15, 15, 15, 15, 0 

        macro_vol03:
            .byte 2, 2, $FF, <@Data, >@Data
            @Data: 
                .byte 15, 15, 0

        macro_vol04:
            .byte 4, 4, $FF, <@Data, >@Data
            @Data: 
                .byte 15, 14, 13, 12, 0

        macro_vol05:
            .byte 8, 8, $FF, <@Data, >@Data
            @Data: 
                .byte 15, 12, 10, 8, 6, 5, 3, 1, 0

        macro_vol06:
            .byte 4, 4, $FF, <@Data, >@Data
            @Data: 
                .byte 15, 15, 15, 15, 0

        macro_vol07:
            .byte 12, 12, $FF, <@Data, >@Data 
            @Data:
                .byte 6, 6, 5, 5, 5, 5, 5, 5, 3, 3, 2, 2, 1 

    ; Arp Macro Data:
        macro_arp00:
            .byte 1, 1, $FF, <@Data, >@Data
            @Data:
                .byte 12, 0 

        macro_arp01:
            .byte 7, 0, $FF, <@Data, >@Data
            @Data:
                .byte 0, 0, 7, 7, 4, 4, 11, 11 

        macro_arp02:
            .byte 4, 4, $FF, <@Data, >@Data 
            @Data:
                .byte 0, $F8, $F0, $E8, $E0

        macro_arp03:
            .byte 2, 1, $FF, <@Data, >@Data 
            @Data:
                .byte $FF, 10, 8

        macro_arp04:
            .byte 7, 0, $FF, <@Data, >@Data
            @Data:
                .byte 0, 0, 6, 6, 4, 4, 11, 11

        macro_arp05:
            .byte 5, 0, $FF, <@Data, >@Data 
            @Data:
                .byte 0, 0, 5, 5, 9, 9

        macro_arp06:
            .byte 7, 0, $FF, <@Data, >@Data 
            @Data:
                .byte 0, 0, 7, 7, 3, 3, 10, 10

        macro_arp07:
            .byte 3, 3, $FF, <@Data, >@Data 
            @Data:
                .byte 0, 3, 7, 10

        macro_arp08:
            .byte 3, 3, $FF, <@Data, >@Data 
            @Data:
                .byte 0, 4, 7, 11

        macro_arp09:
            .byte 7, 0, $FF, <@Data, >@Data 
            @Data:
                .byte 0, 0, 4, 4, 6, 6, 10, 10

        macro_arp0A:
            .byte 3, 3, $FF, <@Data, >@Data 
            @Data:
                .byte 12, 12, 0 

        macro_arp0B:
            .byte 2, 0, $FF, <@Data, >@Data 
            @Data:
                .byte 12, 12, 0 

        macro_arp0C:
            .byte 5, 0, $FF, <@Data, >@Data 
            @Data:
                .byte 0, 0, 5, 5, 9, 9

    ; Duty macro data
        macro_duty00:
            .byte 2, 2, $FF, <@Data, >@Data
            @Data:
                .byte 2, 0, 1

            
                

    ; BGM MODULES
        .include "music_driver/modules/BGM/test_module_new_new.asm"
        .include "music_driver/modules/BGM/mod_cool_bricks.asm"
        .include "music_driver/modules/BGM/spoopy.asm"

    ; SFX MODULES

RMD_DATA_END:           ; MUSIC DATA END"