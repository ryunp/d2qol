Repeat_Clicks() {
    global

    static looper := ""
    
    cfg := config.actions.Repeat_Clicks
    if (looper && looper.active) {
        if (cfg.disablemouse) {
            block_mouse_input(false)
        }
        looper.stop()
    } else {
        looper := new Action_Loop(cfg.quantity, cfg.delay, func("rc_tick_callback"))
        looper.setRequiredWindow("Diablo II ahk_class Diablo II")
        looper.start()
         if (cfg.disablemouse) {
            block_mouse_input(true)
        }
    }
}

rc_tick_callback(current, quantity, delay) {
    global

    SendInput, {LButton}
    TrayTip, Clicker, % current "/" quantity " [" delay "ms]"
    
    if (current = quantity) {
         if (cfg.disablemouse) {
            block_mouse_input(false)
        }
    }
}