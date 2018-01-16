Open_Inv_Cube() {
	global
	
	block_mouse_input(true)
	MouseGetPos, x, y

	; Open inventory pane
	Send, % config.game.keybinds.inventory
	sleep % 42 ; wait 1 frame just to be sure

	; Move to cube location
	coord := config.coords.cube
	MouseMove % coord.x, % coord.y
	SendInput, {RButton}
	
	MouseMove, % x, % y
	block_mouse_input(false)
}