Drop_Item() {
	global

	WinGetPos,,, wW, wH, A
	
    ; Disable Auto-Pickup setting
	if not (config.game.manualpickup) {
		SendInput, {LButton}
		sleep % config.game.interactiondelay
	}

	block_mouse_input(true)
	MouseGetPos, mX, mY

	; Drop in left half
	MouseMove % wW * 0.25, wH * 0.5
	SendInput, {LButton}

	MouseMove, % mX, % mY
	block_mouse_input(false)
}