Repeat_Clicks() {
    global    

    ; Singleton-ish
    static looper
    if not (looper) {
        looper := new Action_Loop(func("rc_tick_callback"), d2_window)
    }
    
    cfg := config.actions.Repeat_Clicks
    if (looper.active) {
        looper.stop()

        ; Block Mouse setting
        if (cfg.disablemouse) {
            block_mouse_input(false)
        }
    } else {
        looper.start(cfg.quantity, cfg.delay)

        ; Block Mouse setting
        if (cfg.disablemouse) {
            block_mouse_input(true)
        }
    }
}

rc_tick_callback(current, quantity, delay) {
    global

    ; Action to perform
    SendInput, {LButton}

    cfg := config.actions.Repeat_Clicks
    
    ; Notify Progress setting
    if (cfg.notifyprogress) {
        TrayTip, d2qol Clicker, % current "/" quantity " [" delay "ms]"
    }

    if (current = quantity) {
        ; Block Mouse setting
        if (cfg.disablemouse) {
            block_mouse_input(false)
        }
    }
}