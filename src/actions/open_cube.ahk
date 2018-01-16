Open_Cube() {
    global

    point := config.coords.cube

    ; Ignore user, save mouse
    block_mouse_input(true)
    MouseGetPos, x, y

    ; Move to cube location
    MouseMove % point.x, % point.y
    sleep % 42*1 ; wait 1 frame

    ; Open cube
    SendInput, {RButton}
    
    ; Revert position
    MouseMove, % x, % y
    block_mouse_input(false)
}