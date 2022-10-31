.segment "PRG_BANK0"
    Program_Begin:
        jsr update_controller       ; Call controller subroutine
        jsr RMD_BEGIN               ; Call music driver
        ; End CPU usage meter overlay
        lda #%00011110
        sta PPUMASK
        lda Button_A_HoldTimer
        beq :+
            jmp Program_Begin
        :
        inc Frame_Done                ; We are done, wait for VBlank.

    WaitForVBlank:
        ; Any value besides 0 means that NMI routine hasn't happened yet.
        lda Frame_Done
        bne WaitForVBlank 
        jmp Program_Begin

    ; misc
    .include "music_driver/music_data.asm"
    .include "music_driver/music_driver.asm"

DrawScreenData:
    ; draws a whole screen.
    ; Commands:
    ; $FE repeats the desired tile for n times (Example: $FE $07 $3A)
    ; $FF draws empty tile ($20) for n times (Example: $FF $20)
    ; $FF $FF ends the routine.
    jsr TurnOffScreen
    bit PPUSTATUS
    lda Draw_StartHi
    sta PPUADDR
    lda Draw_StartLo
    sta PPUADDR
    ; reset counter index
    ldy #$FF 

    ; read data
    @MainLoop:
        iny 
        tya 
        clc 
        adc General_Pointer
        sta General_Pointer
        lda General_Pointer+1
        adc #0
        sta General_Pointer+1

        ldy #0

        lda (General_Pointer), Y   ; read byte
        cmp #$FE ; check if the loaded byte is a command byte
        bcs :+
        ; non-command byte
        sta PPUDATA
        jmp @MainLoop
        : 
        bne :+ ; skip over if the loaded byte is not $FE
        iny 
        lda (General_Pointer), Y ; read desired repeating tile
        pha 
        iny 
        lda (General_Pointer), Y ; repeat counter 
        tax 
        pla 
        ;start the thing
        @RepeatingLoop:
            sta PPUDATA
            dex 
            bne @RepeatingLoop
            jmp @MainLoop
        :

        iny 
        lda (General_Pointer), Y ; read next byte 
        cmp #$FF ; check if it is another $FF
        beq @RoutineEnd ; end the routine if it is
        tax 
        lda #$20

        ; start the thing
        @ClearingLoop:
            sta PPUDATA 
            dex  
            bne @ClearingLoop
            jmp @MainLoop
        
        @RoutineEnd:
        jsr TurnOnScreen
        rts 

    MainScreenData:
        .byte .concat("RMD (NES) v", RMD_VERSION, " by Roddy   MMC5")
        .byte .concat("Last update: ", last_update), $FF, 32 - update_string_length
        .byte "Driver size: $", $FF, $08, "Song =", $FF, $04
        .byte "Data size:", $FF, $03, "$", $FF, $05, "Playing =", $FF, $24
        .byte $FF, 8, "P1", $FF, 3, "P2", $FF, 3, "TRI", $FF, 3, "NOI", $FF, $25
        .byte "Note", $FF, 28
        .byte "Vol", $FF, 29
        .byte "Duty", $FF, 28
        .byte "Inst", $FF, 28
        .byte "Length", $FF, 26
        .byte "Fine", $FF, 28
        .byte "Freq", $FF, 28
        .byte "VSpeed", $FF, 26
        .byte "VDepth", $FF, (32 * 4) + 26
        .byte "CPU Usage", $FF, (32*6) + 23
        .byte $10, $20, $11, $FF, 4, "Select song", $FF, 14
        .byte "SELECT Load/Reset", $FF, 15
        .byte "START  Play/Pause"
        .byte $FF, $FF 

; Math stuff
    ; MODULO ( A / B )
    MOD_CALC:
        lda Temp_Word  ; memory addr A
        sec 
        @Modulus:	
            sbc Temp_Word+1  ; memory addr B
            bcs @Modulus
            adc Temp_Word+1
            rts 

    ; DIVISION ( A / B )
    DIV_CALC:
        ;division, rounds up, returns in reg A
        lda Temp_Word ; memory addr A
        ldx #0
        sec 
        @Divide:		
            inx 
            sbc Temp_Word+1 ; memory addr B
            bcs @Divide
            dex 
            txa      ;get result into accumulator
            rts 

CorrectDisplayTile:
    ; Stole this piece of code from Software Creations' NES music driver.
    pha                      
    lsr A                    
    lsr A                    
    lsr A                    
    lsr A                    
    sta PPUDATA       
    pla                      
    and #$0F 
    sta PPUDATA         
    rts                     

TurnOffScreen:
    ; Disable NMI
    lda #%00001000
    sta PPUCTRL

    ; Disable sprite and background rendering:
    lda #%00000000
    sta PPUMASK

    rts 

TurnOnScreen:
    ; Enable NMI
    lda #%10001000
    sta PPUCTRL

    ; Enable sprite and background rendering:
    lda #%00011110
    sta PPUMASK
    
    ; wait until start of the screen 
    :
        bit PPUSTATUS
        bpl :-
        
    rts 
