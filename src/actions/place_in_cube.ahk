; Issue: Large items wont go into cube! SendMode work around:
; 'SendMode Input' teleports the mouse around. 'SendMode Event' simulates the
; mouse as typical distance interpolation. Mouse events update the d2
; window and is what triggers the d2 engine's recalculation for item hitbox(?).
; Or something like that? Teleporting is bad for large items and their hitbox.
Place_In_Cube() {
	global

	point := config.coords.cube

	if not (config.game.manualpickup) {
		Click
		sleep 150
	}

	; Ignore user, save mouse
	BlockInput, On
	MouseGetPos, x, y
	
	; Hitbox workaround
	SendMode Event                        ; trigger mouse moving
	MouseMove % point.x, % point.y - 50   ;  p1
	MouseMove % point.x, % point.y, 2     ;  p2
	SendMode Input                        ; set back to teleporting
	
	; Click at location
	Click

	MouseMove, % x, % y
	BlockInput, Off
}