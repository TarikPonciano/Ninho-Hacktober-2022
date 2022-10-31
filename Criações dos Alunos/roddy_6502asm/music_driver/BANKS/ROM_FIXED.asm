.segment "PRG_FIXED"

    ; Fixed bank $E000
    .include "init_code.asm"

    ; Controller polling code 
    .include "controller.asm" 



    NMI:
    ; Store register contents into the stack.
    pha 
    txa     ; X register
    pha 
    tya     ; Y register
    pha 

    ; Trigger Sprite OAM DMA
    lda #$00
    sta OAMADDR
    lda #$02
    sta OAMDMA

    lda #$00
    sta Frame_Done
    sta PPUSCROLL
    sta PPUSCROLL

    ; Enable sprite and background rendering (this also fixes the scrolling problem):
    lda #%00011110
    sta PPUMASK

    ldy #$11
    ldx #$29
    ; ldy #$04
    ; ldx #$8E
    @CounterX:
    dex 
    bne @CounterX
    dey 
    bne @CounterX

    ; Restore register contents:
    pla                      
    tay                      
    pla                      
    tax                      
    pla 
                  
    rti 