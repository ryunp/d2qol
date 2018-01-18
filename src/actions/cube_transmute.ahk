Cube_Transmute() {
    global

    block_mouse_input(true)
    MouseGetPos, x, y

	point := config.coords.transmute
	MouseMove % point.x, % point.y
	SendInput, {LButton}

	MouseMove, % x, % y
    block_mouse_input(false)
}