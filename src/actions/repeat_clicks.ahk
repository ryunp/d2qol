; I think this continues to expand 'committed memory' with each object
; initialization until app exit, so sorta memory leaks.
; TODO: Convert to global state and static methods on object
Repeat_Clicks() {
    global

    cfg := config.actions.Repeat_Clicks
    
    ; Save handle to timer
    static looper := ""

    if (looper && looper.active) {
        ; Block Mouse setting
        if (cfg.disablemouse) {
            block_mouse_input(false)
        }

        looper.stop()
    } else {
        looper := new Action_Loop(cfg.quantity, cfg.delay, func("rc_tick_callback"))
        looper.setRequiredWindow("Diablo II ahk_class Diablo II")
        looper.start()

        ; Block Mouse setting
         if (cfg.disablemouse) {
            block_mouse_input(true)
        }
    }
}

rc_tick_callback(current, quantity, delay) {
    global

    cfg := config.actions.Repeat_Clicks

    ; Action to perform
    SendInput, {LButton}

    ; Notify Progress setting
    if (cfg.notifyprogress) {
        TrayTip, Clicker, % current "/" quantity " [" delay "ms]"
    }

    ; Block Mouse setting
    if (current = quantity) {
         if (cfg.disablemouse) {
            block_mouse_input(false)
        }
    }
}