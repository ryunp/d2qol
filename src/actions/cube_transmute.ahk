Cube_Transmute() {
    global

	point := config.coords.transmute

	; Ignore user, save mouse
    block_mouse_input(true)
	MouseGetPos, x, y

	; Click at location
	MouseMove % point.x, % point.y
	SendInput, {LButton}

    ; Revert position
	MouseMove, % x, % y
    block_mouse_input(false)
}