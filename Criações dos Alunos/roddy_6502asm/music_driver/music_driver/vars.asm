start_offset = $0700
.org start_offset
PulseA_BaseNote: .res 1
PulseB_BaseNote: .res 1
Tri_BaseNote: .res 1
Noise_BaseNote: .res 1

PulseA_FinalNote: .res 1
PulseB_FinalNote: .res 1
Tri_FinalNote: .res 1
Noise_FinalNote: .res 1

PulseA_Trans: .res 1
PulseB_Trans: .res 1
Tri_Trans: .res 1

PulseA_ChVol: .res 1
PulseB_ChVol: .res 1
Tri_ChVol: .res 1
Noise_ChVol: .res 1

PulseA_InstVol: .res 1
PulseB_InstVol: .res 1
Tri_InstVol: .res 1
Noise_InstVol: .res 1

PulseA_FinalVol: .res 1
PulseB_FinalVol: .res 1
Tri_FinalVol: .res 1
Noise_FinalVol: .res 1

PulseA_Instrument: .res 1
PulseB_Instrument: .res 1
Tri_Instrument: .res 1
Noise_Instrument: .res 1

PulseA_Duty: .res 1
PulseB_Duty: .res 1
Tri_Duty: .res 1
Noise_Duty: .res 1

PulseA_BaseHiFreq: .res 1
PulseB_BaseHiFreq: .res 1
Tri_BaseHiFreq: .res 1

PulseA_BaseLoFreq: .res 1
PulseB_BaseLoFreq: .res 1
Tri_BaseLoFreq: .res 1

PulseA_HiFreq: .res 1
PulseB_HiFreq: .res 1
Tri_HiFreq: .res 1

PulseA_LoFreq: .res 1
PulseB_LoFreq: .res 1
Tri_LoFreq: .res 1

PulseA_HiFreq_Prev: .res 1
PulseB_HiFreq_Prev: .res 1
Tri_HiFreq_Prev: .res 1

PulseA_PortSpeed: .res 1
PulseB_PortSpeed: .res 1
Tri_PortSpeed: .res 1
Noise_PortSpeed: .res 1

PulseA_PortCurLoFreq: .res 1
PulseB_PortCurLoFreq: .res 1
Tri_PortCurLoFreq: .res 1
Noise_PortCurLoFreq: .res 1

PulseA_PortTarLoFreq: .res 1
PulseB_PortTarLoFreq: .res 1
Tri_PortTarLoFreq: .res 1
Noise_PortTarLoFreq: .res 1

PulseA_Length: .res 1
PulseB_Length: .res 1
Tri_Length: .res 1
Noise_Length: .res 1

PulseA_Delay: .res 1
PulseB_Delay: .res 1
Tri_Delay: .res 1
Noise_Delay: .res 1

PulseA_VibCount = $0500
PulseB_VibCount = $0501
Tri_VibCount = $502

PulseA_VibSpeed = $503
PulseB_VibSpeed = $504
Tri_VibSpeed = $505

PulseA_VibDepth = $506
PulseB_VibDepth = $507
Tri_VibDepth = $508

PulseA_FixedLength: .res 1
PulseB_FixedLength: .res 1
Tri_FixedLength: .res 1
Noise_FixedLength: .res 1

; INSTRUMENT ENVELOPES
PulseA_Env_Vol_Counter: .res 1
PulseB_Env_Vol_Counter: .res 1
Tri_Env_Vol_Counter: .res 1
Noise_Env_Vol_Counter: .res 1

PulseA_Env_Arp_Counter: .res 1
PulseB_Env_Arp_Counter: .res 1
Tri_Env_Arp_Counter: .res 1
Noise_Env_Arp_Counter: .res 1

PulseA_Env_Duty_Counter: .res 1
PulseB_Env_Duty_Counter: .res 1
Tri_Env_Duty_Counter: .res 1
Noise_Env_Duty_Counter: .res 1

PulseA_Env_Vol_Length: .res 1
PulseB_Env_Vol_Length: .res 1
Tri_Env_Vol_Length: .res 1
Noise_Env_Vol_Length: .res 1

PulseA_Env_Arp_Length: .res 1
PulseB_Env_Arp_Length: .res 1
Tri_Env_Arp_Length: .res 1
Noise_Env_Arp_Length: .res 1

PulseA_Env_Duty_Length: .res 1
PulseB_Env_Duty_Length: .res 1
Tri_Env_Duty_Length: .res 1
Noise_Env_Duty_Length: .res 1

PulseA_Env_Vol_LoopPoint: .res 1
PulseB_Env_Vol_LoopPoint: .res 1
Tri_Env_Vol_LoopPoint: .res 1
Noise_Env_Vol_LoopPoint: .res 1

PulseA_Env_Arp_LoopPoint: .res 1
PulseB_Env_Arp_LoopPoint: .res 1
Tri_Env_Arp_LoopPoint: .res 1
Noise_Env_Arp_LoopPoint: .res 1

PulseA_Env_Duty_LoopPoint: .res 1
PulseB_Env_Duty_LoopPoint: .res 1
Tri_Env_Duty_LoopPoint: .res 1
Noise_Env_Duty_LoopPoint: .res 1

PulseA_Env_Vol_ReleasePoint: .res 1
PulseB_Env_Vol_ReleasePoint: .res 1
Tri_Env_Vol_ReleasePoint: .res 1
Noise_Env_Vol_ReleasePoint: .res 1

PulseA_Env_Arp_ReleasePoint: .res 1
PulseB_Env_Arp_ReleasePoint: .res 1
Tri_Env_Arp_ReleasePoint: .res 1
Noise_Env_Arp_ReleasePoint: .res 1

PulseA_Env_Duty_ReleasePoint: .res 1
PulseB_Env_Duty_ReleasePoint: .res 1
Tri_Env_Duty_ReleasePoint: .res 1
Noise_Env_Duty_ReleasePoint: .res 1

SFX_Active: .res 1
SFX_Channels: .res 1

PulseA_SFX_Length: .res 1
PulseB_SFX_Length: .res 1
Tri_SFX_Length: .res 1
Noise_SFX_Length: .res 1

Song_Speed: .res 1
Song_Tempo: .res 1
Speed_Accum: .res 2
Speed_Adder: .res 2
Current_Frame: .res 1
Current_Row: .res 1
Total_Frames: .res 1
Total_Rows: .res 1

Song_Playing: .res 1
NewModuleRequest: .res 1
ErrorFound: .res 1       
Current_Channel: .res 1
speed_index: .res 1
PulseA_DelayBuffer: .res 16
PulseB_DelayBuffer: .res 16
Tri_DelayBuffer: .res 16
Noise_DelayBuffer: .res 16
end_offset = Noise_DelayBuffer+15 - start_offset
; These can't be cleared
Current_SongID: .res 1
RequestFrame: .res 1
Draw_StartHi: .res 1
Draw_StartLo: .res 1 
ReturnedOpcode: .res 1 
.reloc 