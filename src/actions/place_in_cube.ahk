Place_In_Cube() {
	global

	point := config.coords.cube
	delay := config.game.interactiondelay

	if not (config.game.manualpickup) {
		SendInput, {LButton}
		sleep % delay
	}

	; Ignore user, save mouse
	block_mouse_input(true)
	MouseGetPos, x, y
	
	; Hitbox workaround
	SendMode Event                        ; trigger mouse moving
	MouseMove % point.x, % point.y - 50   ;  p1
	MouseMove % point.x, % point.y, 2     ;  p2
	SendMode Input                        ; set back to teleporting
	sleep, % delay
	
	; Click at location
	SendInput, {LButton}

    ; Revert position
	MouseMove, % x, % y
	block_mouse_input(false)
}