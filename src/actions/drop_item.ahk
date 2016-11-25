Drop_Item() {
	
	WinGetPos,,, wW, wH, A
	
	; Ignore user, save mouse
	BlockInput, On
	MouseGetPos, mX, mY

	; Drop in left half
	MouseMove % wW * 0.25, wH * 0.5
	Click

	MouseMove, % mX, % mY
	BlockInput, Off
}