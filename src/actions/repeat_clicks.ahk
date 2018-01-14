Repeat_Clicks() {
    global

    static looper := ""
    
    cfg := config.actions.Repeat_Clicks
    if (looper && looper.active) {
        if (cfg.disablemouse) {
            BlockInput, Off
            BlockInput, MouseMoveOff
        }
        looper.stop()
    } else {
        looper := new Action_Loop(cfg.quantity, cfg.delay, func("rc_tick_callback"))
        looper.setRequiredWindow("Diablo II ahk_class Diablo II")
        looper.start()
         if (cfg.disablemouse) {
            BlockInput, MouseMove
        }
    }
}

rc_tick_callback(current, quantity, delay) {
    global

    if (current < 2) {
         if (cfg.disablemouse) {
            BlockInput, Off
            BlockInput, MouseMoveOff
        }
    }

    Click
    TrayTip, Clicker, % current "/" quantity " [" delay "ms]"
}