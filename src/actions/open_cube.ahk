Open_Cube() {
    global

    block_mouse_input(true)
    MouseGetPos, x, y

    coord := config.coords.cube
    MouseMove % coord.x, % coord.y
    SendInput, {RButton}
    
    MouseMove, % x, % y
    block_mouse_input(false)
}