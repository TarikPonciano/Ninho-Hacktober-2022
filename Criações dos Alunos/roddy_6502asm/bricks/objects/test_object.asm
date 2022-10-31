; load routine:
;   if X == 0 {
;       if Y != 0 {
;           reg X = X - 1;
;           reg Y = Y - 1;
; 		    hiPointer++;
;       } else {
;           doneLoading();
;       }
;   }

; test_object:
; lda #<test_object_end
; sec 
; sbc #<test_object_begin
; tax 
; lda #>test_object_end
; sec 
; sbc #>test_object_begin
; tay 


; @CopyLoop:
;     beq @CopyDone
;     lda test_object_begin, X 
;     sta $6000, X
;     dex 
;     jmp @CopyLoop
;     @CopyDone:



test_object:
    .enum oTest
        created = obj_tempRAM + $0
        xpos    = obj_tempRAM + $1 
        sprite_size = obj_tempRAM + $f
    .endenum

    ; create event
    ldy oTest::created 
    bne :+ 
        ;; set x position
        lda #$E0 
        sta oTest::xpos 
        ;; create event done. do not repeat this code
        inc oTest::created 
    :

    ; move the object to the left
    lda oTest::xpos 
    sec 
    sbc #1
    sta oTest::xpos
    ; check if object has reached the left side of the screen
    bne :+ 
        ldx ManagingObject
        jsr ObjFree
        jmp @ObjectEnd
    : 

    ;; get sprite indexing
    jsr GetSpriteIndex
    tax 

    ;; manage sprite
    ;; y position
    lda #$40
    sta $200, X 

    ;; sprite tile
    lda #4
    sta $201, X 

    ;; attributes
    lda #0
    sta $202, X 

    ;; x position
    lda oTest::xpos 
    sta $203, X 

    ; set sprite size
    lda #1
    sta oTest::sprite_size 

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
test_object_end: