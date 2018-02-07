Repeat_Clicks() {
    static clicker
    
    ; Create a single instance of action loop for reuse
    if not (clicker) {
        clicker := new Action_Loop(func("_cb_repeat_clicks_tick"), D2_WINDOW)
    }
    
    ; Check active status
    cfg := config.actions.Repeat_Clicks
    if (clicker.active) {
        clicker.stop()

        ; Optional mouse disable
        if (cfg.disable_mouse) {
            block_mouse_input(false)
        }
    } else {
        clicker.start(cfg.quantity, cfg.delay)

        ; Optional mouse disable
        if (cfg.disable_mouse) {
            block_mouse_input(true)
        }
    }
}

_cb_repeat_clicks_tick(current, quantity, delay) {
    global

    ; Action to perform
    SendInput, {LButton}

    ; Optional notify progress
    cfg := config.actions.Repeat_Clicks
    if (cfg.notify_progress) {
        TrayTip, d2qol Clicker, % current "/" quantity " [" delay "ms]"
    }

    ; Optional mouse disable
    if (current >= quantity) {
        if (cfg.disable_mouse) {
            block_mouse_input(false)
        }
    }
}