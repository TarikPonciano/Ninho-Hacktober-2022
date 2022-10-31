; PPU memory addresses
    PPUCTRL = $2000
    PPUMASK = $2001
    PPUSTATUS = $2002 ; Reading this resets VBlank flag and the address latch for PPUSCROLL and PPUADDR
    OAMADDR = $2003
    OAMDATA = $2004
    PPUSCROLL = $2005 ; two writes: X scroll, Y scroll
    PPUADDR = $2006 ; two writes: most significant byte, least significant byte
    PPUDATA = $2007
    OAMDMA = $4014

; MMC5 registers
MMC5_PRGMode = $5100
MMC5_BANK0 = $5114
MMC5_BANK1 = $5115
MMC5_BANK2 = $5116
MMC5_BANK3 = $5117
MMC5_Multiplicand = $5205 
MMC5_Multiplier = $5206 
MMC5_ResLo = $5205
MMC5_ResHi = $5206

; MUSIC DRIVER
; Driver and Data Sizes for display:
Music_Driver_Size_Hi = $110
Music_Driver_Size_Lo = $111
Music_Data_Size_Hi = $112
Music_Data_Size_Lo = $113

; system regio
System_Region = $6FF

; these must be in zeropage (usually pointers)
.org $0000
Frame_Done: .res 1
PulseA_Lookup: .res 2    ;word
PulseB_Lookup: .res 2
Tri_Lookup: .res 2
Noise_Lookup: .res 2

PulseA_Env_Vol_Lookup: .res 2
PulseB_Env_Vol_Lookup: .res 2
Tri_Env_Vol_Lookup: .res 2
Noise_Env_Vol_Lookup: .res 2

PulseA_Env_Arp_Lookup: .res 2
PulseB_Env_Arp_Lookup: .res 2
Tri_Env_Arp_Lookup: .res 2
Noise_Env_Arp_Lookup: .res 2

PulseA_Env_Duty_Lookup: .res 2
PulseB_Env_Duty_Lookup: .res 2
Tri_Env_Duty_Lookup: .res 2
Noise_Env_Duty_Lookup: .res 2

PulseA_FramePointer: .res 2
PulseB_FramePointer: .res 2
Tri_FramePointer: .res 2
Noise_FramePointer: .res 2

PulseA_SFX_Lookup: .res 2
PulseB_SFX_Lookup: .res 2
Tri_SFX_Lookup: .res 2
Noise_SFX_Lookup: .res 2

General_Pointer: .res 2      ; make sure this is reusable
Temp_Word: .res 2
Temp_Word2: .res 2
Temp_Word3: .res 1
Multiplicand: .res 1
Multiplier: .res 1

; Variables and Constants
; .if driver_on_zp = 0
;     start_offset = $0700
;     .org start_offset 
; .else 
;     start_offset = Multiplier+1 
; .endif 

;end_labels

; Hardware registers.
PulseA_DutyVol = $4000
PulseA_APULoFreq = $4002
PulseA_APUHiFreq = $4003

PulseB_DutyVol = $4004
PulseB_APULoFreq = $4006
PulseB_APUHiFreq = $4007

Tri_DutyVol = $4008
Tri_APULoFreq = $400A
Tri_APUHiFreq = $400B

Noise_DutyVol = $400C
Noise_Freq = $400E

; NOTES

C0 = (00 * 12)
C1 = (01 * 12)
C2 = (02 * 12)
C3 = (03 * 12)
C4 = (04 * 12)
C5 = (05 * 12)
C6 = (06 * 12)
C7 = (07 * 12)
Cd0 = (00 * 12) + 1
Cd1 = (01 * 12) + 1
Cd2 = (02 * 12) + 1
Cd3 = (03 * 12) + 1
Cd4 = (04 * 12) + 1
Cd5 = (05 * 12) + 1
Cd6 = (06 * 12) + 1
Cd7 = (07 * 12) + 1
D0 = (00 * 12) + 2
D1 = (01 * 12) + 2
D2 = (02 * 12) + 2
D3 = (03 * 12) + 2
D4 = (04 * 12) + 2
D5 = (05 * 12) + 2
D6 = (06 * 12) + 2
D7 = (07 * 12) + 2
Dd0 = (00 * 12) + 3
Dd1 = (01 * 12) + 3
Dd2 = (02 * 12) + 3
Dd3 = (03 * 12) + 3
Dd4 = (04 * 12) + 3
Dd5 = (05 * 12) + 3
Dd6 = (06 * 12) + 3
Dd7 = (07 * 12) + 3
E0 = (00 * 12) + 4
E1 = (01 * 12) + 4
E2 = (02 * 12) + 4
E3 = (03 * 12) + 4
E4 = (04 * 12) + 4
E5 = (05 * 12) + 4
E6 = (06 * 12) + 4
E7 = (07 * 12) + 4
F0 = (00 * 12) + 5
F1 = (01 * 12) + 5
F2 = (02 * 12) + 5
F3 = (03 * 12) + 5
F4 = (04 * 12) + 5
F5 = (05 * 12) + 5
F6 = (06 * 12) + 5
F7 = (07 * 12) + 5
Fd0 = (00 * 12) + 6
Fd1 = (01 * 12) + 6
Fd2 = (02 * 12) + 6
Fd3 = (03 * 12) + 6
Fd4 = (04 * 12) + 6
Fd5 = (05 * 12) + 6
Fd6 = (06 * 12) + 6
Fd7 = (07 * 12) + 6
G0 = (00 * 12) + 7
G1 = (01 * 12) + 7
G2 = (02 * 12) + 7
G3 = (03 * 12) + 7
G4 = (04 * 12) + 7
G5 = (05 * 12) + 7
G6 = (06 * 12) + 7
G7 = (07 * 12) + 7
Gd0 = (00 * 12) + 8
Gd1 = (01 * 12) + 8
Gd2 = (02 * 12) + 8
Gd3 = (03 * 12) + 8
Gd4 = (04 * 12) + 8
Gd5 = (05 * 12) + 8
Gd6 = (06 * 12) + 8
Gd7 = (07 * 12) + 8
A0 = (00 * 12) + 9
A1 = (01 * 12) + 9
A2 = (02 * 12) + 9
A3 = (03 * 12) + 9
A4 = (04 * 12) + 9
A5 = (05 * 12) + 9
A6 = (06 * 12) + 9
A7 = (07 * 12) + 9
Ad0 = (00 * 12) + 10
Ad1 = (01 * 12) + 10
Ad2 = (02 * 12) + 10
Ad3 = (03 * 12) + 10
Ad4 = (04 * 12) + 10
Ad5 = (05 * 12) + 10
Ad6 = (06 * 12) + 10
Ad7 = (07 * 12) + 10
B0 = (00 * 12) + 11
B1 = (01 * 12) + 11
B2 = (02 * 12) + 11
B3 = (03 * 12) + 11
B4 = (04 * 12) + 11
B5 = (05 * 12) + 11
B6 = (06 * 12) + 11
B7 = (07 * 12) + 11     ; $5F
stop = $60              ; note stop value

; noise notes
N0 = $F
N1 = $E
N2 = $D
N3 = $C
N4 = $B
N5 = $A
N6 = $9
N7 = $8
N8 = $7
N9 = $6
NA = $5
NB = $4
NC = $3
ND = $2
NE = $1
NF = $0

; commands
vol = $80
inst = $90
len = $91
delay = $92 
trans = $93
vib = $94
skip = $95
swup = $96
swdn = $97
port = $98
slup = $99
sldn = $9A
duty = $B0
end_row = $C0

.reloc 
