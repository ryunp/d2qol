Open_Inv_Cube() {
	global
	
	point := config.coords.cube

	; Ignore user, save mouse
	block_mouse_input(true)
	MouseGetPos, x, y

	; Open inventory pane
	Send, % config.game.keybinds.inventory
	sleep % 42*1 ; wait 1 frame

	; Move to cube location
	MouseMove % point.x, % point.y

	; Open cube
	SendInput, {RButton}
	
    ; Revert position
	MouseMove, % x, % y
	block_mouse_input(false)
}