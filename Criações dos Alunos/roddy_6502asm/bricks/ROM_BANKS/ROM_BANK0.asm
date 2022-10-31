.SEGMENT "PRG_BANK0"
    lda $310
    beq :+
        lda #2
        sta $7C5
        dec NewModuleRequest
        @DoomLoop:
        jsr RMD_BEGIN
        @Done:
        inc Frame_Done
            @WaitForVBlank:
            ; Any value besides 0 means that NMI routine hasn't happened yet.
            lda Frame_Done
            bne @WaitForVBlank 
            jmp @DoomLoop
    :
    jsr InitializePlayer
    lda #ObjArea
    sta ObjectSlot_Pointer+1
    initialLoop:
        lda #1
        sta $77a
        lda Current_SongID
        beq :+
            lda #$20
            bne :++
        :
        lda #$4a
        :
        sta $77b
        ; Start CPU usage meter overlay:
        lda CPUMeter
        beq :+
            lda #%00011111      
            sta PPUMASK
        :
        jsr update_controller


        ; DEBUG (Create test object)
        ;lda Button_Select_HoldTimer
        ;cmp #1
        ;bne :+ 
        ;    ; jsr $6000
        ;    lda #2 
        ;    jsr ObjAlloc
        ; :

        ;lda Button_Select_HoldTimer
        ;cmp #1
        ;bne :+ 
        ;    lda CPUMeter
        ;    eor #1
        ;    sta CPUMeter
        ; :

        lda Button_Start_HoldTimer
        cmp #1
        bne :+ 
            lda Current_SongID
            eor #1
            sta Current_SongID
            dec NewModuleRequest
        :

        ; DEBUG (Remove all test objects)
        ;lda Button_Start_HoldTimer
        ;cmp #1
        ;bne :+ 
        ;    lda #3 
        ;    jsr ObjFreeID
        ; :

        ; clean up all sprites
        lda #0
        tax 
        @ClearSpritesLoop:
            sta $201, X 
            inx 
            inx 
            inx 
            inx 
            bne @ClearSpritesLoop

        jsr ManageObjectsBegin
        jsr RMD_BEGIN
        ; .include "music_driver/music_routine.asm"   ; music driver

        ; We are done, wait for VBlank.
        inc Frame_Done

        ; End CPU usage meter overlay
        lda #%00011110
        sta PPUMASK

    WaitForVBlank:
        ; Any value besides 0 means that NMI routine hasn't happened yet.
        lda Frame_Done
        bne WaitForVBlank 
        jmp initialLoop

        .include "controller.asm"                   ; poll controller inputs
        .include "music_driver/music_driver.asm"
        .include "objects/player.asm"                       ; player paddle code
        .include "objects/ball.asm"                         ; ball code.
        .include "objects/test_object.asm"


        GameOverSequence:
            lda #1
            jsr ObjFreeID
            lda #2
            jsr ObjFreeID
            lda #$20
            sta Draw_StartHi
            lda #$00
            sta Draw_StartLo
            lda #<GameOverScreen
            sta General_Pointer
            lda #>GameOverScreen
            sta General_Pointer
            jsr DrawScreenData
            @Loop:
            jmp @Loop

        ; Manage on-screen objects
        ManageObjectsBegin:
            ldy #$FF
        ManageObjects:
            iny  
            cpy #MAX_OBJECTS
            bne :+ 
            rts 
            :
            ldx ObjectList, Y 
            beq ManageObjects
            ; set object variables pointer
            tya 
            pha 
            sta ManagingObject
            jsr ObjSetPointer

            ; copy object contents into temp RAM
            ldy #15
            @CopyLoop:
                lda (ObjectSlot_Pointer), Y 
                sta obj_tempRAM, Y 
                dey 
                bpl @CopyLoop

            ; load object function
            lda ObjectFunctionsLo, X
            sta TempWord
            lda ObjectFunctionsHi, X 
            sta TempWord+1

            ; jump to object function
            jmp (TempWord)

        ObjectFunctionsLo:
            .byte 0, <movePlayer, <ManageBall, <test_object

        ObjectFunctionsHi:
            .byte 0, >movePlayer, >ManageBall, >test_object


        ; Function: Allocates a new object into the Object List.
        ; Usage: reg A = Object ID.
        ObjAlloc:
            ldx #0
            @Loop:
            ldy ObjectList, X 
            bne :+ 
                sta ObjectList, X 
                rts 
            :
            inx 
            cpx #MAX_OBJECTS
            bne @Loop
            ; No object slot available, do nothing and return.
            rts 

        ; Function: This returns the number of the specified object currently active
        ; Usage: A = Object ID, Returns on A.
        ObjInstanceCount:
            sta TempWord
            lda #0
            sta TempWord+1
            ldy #$0F
            @CountLoop:
                ldx ObjectList, Y 
                cpx TempWord
                bne :+ 
                    inc TempWord+1
                :
                dey 
                bpl @CountLoop
                lda TempWord+1
            rts 

        ; Function: This returns the first object slot found with the specified object, excluding itself.
        ; Usage: A = Object ID, returns in A
        ObjFind:
            sta TempWord
            ldx #0
            @FindLoop:
                lda ObjectList, X 
                cmp TempWord
                beq :+++ 
                    inx 
                    cpx #MAX_OBJECTS
                    bne :+ 
                        ldx #$FF
                    :
                    cpx ManagingObject
                    bne :+ 
                        inx 
                    :
                    jmp @FindLoop
                :
                txa 
            rts 
        
        ; Function: Clears all the sprites used from a removed object.
        ; Usage: reg X = object slot
        ; This is called from ObjFree subroutine, so A and X are already properly set.
        ClearObjSprites:
            txa             ; transfer object slot into accumulator
            jsr GetSpriteIndex
            tax             ; transfer value back to index register
            lda #0
            sta $200, X     ; clear sprite data
            sta $201, X 
            sta $202, X 
            sta $203, X 
            rts 

        ;; Function: This gets the sprite index relative to other object sprites before the index ID.
        ; Usage: This checks for the currently object being managed, no need to setup any register.
        GetSpriteIndex:
            ldx #$0F
            stx TempWord
            ldx #$04
            stx TempWord+1
            ldy #0
            tya 
            tax 
            @MainLoop:
                cpx ManagingObject
                bne :+ 
                asl A 
                asl A 
                rts 
                :
                clc 
                adc (TempWord), Y 
                pha 
                lda TempWord
                clc 
                adc #$10
                sta TempWord
                inx 
                pla 
                jmp @MainLoop






        ; Function: Removes an object from the Object List
        ; Usage: reg X = Object slot
        ObjFree:
            lda #0
            sta ObjectList, X 
            txa 
            jsr ObjFreeMemory 
            rts 

        ; Function: Remove all specified object ID from object slots
        ; Usage: reg A = object ID
        ObjFreeID:
            ldx #$FF 
            @Loop: 
                inx 
                cpx #MAX_OBJECTS
                bne :+ 
                rts 
                :                
                cmp ObjectList, X 
                bne @Loop
                pha 
                txa 
                pha
                jsr ObjFreeMemory
                lda #0
                sta ObjectList, X 
                pla 
                tax 
                pla 
                jmp @Loop

        ; Function: Clears up the object's 16 bytes of memory space.
        ; Usage: reg A = Object slot
        ObjFreeMemory:
            ; clear object sprites
            pha 
            jsr ClearObjSprites
            ldy #$0F 
            pla 
            jsr ObjSetPointer
            lda #0
            @Loop: 
                sta (ObjectSlot_Pointer), Y 
                dey 
                bpl @Loop 
            rts 

        ; Function: Set ObjectSlot_Pointer ($10 * A) 
        ; Usage A = object slot 
        ObjSetPointer:
            asl A       ; multiply by 16
            asl A 
            asl A 
            asl A 
            sta ObjectSlot_Pointer
            rts 

DrawScreenData:
    ; draws a whole screen.
    ; Commands:
    ; $FE repeats the desired tile for n times (Example: $FE $07 $3A)
    ; $FF draws empty tile ($20) for n times (Example: $FF $20)
    ; $FF $FF ends the routine.
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

        ; cmp #$FF 
        ; bne :+ 
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
        rts 


; draws a whole screen.
    ; Commands:
    ; $FE repeats the desired tile for n times (Example: $FE $07 $3A)
    ; $FF draws empty tile ($20) for n times (Example: $FF $20)
    ; $FF $FF ends the routine.

MainScreenData:
    .byte "cool bripgnapkfngbamrvmiahsngpin"
    .byte $02, $FE, $04, $1E, $05
    .byte $03, $FF, $1E, $03
    .byte $03, $FF, $1E, $03
    .byte $03, $FF, $1E, $03
    .byte $03, $FF, $1E, $03
    .byte $03, "   Please pretend there are   ", $03
    .byte $03, "         bricks here          ", $03
    .byte $03, "            please            ", $03
    .byte $03, $FF, $1E, $03
    .byte $03, $FF, $1E, $03
    .byte $03, $FF, $1E, $03
    .byte $03, $FF, $1E, $03
    .byte $03, $FF, $1E, $03
    .byte $03, $FF, $1E, $03
    .byte $03, $FF, $1E, $03
    .byte $03, $FF, $1E, $03
    .byte $03, $FF, $1E, $03
    .byte $03, $FF, $1E, $03
    .byte $03, $FF, $1E, $03
    .byte $03, $FF, $1E, $03
    .byte $03, $FF, $1E, $03
    .byte $03, $FF, $1E, $03
    .byte $03, $FF, $1E, $03
    .byte $03, $FF, $1E, $03
    .byte $03, $FF, $1E, $03
    .byte $03, $FF, $1C, $80, $81, $03
    .byte $03, $FF, $1C, $90, $91, $03
    .byte $FF, $FF

DoomedScreen:
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 32
    .byte "    You can never escape the    "
    .byte "             smile              "
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 14, $80, $81, $82, $83, $FF, 14
    .byte $FF, 14, $90, $91, $92, $93, $FF, 14
    .byte $FF, 14, $A0, $A1, $A2, $A3, $FF, 14
    .byte $FF, 14, $B0, $B1, $B2, $B3, $FF, 14
    .byte $FF, $FF

Doomed2Screen:
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 32
    .byte "      I know what you did.      "
    .byte "           Nice try.            "
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 14, $80, $81, $82, $83, $FF, 14
    .byte $FF, 14, $90, $91, $92, $93, $FF, 14
    .byte $FF, 14, $A0, $A1, $A2, $A3, $FF, 14
    .byte $FF, 14, $B0, $B1, $B2, $B3, $FF, 14
    .byte $FF, $FF

GameOverScreen:
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 32
    .byte "            Game over           "
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 32
    .byte $FF, 32

; Other functions
; Division
DIV_CALC:
    ; division, rounds up, returns in reg A
    lda $30 ; memory addr A
    ldx #0
    sec 
    @Divide:		
        inx 
        sbc $31 ; memory addr B
        bcs @Divide
        dex 
        txa      ;get result into accumulator
        rts 

; MODULO ( A / B )
MOD_CALC:
    lda $30  ; memory addr A
    sec 
    @Modulus:	
        sbc $31  ; memory addr B
        bcs @Modulus
        adc $31
        rts 

InvertSign:
    ; This inverts the sign of whatever it's currently in the accumulator.
    eor #$FF 
    clc 
    adc #$01
    rts 

InitializePlayer:
    ; ldx #$00
    ; stx Song_CurrentID
    ; dex 
    ; stx Song_RequestLoad
    ; remove player and ball objects
    lda #1
    jsr ObjFreeID

    lda #2
    jsr ObjFreeID

    ; set objects 
    lda #1
    jsr ObjAlloc
    lda #2
    jsr ObjAlloc

    ; start song
    lda Current_SongID
    eor #1
    sta Current_SongID
    dec NewModuleRequest
    rts 

jamDance_AnimData:
    .byte $10, $11, $12, $13    ; frame 0

SubSpeedXTable:
    .byte 31, 63, 95, 127, 159, 191, 223, 255

; YEP, that's me.
.asciiz "RODDY_ROM_END"