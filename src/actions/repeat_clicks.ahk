Repeat_Clicks() {
    static clicker
    
    ; Create a single instance of action loop for reuse
    if not (clicker) {
        clicker := new Action_Loop(D2_WINDOW)
        clicker.set_callback("tick", func("cb_repeat_clicks_tick"))
        clicker.set_callback("start", func("cb_repeat_clicks_start"))
        clicker.set_callback("stop", func("cb_repeat_clicks_stop"))
    }
    
    ; Check active status
    cfg := config.actions.Repeat_Clicks
    if (clicker.active) {
        clicker.stop()
    } else {
        clicker.start(cfg.quantity, cfg.delay)
    }
}

cb_repeat_clicks_start(current, quantity, delay) {
     ; Optional mouse disable
    if (config.actions.Repeat_Clicks.disable_mouse) {
        block_mouse_input(true)
    }
}

cb_repeat_clicks_stop(current, quantity, delay) {
    ; Optional mouse disable
    if (config.actions.Repeat_Clicks.disable_mouse) {
        block_mouse_input(false)
    }

    ; Optional notify progress
    if (config.actions.Repeat_Clicks.notify_progress) {
        TrayTip, d2qol Clicker, % "Stopped at iteration #" current
    }
}

cb_repeat_clicks_tick(current, quantity, delay) {
    ; Action to perform
    SendInput, {LButton}

    ; Optional notify progress
    if (config.actions.Repeat_Clicks.notify_progress) {
        TrayTip, d2qol Clicker, % current "/" quantity " [" delay "ms]"
    }
}