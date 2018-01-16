Drop_Item() {
	global

	WinGetPos,,, wW, wH, A
	
	if not (config.game.manualpickup) {
		SendInput, {LButton}
		sleep % 42*3 ; wait three frames
	}

	; Ignore user, save mouse
	block_mouse_input(true)
	MouseGetPos, mX, mY

	; Drop in left half
	MouseMove % wW * 0.25, wH * 0.5
	SendInput, {LButton}

    ; Revert position
	MouseMove, % mX, % mY
	block_mouse_input(false)
}