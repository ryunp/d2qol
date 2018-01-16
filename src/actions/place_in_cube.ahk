Place_In_Cube() {
	global

	if not (config.game.manualpickup) {
		SendInput, {LButton}
		sleep % config.game.interactiondelay
	}

	block_mouse_input(true)
	MouseGetPos, x, y
	
	; Cube hitbox detection workaround
	coord := config.coords.cube
	SendMode Event                        ; trigger mouse moving
	MouseMove % coord.x, % coord.y - 50   ; start above target location
	MouseMove % coord.x, % coord.y, 2     ; simulate moving over cube
	SendMode Input                        ; set back to teleporting
	
	; Wait a for item pickup to register, then deposite into cube
	sleep, % config.game.interactiondelay
	SendInput, {LButton}

	MouseMove, % x, % y
	block_mouse_input(false)
}