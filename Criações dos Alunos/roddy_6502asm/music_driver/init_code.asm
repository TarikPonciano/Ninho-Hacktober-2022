reset:
    sei                     ; Set interrupt flag
    cld                     ; Disable decimal mode

    ; Disable APU IRQ
    lda #%01000000
    sta $4017

    ldx #$FF
    txs             ; Initialize the stack pointer
    inx             ; rolls X back to $00

    stx PPUCTRL     ; Disable NMI
    stx PPUMASK     ; Disable rendering

    stx $4010       ; Disable DMC IRQ
    txa 

    ; Let the PPU warm up.
    :
    bit PPUSTATUS
    bpl :- 

    @clear_memory:
        sta $00, X
        sta $0100, X
        sta $0300, X
        sta $0400, X
        sta $0500, X
        sta $0600, X
        sta $0700, X
        lda #$FF
        sta $0200, X 
        lda #$00
        inx 
        bne @clear_memory

    :
    bit PPUSTATUS
    bpl :- 

    ; Setup initial palettes:
    SetupPalette:
        ldx #$00
        bit PPUSTATUS       ; reset address latch
        lda #$3F
        sta PPUADDR
        stx PPUADDR         ; set target PPU address to palette area

        @Loop:
            lda :+, X
            sta PPUDATA
            inx 
            cpx #$20
            beq :++ 
            bne @Loop

        :   
            ; Background palettes
            .byte $1A, $3F, $20, $34
            .byte $09, $3F, $20, $34
            .byte $09, $3F, $20, $34
            .byte $09, $3F, $20, $34

            ; Sprite palettes
            .byte $09, $3F, $20, $34
            .byte $09, $3F, $20, $34
            .byte $09, $3F, $20, $34
            .byte $09, $3F, $20, $34
        :

    ; Let's clear our PPU nametable!
    clear_nametable:
    ; First, let's tell our PPU where in it's memory we want to access. (in our case, $2000)
    ; It's two writes. First write is the most significant byte and then the lower significant byte.
    lda #$20
    sta PPUADDR
    lda #$00
    sta PPUADDR
    ; We have never set our Y register on boot. When resetting the game, register contents aren't cleared.
    tax 
    tay 
    lda #$FF

    clearing_loop:
        sta PPUDATA
        inx 
        bne clearing_loop
        iny 
        cpy #$08
        bne clearing_loop

    lda #2
    sta MMC5_PRGMode 

    lda #$80
    sta MMC5_BANK1

    jsr ResetAPU                ; Reset the APU to a known muted state.

    ; setup screen data pointer
    lda #<MainScreenData
    sta General_Pointer
    lda #>MainScreenData
    sta General_Pointer+1

    lda #$20
    sta Draw_StartHi 
    lda #$00
    sta Draw_StartLo

    ; start drawing screen data.
    jsr DrawScreenData
    jsr TurnOffScreen
    ; jsr DrawStaticText          ; Draw static text (nametable)
    ; jsr InitializeSprites

    ; Calculate driver size:
        lda #>RMD_END
        sec 
        sbc #>FakeRMDBegin
        sta Music_Driver_Size_Hi

        lda #<RMD_END
        sec 
        sbc #<FakeRMDBegin
        sta Music_Driver_Size_Lo
        bcs :+
        dec Music_Driver_Size_Hi
        :

    ; Calculate module data size:
        lda #>RMD_DATA_END
        sec 
        sbc #>RMD_DATA_BEGIN
        sta Music_Data_Size_Hi

        lda #<RMD_DATA_END
        sec 
        sbc #<RMD_DATA_BEGIN
        sta Music_Data_Size_Lo
        bcs :+
        dec Music_Data_Size_Hi
        :

    ; Calculate the correct tiles for driver size:
            ; High byte
            bit PPUSTATUS
            lda #$20
            sta PPUADDR
            lda #$4E
            sta PPUADDR
            lda Music_Driver_Size_Hi
            jsr CorrectDisplayTile

            ; Low byte
            lda #$20
            sta PPUADDR
            lda #$50
            sta PPUADDR
            lda Music_Driver_Size_Lo
            jsr CorrectDisplayTile

        ; Calculate the correct tiles for module size:
            ; High byte
            bit PPUSTATUS
            lda #$20
            sta PPUADDR
            lda #$6E
            sta PPUADDR
            lda Music_Data_Size_Hi
            jsr CorrectDisplayTile

            ; Low byte
            lda #$20
            sta PPUADDR
            lda #$70
            sta PPUADDR
            lda Music_Data_Size_Lo
            jsr CorrectDisplayTile

    ; Enable APU channels (except DMC)
    lda #%00001111
    sta $4015

    ; Wait for VBlank
        :
            bit PPUSTATUS
            bpl :-

    ; Initialize audio driver registers
    ; jsr ResetAudioDriver

    ; Enable NMI and assign sprite/background tables
    lda #%10001000
    sta PPUCTRL

    ; Enable sprite and background rendering:
    lda #%00011110
    sta PPUMASK

    ; Reset all registers
    lda #$00
    tax 
    tay 
    jmp $8000       ; jump to program start