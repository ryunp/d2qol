Cube_Transmute() {
    block_mouse_input(true)
    MouseGetPos, mX, mY

	point := config.user.coords_transmute
	MouseMove % point.x, % point.y
	SendInput, {LButton}

	MouseMove, % mX, % mY
    block_mouse_input(false)
}