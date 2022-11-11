@PulseB_Frame02:
    .byte stop, len, 0, end_row+1+4 
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