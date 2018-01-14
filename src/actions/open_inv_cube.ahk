Open_Inv_Cube() {

	point := config.coords.cube

	; In case inv is already open
	Send, {Space}

	; Ignore user, save mouse
	BlockInput, On
	MouseGetPos, x, y

	; Open inventory pane
	Send, % config.game.keybinds.inventory

	; move to cube location
	MouseMove % point.x, % point.y

	; Open cube
	Click Right
	sleep % 42 ; wait 1 in game frame
	
	MouseMove, % x, % y
	BlockInput, Off
}