.enum oPlayer
    created = obj_tempRAM + $0
    XPos = obj_tempRAM + $1
    XPos_Prev = obj_tempRAM + $2
    Flags = obj_tempRAM + $3
    ; 76543210     
    ; ||||||||      
    ; |||||||+- D = Direction (0 = Right / 1 = Left)
    ; |++++++-- Currently unused.
    ; +-------- Player defeated.
    Speed = obj_tempRAM + $4
    ActivePower = obj_tempRAM + $5
    ; 76543210
    ; |||||||+- ; big paddle
    ; +++++++-- ; Currently unused.
    ActivePower_Prev = obj_tempRAM + $6
    MiddleX = obj_tempRAM + $7
    LimitX = obj_tempRAM + $8
    timer = obj_tempRAM + $9
    sRepeat = obj_tempRAM + $e
    sprite_size = obj_tempRAM + $f
.endenum 

Power_Big = 1

; PADDLE CODE
movePlayer:
    ; create event
    lda oPlayer::created 
    bne :+ 
        lda #$70
        sta oPlayer::XPos
        lda #240
        sta oPlayer::timer 
        inc oPlayer::created
    :

        ; debug (toggle normal/big paddle)
            lda Button_B_HoldTimer
            cmp #1 
            bne @SkipDebug_BigPaddle
            lda oPlayer::ActivePower      ; toggle big paddle
            eor #$01
            sta oPlayer::ActivePower

        

        @SkipDebug_BigPaddle:
        ; debug (create a new ball every few seconds)
            lda Button_Select_HoldTimer
            cmp #1
            bne :+ 
                lda #2
                jsr ObjAlloc
                lda #240
                sta oPlayer::timer 
            :
        
        lda Button_Left_HoldTimer
        bne @Move_Left
        ;txa                 ; load joypad inputs back
        lda Button_Right_HoldTimer
        bne @Move_Right
        jmp @NoInput        ; no inputs are being pressed, jump over.

        @Move_Left:
            lda oPlayer::Speed
            cmp #$EC
            beq @Move_Done
            dec oPlayer::Speed
            jmp @Move_Done

        @Move_Right:
            lda oPlayer::Speed
            cmp #20
            beq @Move_Done
            inc oPlayer::Speed
            jmp @Move_Done

        @NoInput:
            lda oPlayer::Speed
            beq @Move_Done
            bmi @NoInput_Minus
            sec 
            sbc #$02
            bpl @Speed_Positive
            lda #$00
            @Speed_Positive:
            sta oPlayer::Speed
            bpl @Move_Done
            @NoInput_Minus:
            clc 
            adc #$02
            bmi @Speed_Negative
            lda #$00
            @Speed_Negative:
            sta oPlayer::Speed

        @Move_Done:
            lda oPlayer::Speed    ; load speed and divide by 4
            beq :+++            ; if speed is 0, skip over this code.
            bpl :+              ; if negative go away
            inc oPlayer::Flags             ; set left movement flag
            jsr InvertSign      ; transform negative value to positive
            :
            beq :+ 
            lsr A               ; divide by 4
            lsr A 
            ldx oPlayer::Flags ; check if the speed value was originally negative
            beq :+
            jsr InvertSign      ; invert the value back to negative
            dec oPlayer::Flags             ; clear left movement flag
            :
            clc 
            adc oPlayer::XPos     ; Add current speed with the current position
            sta oPlayer::XPos     ; Store new player position
            bmi @SnapRight      ; If the player position is on the right half side, check for right collision limits.
            ; snap left
            cmp #$08            ; compare X position value with 8
            bcs :+              ; if the carry flag is set, that means the value is equal or greater than 8. Skip.
            lda #$08
            sta oPlayer::XPos     ; Store 8 to player position
            lda #$00
            sta oPlayer::Speed    ; And stop the player speed.

            @SnapRight: ; snap right
            lda oPlayer::ActivePower  ; check if paddle big
            and #Power_Big
            beq @PaddleNormal
            lda oPlayer::XPos
            cmp #$C9 
            bcc :+ 
            lda #$C8 
            sta oPlayer::XPos
            bmi @aaaa
            @PaddleNormal:
            lda oPlayer::XPos
            cmp #$D9            ; Compare X position value with D9
            bcc :+              ; If the carry bit is clear, that means the value is smaller than D9. Skip
            lda #$D8 
            sta oPlayer::XPos     ; set player position to D8
            @aaaa: 
            lda #$00
            sta oPlayer::Speed    ; And stop the player speed.

            :
            ; determine player collision box
            ldx oPlayer::XPos             ; load current player X position
            lda oPlayer::ActivePower      ; Check if paddle is big
            and #Power_Big
            beq @Paddle_CollisionNormal ; if it's not big, skip to normal paddle collision
            txa             ; transfer player position back to accumulator
            clc 
            adc #24         ; get middle point of the player position
            sta oPlayer::MiddleX
            adc #24         ; get right end point position of the player
            sta oPlayer::LimitX
            jmp :+ 
            @Paddle_CollisionNormal:
            txa 
            clc 
            adc #16     ; get middle point of the player position
            sta oPlayer::MiddleX
            adc #16     ; get right point of the player hitbox
            sta oPlayer::LimitX
            :
        

    UpdateSpritePositions:
        lda oPlayer::ActivePower
        and #Power_Big
        beq :+ 
            lda #6
            sta oPlayer::sprite_size
            bpl :++ 
        :
            lda #4
            sta oPlayer::sprite_size 
        :

        jsr GetSpriteIndex
        tax 

        ; left most sprite
            ; y position
            lda #$D0
            sta $200, X 

            ; sprite tile
            lda #1
            sta $201, X 

            ; attributes
            lda #0
            sta $202, X 

            ; x position
            lda oPlayer::XPos
            sta $203, X 

        ; sprite 2
            ; y position
            lda #$D0
            sta $204, X 

            ; sprite tile
            lda #2
            sta $205, X 

            ; attributes
            lda #0
            sta $206, X 

            ; x position
            lda oPlayer::XPos
            clc 
            adc #8 
            sta $207, X 

        ; sprite 3
            ; y position
            lda #$D0
            sta $208, X 

            ; sprite tile
            lda #2
            sta $209, X 

            ; attributes
            lda #0
            sta $20A, X 

            ; x position
            lda oPlayer::XPos
            clc 
            adc #16 
            sta $20B, X 

        ; sprite 4
            ; y position
            lda #$D0
            sta $20C, X 

            ; sprite tile
            lda #1
            sta $20D, X 

            ; attributes
            lda #%01000000  ; flipped
            sta $20E, X 

            ; x position
            lda oPlayer::XPos
            clc 
            adc #24 
            sta $20F, X 
        
        lda oPlayer::ActivePower
        and #Power_Big
        beq :+ 
            ; change 4th sprite
            lda #2
            sta $20D, X 

            ; sprite 5
                ; y position
                lda #$D0 
                sta $210, X 

                ; sprite tile
                lda #2
                sta $211, X 

                ; attribute
                lda #0
                sta $212, X 

                ; x position
                lda oPlayer::XPos 
                clc 
                adc #32 
                sta $213, X 

            ; sprite 6
                ; y position
                lda #$D0 
                sta $214, X 

                ; sprite tile
                lda #1
                sta $215, X 

                ; attribute
                lda #%01000000  ; flipped
                sta $216, X 

                ; x position
                lda oPlayer::XPos 
                clc 
                adc #40 
                sta $217, X 
        :


        @ObjectReturn:
        ; copy contents to object RAM
        ldy #15
        @CopyLoop:
            lda obj_tempRAM, Y 
            sta (ObjectSlot_Pointer), Y 
            dey 
            bpl @CopyLoop
        @ObjectEnd:
        pla 
        tay 
        jmp ManageObjects