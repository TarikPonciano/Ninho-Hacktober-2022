; IT IS STILL NOT DONE!!!!! ;
;jmp RMD_PulseA


RMD_PulseA:
ldy #0
sty Current_Channel     ; currently managing channel 0 (Pulse A)
dey         ; reset read index

lda PulseA_Length   ; check length before new command
beq @DoTheThing
jmp @Driver_ManageEnvelopes      ; skip over if it's not the time.

@DoTheThing:
iny         ; increase read index
; read data
lda (PulseA_Lookup), Y 

bmi @DriverCommands     ; $80-$FF are reserved for driver commands
sta PulseA_BaseNote    ; store final note      (CHANGE THIS TO BaseNote LATER!!!!!)
jsr ResetInstrumentEnvelopes    ; reset envelope counters
bpl @DoTheThing


@DriverCommands:
; End row (length) $C0-$FF
cmp #end_row
bcc :+ 
    and #$3F
    sta PulseA_Length
    jmp @Driver_SetLookup
:

; ($B0-$B3) Duty
cmp #duty
bcc :+ 
    and #3
    sta PulseA_Duty
    jmp @DoTheThing
:

; ($80-8F) Volume
cmp #inst    ; check if read data is less than $90
bcs :+ 
    and #$0F            ; mask off the upper nibble
    sta PulseA_ChVol    ; store into channel volume
    jmp @DoTheThing
:

; ($90) Instrument
bne :+ 
    iny 
    lda (PulseA_Lookup), Y  ; read instrument ID
    sta PulseA_Instrument   ; store into channel instrument
    jsr LoadNewInstrument   ; start loading new instrument
    jmp @DoTheThing
:

; ($92) Delay note
cmp #delay
bne :+ 
    iny 
    lda (PulseA_Lookup), Y 
    sta PulseA_Delay
    jmp @DoTheThing
:

; ($93) Transpose
cmp #trans
bne :+ 
    iny 
    lda (PulseA_Lookup), Y 
    sta PulseA_Trans
    jmp @DoTheThing
:

;($94) Vibrato(TODO)
cmp #vib
bne :+ 
    iny 
    ; lda (PulseA_Lookup), Y 
    ; pha 
    ; and #%11110000
    ; sta PulseA_VibratoSpeed
    ; pla
    ; and #%00001111
    ; sta PulseA_VibratoDepth
    jmp @DoTheThing
:

;($95) Skip frame
cmp #skip
bne :+ 
    lda #1
    sta RequestFrame
    bne @Driver_ManageEnvelopes
:

; ($96) Sweep up(TODO)
cmp #swup
bne :+ 
    iny 
    jmp @DoTheThing
:

; ($97) Sweep down(TODO)
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

@Driver_SetLookup:
iny 
; setup new lookup address.
tya         ; transfer final read index to accumulator
clc
adc PulseA_Lookup       ; add that with the low-byte of lookup address
sta PulseA_Lookup
lda PulseA_Lookup+1     ; now read the high-byte
adc #0                  ; if the low-byte value has rolled over, the carry bit will be set. 1 will be added to the accumulator if so.
sta PulseA_Lookup+1     ; store new high-byte





@Driver_ManageEnvelopes:
lda PulseA_Delay    ; check delay
beq :+ 
    dec PulseA_Delay
:
lda PulseA_BaseNote
cmp #stop 
bne :+ 
lda #$30
sta PulseA_DutyVol
jmp RMD_PulseB
:

; envelopes...
; volume envelope
; check if volume envelope is active
lda PulseA_Env_Vol_Lookup+1 
beq :++ 
    ldy PulseA_Env_Vol_Counter
    lda (PulseA_Env_Vol_Lookup), Y 
    sta PulseA_InstVol
    cpy PulseA_Env_Vol_Length
    bne :+ 
        ldy PulseA_Env_Vol_LoopPoint
        dey 
        sty PulseA_Env_Vol_Counter
    :
    inc PulseA_Env_Vol_Counter
:
jsr VolumeMultiplier


; arpeggio envelope
lda PulseA_BaseNote
ldx PulseA_Env_Arp_Lookup+1 
beq :++ 
    ldy PulseA_Env_Arp_Counter
    clc 
    adc (PulseA_Env_Arp_Lookup), Y 
    cpy PulseA_Env_Arp_Length
    bne :+ 
        ldy PulseA_Env_Arp_LoopPoint
        dey 
        sty PulseA_Env_Arp_Counter
    :
    inc PulseA_Env_Arp_Counter
:
sta PulseA_FinalNote

; duty envelope
lda PulseA_Env_Duty_Lookup+1 
beq :++ 
    ldy PulseA_Env_Duty_Counter
    sty PulseA_Duty
    cpy PulseA_Env_Duty_Length
    bne :+ 
        ldy PulseA_Env_Duty_LoopPoint
        dey 
        sty PulseA_Env_Duty_Counter
    :
    inc PulseA_Env_Duty_Counter
:

@Driver_LastStep:
lda PulseA_FinalNote
clc 
adc PulseA_Trans
@SetFrequency:
sta PulseA_FinalNote
tax 
lda APUFreqHi, X
sta PulseA_HiFreq
lda APUFreqLo, X 
sta PulseA_LoFreq

lda PulseA_Duty     ; roll duty cycle bits to bit 7 and 6
lsr A 
ror A 
ror A 
eor #%00110000      ; insert constant volume flag
eor PulseA_FinalVol
sta PulseA_DutyVol


; only store new high frequency when it actually changes.
; it produces a click everytime it's written to $4003/$4007
lda PulseA_HiFreq
cmp PulseA_HiFreq_Prev
beq :+ 
sta PulseA_HiFreq_Prev      
sta PulseA_APUHiFreq
:

lda PulseA_LoFreq
sta PulseA_APULoFreq
