Open_Inv_Cube() {

	point := config.coords.cube

	; In case inv is already open
	Send, {Space}

	; Ignore user, save mouse
	block_mouse_input(true)
	MouseGetPos, x, y

	; Open inventory pane
	Send, % config.game.keybinds.inventory

	; move to cube location
	MouseMove % point.x, % point.y

	; Open cube
	SendInput, {RButton}
	sleep % 42 ; wait 1 in game frame
	
    ; Revert position
	MouseMove, % x, % y
	block_mouse_input(false)
}