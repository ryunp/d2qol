Drop_Item() {
    global

    ; Disable Auto-Pickup setting
    if not (config.game.manualpickup) {
        SendInput, {LButton}
        sleep % config.game.interactiondelay
    }

    block_mouse_input(true)
    MouseGetPos, mX, mY

    ; Drop 100px offset from top left of current windodw
    MouseMove 100, 100
    SendInput, {LButton}

    MouseMove, % mX, % mY
    block_mouse_input(false)
}