;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ; RMD version 1.1
    ; Written by Roddy
    ; Last Update: May 10, 2022
    ; twitch.tv/roddydev

    ; Update notes:
    ; This is more of a complete rewrite of the driver. The first version of the driver 
    ; was actually my first time ever coding in 6502 ASM. It's been over a year since I started, so
    ; since I got more skilled (I think), I can write a cleaner code while optimizing the most of it.
    ; I still have a ton to learn how to use ca65 Assembler, I'm not even using 10% of it's power.

    ; The major update here is SFX support.

    ; TODO: Add SFX support

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.include "vars.asm"

RMD_BEGIN:          ; MUSIC DRIVER BEGIN
; Change selected BGM ID when LEFT is pressed
lda Button_Left_HoldTimer
cmp #1
bne :+ 
lda Current_SongID
beq :+ 
dec Current_SongID
:

; Change selected BGM ID when RIGHT is pressed
lda Button_Right_HoldTimer
cmp #1
bne :+ 
lda Current_SongID
cmp #total_bgm
beq :+ 
inc Current_SongID
:

;test
lda Button_Up_HoldTimer
cmp #1
bne :+ 
    lda PulseA_VibSpeed
    sec 
    adc #0
    sta PulseA_VibSpeed
:

; Load new module if SELECT is pressed
lda Button_Select_HoldTimer 
cmp #1
bne :+ 
inc NewModuleRequest
:

; Play/Pause song is START is pressed
lda Button_Start_HoldTimer 
cmp #1
bne :+ 
eor Song_Playing
sta Song_Playing
bne :+ 
jsr PauseAudioDriver
:

lda Button_B_HoldTimer
cmp #1
bne :+ 
    lda #1 
    sta RequestFrame
:

; vibrato test

lda PulseA_VibCount
clc 
adc PulseA_VibSpeed
sta PulseA_VibCount
lsr A 
lsr A 
lsr A 
lsr A 
tax 
lda VibTable, X 
sta $666

; Start CPU usage meter overlay:
; Note: This meter only counts the CPU usage of the music driver itself.
lda #%11111111      
sta PPUMASK

FakeRMDBegin:
; Check if the driver is requesting a new song:
lda NewModuleRequest
.if debug_mode = 1
    print "debug mode on"
    beq :++ 
    lda ErrorFound
    beq :+ 
    lda #<ErrorMessageClear
    sta General_Pointer
    lda #>ErrorMessageClear
    sta General_Pointer+1
    lda #$22
    sta Draw_StartHi
    lda #$C0
    sta Draw_StartLo
    jsr DrawScreenData
    dec ErrorFound 
:
.else
    beq :+ 
.endif
jsr LoadNewModule
:

; Check if the driver is playing:
lda Song_Playing
bne @DriverPlaying
rts
@DriverPlaying:

.include "music_driver/driver_pulseA.asm"
.include "music_driver/driver_pulseB.asm"
.include "music_driver/driver_tri.asm"
.include "music_driver/driver_noise.asm"

; Rows/frames in this driver doesn't tie to any data. It's only for timing purposes.


; check if speed accumulator reached 900 or greater
lda Speed_Accum+1
ldx Speed_Accum ; check speed accumulator high byte
cpx #$03
bcc @DecreaseCounters
bne @SpeedAccumSubtract
cmp #$84
bcc @DecreaseCounters
@SpeedAccumSubtract:
; subtract speed accumulator by 900
sec 
sbc #$84
sta Speed_Accum+1
txa
sbc #0
sta Speed_Accum
sec 
sbc #$03
sta Speed_Accum

lda RequestFrame        ; check if the tracker is requesting a frame
bne @CheckFrames
lda Current_Row     ; check if the current row reached the end
cmp Total_Rows
beq @CheckFrames    ; if it have, then check frame counter
inc Current_Row
dec PulseA_Length
dec PulseB_Length
dec Tri_Length
dec Noise_Length
jmp @DecreaseCounters
@CheckFrames:
lda Current_Frame   ; check if current frame reached the end
cmp Total_Frames
bne @ModuleNotFinished      ; if it hasn't, only increment frame counter and load new frame
lda #$FF                    ; reset frame counter (it will be rolled back to 0)
sta Current_Frame
@ModuleNotFinished:
inc Current_Frame           ; increment frame counter
jsr Module_LoadFrame        ; load new frame
sta Current_Row     
jmp RMD_PulseA

@DecreaseCounters:
lda Speed_Accum+1
clc 
adc Speed_Adder+1
sta Speed_Accum+1
lda Speed_Accum
adc #0 
sta Speed_Accum
clc
adc Speed_Adder
sta Speed_Accum

; End of driver
rts 

;;;;;;;;;;;;;;;; Functions and value tables ;;;;;;;;;;;;;;;;
LoadNewModule:              ; This should be called only once every new module call.
    jsr ResetAudioDriver        ; reset music driver values
    ldx Current_SongID          ; get selected song ID
    lda MusicModulesLo, X         ; get low-byte module pointer
    sta General_Pointer               ; store to lo-byte module pointer
    lda MusicModulesHi, X         ; get hi-byte module pointer
    sta General_Pointer+1        ; store to hi-byte module pointer

    ; set channel frame pointers
    ldy #0
    @SetFramePointers:
        lda (General_Pointer), Y 
        sta PulseA_FramePointer, Y
        iny 
        cpy #8
        bne @SetFramePointers

    lda (General_Pointer), Y ; get song speed
    sta Song_Speed
    iny 
    lda (General_Pointer), Y ; get song tempo 
    sta Song_Tempo
    jsr GetSpeedAdder
    iny 
    lda (General_Pointer), Y ; get total rows
    sta Total_Rows
    iny 
    lda (General_Pointer), Y ; get total frames
    sta Total_Frames

    jsr Module_LoadFrame        ; get lookup pointers
    rts 

LoadNewInstrument:
    tya         ; store Y register into the stack.
    pha 
    ldy Current_Channel     ; get current processing channel
    ldx PulseA_Instrument, Y    ; get channel instrument
    lda InstrumentNamesLo, X  ; get low byte of the instrument
    sta General_Pointer      ; store into general purpose pointer
    lda InstrumentNamesHi, X  ; load high byte of the instrument
    sta General_Pointer + 1  

    ; WHY DID I HAVE TO MAKE THIS SO DIFFICULT TO MYSELF
    ; disable all envelopes by clearing the channel envelope lookup high byte
    tya                     ; multiply Current_Channel index offset by 2
    asl A 
    tax      
    stx Temp_Word2        ; save offset value for later 
    lda #0
    sta PulseA_Env_Vol_Lookup+1, X
    sta PulseA_Env_Arp_Lookup+1, X
    sta PulseA_Env_Duty_Lookup+1, X

    ; VOLUME ENVELOPE
    tay             ; hey, the accumulator was already 0! :)
    lda (General_Pointer), Y    ; load volume envelope index
    cmp #$FF
    beq :+                      ; skip if envelope is disabled
        tax         ; transfer envelope index
        lda macro_volumeLo, X 
        sta Temp_Word
        lda macro_volumeHi, X 
        sta Temp_Word+1

        ldx Current_Channel 
        lda (Temp_Word), Y ; read length
        sta PulseA_Env_Vol_Length, X 
        iny 
        lda (Temp_Word), Y ; read loop point value
        sta PulseA_Env_Vol_LoopPoint, X 
        iny 
        lda (Temp_Word), Y ; read release point value
        sta PulseA_Env_Vol_ReleasePoint, X 
        iny 

        ldx Temp_Word2        ; read offset value
        lda (Temp_Word), Y ; read lo-byte lookup
        sta PulseA_Env_Vol_Lookup, X 
        iny 
        lda (Temp_Word), Y ; read hi-byte lookup
        sta PulseA_Env_Vol_Lookup+1, X 
    :

    ; ARPEGGIO ENVELOPE
    ldy #1
    lda (General_Pointer), Y    ; load arpeggio envelope index
    cmp #$FF 
    beq :+ 
        tax         ; transfer envelope index
        lda macro_arpeggioLo, X 
        sta Temp_Word
        lda macro_arpeggioHi, X 
        sta Temp_Word+1

        dey     ; reset Y index
        ldx Current_Channel 
        lda (Temp_Word), Y ; read length
        sta PulseA_Env_Arp_Length, X 
        iny 
        lda (Temp_Word), Y ; read loop point value
        sta PulseA_Env_Arp_LoopPoint, X 
        iny 
        lda (Temp_Word), Y ; read release point value
        sta PulseA_Env_Arp_ReleasePoint, X 
        iny 

        ldx Temp_Word2        ; read offset value
        lda (Temp_Word), Y ; read lo-byte lookup
        sta PulseA_Env_Arp_Lookup, X 
        iny 
        lda (Temp_Word), Y ; read hi-byte lookup
        sta PulseA_Env_Arp_Lookup+1, X 
    :

    ; DUTY ENVELOPE
    ldy #4
    lda (General_Pointer), Y    ; load arpeggio envelope index
    cmp #$FF 
    beq :+ 
        tax         ; transfer envelope index
        lda macro_dutyLo, X 
        sta Temp_Word
        lda macro_dutyHi, X 
        sta Temp_Word+1

        ldy #0     ; reset Y index
        ldx Current_Channel 
        lda (Temp_Word), Y ; read length
        sta PulseA_Env_Duty_Length, X 
        iny 
        lda (Temp_Word), Y ; read loop point value
        sta PulseA_Env_Duty_LoopPoint, X 
        iny 
        lda (Temp_Word), Y ; read release point value
        sta PulseA_Env_Duty_ReleasePoint, X 
        iny 

        ldx Temp_Word2        ; read offset value
        lda (Temp_Word), Y ; read lo-byte lookup
        sta PulseA_Env_Duty_Lookup, X 
        iny 
        lda (Temp_Word), Y ; read hi-byte lookup
        sta PulseA_Env_Duty_Lookup+1, X 
    :

    jsr ResetInstrumentEnvelopes
    pla 
    tay     ; restore Y index
    rts 

Module_LoadFrame:
    lda Current_Frame
    asl A 
    tay 

    ; set channel lookup pointers
    lda (PulseA_FramePointer), Y    ; lo-byte frame pointers
    sta PulseA_Lookup
    lda (PulseB_FramePointer), Y
    sta PulseB_Lookup
    lda (Tri_FramePointer), Y 
    sta Tri_Lookup
    lda (Noise_FramePointer), Y   
    sta Noise_Lookup
    iny 
    lda (PulseA_FramePointer), Y    ; hi-byte frame pointers
    sta PulseA_Lookup+1 
    lda (PulseB_FramePointer), Y   
    sta PulseB_Lookup+1 
    lda (Tri_FramePointer), Y   
    sta Tri_Lookup+1 
    lda (Noise_FramePointer), Y  
    sta Noise_Lookup+1 

    lda #0      ; zero out the channel lengths so the driver doesn't delay it by a frame.
    sta PulseA_Length
    sta PulseB_Length
    sta Tri_Length
    sta Noise_Length
    sta RequestFrame
    rts 

ResetInstrumentEnvelopes:       ; this resets the envelope counters
    ldx Current_Channel 
    lda #15
    sta PulseA_InstVol, X
    lda #0
    sta PulseA_VibCount
    sta PulseA_Env_Vol_Counter, X 
    sta PulseA_Env_Arp_Counter, X 
    sta PulseA_Env_Duty_Counter, X 
    rts 

ResetAPU:
    ldx #$0F
    @InitializeAPU:
        ; Read the next anonymous label (where the APU registers are)
        lda :+, X 
        ; Store that value on the respective APU register
        sta $4000, X 
        dex 
        bpl @InitializeAPU 

        ; Return to previous code.
        rts 

    ; APU registers (silent)
    :
        .byte $30, $08, $00, $00
        .byte $30, $08, $00, $00
        .byte $00, $00, $00, $00
        .byte $30, $00, $00, $00

ResetAudioDriver:       ; Resets the APU and clears all music driver variables
    jsr ResetAPU
    lda #0
    tax 
    @Loop:
        sta start_offset, X
        inx 
        cpx #end_offset + 1 
        bne @Loop

    lda #$60
    sta PulseA_BaseNote
    sta PulseB_BaseNote
    sta Tri_BaseNote
    sta Noise_BaseNote

    lda #$0F                    ; set max volume to audio channels
    sta PulseA_ChVol
    sta PulseB_ChVol
    sta Tri_ChVol
    sta Noise_ChVol

    lda #$FF
    sta PulseA_Delay
    sta PulseB_Delay
    sta Tri_Delay
    sta Noise_Delay
    rts 

PauseAudioDriver:
    ldx #0
    stx Song_Playing
    dex 
    stx PulseA_HiFreq_Prev
    stx PulseB_HiFreq_Prev
    stx Tri_HiFreq_Prev
    jsr ResetAPU
    rts 

VolumeMultiplier:
    ; Formula is: index = (ChannelVolume * 16) + InstVolume
    ; Really want to find a better formula for this so I can get rid of the 256-byte table.
    
    ldx Current_Channel
    lda PulseA_ChVol, X 
    asl A   ; move channel volume value to upper nibble
    asl A
    asl A
    asl A
    eor PulseA_InstVol, X    ; insert instrument volume value to lower nibble
    tay 
    lda VolumeTable, Y  ; get new volume
    sta PulseA_FinalVol, X 
    rts 

GetSpeedAdder: 
    lda #0
    sta Speed_Accum
    sta Speed_Accum+1
    lda Song_Tempo
    sta Temp_Word
    lda Song_Speed
    sta Temp_Word+1
    jsr DIV_CALC
    sta MMC5_Multiplicand
    lda #6
    sta MMC5_Multiplier
    lda MMC5_ResHi
    sta Speed_Adder
    lda MMC5_ResLo
    sta Speed_Adder+1
    rts 

.if debug_mode = 1
    DriverErrorHandler:
        ; something is wrong.
        ; this code looks bad af
        ; i think i'm only yet not used to long subroutines.
        inc ErrorFound
        lda #<@DriverErrorMessage
        sta General_Pointer
        lda #>@DriverErrorMessage
        sta General_Pointer+1
        lda #$22
        sta Draw_StartHi
        lda #$C0
        sta Draw_StartLo
        jsr DrawScreenData

        jsr TurnOffScreen
        bit PPUSTATUS 
        lda #$22
        sta PPUADDR
        lda #$E0
        sta PPUADDR
        lda Current_Channel 
        asl A 
        tay 
        lda PulseA_Lookup+1, Y 
        jsr CorrectDisplayTile
        lda PulseA_Lookup, Y 
        jsr CorrectDisplayTile
        bit PPUSTATUS 
        lda #$22
        sta PPUADDR
        lda #$F5
        sta PPUADDR
        lda ReturnedOpcode
        jsr CorrectDisplayTile
        bit PPUSTATUS 
        lda #$23
        sta PPUADDR
        lda #$08
        sta PPUADDR
        lda Current_Channel
        sta PPUDATA
        jsr TurnOnScreen

        rts 

        @DriverErrorMessage:
            .byte "!!!ERROR!!! I screwed up.", $FF, 12, "returned opcode XX", $FF, 9, "Channel", $FF, $FF 
        

    ErrorMessageClear:
        .byte $FF, $60, $FF, $FF 
.endif

; tables

; vibrato table
VibTable:
    .byte $00, $FE, $FC, $FA, $F8, $FA, $FC, $FE, $00, $02, $04, $06, $08, $06, $04, $02

VolumeTable:        ; 256 bytes volume table........
    .byte $0, $0, $0, $0, $0, $0, $0, $0, $0, $0, $0, $0, $0, $0, $0, $0
	.byte $0, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1
	.byte $0, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1, $2
	.byte $0, $1, $1, $1, $1, $1, $1, $1, $1, $1, $2, $2, $2, $2, $2, $3
	.byte $0, $1, $1, $1, $1, $1, $1, $1, $2, $2, $2, $2, $3, $3, $3, $4
	.byte $0, $1, $1, $1, $1, $1, $2, $2, $2, $3, $3, $3, $4, $4, $4, $5
	.byte $0, $1, $1, $1, $1, $2, $2, $2, $3, $3, $4, $4, $4, $5, $5, $6
	.byte $0, $1, $1, $1, $1, $2, $2, $3, $3, $4, $4, $5, $5, $6, $6, $7
	.byte $0, $1, $1, $1, $2, $2, $3, $3, $4, $4, $5, $5, $6, $6, $7, $8
	.byte $0, $1, $1, $1, $2, $3, $3, $4, $4, $5, $6, $6, $7, $7, $8, $9
	.byte $0, $1, $1, $2, $2, $3, $4, $4, $5, $6, $6, $7, $8, $8, $9, $A
	.byte $0, $1, $1, $2, $2, $3, $4, $5, $5, $6, $7, $8, $8, $9, $A, $B
	.byte $0, $1, $1, $2, $3, $4, $4, $5, $6, $7, $8, $8, $9, $A, $B, $C
	.byte $0, $1, $1, $2, $3, $4, $5, $6, $6, $7, $8, $9, $A, $B, $C, $D
	.byte $0, $1, $1, $2, $3, $4, $5, $6, $7, $8, $9, $A, $B, $C, $D, $E
	.byte $0, $1, $2, $3, $4, $5, $6, $7, $8, $9, $A, $B, $C, $D, $E, $F

; Note frequencies.
APUFreqLo:
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $F1, $7F, $13    ; OCTAVE 0
    .byte $AD, $4D, $F3, $9D, $4C, $00, $B8, $74, $34, $F8, $BF, $89    ; OCTAVE 1
    .byte $56, $26, $F9, $CE, $A6, $80, $5C, $3A, $1A, $FB, $DF, $C4    ; OCTAVE 2
    .byte $AB, $93, $7C, $67, $52, $3F, $2D, $1C, $0C, $FD, $EF, $E1    ; OCTAVE 3
    .byte $D5, $C9, $BD, $B3, $A9, $9F, $96, $8E, $86, $7E, $77, $70    ; OCTAVE 4
    .byte $6A, $64, $5E, $59, $54, $4F, $4B, $46, $42, $3F, $3B, $38    ; OCTAVE 5
    .byte $34, $31, $2F, $2C, $29, $27, $25, $23, $21, $1F, $1D, $1B    ; OCTAVE 6
    .byte $1A, $18, $17, $15, $14, $13, $12, $11, $10, $0F, $0E, $0D    ; OCTAVE 7
    .byte $00 

APUFreqHi:
    .byte $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F    ; OCTAVE 0
    .byte $0E, $0E, $0D, $0D, $0D, $0D, $0C, $0C, $0C, $0B, $0B, $0B    ; OCTAVE 1
    .byte $0B, $0B, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $09, $09, $09    ; OCTAVE 2
    .byte $09, $09, $09, $09, $09, $09, $09, $09, $09, $08, $08, $08    ; OCTAVE 3
    .byte $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08    ; OCTAVE 4
    .byte $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08    ; OCTAVE 5
    .byte $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08    ; OCTAVE 6
    .byte $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08    ; OCTAVE 7
    .byte $00

RMD_END:                ; MUSIC DRIVER END