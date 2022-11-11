module_spoopy:
; Module for RMD Driver v1.1
; This area points where in ROM the frame pointers are.
.word @PulseA_FramePointer, @PulseB_FramePointer, @Tri_FramePointer, @Noise_FramePointer

; Now let's go for module properties
; Speed
.byte 6

; Tempo
.byte 150

; Total rows per frame
.byte 3

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
    .byte Gd1, inst, inst::cb_000, vol+3, duty+1, end_row+2
    .byte Fd1, end_row+2

@PulseB_Frame000:
    .byte Dd1, inst, inst::cb_000, vol+3, duty+2,  end_row+2
    .byte D1, end_row+2

@Tri_Frame000:
    .byte stop, end_row+63

@Noise_Frame000:
    .byte stop, end_row+63