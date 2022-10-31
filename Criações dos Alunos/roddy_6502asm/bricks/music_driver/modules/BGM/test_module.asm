test_module:
; Module for RMD Driver v1.1
; This area points where in ROM the frame pointers are.
.word @PulseA_FramePointer, @PulseB_FramePointer, @Tri_FramePointer, @Noise_FramePointer

; Now let's go for module properties
; Number of frames between each row (higher value the longer a frame is)
.byte 3

; Total rows per frame
.byte 64

; Total number of frames
.byte 0

; ROM Bank this module is in:
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
    trans 8, 0
    note D4, 0
        inst 1, 0 
        vol 10, 0
        duty 2, 6
        ; duty 0, 3
    note Ad3, 0
        duty 2, 3
    note D4, 0
        vol 3, 0
        duty 0, 3
    note G3, 0
        vol 9, 0
        duty 2, 3
    note Ad3, 0
        vol 3, 0
        duty 0, 3
    note Dd3, 0
        vol 9, 0
        duty 2, 3
    note G3, 0
        vol 3, 0
        duty 0, 3
    note D3, 0
        vol 8, 0
        duty 2, 3
    note Dd3, 0
        vol 3, 0
        duty 0, 3
    note Ad2, 0
        vol 8, 0
        duty 2, 3
    note D3, 0
        vol 3, 0
        duty 0, 3
    note G2, 0
        vol 7, 0
        duty 2, 3
    note Ad2, 0
        vol 3, 0
        duty 0, 3
    note Dd2, 0
        vol 7, 0
        duty 2, 3
    note G2, 0
        vol 3, 0
        duty 0, 3
    note Dd4, 0
        vol 10, 0
        duty 2, 3
    note Dd2, 0
        vol 3, 0
        duty 0, 3
    note C4, 0
        vol 10, 0
        duty 2, 3
    note Dd4, 0
        vol 3, 0
        duty 0, 3
    note Gd3, 0
        vol 9, 0
        duty 2, 3
    note C4, 0
        vol 3, 0
        duty 0, 3
    note G3, 0
        vol 9, 0
        duty 2, 3
    note Gd3, 0
        vol 3, 0
        duty 0, 3
    note Dd3, 0
        vol 8, 0
        duty 2, 3
    note G3, 0
        vol 3, 0
        duty 0, 3
    note C3, 0
        vol 8, 0
        duty 2, 3
    note Dd3, 0
        vol 3, 0
        duty 0, 3
    note C4, 0
        vol 10, 0
        duty 2, 3
    note C3, 0
        vol 3, 0
        duty 0, 3
    note Gd3, 0
        vol 10, 0
        duty 2, 3
    note C4, 0
        vol 3, 0
        duty 0, 3
    note F3, 0
        vol 9, 0
        duty 2, 3
    note Gd3, 0
        vol 3, 0
        duty 0, 3
    note Cd3, 0
        vol 9, 0
        duty 2, 3
    note F3, 0
        vol 3, 0
        duty 0, 3
    note C3, 0
        vol 8, 0
        duty 2, 3
    note Cd3, 0
        vol 3, 0
        duty 0, 3
    note Gd2, 0
        vol 8, 0
        duty 2, 3
    note C3, 0
        vol 3, 0
        duty 0, 3
    note Dd4, 0
        vol 10, 0
        duty 2, 3
    note Gd2, 0
        vol 3, 0
        duty 0, 3
    note B3, 0
        vol 10, 0
        duty 2, 3
    note Dd4, 0
        vol 3, 0
        duty 0, 3
    note Ad3, 0
        vol 9, 0
        duty 2, 3
    note B3, 0
        vol 3, 0
        duty 0, 3
    note Fd3, 0
        vol 9, 0
        duty 2, 3
    note Ad3, 0
        vol 3, 0
        duty 0, 3
    note Dd3, 0
        vol 8, 0
        duty 2, 3
    note Fd3, 0
        vol 3, 0
        duty 0, 3
    note B2, 0
        vol 8, 0
        duty 2, 3
    note Dd3, 0
        vol 3, 0
        duty 0, 3
    note Ad2, 0
        vol 7, 0
        duty 2, 3
    note B2, 0
        vol 3, 0
        duty 0, 3
    note Fd2, 0
        vol 7, 0
        duty 2, 3
    note Ad2, 0
        vol 3, 0
        duty 0, 3
    note Dd2, 0
        vol 6, 0
        duty 2, 3
    note Fd2, 0
        vol 2, 0
        duty 0, 3
    note B1, 0
        vol 6, 0
        duty 2, 3
    note Dd2, 0
        vol 2, 0
        duty 0, 255

    
    


@PulseB_Frame000:
@Tri_Frame000:
@Noise_Frame000: