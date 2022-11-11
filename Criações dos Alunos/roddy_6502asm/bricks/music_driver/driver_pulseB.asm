; IT IS STILL NOT DONE!!!!! ;
;jmp RMD_PulseB


RMD_PulseB:
lda #1
sta Current_Channel     ; currently managing channel 1 (Pulse B)

ldy #$FF 
lda PulseB_Delay
bne :+ 
    ; store real lookup to temp area
    lda PulseB_Lookup
    sta Temp_Word3
    lda PulseB_Lookup+1
    sta Temp_Word3+1
    lda #<PulseB_DelayBuffer
    sta PulseB_Lookup
    lda #>PulseB_DelayBuffer
    sta PulseB_Lookup+1
    jmp @DoTheThing
:

lda PulseB_Length   ; check length before new command
beq @DoTheThing
jmp @Driver_ManageEnvelopes      ; skip over if it's not the time.

@DoTheThing:
iny         ; increase read index
; read data
lda (PulseB_Lookup), Y 

bmi @DriverCommands     ; $80-$FF are reserved for driver commands
sta PulseB_BaseNote    ; store initial note
jsr ResetInstrumentEnvelopes    ; reset envelope counters
bpl @DoTheThing


@DriverCommands:
; End row (length) $C0-$FF
cmp #end_row
bcc :++
    ldx PulseB_Delay
    bne :+ 
        lda Temp_Word3+1
        sta PulseB_Lookup+1
        lda Temp_Word3
        sta PulseB_Lookup
        jmp @Driver_ManageEnvelopes
    :
    and #$3F
    sta PulseB_Length
    jmp @Driver_SetLookup
:

; ($B0-$B3) Duty
cmp #duty
bcc :+ 
    and #3
    sta PulseB_Duty
    jmp @DoTheThing
:

; ($80-8F) Volume
cmp #inst    ; check if read data is less than $90
bcs :+ 
    and #%00001111      ; mask off the upper nibble
    sta PulseB_ChVol    ; store into channel volume
    jmp @DoTheThing
:

; ($90) Instrument
bne :+ 
    iny 
    lda (PulseB_Lookup), Y  ; read instrument ID
    sta PulseB_Instrument   ; store into channel instrument
    jsr LoadNewInstrument   ; start loading new instrument
    jmp @DoTheThing
:

; ($92) Delay note
cmp #delay 
bne :+ 
    iny 
    lda (PulseB_Lookup), Y 
    sta PulseB_Delay
    jmp @WriteDelayBuffer
    ; jmp @Driver_SetLookup
    ; jmp @DoTheThing
:

; ($93) Transpose
cmp #trans 
bne :+ 
    iny 
    lda (PulseB_Lookup), Y 
    sta PulseB_Trans
    jmp @DoTheThing
:

;($94) Vibrato (TODO)
cmp #vib 
bne :+ 
    iny 
    ; lda (PulseB_Lookup), Y 
    ; pha 
    ; and #%11110000
    ; lsr A 
    ; lsr A 
    ; lsr A 
    ; lsr A 
    ; sta PulseB_VibratoSpeed
    ; pla
    ; and #%00001111
    ; sta PulseB_VibratoDepth
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
sta ReturnedOpcode
jsr PauseAudioDriver ; pause driver
rts     ; quit driver

@WriteDelayBuffer:
    ldx #0
    @Loop:
        iny 
        lda (PulseB_Lookup), Y 
        sta PulseB_DelayBuffer, X 
        cmp #end_row 
        bcc :+
            and #$3F
            sta PulseB_Length
            jmp @Driver_SetLookup
        :
        inx 
        bne @Loop

; setup new lookup address.
@Driver_SetLookup:
iny 
tya         ; transfer final read index to accumulator
clc
adc PulseB_Lookup       ; add that with the low-byte of lookup address
sta PulseB_Lookup
lda PulseB_Lookup+1     ; now read the high-byte
adc #0                  ; if the low-byte value has rolled over, the carry bit will be set. 1 will be added to the accumulator if so.
sta PulseB_Lookup+1     ; store new high-byte

@Driver_ManageEnvelopes:
lda PulseB_Delay
bmi :+ 
    dec PulseB_Delay
:
lda PulseB_BaseNote
cmp #stop 
bne :+ 
lda #$30
sta PulseB_DutyVol
jmp RMD_Tri
:
sta PulseB_FinalNote

; envelopes...
; volume envelope
; check if volume envelope is active
lda PulseB_Env_Vol_Lookup+1 
beq :++ 
    ldy PulseB_Env_Vol_Counter
    lda (PulseB_Env_Vol_Lookup), Y 
    sta PulseB_InstVol
    cpy PulseB_Env_Vol_Length
    bne :+ 
        ldy PulseB_Env_Vol_LoopPoint
        dey 
        sty PulseB_Env_Vol_Counter
    :
    inc PulseB_Env_Vol_Counter
:
jsr VolumeMultiplier


; arpeggio envelope
lda PulseB_BaseNote
ldx PulseB_Env_Arp_Lookup+1 
beq :++ 
    ldy PulseB_Env_Arp_Counter
    clc 
    adc (PulseB_Env_Arp_Lookup), Y 
    cpy PulseB_Env_Arp_Length
    bne :+ 
        ldy PulseB_Env_Arp_LoopPoint
        dey 
        sty PulseB_Env_Arp_Counter
    :
    inc PulseB_Env_Arp_Counter
:
sta PulseB_FinalNote

; duty envelope
lda PulseB_Env_Duty_Lookup+1 
beq :++ 
    ldy PulseB_Env_Duty_Counter
    lda (PulseB_Env_Duty_Lookup), Y
    sta PulseB_Duty
    cpy PulseB_Env_Duty_Length
    bne :+ 
        ldy PulseB_Env_Duty_LoopPoint
        dey 
        sty PulseB_Env_Duty_Counter
    :
    inc PulseB_Env_Duty_Counter
:

@Driver_LastStep:
lda PulseB_FinalNote
clc 
adc PulseB_Trans
@SetFrequency:
sta PulseB_FinalNote
tax 
lda APUFreqHi, X
sta PulseB_HiFreq
lda APUFreqLo, X 
sta PulseB_LoFreq

lda PulseB_Duty     ; roll duty cycle bits to bit 7 and 6
lsr A 
ror A 
ror A 
eor #%00110000      ; insert constant volume flag
eor PulseB_FinalVol
sta PulseB_DutyVol


; only store new high frequency when it actually changes.
; it produces a click everytime it's written to $4003/$4007
lda PulseB_HiFreq
cmp PulseB_HiFreq_Prev
beq :+ 
sta PulseB_HiFreq_Prev      
sta PulseB_APUHiFreq
:

lda PulseB_LoFreq
sta PulseB_APULoFreq
