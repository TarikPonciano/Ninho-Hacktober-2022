; Controller

Joy_Data = $00FC
; This is the memory address we need to manipulate from to communicate with the controller.
Controller_1 = $4016
; These memory addresses refers to how many frames a button has been pressed.
Button_Right_HoldTimer = $100
Button_Left_HoldTimer = $101
Button_Down_HoldTimer = $102
Button_Up_HoldTimer = $103
Button_Start_HoldTimer = $104
Button_Select_HoldTimer = $105
Button_B_HoldTimer = $106
Button_A_HoldTimer = $107

Joy_Right = 1 << 0
Joy_Left = 1 << 1
Joy_Down = 1 << 2
Joy_Up = 1 << 3
Joy_Start = 1 << 4
Joy_Select = 1 << 5
Joy_B = 1 << 6
Joy_A = 1 << 7

update_controller:
    ldx #1          ; open controller 1 bus
    stx Controller_1
    dex             ; close controller 1 bus with new input data
    stx Controller_1
    ldx #7

    @readController: 
        lda Controller_1                         ; Load button bit
        lsr A                              ; Move the loaded bit to carry bit.
        bcs @ButtonSet                      

        ; clear hold timer
        lda #0
        sta Button_Right_HoldTimer, X 
        rol Joy_Data
        dex 
        bpl @readController
        rts 

        ; if button was held
        @ButtonSet:
        rol Button_Right_HoldTimer, X              ; Rotate the carry bit to bit 0.
        sec 
        rol Joy_Data
        dex                              ; Decrement X register.
        bpl @readController                  ; If we still have something to read, go back.

    rts 