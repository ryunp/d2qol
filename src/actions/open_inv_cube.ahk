Open_Inv_Cube() {
	global
	
	block_mouse_input(true)
	MouseGetPos, mX, mY

	; Open inventory pane
	Send, % config.user.game_keybind_inventory
	sleep, % 1000/GAME_FPS ; wait 1 frame just to be sure

	; Move to cube location
	point := config.user.coords_cube
	MouseMove, % point.x, % point.y
	SendInput, {RButton}
	
	MouseMove, % mX, % mY
	block_mouse_input(false)
}