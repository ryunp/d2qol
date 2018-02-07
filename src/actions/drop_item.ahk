Drop_Item() {
    ; Check settings for optional behavior
    if not (config.user.manual_pickup) {
        SendInput, {LButton}
        sleep, % config.user.interaction_delay
    }

    block_mouse_input(true)
    MouseGetPos, mX, mY

    ; Drop offset from top left of active window, which covers all resolutions
    MouseMove, 10, 40
    SendInput, {LButton}

    MouseMove, % mX, % mY
    block_mouse_input(false)
}