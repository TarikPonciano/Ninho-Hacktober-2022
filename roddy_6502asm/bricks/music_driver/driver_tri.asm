; ; IT IS STILL NOT DONE!!!!! ;
; ;jmp RMD_Tri


RMD_Tri:
lda #2
sta Current_Channel     ; currently managing channel 0 (Pulse A)

ldy #$FF 

lda Tri_Length   ; check length before new command
beq @DoTheThing
jmp @Driver_ManageEnvelopes      ; skip over if it's not the time.

@DoTheThing:
iny         ; increase read index
; read data
lda (Tri_Lookup), Y  

bmi @DriverCommands     ; $80-$FF are reserved for driver commands
sta Tri_BaseNote    ; store final note      (CHANGE THIS TO BaseNote LATER!!!!!)
jsr ResetInstrumentEnvelopes    ; reset envelope counters
bpl @DoTheThing


@DriverCommands:
; End row (length) $C0-$FF
cmp #end_row
bcc :+ 
    and #$3F
    sta Tri_Length
    jmp @Driver_SetLookup
:

; ($80-8F) Volume
cmp #inst    ; check if read data is less than $90
bcs :+ 
    and #%00001111      ; mask off the upper nibble
    sta Tri_ChVol    ; store into channel volume
    jmp @DoTheThing
:

; ($90) Instrument
bne :+ 
    iny 
    lda (Tri_Lookup), Y  ; read instrument ID
    sta Tri_Instrument   ; store into channel instrument
    jsr LoadNewInstrument   ; start loading new instrument
    jmp @DoTheThing
:

; ($92) Delay note
cmp #delay 
bne :+ 
    iny 
    lda (Tri_Lookup), Y 
    sta Tri_Delay
    ; jmp @Driver_SetLookup
    jmp @DoTheThing
:

; ($93) Transpose
cmp #trans 
bne :+ 
    iny 
    lda (Tri_Lookup), Y 
    sta Tri_Trans
    jmp @DoTheThing
:

;($94) Vibrato (TODO)
cmp #vib 
bne :+ 
    iny 
    ; lda (Tri_Lookup), Y 
    ; pha 
    ; and #%11110000
    ; sta Tri_VibratoSpeed
    ; pla
    ; and #%00001111
    ; sta Tri_VibratoDepth
    jmp @DoTheThing
:

;($95) Skip frame
cmp #skip
bne :+ 
    lda #1
    sta RequestFrame
    bne @Driver_ManageEnvelopes
:

; ($96) Sweep up (TODO)
cmp #swup
bne :+ 
    iny 
    jmp @DoTheThing
:

; ($97) Sweep down (TODO)
cmp #swdn
bne :+ 
    iny 
    jmp @DoTheThing
:

; ($98) Automatic Portamento (TODO)
cmp #port
bne :+ 
    iny 
    jmp @DoTheThing
:

; ($99) Slide up (TODO)
cmp #slup 
bne :+ 
    iny 
    jmp @DoTheThing
:

; ($9A) Slide down (TODO)
cmp #sldn 
bne :+ 
    iny 
    jmp @DoTheThing
:

; it read none of these... oops.
jsr PauseAudioDriver ; pause driver
rts     ; quit driver

; setup new lookup address.
@Driver_SetLookup:
iny 
tya         ; transfer final read index to accumulator
clc
adc Tri_Lookup       ; add that with the low-byte of lookup address
sta Tri_Lookup
lda Tri_Lookup+1     ; now read the high-byte
adc #0                  ; if the low-byte value has rolled over, the carry bit will be set. 1 will be added to the accumulator if so.
sta Tri_Lookup+1     ; store new high-byte





@Driver_ManageEnvelopes:
lda Tri_Delay
beq :+ 
    dec Tri_Delay
:

lda Tri_BaseNote
cmp #stop 
bne :+ 
lda #$00
sta Tri_DutyVol
jmp RMD_Noise
:
sta Tri_FinalNote

; envelopes...
; volume envelope
; check if volume envelope is active
lda Tri_Env_Vol_Lookup+1 
beq :++ 
    ldy Tri_Env_Vol_Counter
    lda (Tri_Env_Vol_Lookup), Y 
    sta Tri_InstVol
    cpy Tri_Env_Vol_Length
    bne :+ 
        ldy Tri_Env_Vol_LoopPoint
        dey 
        sty Tri_Env_Vol_Counter
    :
    inc Tri_Env_Vol_Counter
:
jsr VolumeMultiplier


; arpeggio envelope
lda Tri_BaseNote
ldx Tri_Env_Arp_Lookup+1 
beq :++ 
    ldy Tri_Env_Arp_Counter
    clc 
    adc (Tri_Env_Arp_Lookup), Y 
    cpy Tri_Env_Arp_Length
    bne :+ 
        ldy Tri_Env_Arp_LoopPoint
        dey 
        sty Tri_Env_Arp_Counter
    :
    inc Tri_Env_Arp_Counter
:
sta Tri_FinalNote

; duty envelope
lda Tri_Env_Duty_Lookup+1 
beq :++ 
    ldy Tri_Env_Duty_Counter
    lda (Tri_Env_Duty_Lookup), Y
    sta Tri_Duty
    cpy Tri_Env_Duty_Length
    bne :+ 
        ldy Tri_Env_Duty_LoopPoint
        dey 
        sty Tri_Env_Duty_Counter
    :
    inc Tri_Env_Duty_Counter
:

@Driver_LastStep:
lda Tri_FinalNote
clc 
adc Tri_Trans
@SetFrequency:
sta Tri_FinalNote
tax 
lda APUFreqHi, X
sta Tri_HiFreq
lda APUFreqLo, X 
sta Tri_LoFreq

; Read volume
lda Tri_FinalVol
; Check if volume is zero, skip if it isn't.
bne :+
lda #$00
beq :++ 
:
lda #$FF
:
sta Tri_DutyVol




; only store new high frequency when it actually changes.
; it produces a click everytime it's written to $4003/$4007
lda Tri_HiFreq
cmp Tri_HiFreq_Prev
beq :+ 
sta Tri_HiFreq_Prev      
sta Tri_APUHiFreq
:

lda Tri_LoFreq
sta Tri_APULoFreq
