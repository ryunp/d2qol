Place_In_Cube() {
	global

	point := config.coords.cube

	if not (config.game.manualpickup) {
		Click
		sleep 126 ; wait three frames
	}

	; Ignore user, save mouse
	BlockInput, On
	MouseGetPos, x, y
	
	; Hitbox workaround
	SendMode Event                        ; trigger mouse moving
	MouseMove % point.x, % point.y - 50   ;  p1
	MouseMove % point.x, % point.y, 2     ;  p2
	SendMode Input                        ; set back to teleporting
	sleep, 84 ; wait two frames
	
	; Click at location
	Click

	MouseMove, % x, % y
	BlockInput, Off
}