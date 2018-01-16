Cube_Transmute() {
    global

	point := config.coords.transmute

    block_mouse_input(true)
	MouseGetPos, x, y

	MouseMove % point.x, % point.y
	SendInput, {LButton}

	MouseMove, % x, % y
    block_mouse_input(false)
}