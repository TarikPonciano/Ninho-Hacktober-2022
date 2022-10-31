.enum oBall
    Status = obj_tempRAM + 0
    ; 76543210
    ; |||||||+- Ball Locked
    ; ||||||+-- Y = Ball Y Direction (0 = up / 1 = down)
    ; |||||+--- X = Ball X Direction (0 = left / 1 = right)
    ; +++++---- Currently unused.
    XPos = obj_tempRAM + 1
    SubXPos = obj_tempRAM + 2
    YPos = obj_tempRAM + 3
    SubYPos = obj_tempRAM + 4
    SpeedX = obj_tempRAM + 5
    SubSpeedX = obj_tempRAM + 6
    SpeedY = obj_tempRAM + 7
    SubSpeedY = obj_tempRAM + 8
    HitPoint = obj_tempRAM + 9
    created = obj_tempRAM + $a
    gameover = obj_tempRAM + $b
    sprite_size = obj_tempRAM + $f
    plXPos = obj_tempRAM + $10
    plMiddleX = obj_tempRAM + $11
    plLimitX = obj_tempRAM + $12
    plRAM = obj_tempRAM + $13
    plYPos = obj_tempRAM + $15
.endenum 

Ball_Locked = 1
Ball_YDirection = 1 << 1
Ball_XDirection = 1 << 2

ManageBall:
    ; find player paddle object
        lda #1
        jsr ObjFind
        bmi :+ 
            asl A 
            asl A 
            asl A 
            asl A 
            sta oBall::plRAM
            lda #4
            sta oBall::plRAM+1
            ; get variables
            ; xposition
            ldy #1
            lda (oBall::plRAM), Y
            sta oBall::plXPos
            ldy #7 
            lda (oBall::plRAM), Y 
            sta oBall::plMiddleX 
            iny 
            lda (oBall::plRAM), Y 
            sta oBall::plLimitX
            iny 
        :

    ; create event 
    lda oBall::created 
    bne :++ 
        ; check for level initialization
        lda global_levelInitialized
        bne :+ 
            ; lock ball
            lda #1
            sta oBall::Status
            sta oBall::created
            sta global_levelInitialized
            bpl :++ 
        :
        lda oBall::plMiddleX
        sec 
        sbc #2
        sta oBall::XPos
        lda #$CA 
        sta oBall::YPos
        ldx #1
        stx oBall::SpeedY
        inx 
        stx oBall::Status


        ;lda #2
        ;jsr ObjFind
        ;asl A 
        ;asl A 
        ;asl A 
        ;asl A 
        ;sta TempWord
        ;lda #4
        ;sta TempWord+1
        ;ldy #0
        ;lda (TempWord), Y 
        ;sta oBall::Status
        ;iny 
        ;lda (TempWord), Y 
        ;sec 
        ;sbc #24
        ;sta oBall::XPos
        ;ldy #3
        ;lda (TempWord), Y 
        ;clc 
        ;adc #8
        ;sta oBall::YPos
        ;ldy #5
        ;lda (TempWord), Y 
        ;sta oBall::SpeedX
        ;iny 
        ;lda (TempWord), Y 
        ;sta oBall::SubSpeedX
        ;iny 
        ;lda (TempWord), Y 
        ;sta oBall::SpeedY 
        ;iny 
        ;lda (TempWord), Y 
        ;sta oBall::SubSpeedY


        lda #1
        sta oBall::created
            
    :

    lda oBall::Status     ; check if ball is locked to player
    and #Ball_Locked
    beq @UpdateBall     ; if not then execute ball code
    lda Button_A_HoldTimer      ; unlock the ball if the A button is being held
    beq :+ 
    lda #%10            ; unlock player and ball direction down
    sta oBall::Status
    lda #1              ; Set a initial speed for the unlocked ball
    sta oBall::SpeedY
    lda #$80
    sta oBall::SubSpeedY
    bmi @UpdateBall
    
    :
    lda #$C8                    ; lock the ball into the paddle
    sta oBall::YPos
    lda oBall::plXPos 
    clc 
    adc #15
    sta oBall::XPos
    jmp @UpdateBallSpritePosition

    @UpdateBall:
    ; X POSITION
    lda oBall::Status     ; check for ball X Direction
    and #Ball_XDirection
    beq @Ball_LeftDirection
    lda oBall::XPos                        ; ball going right direction. load X position
    clc 
    adc oBall::SpeedX             ; add with current speed
    sta oBall::XPos
    lda oBall::SubXPos           ; load sub-pixel X position
    clc 
    adc oBall::SubSpeedX          ; add with current sub speed
    sta oBall::SubXPos
    lda oBall::XPos               ; increase X position value if the sub pixel rolls back to 0.
    adc #0
    sta oBall::XPos
    jmp :+ 

    @Ball_LeftDirection:
    lda oBall::XPos                        ; ball going left direction. load X position
    sec 
    sbc oBall::SpeedX             ; subtract with current speed
    sta oBall::XPos
    lda oBall::SubXPos           ; load sub-pixel X position
    sec 
    sbc oBall::SubSpeedX          ; subtract with current sub speed
    sta oBall::SubXPos
    lda oBall::XPos               ; decrease X position value if the sub pixel rolls back to FF.
    sbc #0
    sta oBall::XPos
    :

    ; Y POSITION
    lda oBall::Status     ; check for ball Y Direction
    and #Ball_YDirection
    beq @Ball_UpDirection
    lda oBall::YPos                        ; ball going right direction. load X position
    clc 
    adc oBall::SpeedY             ; add with current speed
    sta oBall::YPos
    lda oBall::SubYPos           ; load sub-pixel X position
    clc 
    adc oBall::SubSpeedY          ; add with current sub speed
    sta oBall::SubYPos
    lda oBall::YPos               ; increase X position value if the sub pixel rolls back to 0.
    adc #0
    sta oBall::YPos
    jmp :+ 

    @Ball_UpDirection:
    lda oBall::YPos                        ; ball going left direction. load X position
    sec 
    sbc oBall::SpeedY             ; subtract with current speed
    sta oBall::YPos
    lda oBall::SubYPos           ; load sub-pixel X position
    sec 
    sbc oBall::SubSpeedY          ; subtract with current sub speed
    sta oBall::SubYPos
    lda oBall::YPos               ; decrease X position value if the sub pixel rolls back to FF.
    sbc #0
    sta oBall::YPos
    :

    ; COLLISION
    ; Collision with the top limit of the screen:
    lda oBall::YPos       ; load ball Y position
    cmp #16             ; compare with top limit of the play area
    bcs :+ 
    lda #16             ; move the ball to the top limit of the screen
    sta oBall::YPos   
    lda oBall::Status     ; invert the ball Y direction
    eor #Ball_YDirection
    sta oBall::Status
    lda oBall::SubSpeedY
    clc 
    adc #$0f
    sta oBall::SubSpeedY
    lda oBall::SpeedY 
    adc #0
    sta oBall::SpeedY
    :

    ; Collision with the left limit of the screen:
    lda oBall::XPos       ; load ball X position
    cmp #11              ; compare with left limit of the screen
    bcs :+ 
    lda #12              ; move the ball to the left limit of the screen
    sta oBall::XPos
    lda oBall::Status     ; invert the ball X direction
    eor #Ball_XDirection
    sta oBall::Status
    lda oBall::SubSpeedY
    clc 
    adc #$0f
    sta oBall::SubSpeedY
    lda oBall::SpeedY 
    adc #0
    sta oBall::SpeedY
    :

    ; Collision with the right limit of the screen:
    lda oBall::XPos       ; load ball X position
    cmp #246            ; compare with right limit of the screen
    bcc :+ 
    lda #245            ; move the ball to the right limit of the screen
    sta oBall::XPos
    lda oBall::Status     ; invert the ball X direction
    eor #Ball_XDirection
    sta oBall::Status
    lda oBall::SubSpeedY
    clc 
    adc #$0f
    sta oBall::SubSpeedY
    lda oBall::SpeedY 
    adc #0
    sta oBall::SpeedY
    :

    ; Ball falls off the map
    lda oBall::YPos
    cmp #$F0 
    bcc :+ 
	ldx ManagingObject
	jsr ObjFree
	jmp @ObjectEnd
	:

    ; Collision with player paddle
    lda oBall::Status         ; don't collide with paddle if ball direction is upwards
    and #Ball_YDirection
    beq :+ 
    lda oBall::YPos           ; check if the ball is within the paddle's hitbox
    cmp #$C8
    bcc :+ 
    cmp #$D4 
    bcs :+ 
    lda oBall::XPos       ; load ball X position
    cmp oBall::plXPos
    bcc :+ 
    cmp oBall::plLimitX
    bcs :+ 
    sec                     ; subtract ball X position with the paddle's center position
    sbc oBall::plMiddleX  
    sta oBall::HitPoint
    bpl @Ball_RightCol              ; ball is on the right side of the paddle
    ; left side collision
    lda oBall::Status     ; force ball X and Y direction bit clear (go left, up)
    and #%11111001
    sta oBall::Status
    lda oBall::HitPoint       ; load relative ball collision position
    jsr InvertSign          ; convert to a positive value
    bpl @Ball_SetSpeed
    @Ball_RightCol:
    lda oBall::Status     
    ora #%00000100      ; force ball X direction bit set (go right)
    and #%11111101      ; force ball Y direction bit clear (go up)
    sta oBall::Status
    lda oBall::HitPoint
    @Ball_SetSpeed:
    pha 
    lsr A           ; divide by 8
    lsr A 
    lsr A 
    sta oBall::SpeedX     ; store X speed
    pla 
    and #7      ; A mod 8
    tax         ; transfer to index
    lda SubSpeedXTable, X       ; get X sub speed
    sta oBall::SubSpeedX
    lda oBall::SubSpeedY
    clc 
    adc #$0f
    sta oBall::SubSpeedY
    lda oBall::SpeedY 
    adc #0
    sta oBall::SpeedY
    :

    @UpdateBallSpritePosition:
        jsr GetSpriteIndex
        tax 
        ; y position 
        lda oBall::YPos
        sta $200, X 

        ; sprite tile
        lda #3
        sta $201, X 

        ; attributes
        lda #1
        sta $202, X 

        ; x position
        lda oBall::XPos
        sec 
        sbc #4
        sta $203, X 

        lda #1
        sta oBall::sprite_size

        

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
