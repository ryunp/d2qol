Place_In_Cube() {
	global

    ; Optional auto-pickup
	if not (config.user.manual_pickup) {
		SendInput, {LButton}
		sleep, % config.user.interaction_delay
	}

	block_mouse_input(true)
	MouseGetPos, mX, mY
	
	; Cube hitbox detection workaround
	point := config.user.coords_cube
	SendMode, Event                        ; trigger mouse moving
	MouseMove, % point.x, % point.y - 50   ; start above target location
	MouseMove, % point.x, % point.y, 2     ; simulate moving over cube
	SendMode, Input                        ; set back to teleporting
	
	; Wait for dragging over cube's hitbox to register
	sleep, % config.user.interaction_delay
	SendInput, {LButton}

	MouseMove, % mX, % mY
	block_mouse_input(false)
}