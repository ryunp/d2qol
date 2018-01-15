Open_Cube() {
    point := config.coords.cube

    ; Ignore user, save mouse
    block_mouse_input(true)
    MouseGetPos, x, y

    ; move to cube location
    MouseMove % point.x, % point.y

    ; Open cube
    SendInput, {RButton}
    sleep % 42 ; wait 1 frame
    
    ; Revert position
    MouseMove, % x, % y
    block_mouse_input(false)
}