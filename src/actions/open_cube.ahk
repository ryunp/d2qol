Open_Cube() {
    block_mouse_input(true)
    MouseGetPos, mX, mY

    point := config.user.coords_cube
    MouseMove, % point.x, % point.y
    SendInput, {RButton}
    
    MouseMove, % mX, % mY
    block_mouse_input(false)
}