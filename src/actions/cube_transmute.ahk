Cube_Transmute() {

	point := config.coords.transmute

	; Ignore user, save mouse
	BlockInput, On
	MouseGetPos, x, y

	; Click at location
	MouseMove % point.x, % point.y
	Click

	MouseMove, % x, % y
	BlockInput, Off
}