test_module_new:
; Module for RMD Driver v1.1
; This area points where in ROM the frame pointers are.
.word @PulseA_FramePointer, @PulseB_FramePointer, @Tri_FramePointer, @Noise_FramePointer

; Now let's go for module properties
; Number of frames between each row (higher value the longer a frame is)
.byte 3

; Total rows per frame
.byte 60

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
    ; .byte D4, trans, 8, inst, 1, vol, 10, duty, 2, end_row, 6
    note D4 
        inst 1 
        vol 10 
        duty 2 
        fix_length 1
        end_row
    vol 0
        end_row 
    note Ad3 
        vol 10 
        duty 2
        end_row
    note D4 
        vol 3 
        duty 0
        end_row
    note G3 
        vol 9
        duty 2
        end_row
    note Ad3 
        vol 3
        duty 0
        end_row
    note Dd3 
        vol 9
        duty 2
        end_row
    note G3 
        vol 3
        duty 0
        end_row
    note D3 
        vol 8
        duty 2
        end_row
    note Dd3
        vol 3
        duty 0
        end_row
    note Ad2
        vol 8
        duty 2
        end_row
    note D3
        vol 3
        duty 0
        end_row
    note G2
        vol 7
        duty 2
        end_row
    note Ad2
        vol 3
        duty 0 
        end_row 
    note Dd2
        vol 7
        duty 2
        end_row
    note G2
        vol 3
        duty 0
        end_row
    note Dd4
        vol 10
        duty 2
        end_row
    note Dd2
        vol 3
        duty 0
        end_row
    note C4
        vol 10
        duty 2
        end_row
    note Dd4
        vol 3
        duty 0
        end_row
    note Gd3
        vol 9
        duty 2
        end_row
    note C4
        vol 3
        duty 0
        end_row
    note G3
        vol 9
        duty 2
        end_row
    note Gd3
        vol 3
        duty 0
        end_row
    note Dd3
        vol 8
        duty 2
        end_row
    note G3
        vol 3
        duty 0
        end_row
    note C3
        vol 8
        duty 2
        end_row
    note Dd3
        vol 3
        duty 0
        end_row
    note C4
        vol 10
        duty 2
        end_row
    note C3
        vol 3
        duty 0
        end_row
    note Gd3
        vol 10
        duty 2
        end_row
    note C4
        vol 3
        duty 0
        end_row
    note F3
        vol 9
        duty 2
        end_row
    note Gd3
        vol 3
        duty 0
        end_row
    note Cd3
        vol 9
        duty 2
        end_row
    note F3
        vol 3
        duty 0
        end_row
    note C3
        vol 8
        duty 2
        end_row
    note Cd3
        vol 3
        duty 0
        end_row
    note Gd2
        vol 8
        duty 2
        end_row
    note C3
        vol 3
        duty 0
        end_row
    note Dd4
        vol 10
        duty 2
        end_row
    note Gd2
        vol 3
        duty 0
        end_row
    note B3
        vol 10
        duty 2
        end_row
    note Dd4
        vol 3
        duty 0
        end_row
    note Ad3
        vol 9
        duty 2
        end_row
    note B3
        vol 3
        duty 0
        end_row
    note Fd3
        vol 9
        duty 2
        end_row
    note Ad3
        vol 3
        duty 0
        end_row
    note Dd3
        vol 8
        duty 2
        end_row
    note Fd3
        vol 3
        duty 0
        end_row
    note B2
        vol 8
        duty 2
        end_row
    note Dd3
        vol 3
        duty 0
        end_row
    note Ad2
        vol 7
        duty 2
        end_row
    note B2
        vol 3
        duty 0
        end_row
    note Fd2
        vol 7
        duty 2
        end_row
    note Ad2
        vol 3
        duty 0
        end_row
    note Dd2
        vol 6
        duty 2
        end_row
    note Fd2
        vol 2
        duty 0
        end_row
    note B1
        vol 6
        duty 2
        end_row
    note Dd2
        vol 2
        duty 0
        fix_length 0
        end_row 255

    
    


@PulseB_Frame000:
@Tri_Frame000:
@Noise_Frame000: