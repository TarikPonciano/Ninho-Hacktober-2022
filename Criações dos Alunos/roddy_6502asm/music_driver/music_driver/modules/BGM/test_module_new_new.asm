test_module_new:
; Module for RMD Driver v1.1
; This area points where in ROM the frame pointers are.
.word @PulseA_FramePointer, @PulseB_FramePointer, @Tri_FramePointer, @Noise_FramePointer

; Now let's go for module properties
; Speed
.byte 3

; Tempo
.byte 165

; Total rows per frame
.byte 63

; Total number of frames
.byte 31

@PulseA_FramePointer:
    .word @PulseA_Frame00, @PulseA_Frame01, @PulseA_Frame02, @PulseA_Frame01
    .word @PulseA_Frame04, @PulseA_Frame05, @PulseA_Frame06, @PulseA_Frame07
    .word @PulseA_Frame08, @PulseA_Frame09, @PulseA_Frame08, @PulseA_Frame09
    .word @PulseA_Frame0C, @PulseA_Frame0D, @PulseA_Frame0E, @PulseA_Frame0F
    .word @PulseA_Frame00, @PulseA_Frame01, @PulseA_Frame02, @PulseA_Frame01
    .word @PulseA_Frame04, @PulseA_Frame05, @PulseA_Frame06, @PulseA_Frame07
    .word @PulseA_Frame18, @PulseA_Frame19, @PulseA_Frame18, @PulseA_Frame1B
    .word @PulseA_Frame1C, @PulseA_Frame1D, @PulseA_Frame1E, @PulseA_Frame1F

@PulseB_FramePointer:
    .word @PulseB_Frame00, @PulseB_Frame01, @PulseB_Frame02, @PulseB_Frame03
    .word @PulseB_Frame04, @PulseB_Frame05, @PulseB_Frame04, @PulseB_Frame07
    .word @PulseB_Frame08, @PulseB_Frame09, @PulseB_Frame0A, @PulseB_Frame0B
    .word @PulseB_Frame0C, @PulseB_Frame0D, @PulseB_Frame0E, @PulseB_Frame0F
    .word @PulseB_Frame00, @PulseB_Frame01, @PulseB_Frame02, @PulseB_Frame03
    .word @PulseB_Frame04, @PulseB_Frame05, @PulseB_Frame04, @PulseB_Frame07
    .word @PulseB_Frame18, @PulseB_Frame19, @PulseB_Frame1A, @PulseB_Frame1B
    .word @PulseB_Frame1C, @PulseB_Frame1D, @PulseB_Frame1E, @PulseB_Frame1F


@Tri_FramePointer:
    .word @Tri_Frame00, @Tri_Frame01, @Tri_Frame00, @Tri_Frame01
    .word @Tri_Frame00, @Tri_Frame01, @Tri_Frame00, @Tri_Frame01
    .word @Tri_Frame08, @Tri_Frame09, @Tri_Frame08, @Tri_Frame09
    .word @Tri_Frame0C, @Tri_Frame0D, @Tri_Frame0E, @Tri_Frame0F
    .word @Tri_Frame10, @Tri_Frame11, @Tri_Frame10, @Tri_Frame11
    .word @Tri_Frame10, @Tri_Frame11, @Tri_Frame10, @Tri_Frame11
    .word @Tri_Frame18, @Tri_Frame19, @Tri_Frame18, @Tri_Frame19
    .word @Tri_Frame1C, @Tri_Frame1D, @Tri_Frame1E, @Tri_Frame1F


@Noise_FramePointer:
    .word @Noise_Frame00, @Noise_Frame00, @Noise_Frame02, @Noise_Frame03
    .word @Noise_Frame00, @Noise_Frame00, @Noise_Frame00, @Noise_Frame00
    .word @Noise_Frame00, @Noise_Frame00, @Noise_Frame00, @Noise_Frame00
    .word @Noise_Frame00, @Noise_Frame00, @Noise_Frame00, @Noise_Frame0F
    .word @Noise_Frame10, @Noise_Frame10, @Noise_Frame12, @Noise_Frame13
    .word @Noise_Frame10, @Noise_Frame10, @Noise_Frame10, @Noise_Frame10
    .word @Noise_Frame10, @Noise_Frame10, @Noise_Frame10, @Noise_Frame10
    .word @Noise_Frame10, @Noise_Frame1D, @Noise_Frame10, @Noise_Frame00

;;;;;;;; PULSE A ;;;;;;;;
@PulseA_Frame00:
    .byte Dd3, inst, 2, vol+15, duty+0, end_row+4
    .byte duty+1, end_row+4 
    .byte stop, end_row+8 
    .byte Gd3, duty+0, end_row+4 
    .byte duty+1, end_row+4 
    .byte stop, end_row+4 
    .byte Cd3, end_row+4
    .byte duty+0, end_row+4
    .byte stop, end_row+4 
    .byte B2, duty+2, end_row+4
    .byte duty+1, end_row+4
    .byte stop, end_row+12

@PulseA_Frame01:
    .byte end_row+4 
    .byte Dd3, duty+1, end_row+4 
    .byte duty+2, end_row+4 
    .byte stop, end_row+4 
    .byte Gd3, duty+0, end_row+4
    .byte duty+1, end_row+4
    .byte stop, end_row+4
    .byte Cd3, end_row+4
    .byte duty+0, end_row+4
    .byte stop, end_row+8
    .byte B2, duty+2, end_row+4
    .byte duty+1, end_row+4
    .byte stop, end_row+4
    .byte duty+2, end_row+4

@PulseA_Frame02:
    .byte end_row+4
    .byte Dd3, vol+8, duty+1, end_row+4
    .byte stop, end_row+8
    .byte Gd3, vol+15, duty+0, end_row+4
    .byte duty+1, end_row+4
    .byte stop, end_row+4
    .byte Cd3, duty+1, end_row+4
    .byte duty+0, end_row+4
    .byte stop, end_row+4
    .byte B2, duty+2, end_row+4
    .byte duty+1, end_row+4
    .byte stop, end_row+12

@PulseA_Frame03:
@PulseA_Frame04:
    .byte Ad2, inst, $0A, vol+15, duty+0, end_row+4
    .byte duty+1, end_row+4
    .byte G3, inst, $03, vol+6, duty+2, end_row+2
    .byte G2, end_row+2
    .byte G3, end_row+2
    .byte G4, end_row+2
    .byte Dd3, inst, $0A, vol+15, duty+0, end_row+4
    .byte duty+1, end_row+4
    .byte C4, inst, $03, vol+6, duty+2, end_row+2
    .byte C3, end_row+2
    .byte Gd2, inst, $0A, vol+15, duty+1, end_row+4
    .byte duty+0, end_row+4
    .byte F4, inst, $03, vol+6, duty+2, end_row+2
    .byte F3, end_row+2
    .byte Fd2, inst, $0A, vol+15, duty+2, end_row+4
    .byte duty+1, end_row+4
    .byte stop, end_row+7
    .byte duty+0, end_row+1
    .byte A5, inst, $00, vol+2, sldn, $02, end_row+8

@PulseA_Frame05:
    .byte end_row+2
    .byte stop, sldn, $00, end_row+2
    .byte Ad2, inst, $0A, vol+15, duty+1, end_row+4
    .byte duty+2, end_row+4
    .byte G3, inst, $03, vol+6, end_row+2
    .byte G2, end_row+2
    .byte Dd3, inst, $0A, vol+15, duty+0, end_row+4
    .byte duty+1, end_row+4
    .byte C4, inst, $03, vol+6, duty+2, end_row+2
    .byte C3, end_row+2
    .byte Gd2, inst, $0A, vol+15, duty+1, end_row+4
    .byte duty+0, end_row+4
    .byte Cd4, inst, $03, vol+6, duty+2, end_row+2
    .byte Cd3, end_row+2
    .byte Cd4, end_row+2
    .byte Cd5, end_row+2
    .byte Fd2, inst, $0A, vol+15, duty+2, end_row+4
    .byte duty+1, end_row+4
    .byte Ad4, inst, $01, vol+1, duty+0, end_row+1
    .byte Fd4, vol+2, end_row+1
    .byte Dd4, vol+3, end_row+1
    .byte B3, vol+4, end_row+1
    .byte Ad3, vol+5, end_row+1
    .byte Fd3, vol+6, end_row+1
    .byte Dd3, vol+7, end_row+1
    .byte B2, vol+8, end_row+5

@PulseA_Frame06:
    .byte Ad2, inst, $0A, vol+15, end_row+4
    .byte duty+1, end_row+4
    .byte G3, inst, $03, vol+6, duty+2, end_row+2
    .byte G2, end_row+2
    .byte G3, end_row+2
    .byte G4, end_row+2
    .byte Dd3, inst, $0A, vol+15, duty+0, end_row+4
    .byte duty+1, end_row+4
    .byte C4, inst, $03, vol+6, duty+2, end_row+2
    .byte C3, end_row+2
    .byte Gd2, inst, $0A, vol+15, duty+1, end_row+4
    .byte duty+0, end_row+4
    .byte F4, inst, $03, vol+6, duty+2, end_row+2
    .byte F3, end_row+2
    .byte Fd2, inst, $0A, vol+15, duty+2, end_row+4
    .byte duty+1, end_row+4
    .byte stop, end_row+7
    .byte duty+0, end_row+1
    .byte D4, inst, $00, vol+2, slup, $08, end_row+6

@PulseA_Frame07:
    .byte end_row+2
    .byte stop, sldn, $00, end_row+2
    .byte Ad2, inst, $0A, vol+15, duty+1, end_row+4
    .byte duty+2, end_row+4
    .byte G3, inst, $03, vol+6, duty+2, end_row+2
    .byte G2, end_row+2
    .byte Dd3, inst, $0A, vol+15, duty+0, end_row+4
    .byte duty+1, end_row+4
    .byte C4, inst, $03, vol+6, duty+2, end_row+2
    .byte C3, end_row+2
    .byte Gd2, inst, $0A, vol+15, duty+1, end_row+4
    .byte duty+0, end_row+4
    .byte Cd4, inst, $03, vol+6, duty+2, end_row+2
    .byte Cd3, end_row+2
    .byte Cd4, end_row+2
    .byte Cd5, end_row+2
    .byte Fd2, inst, $0A, vol+15, duty+2, end_row+4
    .byte duty+1, end_row+4
    .byte B2, inst, $01, vol+1, duty+0, end_row+1
    .byte Dd3, vol+2, end_row+1
    .byte Fd3, vol+3, end_row+1
    .byte Ad3, vol+4, end_row+1
    .byte B3, vol+5, end_row+1
    .byte Dd4, vol+6, end_row+1
    .byte Fd4, vol+7, end_row+1
    .byte Ad4, vol+8, end_row+8

@PulseA_Frame08:
    .byte Gd2, inst, $02, vol+15, duty+0, end_row+8
    .byte Ad2, inst, $0A, vol+5, end_row+4
    .byte Gd2, inst, $02, vol+15, end_row+8
    .byte Ad2, inst, $0A, vol+5, end_row+4
    .byte Gd2, inst, $02, vol+15, duty+1, end_row+8
    .byte Ad2, inst, $0A, vol+5, end_row+8
    .byte F1, inst, $01, vol+8, duty+2, end_row+1
    .byte stop, end_row+1
    .byte F2, end_row+2
    .byte F1, end_row+8

@PulseA_Frame09:
    .byte Ad2, inst, $02, vol+15, end_row+8
    .byte C3, inst, $0A, vol+5, end_row+4
    .byte Ad2, inst, $02, vol+15, end_row+8
    .byte C3, inst, $0A, vol+5, end_row+4
    .byte Ad2, inst, $02, vol+15, duty+1, end_row+8
    .byte C3, inst, $0A, vol+5, end_row+8
    .byte G2, inst, $01, vol+8, duty+2, end_row+4
    .byte G1, end_row+1
    .byte stop, end_row+1
    .byte G1, end_row+8

@PulseA_Frame0C:
    .byte Gd2, inst, $02, vol+15, duty+0, end_row+8
    .byte Ad2, inst, $0A, vol+5, end_row+4
    .byte Gd2, inst, $02, vol+15, end_row+8
    .byte Ad2, inst, $0A, vol+5, end_row+4
    .byte Gd2, inst, $02, vol+15, duty+1, end_row+8
    .byte Ad2, inst, $0A, vol+5, end_row+8
    .byte Ad1, inst, $01, vol+8, duty+2, end_row+1
    .byte stop, end_row+1
    .byte Ad1, end_row+2
    .byte Ad0, end_row+8

@PulseA_Frame0D:
    .byte Ad2, inst, $02, vol+15, duty+2, end_row+8
    .byte C3, inst, $0A, vol+5, end_row+4
    .byte Ad2, inst, $02, vol+15, end_row+8
    .byte C3, inst, $0A, vol+5, end_row+4
    .byte Ad2, inst, $02, vol+15, duty+1, end_row+8
    .byte C3, inst, $0A, vol+5, end_row+8
    .byte C1, inst, $01, vol+8, duty+2, end_row+4
    .byte C2, end_row+8

@PulseA_Frame0E:
    .byte B2, inst, $07, vol+10, duty+0, end_row+3
    .byte vol+9, end_row+3
    .byte vol+8, end_row+2
    .byte duty+1, end_row+1
    .byte vol+7, end_row+3
    .byte vol+6, end_row+4
    .byte duty+2, end_row+2
    .byte vol+5, end_row+6
    .byte vol+4, duty+1, end_row+8
    .byte vol+3, duty+0, end_row+6
    .byte duty+1, end_row+6
    .byte vol+2, duty+2, end_row+6
    .byte duty+1, end_row+6
    .byte duty+0, end_row+4
    .byte duty+1, end_row+8

@PulseA_Frame0F:
    .byte B2, inst, $08, vol+8, duty+2, end_row+4
    .byte duty+1, end_row+2
    .byte vol+7, end_row+2
    .byte duty+0, end_row+4
    .byte vol+6, duty+1, end_row+4
    .byte duty+2, end_row+2
    .byte vol+5, end_row+2
    .byte duty+1, end_row+4
    .byte vol+4, duty+0, end_row+3
    .byte duty+1, end_row+3
    .byte duty+2, end_row+2
    .byte vol+3, end_row+1
    .byte duty+1, end_row+3
    .byte duty+0, end_row+3
    .byte duty+1, end_row+3
    .byte duty+2, end_row+2
    .byte vol+2, end_row+1
    .byte duty+1, end_row+3
    .byte duty+0, end_row+2
    .byte duty+1, end_row+2
    .byte duty+2, end_row+2
    .byte duty+1, end_row+2
    .byte duty+0, end_row+2
    .byte duty+1, end_row+2
    .byte duty+2, end_row+2
    .byte duty+1, end_row+2

@PulseA_Frame18:
    .byte D3, inst, $0C, vol+15, duty+2, end_row+12
    .byte D3, duty+1, end_row+12
    .byte D3, duty+0, end_row+16
    .byte D3, inst, $0D, end_row+4
    .byte C3, inst, $0A, duty+1, end_row+4

@PulseA_Frame19:
    .byte Cd3, inst, $02, duty+2, end_row+12
    .byte Cd3, duty+1, end_row+12
    .byte Cd3, duty+0, end_row+16
    .byte Cd3, inst, $0E, end_row+4
    .byte Dd3, inst, $0A, duty+1, end_row+4

@PulseA_Frame1B:
    .byte Cd3, inst, $02, duty+2, end_row+12
    .byte Cd3, duty+1, end_row+12
    .byte Cd3, duty+0, end_row+16
    .byte F2, inst, $0C, end_row+8

@PulseA_Frame1C:
    .byte Gd2, end_row+12
    .byte Gd2, end_row+12
    .byte Gd2, end_row+16
    .byte Gd2, inst, $0D, end_row+4
    .byte Gd2, inst, $0C, end_row+4

@PulseA_Frame1D:
    .byte Ad2, end_row+12
    .byte Ad2, end_row+12
    .byte Ad2, end_row+16
    .byte Ad2, inst, $0D, end_row+4
    .byte Ad2, inst, $0C, end_row+4

@PulseA_Frame1E:
    .byte B2, inst, $08, vol+10, duty+0, end_row+3
    .byte vol+9, end_row+3
    .byte vol+8, end_row+2
    .byte duty+1, end_row+1
    .byte vol+7, end_row+3
    .byte vol+6, end_row+4
    .byte duty+2, end_row+2
    .byte vol+5, end_row+6
    .byte vol+4, duty+1, end_row+8
    .byte vol+3, duty+0, end_row+6
    .byte duty+1, end_row+6
    .byte vol+2, duty+2, end_row+6
    .byte duty+1, end_row+6
    .byte duty+0, end_row+4
    .byte duty+1, end_row+4

@PulseA_Frame1F:
    .byte B2, inst, $0F, vol+8, duty+2, end_row+4
    .byte duty+1, end_row+2
    .byte vol+7, end_row+2
    .byte duty+0, end_row+4
    .byte vol+6, duty+1, end_row+4
    .byte duty+2, end_row+2
    .byte vol+5, end_row+2
    .byte duty+1, end_row+4
    .byte vol+4, duty+0, end_row+3
    .byte duty+1, end_row+3
    .byte duty+2, end_row+2
    .byte vol+3, end_row+1
    .byte duty+1, end_row+3
    .byte duty+0, end_row+3
    .byte duty+1, end_row+3
    .byte duty+2, end_row+2
    .byte vol+2, end_row+1
    .byte duty+1, end_row+3
    .byte duty+0, end_row+2
    .byte duty+1, end_row+2
    .byte duty+2, end_row+2
    .byte duty+1, end_row+2
    .byte duty+0, end_row+2
    .byte duty+1, end_row+2
    .byte duty+2, end_row+2
    .byte duty+1, end_row+63

;;;;;;;; PULSE B ;;;;;;;;

@PulseB_Frame00:
    .byte D4, inst, 1, vol+10, duty+2, end_row+1
    .byte vol+0, end_row+1+0 
    .byte Ad3, vol+10, duty+2, end_row+1
    .byte D4, vol+3, duty+0, end_row+1 
    .byte G3, vol+9, duty+2, end_row+1 
    .byte Ad3, vol+3, duty+0, end_row+1 
    .byte Dd3, vol+9, duty+2, end_row+1 ; instead of 0, you set the length if fixed length isn't enabled. you get the idea
    .byte G3, vol+3, duty+0, end_row+1 
    .byte D3, vol+8, duty+2, end_row+1 
    .byte Dd3, vol+3, duty+0, end_row+1 
    .byte Ad2, vol+8, duty+2, end_row+1 
    .byte D3, vol+3, duty+0, end_row+1 
    .byte G2, vol+7, duty+2, end_row+1 
    .byte Ad2, vol+3, duty+0, end_row+1
    .byte Dd2, vol+7, duty+2, end_row+1
    .byte G2, vol+3, duty+0, end_row+1
    .byte Dd4, vol+10, duty+2, end_row+1
    .byte Dd2, vol+3, duty+0, end_row+1
    .byte C4, vol+10, duty+2, end_row+1
    .byte Dd4, vol+3, duty+0, end_row+1
    .byte Gd3, vol+9, duty+2, end_row+1
    .byte C4, vol+3, duty+0, end_row+1
    .byte G3, vol+9, duty+2, end_row+1 
    .byte Gd3, vol+3, duty+0, end_row+1
    .byte Dd3, vol+8, duty+2, end_row+1
    .byte G3, vol+3, duty+0, end_row+1
    .byte C3, vol+8, duty+2, end_row+1
    .byte Dd3, vol+3, duty+0, end_row+1
    .byte C4, vol+10, duty+2, end_row+1
    .byte C3, vol+3, duty+0, end_row+1
    .byte Gd3, vol+10, duty+2, end_row+1
    .byte C4, vol+3, duty+0, end_row+1
    .byte F3, vol+9, duty+2, end_row+1
    .byte Gd3, vol+3, duty+0, end_row+1
    .byte Cd3, vol+9, duty+2, end_row+1
    .byte F3, vol+3, duty+0, end_row+1
    .byte C3, vol+8, duty+2, end_row+1
    .byte Cd3, vol+3, duty+0, end_row+1
    .byte Gd2, vol+8, duty+2, end_row+1
    .byte C3, vol+3, duty+0, end_row+1 
    .byte Dd4, vol+10, duty+2, end_row+1 
    .byte Gd2, vol+3, duty+0, end_row+1
    .byte B3, vol+10, duty+2, end_row+1
    .byte Dd4, vol+3, duty+0, end_row+1
    .byte Ad3, vol+9, duty+2, end_row+1
    .byte B3, vol+3, duty+0, end_row+1
    .byte Fd3, vol+9, duty+2, end_row+1
    .byte Ad3, vol+3, duty+0, end_row+1
    .byte Dd3, vol+8, duty+2, end_row+1
    .byte Fd3, vol+3, duty+0, end_row+1
    .byte B2, vol+8, duty+2, end_row+1
    .byte Dd3, vol+3, duty+0, end_row+1
    .byte Ad2, vol+7, duty+2, end_row+1
    .byte B2, vol+3, duty+0, end_row+1
    .byte Fd2, vol+7, duty+2, end_row+1
    .byte Ad2, vol+3, duty+0, end_row+1
    .byte Dd2, vol+6, duty+2, end_row+1
    .byte Fd2, vol+2, duty+0, end_row+1
    .byte B1, vol+6, duty+2, end_row+1
    .byte Dd2, vol+2, duty+0, skip
    
@PulseB_Frame01:
    .byte Ad1, vol+5, duty+2, end_row+1 
    .byte Fd2, vol+2, duty+0, end_row+1 
    .byte Fd1, vol+5, duty+2, end_row+1 
    .byte Dd2, vol+2, duty+0, end_row+1 
    .byte D4, vol+10, duty+2, end_row+1 
    .byte Fd1, vol+2, duty+0, end_row+1 
    .byte Ad3, vol+10, duty+2, end_row+1 
    .byte D4, vol+3, duty+0, end_row+1 
    .byte G3, vol+9, duty+2, end_row+1 
    .byte Ad3, vol+3, duty+0, end_row+1 
    .byte Dd3, vol+9, duty+2, end_row+1 
    .byte G3, vol+3, duty+0, end_row+1 
    .byte D3, vol+8, duty+2, end_row+1 
    .byte Dd3, vol+3, duty+0, end_row+1
    .byte Ad2, vol+8, duty+2, end_row+1
    .byte D3, vol+3, duty+0, end_row+1
    .byte Dd4, vol+10, duty+2, end_row+1
    .byte Dd2, vol+3, duty+0, end_row+1 
    .byte C4, vol+10, duty+2, end_row+1 
    .byte Dd4, vol+3, duty+0, end_row+1 
    .byte Gd3, vol+9, duty+2, end_row+1 
    .byte C4, vol+3, duty+0, end_row+1 
    .byte G3, vol+9, duty+2, end_row+1 
    .byte Gd3, vol+3, duty+0, end_row+1 
    .byte Dd3, vol+8, duty+2, end_row+1 
    .byte G3, vol+3, duty+0, end_row+1 
    .byte C3, vol+8, duty+2, end_row+1 
    .byte Dd3, vol+3, duty+0, end_row+1 
    .byte C4, vol+10, duty+2, end_row+1 
    .byte C3, vol+3, duty+0, end_row+1 
    .byte Gd3, vol+10, duty+2, end_row+1 
    .byte C4, vol+3, duty+0, end_row+1 
    .byte F3, vol+9, duty+2, end_row+1 
    .byte Gd3, vol+3, duty+0, end_row+1 
    .byte Cd3, vol+9, duty+2, end_row+1 
    .byte F3, vol+3, duty+0, end_row+1 
    .byte C3, vol+8, duty+2, end_row+1 
    .byte Cd3, vol+3, duty+0, end_row+1 
    .byte Gd2, vol+8, duty+2, end_row+1 
    .byte C3, vol+3, duty+0, end_row+1 
    .byte F2, vol+7, duty+2, end_row+1 
    .byte Gd2, vol+3, duty+0, end_row+1 
    .byte Cd2, vol+7, duty+2, end_row+1 
    .byte F2, vol+3, duty+0, end_row+1 
    .byte Dd4, vol+10, duty+2, end_row+1 
    .byte Cd2, vol+3, duty+0, end_row+1 
    .byte B3, vol+10, duty+2, end_row+1 
    .byte Dd4, vol+3, duty+0, end_row+1 
    .byte Ad3, vol+9, duty+2, end_row+1 
    .byte B3, vol+3, duty+0, end_row+1 
    .byte Fd3, vol+9, duty+2, end_row+1 
    .byte Ad3, vol+3, duty+0, end_row+1 
    .byte Dd3, vol+8, duty+2, end_row+1 
    .byte Fd3, vol+3, duty+0, end_row+1 
    .byte B2, vol+8, duty+2, end_row+1 
    .byte Dd3, vol+3, duty+0, end_row+1 
    .byte Ad2, vol+7, duty+2, end_row+1 
    .byte B2, vol+3, duty+0, end_row+1 
    .byte Fd2, vol+7, duty+2, end_row+1 
    .byte Ad2, vol+3, duty+0, skip

@PulseB_Frame02:
    .byte stop, end_row+4 
    .byte G3, vol+9, duty+2, end_row+1
    .byte Ad3, vol+3, duty+0, end_row+1
    .byte Dd3, vol+9, duty+2, end_row+1
    .byte G3, vol+3, duty+0, end_row+1 
    .byte D3, vol+8, duty+2, end_row+1 
    .byte Dd3, vol+3, duty+0, end_row+1 
    .byte Ad2, vol+8, duty+2, end_row+1 
    .byte D3, vol+3, duty+0, end_row+1 
    .byte G2, vol+7, duty+2, end_row+1 
    .byte Ad2, vol+3, duty+0, end_row+1
    .byte Dd2, vol+7, duty+2, end_row+1
    .byte G2, vol+3, duty+0, end_row+1
    .byte Dd4, vol+10, duty+2, end_row+1
    .byte Dd2, vol+3, duty+0, end_row+1
    .byte C4, vol+10, duty+2, end_row+1
    .byte Dd4, vol+3, duty+0, end_row+1
    .byte Gd3, vol+9, duty+2, end_row+1
    .byte C4, vol+3, duty+0, end_row+1
    .byte G3, vol+9, duty+2, end_row+1 
    .byte Gd3, vol+3, duty+0, end_row+1
    .byte Dd3, vol+8, duty+2, end_row+1
    .byte G3, vol+3, duty+0, end_row+1
    .byte C3, vol+8, duty+2, end_row+1
    .byte Dd3, vol+3, duty+0, end_row+1
    .byte C4, vol+10, duty+2, end_row+1
    .byte C3, vol+3, duty+0, end_row+1
    .byte Gd3, vol+10, duty+2, end_row+1
    .byte C4, vol+3, duty+0, end_row+1
    .byte F3, vol+9, duty+2, end_row+1
    .byte Gd3, vol+3, duty+0, end_row+1
    .byte Cd3, vol+9, duty+2, end_row+1
    .byte F3, vol+3, duty+0, end_row+1
    .byte C3, vol+8, duty+2, end_row+1
    .byte Cd3, vol+3, duty+0, end_row+1
    .byte Gd2, vol+8, duty+2, end_row+1
    .byte C3, vol+3, duty+0, end_row+1 
    .byte Dd4, vol+10, duty+2, end_row+1 
    .byte Gd2, vol+3, duty+0, end_row+1
    .byte B3, vol+10, duty+2, end_row+1
    .byte Dd4, vol+3, duty+0, end_row+1
    .byte Ad3, vol+9, duty+2, end_row+1
    .byte B3, vol+3, duty+0, end_row+1
    .byte Fd3, vol+9, duty+2, end_row+1
    .byte Ad3, vol+3, duty+0, end_row+1
    .byte Dd3, vol+8, duty+2, end_row+1
    .byte Fd3, vol+3, duty+0, end_row+1
    .byte B2, vol+8, duty+2, end_row+1
    .byte Dd3, vol+3, duty+0, end_row+1
    .byte Ad2, vol+7, duty+2, end_row+1
    .byte B2, vol+3, duty+0, end_row+1
    .byte Fd2, vol+7, duty+2, end_row+1
    .byte Ad2, vol+3, duty+0, end_row+1
    .byte Dd2, vol+6, duty+2, end_row+1
    .byte Fd2, vol+2, duty+0, end_row+1
    .byte B1, vol+6, duty+2, end_row+1
    .byte Dd2, vol+2, duty+0, skip

@PulseB_Frame03:
    .byte Ad1, vol+5, duty+2, end_row+1 
    .byte Fd2, vol+2, duty+0, end_row+1 
    .byte Fd1, vol+5, duty+2, end_row+1 
    .byte Dd2, vol+2, duty+0, end_row+1 
    .byte D4, vol+10, duty+2, end_row+1 
    .byte Fd1, vol+2, duty+0, end_row+1 
    .byte Ad3, vol+10, duty+2, end_row+1 
    .byte D4, vol+3, duty+0, end_row+1 
    .byte G3, vol+9, duty+2, end_row+1 
    .byte Ad3, vol+3, duty+0, end_row+1 
    .byte Dd3, vol+9, duty+2, end_row+1 
    .byte G3, vol+3, duty+0, end_row+1 
    .byte D3, vol+8, duty+2, end_row+1 
    .byte Dd3, vol+3, duty+0, end_row+1
    .byte Ad2, vol+8, duty+2, end_row+1
    .byte D3, vol+3, duty+0, end_row+1
    .byte Dd4, vol+10, duty+2, end_row+1
    .byte Dd2, vol+3, duty+0, end_row+1 
    .byte C4, vol+10, duty+2, end_row+1 
    .byte Dd4, vol+3, duty+0, end_row+1 
    .byte Gd3, vol+9, duty+2, end_row+1 
    .byte C4, vol+3, duty+0, end_row+1 
    .byte G3, vol+9, duty+2, end_row+1 
    .byte Gd3, vol+3, duty+0, end_row+1 
    .byte Dd3, vol+8, duty+2, end_row+1 
    .byte G3, vol+3, duty+0, end_row+1 
    .byte C3, vol+8, duty+2, end_row+1 
    .byte Dd3, vol+3, duty+0, end_row+1 
    .byte C4, vol+10, duty+2, end_row+1 
    .byte C3, vol+3, duty+0, end_row+1 
    .byte Gd3, vol+10, duty+2, end_row+1 
    .byte C4, vol+3, duty+0, end_row+1 
    .byte F3, vol+9, duty+2, end_row+1 
    .byte Gd3, vol+3, duty+0, end_row+1 
    .byte Cd3, vol+9, duty+2, end_row+1 
    .byte F3, vol+3, duty+0, end_row+1 
    .byte C3, vol+8, duty+2, end_row+1 
    .byte Cd3, vol+3, duty+0, end_row+1 
    .byte Gd2, vol+8, duty+2, end_row+1 
    .byte C3, vol+3, duty+0, end_row+1 
    .byte F2, vol+7, duty+2, end_row+1 
    .byte Gd2, vol+3, duty+0, end_row+1 
    .byte Cd2, vol+7, duty+2, end_row+1 
    .byte F2, vol+3, duty+0, end_row+1 
    .byte B1, vol+1, duty+2, end_row+1 
    .byte Dd2, end_row+1 
    .byte Fd2, vol+2, end_row+1 
    .byte Ad2, end_row+1 
    .byte B2, vol+3, end_row+1
    .byte Dd3, end_row+1 
    .byte Fd3, vol+4, end_row+1 
    .byte Ad3, end_row+1 
    .byte B3, vol+5, end_row+1 
    .byte Dd4, end_row+1 
    .byte Fd4, vol+6, end_row+1 
    .byte Ad4, end_row+1 
    .byte B4, vol+7, end_row+1 
    .byte Dd5, end_row+1 
    .byte Fd5, vol+8, end_row+1 
    .byte Ad5, skip

@PulseB_Frame04:
    .byte F3, inst, $00, vol+10, duty+2, end_row+2
    .byte swup, $42, end_row+2
    .byte stop, end_row+4
    .byte F3, vol+4, end_row+2
    .byte swup, $42, end_row+2
    .byte stop, end_row+4
    .byte Ad3, vol+10, end_row+4
    .byte stop, end_row+4
    .byte Ad3, vol+4, end_row+4
    .byte C4, vol+10, end_row+4
    .byte stop, end_row+4
    .byte C4, vol+4, end_row+4
    .byte F3, vol+10, end_row+4
    .byte swdn, $42, end_row+2
    .byte stop, end_row+2
    .byte F3, vol+4, end_row+4
    .byte swdn, $42, end_row+2
    .byte stop, end_row+2
    .byte F3, vol+2, end_row+3
    .byte skip


@PulseB_Frame05:
    .byte swdn, $42, end_row+2
    .byte stop, end_row+2
    .byte F3, vol+10, duty+2, end_row+2
    .byte swup, $42, end_row+2
    .byte stop, end_row+4
    .byte F3, vol+4, duty+2, end_row+2
    .byte swup, $42, end_row+2
    .byte Ad3, vol+10, end_row+4
    .byte stop, end_row+4
    .byte Ad3, vol+4, end_row+4
    .byte C4, vol+10, end_row+4
    .byte stop, end_row+4
    .byte C4, vol+4, end_row+4
    .byte Dd4, vol+10, end_row+4
    .byte swdn, $42, end_row+2
    .byte stop, end_row+2
    .byte Dd4, vol+4, end_row+4
    .byte swdn, $42, end_row+2
    .byte stop, end_row+2
    .byte Dd4, vol+2, end_row+3
    .byte skip 


@PulseB_Frame06:
@PulseB_Frame07:
    .byte swdn, $42, end_row+2
    .byte stop, end_row+2
    .byte F3, vol+10, duty+2, end_row+2
    .byte swup, $42, end_row+2
    .byte stop, end_row+4
    .byte F3, vol+4, end_row+2
    .byte swup, $42, end_row+2
    .byte D4, vol+10, end_row+1
    .byte Dd4, end_row+3
    .byte stop, end_row+4
    .byte D4, vol+4, end_row+1
    .byte Dd4, end_row+3
    .byte F4, vol+10, end_row+4
    .byte stop, end_row+4
    .byte F4, vol+4, end_row+4
    .byte Gd3, vol+10, end_row+4
    .byte Ad3, vol+10, end_row+4
    .byte stop, end_row+4
    .byte Ad3, vol+4, end_row+4
    .byte stop, end_row+3
    .byte skip

@PulseB_Frame08:
    .byte stop, end_row+4 
    .byte G3, inst, 11, vol+10, duty+1, end_row+1
    .byte vol+9, end_row+1 
    .byte vol+8, end_row+1 
    .byte vol+7, end_row+1 
    .byte delay, 2, Gd3, vol+10, end_row+1
    .byte vol+9, end_row+1 
    .byte vol+8, end_row+1 
    .byte vol+7, end_row+1
    .byte delay, 2, Dd4, inst, 0, vol+10, end_row+1
    .byte vol+9, end_row+1 
    .byte vol+8, end_row+1 
    .byte vol+7, end_row+1
    .byte Ad3, inst, 11, vol+10, end_row+1
    .byte B3, inst, 0, vol+9, end_row+1 
    .byte Ad3, vol+8, end_row+1
    .byte Gd3, vol+7, end_row+1
    .byte vol+6, end_row+1
    .byte Ad3, inst, 11, vol+10, end_row+2
    .byte vib, $84, end_row+3
    .byte Gd3, vib, $00, end_row+1
    .byte vol+9, end_row+1
    .byte delay, 2, F3, inst, 0, end_row+1
    .byte vol+8, end_row+1
    .byte delay, 4, Dd3, vol+7, end_row+2
    .byte vol+6, end_row+1 
    .byte Gd3, inst, $0B, vol+10, end_row+1
    .byte vol+9, end_row+1
    .byte delay, 2, F3, inst, $00, end_row+1
    .byte vol+8, end_row+1 
    .byte delay, 4, Dd3, vol+7, end_row+2
    .byte vol+6, end_row+1
    .byte C3, inst, $0B, vol+10, end_row+2
    .byte stop, end_row+2
    .byte Dd3, vol+10, end_row+1
    .byte vol+8, end_row+1
    .byte G3, vol+10, end_row+1
    .byte vol+8, skip

@PulseB_Frame09:
    .byte Ad3, vol+10, end_row+1
    .byte vol+8, end_row+1
    .byte D4, inst, $00, vol+10, end_row+1
    .byte vol+8, end_row+1
    .byte F4, inst, $0B, vol+10, end_row+1
    .byte vol+8, end_row+1
    .byte A4, inst, $00, vol+10, end_row+1
    .byte vol+8, end_row+1 
    .byte Ad4, inst, $0B, vol+10, end_row+1
    .byte delay, 2, stop, end_row+1
    .byte Ad4, vol+10, end_row+1
    .byte vol+9, swup, $22, end_row+2
    .byte vol+8, vib, $84, end_row+1
    .byte vol+7, end_row+2
    .byte Ad4, vol+10, vib, $00, end_row+1
    .byte delay, 2, A4, inst, $00, vol+9, end_row+1
    .byte vol+8, end_row+1
    .byte F4, vol+7, end_row+1
    .byte delay, 2, D4, inst, $0B, vol+10, end_row+1
    .byte vol+9, end_row+1
    .byte C4, inst, $00, vol+8, end_row+1
    .byte delay, 2, Ad3, vol+7, end_row+1
    .byte vol+6, end_row+1
    .byte A3, inst, $0B, vol+10, end_row+1
    .byte vol+9, end_row+2
    .byte Ad3, inst, $00, vol+8, end_row+1
    .byte A3, vol+7, end_row+1
    .byte F3, inst, $0B, end_row+1
    .byte vol+6, end_row+1
    .byte vol+5, end_row+2
    .byte stop, end_row+2
    .byte G3, vol+10, end_row+1
    .byte vol+9, end_row+1 
    .byte vol+8, end_row+1 
    .byte vol+7, end_row+1
    .byte delay, 2, F3, vol+10, end_row+1
    .byte vol+9, end_row+1 
    .byte vol+8, end_row+1 
    .byte vol+7, end_row+1
    .byte delay, 4, C4, vol+10, end_row+1
    .byte vol+9, end_row+1 
    .byte vol+8, end_row+1 
    .byte vol+7, skip

@PulseB_Frame0A:
    .byte delay, 2, G3, vol+10, end_row+1
    .byte vol+9, end_row+1
    .byte vol+8, end_row+1
    .byte vol+7, end_row+1
    .byte delay, 3, F3, vol+10, end_row+1
    .byte vol+9, end_row+1
    .byte vol+8, end_row+1
    .byte vol+7, end_row+1
    .byte delay, 1, Dd4, vol+10, end_row+1
    .byte vol+9, end_row+1
    .byte vol+8, end_row+1
    .byte vol+7, end_row+1
    .byte C4, vol+10, end_row+1
    .byte vol+9, end_row+1
    .byte vol+8, end_row+1
    .byte delay, 2, Ad3, vol+10, end_row+1
    .byte vol+9, end_row+1
    .byte vol+8, end_row+1
    .byte delay, 4, F4, vol+10, end_row+1
    .byte vol+9, end_row+1
    .byte vol+8, end_row+1
    .byte delay, 5, Dd4, vol+10, end_row+1
    .byte vol+9, end_row+1
    .byte vol+8, end_row+1
    .byte delay, 1, C4, vol+10, end_row+1
    .byte vol+9, end_row+1
    .byte vol+8, end_row+1
    .byte delay, 1, G4, vol+10, end_row+1
    .byte vol+9, end_row+1
    .byte vol+8, end_row+1
    .byte delay, 1, F4, vol+10, end_row+1
    .byte vol+8, end_row+1 
    .byte delay, 2, Dd4, vol+10, end_row+1
    .byte vol+8, end_row+1 
    .byte delay, 3, Ad4, vol+10, end_row+1
    .byte vol+8, end_row+1 
    .byte delay, 2, G4, vol+10, end_row+1
    .byte vol+8, end_row+1 
    .byte delay, 2, F4, vol+10, end_row+1
    .byte vol+8, end_row+1 
    .byte delay, 1, C5, vol+10, end_row+1
    .byte vol+8, end_row+1 
    .byte Ad4, vol+10, end_row+1
    .byte vol+8, end_row+1 
    .byte G4, vol+10, end_row+1
    .byte vol+8, end_row+1 
    .byte Dd5, vol+10, end_row+1
    .byte vol+9, swup, $22, skip

@PulseB_Frame0B:
    .byte end_row+1
    .byte vol+8, end_row+1
    .byte swdn, $22, end_row+1
    .byte vol+7 
    .byte vib, $84, end_row+1
    .byte vol+6, end_row+2
    .byte vol+5, vib, $00, end_row+1
    .byte slup, $03, end_row+1
    .byte vol+4, end_row+1
    .byte stop, end_row+2
    .byte G5, inst, $00, vol+6, port, $00, end_row+1
    .byte F5, vol+8, end_row+1
    .byte Dd5, inst, $0B, vol+10, end_row+1
    .byte vol+8, end_row+1
    .byte C5, inst, $00, vol+10, port, $10, end_row+1
    .byte vol+8, end_row+1
    .byte Ad4, vol+10, end_row+1
    .byte vol+8, end_row+1
    .byte Dd5, inst, $0B, vol+10, end_row+1
    .byte delay, 2, C5, inst, $00, end_row+2
    .byte vol+8, end_row+1
    .byte Ad4, vol+10, end_row+1
    .byte delay, 2, G4, end_row+1
    .byte vol+8, end_row+1
    .byte C5, vol+10, port, $18, end_row+1
    .byte delay, 2, Ad4, end_row+1
    .byte vol+8, end_row+1
    .byte G4, vol+10, end_row+1
    .byte delay, 2, Dd4, end_row+1
    .byte vol+8, end_row+1 
    .byte stop, end_row+2
    .byte Ad3, inst, $0B, vol+10, port, $00, end_row+1
    .byte vol+8, end_row+1
    .byte delay, 1, C4, inst, $00, vol+10, end_row+1
    .byte vol+8, end_row+1
    .byte delay, 2, Dd4, inst, $0B, vol+10, end_row+1
    .byte vol+9, end_row+1
    .byte vol+8, end_row+1
    .byte C4, inst, $00, vol+10, end_row+1
    .byte vol+8, end_row+1
    .byte delay, 1, Dd4, inst, $0B, vol+10, end_row+1
    .byte vol+8, end_row+1
    .byte delay, 2, F4, inst, $00, vol+10, end_row+1
    .byte vol+8, end_row+1
    .byte delay, 1, stop, skip, end_row+4

@PulseB_Frame0C:
    .byte delay, 2, F4, inst, $0B, vol+10, end_row+1
    .byte G4, inst, $00, port, $01, end_row+1
    .byte vol+9, end_row+2
    .byte vol+8, end_row+2
    .byte vol+7, end_row+2
    .byte vol+6, vib, $84, end_row+2
    .byte vol+5, end_row+1
    .byte port, $00, end_row+1
    .byte F4, inst, $0B, vol+8, vib, $00, end_row+1
    .byte G4, inst, $00, end_row+1
    .byte F4, vol+9, end_row+1
    .byte Dd4, end_row+1
    .byte C4, inst, $0B, vol+10, end_row+1
    .byte vol+8, end_row+1
    .byte Ad3, inst, $00, vol+10, end_row+1
    .byte stop, end_row+1
    .byte C4, inst, $0B, end_row+1
    .byte vol+8, end_row+1
    .byte G3, inst, $00, vol+10, end_row+1
    .byte stop, end_row+1
    .byte F3, inst, $0B, end_row+1
    .byte vol+8, end_row+1
    .byte G3, inst, $00, vol+10, end_row+1
    .byte stop, end_row+1
    .byte Ad3, inst, $0B, end_row+1
    .byte delay, 2, G3, inst, $00, end_row+1
    .byte vol+8, end_row+1
    .byte F3, vol+10, end_row+1
    .byte delay, 2, G3, inst, $0B, end_row+1
    .byte vol+8, end_row+1
    .byte stop, end_row+2
    .byte F3, end_row+1
    .byte Fd3, inst, $00, end_row+1
    .byte F3, vol+9, end_row+1
    .byte Dd3, end_row+2
    .byte C3, vol+10, end_row+1
    .byte vol+9, end_row+1
    .byte vol+8, end_row+1
    .byte Ad3, inst, $0B, vol+10, end_row+1
    .byte swup, $32, end_row+2
    .byte vol+9, skip 

@PulseB_Frame0D:
    .byte vib, $84, end_row+2
    .byte vol+8, vib, $95, end_row+2
    .byte vib, $A6, end_row+1
    .byte vol+7, end_row+1
    .byte sldn, $10, end_row+1
    .byte vib, $00, end_row+1
    .byte vol+6, end_row+2
    .byte G3, vol+10, sldn, $00, end_row+1
    .byte vol+8, end_row+1
    .byte F3, inst, $00, vol+10, end_row+1
    .byte vol+8, end_row+1
    .byte G3, vol+10, end_row+1
    .byte vol+8, end_row+1
    .byte Ad3, inst, $0B, vol+10, end_row+1
    .byte vol+8, end_row+1
    .byte G3, inst, $00, vol+10, end_row+1
    .byte vol+8, end_row+1
    .byte Ad3, inst, $0B, vol+10, end_row+1
    .byte delay, 2, C4, inst, $00, end_row+1
    .byte vol+8, end_row+1
    .byte Ad3, inst, $0B, vol+10, end_row+1
    .byte delay, 2, C4, inst, $00, end_row+1
    .byte vol+8, end_row+1
    .byte delay, 2, stop, end_row+1
    .byte F4, vol+10, end_row+1
    .byte swdn, $32, end_row+2
    .byte vol+9, end_row+1
    .byte swup, $32, end_row+2
    .byte vol+8, end_row+2
    .byte vib, $86, end_row+1
    .byte vol+7, end_row+2
    .byte vib, $00, end_row+1
    .byte vol+6, slup, $18, end_row+1
    .byte stop, end_row+1
    .byte slup, $00, end_row+1
    .byte delay, 2, C4, inst, $0B, vol+10, end_row+1
    .byte vol+8, end_row+1
    .byte delay, 4, Ad3, inst, $00, vol+10, end_row+1
    .byte vol+9, end_row+1
    .byte vol+8, end_row+1
    .byte vol+7, skip

@PulseB_Frame0E:
    .byte Fd4, inst, $0B, vol+10, end_row+1
    .byte vol+8, end_row+1
    .byte delay, 2, Dd4, inst, $00, vol+10, end_row+1
    .byte vol+8, end_row+1
    .byte delay, 4, Cd4, inst, $0B, vol+10, end_row+1
    .byte vol+9, end_row+1
    .byte vol+8, end_row+1
    .byte vol+7, end_row+1
    .byte Ad3, inst, $00, vol+10, end_row+1
    .byte vol+8, end_row+1
    .byte delay, 2, Gd3, inst, $0B, vol+10, end_row+1
    .byte vol+8, end_row+1
    .byte delay, 4, Fd3, inst, $00, vol+10, end_row+1
    .byte vol+9, end_row+1
    .byte vol+8, end_row+1
    .byte vol+7, end_row+1
    .byte Dd3, inst, $0B, vol+10, end_row+1
    .byte vol+8, end_row+1
    .byte delay, 2, Cd3, inst, $00, vol+10, end_row+1
    .byte vol+8, end_row+1
    .byte delay, 4, Ad2, inst, $0B, vol+10, end_row+1
    .byte vol+9, end_row+1
    .byte vol+8, end_row+1
    .byte vol+7, end_row+1
    .byte Gd2, inst, $00, vol+10, end_row+1
    .byte vol+8, end_row+1
    .byte delay, 2, Fd2, inst, $0B, vol+10, end_row+1
    .byte vol+8, end_row+1
    .byte delay, 4, Dd2, inst, $00, vol+10, end_row+1
    .byte vol+9, end_row+1
    .byte vol+8, end_row+1
    .byte vol+7, end_row+1
    .byte Cd2, inst, $0B, vol+10, end_row+1
    .byte delay, 1, Dd2, inst, $00, end_row+1
    .byte delay, 2, Fd2, end_row+1
    .byte vol+8, end_row+1
    .byte Gd2, inst, $0B, vol+10, end_row+1
    .byte delay, 1, A2, inst, $00, end_row+1
    .byte delay, 2, Ad2, end_row+1
    .byte vol+8, end_row+1
    .byte Cd3, inst, $0B, vol+10, end_row+1
    .byte delay, 1, Dd3, inst, $00, end_row+1
    .byte delay, 2, F3, end_row+1
    .byte vol+8, end_row+1
    .byte Fd3, inst, $0B, vol+10, end_row+1
    .byte delay, 1, Gd3, inst, $00, end_row+1
    .byte delay, 2, Ad3, end_row+1
    .byte vol+8, end_row+1
    .byte Cd4, inst, $0B, vol+10, end_row+1
    .byte delay, 1, D4, inst, $00, end_row+1
    .byte delay, 2, Dd4, end_row+1
    .byte vol+8, end_row+1
    .byte Fd4, inst, $0B, vol+10, end_row+1
    .byte delay, 1, Gd4, inst, $00, end_row+1
    .byte delay, 2, Ad4, end_row+1
    .byte vol+8, end_row+1
    .byte Cd5, inst, $0B, vol+10, end_row+1
    .byte delay, 1, D5, inst, $00, end_row+1
    .byte delay, 2, Dd5, end_row+1
    .byte vol+8, end_row+1
    .byte Fd5, inst, $0B, vol+10, end_row+2
    .byte swup, $12, end_row+1
    .byte vol+9, skip

@PulseB_Frame0F:
    .byte end_row+2
    .byte vol+8, end_row+2
    .byte swup, $12, end_row+2
    .byte vol+7, end_row+1
    .byte swdn, $12, end_row+3
    .byte vol+6, swup, $12, end_row+4
    .byte swdn, $12, end_row+1
    .byte vol+5, end_row+3
    .byte swup, $12, end_row+2
    .byte vol+4, end_row+3
    .byte swdn, $12, end_row+4
    .byte vol+3, end_row+5
    .byte vib, $84, end_row+12
    .byte vib, $00, end_row+1
    .byte slup, $03, end_row+3
    .byte sldn, $0F, end_row+4
    .byte Cd6, inst, $00, vol+2, end_row+4
    .byte Cd6, vol+1, end_row+4
    .byte stop, sldn, $00, end_row+4 

@PulseB_Frame18:
    .byte D3, vol+10, duty+0, end_row+2
    .byte vol+9, end_row+2
    .byte vol+8, vib, $64, end_row+2
    .byte vol+7, end_row+1
    .byte vib, $00, end_row+1
    .byte Ad2, vol+10, port, $18, end_row+2
    .byte vol+9, end_row+2
    .byte vol+8, vib, $64, end_row+2
    .byte vol+7, end_row+2
    .byte A3, vol+10, vib, $00, end_row+2
    .byte vol+9, end_row+2
    .byte vol+8, vib, $64, end_row+2
    .byte vol+7, end_row+2
    .byte F3, vol+10, vib, $00, end_row+2
    .byte vol+9, end_row+2
    .byte vol+8, vib, $64, end_row+2
    .byte vol+7, end_row+2
    .byte C4, vol+10, vib, $00, end_row+2
    .byte vol+9, end_row+2
    .byte vol+8, vib, $64, end_row+2
    .byte vol+7, end_row+2
    .byte A3, vol+10, vib, $00, end_row+2
    .byte vol+9, end_row+2
    .byte vol+8, vib, $64, end_row+2
    .byte vol+7, end_row+1
    .byte vib, $00, skip

@PulseB_Frame19:
    .byte Cd3, vol+10, port, $00, end_row+1
    .byte vol+9, end_row+2
    .byte vol+8, end_row+1
    .byte vol+7, vib, $64, end_row+1
    .byte vib, $00, end_row+1
    .byte Gd2, vol+10, port, $18, end_row+1
    .byte vol+9, end_row+2
    .byte vol+8, end_row+1
    .byte vol+7, vib, $64, end_row+2
    .byte F3, vol+10, vib, $00, end_row+1
    .byte vol+9, end_row+2
    .byte vol+8, end_row+1
    .byte vol+7, vib, $64, end_row+2
    .byte C3, vol+10, vib, $00, end_row+1
    .byte vol+9, end_row+2
    .byte vol+8, end_row+1
    .byte vol+7, vib, $64, end_row+2
    .byte Gd3, vol+10, vib, $00, end_row+1
    .byte vol+9, end_row+2
    .byte vol+8, end_row+1
    .byte vol+7, vib, $64, end_row+2
    .byte F3, vol+10, vib, $00, end_row+1
    .byte vol+9, end_row+2
    .byte vol+8, end_row+1
    .byte vol+7, vib, $64, end_row+2
    .byte C4, vol+10, vib, $00, end_row+1
    .byte vol+9, end_row+2
    .byte vol+8, end_row+1
    .byte vol+7, vib, $64, end_row+2
    .byte Gd3, vol+10, vib, $00, end_row+1
    .byte vol+9, end_row+2
    .byte vol+8, port, $00, end_row+1
    .byte vol+7, vib, $64, end_row+1
    .byte vib, $00, skip

@PulseB_Frame1A:
    .byte D4, inst, $01, vol+10, duty+2, end_row+1
    .byte vol+9, end_row+2
    .byte vol+8, end_row+1
    .byte D4, vol+7, end_row+2
    .byte vol+6, end_row+1
    .byte vol+5, end_row+1
    .byte C4, vol+10, end_row+1
    .byte vol+9, end_row+2
    .byte vol+8, end_row+1
    .byte C4, vol+7, end_row+2
    .byte vol+6, end_row+1
    .byte vol+5, end_row+1
    .byte A3, vol+10, end_row+1
    .byte vol+9, end_row+2
    .byte vol+8, end_row+1
    .byte A3, vol+7, end_row+2
    .byte vol+6, end_row+1
    .byte vol+5, end_row+1
    .byte G3, vol+10, end_row+1
    .byte vol+9, end_row+2
    .byte vol+8, end_row+1
    .byte G3, vol+7, end_row+2
    .byte vol+6, end_row+1
    .byte vol+5, end_row+1
    .byte F3, vol+10, end_row+1
    .byte vol+9, end_row+2
    .byte vol+8, end_row+1
    .byte F3, vol+7, end_row+2
    .byte vol+6, end_row+1
    .byte vol+5, end_row+1
    .byte D3, vol+10, end_row+1
    .byte vol+9, end_row+2
    .byte vol+8, end_row+1
    .byte D3, vol+7, end_row+2
    .byte vol+6, end_row+1
    .byte vol+5, skip
    
@PulseB_Frame1B:
    .byte F4, vol+10, end_row+1
    .byte vol+9, end_row+1
    .byte vol+8, end_row+1
    .byte vol+7, end_row+1
    .byte F4, vol+6, end_row+1
    .byte vol+5, end_row+1
    .byte Dd4, vol+10, end_row+1
    .byte vol+9, end_row+1
    .byte vol+8, end_row+1
    .byte vol+7, end_row+1
    .byte Dd4, vol+6, end_row+1
    .byte vol+5, end_row+1
    .byte C4, vol+10, end_row+1
    .byte vol+9, end_row+1
    .byte vol+8, end_row+1
    .byte vol+7, end_row+1
    .byte C4, vol+6, end_row+1
    .byte vol+5, end_row+1
    .byte Ad3, vol+10, end_row+1
    .byte vol+9, end_row+1
    .byte vol+8, end_row+1
    .byte vol+7, end_row+1
    .byte Ad3, vol+6, end_row+1
    .byte vol+5, end_row+1
    .byte Gd3, vol+10, end_row+1
    .byte vol+9, end_row+1
    .byte vol+8, end_row+1
    .byte vol+7, end_row+1
    .byte Gd3, vol+6, end_row+1
    .byte vol+5, end_row+1
    .byte F3, vol+10, end_row+1
    .byte vol+9, end_row+1
    .byte vol+8, end_row+1
    .byte vol+7, end_row+1
    .byte F3, vol+6, end_row+1
    .byte vol+5, end_row+1
    .byte Dd3, vol+10, end_row+1
    .byte vol+9, end_row+1
    .byte vol+8, end_row+1
    .byte vol+7, end_row+1
    .byte Dd3, vol+6, end_row+1
    .byte vol+5, end_row+1
    .byte C3, vol+10, end_row+1
    .byte vol+9, end_row+1
    .byte vol+8, end_row+1
    .byte vol+7, end_row+1
    .byte C3, vol+6, end_row+1
    .byte vol+5, skip

@PulseB_Frame1C:
    .byte Gd2, inst, $0B, vol+11, end_row+4
    .byte vol+10, end_row+4
    .byte vol+9, sldn, $30, end_row+4
    .byte Gd2, vol+8, sldn, $00, end_row+4
    .byte vol+7, end_row+4
    .byte vol+6, sldn, $30, end_row+4
    .byte Gd2, vol+5, sldn, $00, end_row+4
    .byte vol+4, end_row+4
    .byte vol+3, sldn, $30, end_row+4
    .byte B2, vol+11, sldn, $00, end_row+1
    .byte vol+10, end_row+1
    .byte vol+9, end_row+1
    .byte vol+8, end_row+1
    .byte Ad2, vol+11, end_row+1
    .byte vol+10, end_row+1
    .byte stop, end_row+2
    .byte Gd2, vol+11, end_row+1
    .byte vol+10, end_row+1
    .byte vol+9, end_row+1
    .byte vol+8, skip

@PulseB_Frame1D:
    .byte Ad2, inst, $0B, vol+11, end_row+4
    .byte vol+10, end_row+4
    .byte vol+9, sldn, $30, end_row+4
    .byte Ad2, vol+8, sldn, $00, end_row+4
    .byte vol+7, end_row+4
    .byte vol+6, sldn, $30, end_row+4
    .byte Ad2, vol+5, sldn, $00, end_row+4
    .byte vol+4, end_row+4
    .byte vol+3, sldn, $30, end_row+4
    .byte Cd3, vol+11, sldn, $00, end_row+1
    .byte vol+10, end_row+1
    .byte vol+9, end_row+1
    .byte vol+8, end_row+1
    .byte B2, vol+11, end_row+1
    .byte vol+10, end_row+1
    .byte stop, end_row+2
    .byte Ad2, vol+11, end_row+1
    .byte vol+10, end_row+1
    .byte vol+9, end_row+1
    .byte vol+8, skip

@PulseB_Frame1E:
    .byte Cd3, vol+11, end_row+2
    .byte swup, $42, end_row+4
    .byte vol+10, end_row+6
    .byte vol+9, end_row+6
    .byte vol+8, end_row+2
    .byte swup, $75, end_row+4
    .byte vol+7, end_row+1
    .byte swdn, $75, end_row+5
    .byte vol+6, end_row+2
    .byte vib, $58, end_row+4
    .byte vol+5, end_row+4
    .byte vib, $69, end_row+2
    .byte vol+4, end_row+6
    .byte vol+3, vib, $7A, end_row+6
    .byte vol+2, end_row+2
    .byte vib, $8B, end_row+4
    .byte vol+1, end_row+3
    .byte vib, $00, skip

@PulseB_Frame1F:
    .byte B2, inst, $00, vol+8, duty+0, end_row+1
    .byte Dd3, end_row+1
    .byte F3, end_row+1
    .byte A3, duty+1, end_row+1
    .byte F3, end_row+1
    .byte Dd3, end_row+1
    .byte B2, vol+7, duty+2, end_row+1
    .byte Dd3, end_row+1
    .byte F3, end_row+1
    .byte A3, duty+1, end_row+1
    .byte F3, end_row+1
    .byte Dd3, end_row+1

    .byte B2, vol+6, duty+0, end_row+1
    .byte Dd3, end_row+1
    .byte F3, end_row+1
    .byte A3, duty+1, end_row+1
    .byte F3, end_row+1
    .byte Dd3, end_row+1
    .byte B2, vol+5, duty+2, end_row+1
    .byte Dd3, end_row+1
    .byte F3, end_row+1
    .byte A3, duty+1, end_row+1
    .byte F3, end_row+1
    .byte Dd3, end_row+1

    .byte B2, vol+4, duty+0, end_row+1
    .byte Dd3, end_row+1
    .byte F3, end_row+1
    .byte A3, duty+1, end_row+1
    .byte F3, end_row+1
    .byte Dd3, end_row+1
    .byte B2, duty+2, end_row+1
    .byte Dd3, end_row+1
    .byte F3, vol+3, end_row+1
    .byte A3, duty+1, end_row+1
    .byte F3, end_row+1
    .byte Dd3, end_row+1

    .byte B2, duty+0, end_row+1
    .byte Dd3, end_row+1
    .byte F3, end_row+1
    .byte A3, duty+1, end_row+1
    .byte F3, end_row+1
    .byte Dd3, end_row+1
    .byte B2, duty+2, end_row+1
    .byte Dd3, end_row+1
    .byte F3, vol+2, end_row+1
    .byte A3, duty+1, end_row+1
    .byte F3, end_row+1
    .byte Dd3, end_row+1

    .byte B2, duty+0, end_row+1
    .byte Dd3, end_row+1
    .byte F3, end_row+1
    .byte A3, duty+1, end_row+1
    .byte F3, end_row+1
    .byte Dd3, end_row+1
    .byte B2, duty+2, end_row+1
    .byte Dd3, end_row+1
    .byte F3, vol+3, end_row+1
    .byte A3, duty+1, end_row+1
    .byte F3, end_row+1
    .byte Dd3, end_row+63




;;;;;;;; TRIANGLE ;;;;;;;;

@Tri_Frame00:
    .byte E3, inst, $04, end_row+1
    .byte C3, inst, $00, end_row+3
    .byte stop, end_row+4
    .byte C3, inst, $03, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte stop, end_row+3
    .byte E3, end_row+1
    .byte F2, inst, $00, end_row+3
    .byte E3, inst, $04, end_row+1
    .byte stop, end_row+3
    .byte F2, inst, $03, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte Ad2, inst, $00, end_row+3
    .byte E3, inst, $04, end_row+1
    .byte stop, end_row+7
    .byte Gd2, inst, $01, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte stop, end_row+3
    .byte E3, end_row+1
    .byte stop, end_row+3
    .byte E3, end_row+1
    .byte stop, end_row+7

@Tri_Frame01:
    .byte E3, inst, $04, end_row+1
    .byte stop, end_row+3
    .byte C3, inst, $01, end_row+3
    .byte delay, 1, stop, end_row+1
    .byte C3, inst, $03, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte stop, end_row+3
    .byte E3, end_row+1
    .byte F2, inst, $00, end_row+3
    .byte E3, inst, $04, end_row+1
    .byte stop, end_row+3
    .byte F2, inst, $03, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte Ad2, inst, $00, end_row+3
    .byte E3, inst, $04, end_row+1
    .byte stop, end_row+11
    .byte E3, end_row+1
    .byte Gd2, inst, $00, end_row+3
    .byte E3, inst, $04, end_row+1
    .byte stop, end_row+3
    .byte E3, end_row+1
    .byte stop, end_row+7

@Tri_Frame08:
    .byte E3, end_row+1
    .byte F2, inst, $00, end_row+3
    .byte E3, inst, $04, end_row+1
    .byte stop, end_row+3
    .byte F2, inst, $03, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte F2, inst, $00, end_row+3
    .byte E3, inst, $04, end_row+1
    .byte stop, end_row+3
    .byte E3, end_row+1
    .byte stop, end_row+3
    .byte F2, inst, $01, end_row+3
    .byte stop, end_row+1
    .byte F2, inst, $03, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte stop, end_row+3
    .byte E3, end_row+1
    .byte stop, end_row+3
    .byte F2, inst, $03, end_row+2
    .byte F3, end_row+2
    .byte E3, inst, $04, end_row+1
    .byte F2, inst, $00, end_row+16

@Tri_Frame09:
    .byte E3, inst, $04, end_row+1
    .byte G2, inst, $00, end_row+3
    .byte E3, inst, $04, end_row+1
    .byte stop, end_row+3
    .byte G2, inst, $03, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte G2, inst, $00, end_row+3
    .byte E3, inst, $04, end_row+1
    .byte stop, end_row+3
    .byte E3, end_row+1
    .byte stop, end_row+3
    .byte G2, inst, $01, end_row+3
    .byte stop, end_row+1
    .byte G2, inst, $03, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte stop, end_row+3
    .byte E3, end_row+1
    .byte stop, end_row+3
    .byte G2, inst, $03, end_row+2
    .byte G3, end_row+2
    .byte E3, inst, $04, end_row+1
    .byte G2, inst, $00, end_row+18

@Tri_Frame0C:
    .byte E3, inst, $04, end_row+1
    .byte Ad2, inst, $00, end_row+3
    .byte E3, inst, $04, end_row+1
    .byte stop, end_row+3
    .byte Ad2, inst, $03, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte Ad2, inst, $00, end_row+3
    .byte E3, inst, $04, end_row+1
    .byte stop, end_row+3
    .byte E3, end_row+1
    .byte stop, end_row+3
    .byte Ad2, inst, $01, end_row+3
    .byte stop, end_row+1
    .byte Ad2, inst, $03, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte stop, end_row+3
    .byte E3, end_row+1
    .byte stop, end_row+3
    .byte Ad2, inst, $03, end_row+2
    .byte Ad3, end_row+2
    .byte E3, inst, $04, end_row+1
    .byte Ad2, inst, $00, end_row+3

@Tri_Frame0D:
    .byte E3, inst, $04, end_row+1
    .byte C3, inst, $00, end_row+3
    .byte E3, inst, $04, end_row+1
    .byte stop, end_row+3
    .byte C3, inst, $03, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte C3, inst, $00, end_row+3
    .byte E3, inst, $04, end_row+1
    .byte stop, end_row+3
    .byte E3, end_row+1
    .byte stop, end_row+3
    .byte C3, inst, $01, end_row+3
    .byte stop, end_row+1
    .byte C3, inst, $03, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte stop, end_row+3
    .byte E3, end_row+1
    .byte stop, end_row+3
    .byte C3, inst, $03, end_row+2
    .byte C4, end_row+2
    .byte E3, inst, $04, end_row+1
    .byte C3, inst, $00, end_row+3

@Tri_Frame0E:
    .byte Cd3, inst, $01, end_row+8
    .byte E3, inst, $04, end_row+1
    .byte Cd3, inst, $00, end_row+3
    .byte E3, inst, $04, end_row+1
    .byte Cd3, inst, $00, end_row+3
    .byte E3, inst, $04, end_row+1
    .byte Cd3, inst, $00, end_row+3
    .byte E3, inst, $04, end_row+1
    .byte Cd3, inst, $00, end_row+15
    .byte E3, inst, $04, end_row+1
    .byte Cd3, inst, $00, end_row+3
    .byte E3, inst, $04, end_row+1
    .byte Cd3, inst, $00, end_row+3
    .byte E3, inst, $04, end_row+1
    .byte Cd3, inst, $00, end_row+3
    .byte E3, inst, $03, end_row+1
    .byte Cd3, inst, $00, end_row+1
    .byte Cd2, port, $08, end_row+14

@Tri_Frame0F:
    .byte Cd2, inst, $01, port, $00, end_row+8
    .byte E3, inst, $04, end_row+1
    .byte Cd2, inst, $00, end_row+3
    .byte E3, inst, $04, end_row+1
    .byte Cd2, inst, $00, end_row+3
    .byte E3, inst, $04, end_row+1
    .byte Cd2, inst, $00, end_row+3
    .byte E3, inst, $04, end_row+1
    .byte Cd2, inst, $00, end_row+15
    .byte E3, inst, $04, end_row+1
    .byte Cd2, inst, $00, end_row+3
    .byte E3, inst, $04, end_row+1
    .byte Cd2, inst, $00, end_row+3
    .byte E3, inst, $04, end_row+1
    .byte Cd2, inst, $00, end_row+3
    .byte E3, inst, $04, end_row+1
    .byte Cd2, inst, $00, end_row+7
    .byte E3, inst, $04, end_row+1
    .byte Cd5, inst, $03, end_row+3
    .byte Cd4, end_row+4

@Tri_Frame10:
    .byte E3, inst, $04, end_row+1
    .byte C2, inst, $00, end_row+3
    .byte C3, inst, $05, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte stop, end_row+3
    .byte C3, inst, $05, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte F1, inst, $00, end_row+3
    .byte F2, inst, $05, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte F1, inst, $00, end_row+3
    .byte Ad1, inst, $01, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte Ad2, inst, $05, end_row+3
    .byte Ad1, inst, $01, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte Gd1, inst, $00, end_row+3
    .byte Gd2, inst, $05, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte Gd1, inst, $00, end_row+3
    .byte Gd2, inst, $05, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte Gd1, inst, $00, end_row+3

@Tri_Frame11:
    .byte E3, inst, $04, end_row+1
    .byte stop, end_row+3
    .byte C2, inst, $01, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte C3, inst, $05, end_row+3
    .byte C2, inst, $01, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte F1, inst, $00, end_row+3
    .byte F2, inst, $05, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte F1, inst, $00, end_row+3
    .byte Ad1, inst, $01, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte Ad2, inst, $05, end_row+3
    .byte Ad1, inst, $01, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte Ad1, inst, $05, end_row+3
    .byte Gd1, inst, $01, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte Gd2, inst, $05, end_row+3
    .byte Gd1, inst, $01, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte Gd2, inst, $05, end_row+3

@Tri_Frame18:
    .byte E3, inst, $04, end_row+1
    .byte G1, inst, $00, end_row+3
    .byte G2, inst, $05, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte G1, inst, $00, end_row+3
    .byte G2, inst, $05, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte G1, inst, $00, end_row+3
    .byte G2, inst, $05, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte G1, inst, $00, end_row+3
    .byte G2, inst, $05, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte G1, inst, $00, end_row+3
    .byte G2, inst, $05, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte G1, inst, $00, end_row+3
    .byte G2, inst, $05, end_row+4

@Tri_Frame19:
    .byte E3, inst, $04, end_row+1
    .byte Dd2, inst, $00, end_row+3
    .byte Dd3, inst, $05, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte Dd2, inst, $00, end_row+3
    .byte Dd3, inst, $05, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte Dd2, inst, $00, end_row+3
    .byte Dd3, inst, $05, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte Dd2, inst, $00, end_row+3
    .byte Dd3, inst, $05, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte Dd2, inst, $00, end_row+3
    .byte Dd3, inst, $05, end_row+4
    .byte E3, inst, $04, end_row+1
    .byte Dd2, inst, $00, end_row+3
    .byte Dd3, inst, $05, end_row+63

@Tri_Frame1C:
    .byte end_row+63
@Tri_Frame1D:
    .byte end_row+63
@Tri_Frame1E:
    .byte end_row+63
@Tri_Frame1F:
    .byte end_row+63


;;;;;;;; NOISE ;;;;;;;;

@Noise_Frame00:
    .byte N0, duty+0, end_row+3
    .byte N1, end_row+3
    .byte N2, end_row+3
    .byte N3, end_row+3
    .byte N4, end_row+3
    .byte N5, end_row+3
    .byte N6, end_row+3
    .byte N7, end_row+3
    .byte N8, end_row+3
    .byte N9, end_row+3
    .byte NA, end_row+3
    .byte NB, end_row+3
    .byte NC, end_row+3
    .byte ND, end_row+3
    .byte NE, end_row+3
    .byte NF, end_row+63

@Noise_Frame02:
    .byte N0, duty+1, end_row+3
    .byte N1, end_row+3
    .byte N2, end_row+3
    .byte N3, end_row+3
    .byte N4, end_row+3
    .byte N5, end_row+3
    .byte N6, end_row+3
    .byte N7, end_row+3
    .byte N8, end_row+3
    .byte N9, end_row+3
    .byte NA, end_row+3
    .byte NB, end_row+3
    .byte NC, end_row+3
    .byte ND, end_row+3
    .byte NE, end_row+3
    .byte NF, end_row+63
@Noise_Frame03:
    .byte stop, end_row+63
@Noise_Frame0F:
@Noise_Frame10:
@Noise_Frame12:
@Noise_Frame13:
@Noise_Frame1D:

