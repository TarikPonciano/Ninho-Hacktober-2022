; Module command macros
; Note (2 bytes: note, length) $00-$60
.macro note val, len
    .byte val           ; note value
    .ifnblank   len     ; check if length byte is included
        .byte len 
    .endif
.endmacro

; Volume ($80-$8F)
.macro vol val, len 
    .byte $80 + val
    .ifnblank len 
        .byte len 
    .endif 
.endmacro

; Instrument (2 bytes: opcode, value) $90
.macro inst val, len
    .byte $90, val
    .ifnblank len
        .byte len
    .endif
.endmacro

; Fixed Length $91
.macro fix_length val
    .byte $91, val 
.endmacro 

; Duty $92
.macro duty val, len
    .byte $92, val 
    .ifnblank len
        .byte len 
    .endif
.endmacro

; Transpose $93
.macro trans val, len 
    .byte $93, val
    .ifnblank len 
        .byte len
    .endif 
.endmacro 

; End row test $C0 + length
.macro end_row_test len 
    ; %11LLLLLL = L = Length (max of 64 ($3F))
    .byte $C0+len 
.endmacro 

; ; End row (length) $FF
; .macro end_row len 
;     .byte $FF 
;     .ifnblank len 
;         .byte len 
;     .endif 
; .endmacro

; store zero (no reason to use this)
.macro stz addr 
    pha 
    lda #0
    sta addr 
    pla 
.endmacro 