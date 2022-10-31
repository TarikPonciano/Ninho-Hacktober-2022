.SEGMENT "PRG_FIXED"
    .include "init_code.asm"

NMI:
    ; Store register contents to the stack.
    ; Accumulator
    pha 
    txa     ; X register
    pha 
    tya     ; Y register
    pha 

    ; Trigger Sprite OAM DMA
    ldx #$00
    stx OAMADDR
    lda #$02
    sta OAMDMA

    ; If Frame_Done returns a 1, congratulations! You finished a frame without lag!
    lda Frame_Done
    bne :+ 
    inc Lag_Frames
    bne :+ 
    inc Lag_Frames+1 
    : 

    stx Frame_Done
    stx PPUSCROLL
    stx PPUSCROLL

    ; Enable sprite and background rendering (this also fixes the scrolling problem):
    lda #%00011110
    sta PPUMASK

    ;ldx #$2D
    ;ldy #$03
    ;@Counter:
    ;    dex 
    ;    bne @Counter
    ;    dey 
    ;    bne @Counter

    ; Restore register contents:
    pla                      
    tay                      
    pla                      
    tax                      
    pla 
                  
    rti 