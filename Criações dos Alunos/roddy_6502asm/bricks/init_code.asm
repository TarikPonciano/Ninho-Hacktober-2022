reset:
    sei                     ; Set interrupt flag
    cld                     ; Disable decimal mode

    ; Disable APU IRQ
    lda #%01000000
    sta $4017

    ldx #$FF
    txs             ; Initialize the stack register
    inx             ; rolls X back to $00

    stx PPUCTRL     ; Disable NMI
    stx PPUMASK     ; Disable rendering

    stx $4010       ; Disable DMC IRQ

    ; Let the PPU warm up.
    :
    bit PPUSTATUS
    bpl :-

    txa             ; Transfer X (supposed to be $00) to accumulator.

    ; Let's start clearing memory. Memory contents are randomized on power-up.
    clear_memory:
        sta $0000, X
        sta $0100, X
        sta $0300, X
        sta $0400, X
        sta $0500, X
        sta $0600, X
        sta $0700, X
        ; Also setup the area for sprites. FF so it hides everything off-screen.
        lda #$FF
        sta $0200, X
        lda #$00
        ; Increase X offset.
        inx 
        ; Repeat the code again in case our X register is not zero.
        bne clear_memory

    :
    bit PPUSTATUS
    bpl :-

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

    ldx #2
    stx $5102
    dex 
    stx $5103

    ldx #$20
    lda #$00
    stx PPUADDR 
    sta PPUADDR 
    tax 

    lda $6000
    beq :+
        jmp SkipWritingBottomText
    :

    WriteCPU:
        lda :+, X 
        beq :++ 
        sta PPUDATA 
        inx 
        bne WriteCPU
        :
        .asciiz "CPU Usage:"
        :

    ldx #$23
    stx PPUADDR
    ldx #$80
    stx PPUADDR 
    tax  

    WriteMesen:
        lda :+, X 
        beq :++ 
        sta PPUDATA 
        inx 
        bne WriteMesen
        :
        .asciiz "Mesen emulator recommended."
        :

    ldx #$23
    stx PPUADDR 
    ldx #$A0 
    stx PPUADDR 
    tax 

    WriteBuildDate:
        lda :+, X 
        beq :++ 
        sta PPUDATA 
        inx 
        bne WriteBuildDate 
        :
        .asciiz "very pog test       July 1, 2022"
        :

    SkipWritingBottomText:

    InitialPalettes:
        ldx #$3F
        lda #$00
        stx PPUADDR
        sta PPUADDR
        tax 
        @PaletteLoop:
            lda :+, X 
            sta PPUDATA
            inx 
            cpx #$20
            bne @PaletteLoop
            bpl @PaletteDone

        :
            .byte $0F, $10, $00, $30
            .byte $0F, $00, $10, $20
            .byte $0F, $00, $00, $00
            .byte $0F, $00, $00, $00

            .byte $0F, $25, $15, $0F
            .byte $0F, $01, $1B, $30
            .byte $0F, $00, $00, $00
            .byte $0F, $00, $00, $00
        
        @PaletteDone:

    ; jsr ResetAPU                ; Reset the APU to a known muted state.

;     ; Calculate driver size:
;     lda #>RODDY_MUSIC_DRIVER_END
;     sec 
;     sbc #>RODDY_MUSIC_DRIVER_BEGIN
;     sta Music_Driver_Size_Hi

;     lda #<RODDY_MUSIC_DRIVER_END
;     sec 
;     sbc #<RODDY_MUSIC_DRIVER_BEGIN
;     sta Music_Driver_Size_Lo
;     bcs :+
;     dec Music_Driver_Size_Hi
;     :

; ; Calculate module data size:
;     lda #>RODDY_MODULE_DATA_END
;     sec 
;     sbc #>RODDY_MODULE_DATA_BEGIN
;     sta Music_Data_Size_Hi

;     lda #<RODDY_MODULE_DATA_END
;     sec 
;     sbc #<RODDY_MODULE_DATA_BEGIN
;     sta Music_Data_Size_Lo
;     bcs :+
;     dec Music_Data_Size_Hi
;     :

    lda #$20
    ldx #$00
    sta Draw_StartHi
    stx Draw_StartLo


	lda #<MainScreenData
	sta General_Pointer
	lda #>MainScreenData
	sta General_Pointer+1 
    jsr DrawScreenData

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

    lda #ObjArea
    sta ObjectSlot_Pointer+1 

    ldx #0
    @FOPAFOPJJAFPOJAPOF:
        lda @Message, X 
        beq :+ 
        sta $6000, X 
        inx 
        jmp @FOPAFOPJJAFPOJAPOF

        @Message:
            .asciiz "If you read this message, you now must ThankEgg irl"
    :

    lda #$80
    sta $6969

    ; Reset all registers
    lda #$00
    tax 
    tay 
    jmp $8000 