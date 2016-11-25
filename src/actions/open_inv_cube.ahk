Open_Inv_Cube() {

	point := config.coords.cube

	; Ignore user, save mouse
	BlockInput, On
	MouseGetPos, x, y

	; Open inventory pane
	Send, % config.keybinds.game.inv

	; move to cube location
	MouseMove % point.x, % point.y

	; Use item
	Click Right

	; When inventory is already open:
	Send, % config.keybinds.game.inv
	MouseMove % point.x, % point.y
	Click Right
	
	sleep % 42 ; wait 1 in game frame
	MouseMove, % x, % y
	BlockInput, Off
}