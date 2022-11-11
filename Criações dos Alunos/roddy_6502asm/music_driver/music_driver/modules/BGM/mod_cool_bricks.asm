module_coolbricks:
; Module for RMD Driver v1.1
; This area points where in ROM the frame pointers are.
.word @PulseA_FramePointer, @PulseB_FramePointer, @Tri_FramePointer, @Noise_FramePointer

; Now let's go for module properties
; Speed
.byte 3

; Tempo
.byte 145

; Total rows per frame
.byte 71

; Total number of frames
.byte 0

@PulseA_FramePointer:
    .word @PulseA_Frame000

@PulseB_FramePointer:
    .word @PulseB_Frame000

@Tri_FramePointer:
    .word @Tri_Frame000

@Noise_FramePointer:
    .word @Noise_Frame000

@PulseA_Frame000:
    .byte vol+15, inst, $13, end_row+5
    .byte G3, end_row+9
    .byte G3, end_row+9
    .byte F3, end_row+9
    .byte F3, end_row+9
    .byte G3, end_row+9
    .byte G3, end_row+9
    .byte F3, end_row+9
    .byte F3, end_row+4

@PulseB_Frame000:
    .byte vol+10, inst, $12, end_row+3
    .byte F4, end_row+2
    .byte G4, end_row+3
    .byte stop, end_row+15
    .byte G4, end_row+2
    .byte F4, end_row+3
    .byte stop, end_row+63

@Tri_Frame000:
    .byte Ad2, inst, $11, end_row+4
    .byte stop, end_row+3
    .byte Ad2, end_row+4
    .byte stop, end_row+3
    .byte Ad2, end_row+5
    .byte Gd3, end_row+5
    .byte stop, end_row+63

@Noise_Frame000:
    .byte stop, end_row+63