Class Action_Loop {

    active := 0
    callback := ""
    tick_fn := ""
    required_window := ""
    quantity := 0
    delay := 0
    current_tick := 0

    __New(callback, req_win:="") {
        this.callback := callback
        this.required_window := req_win
        this.tick_fn := ObjBindMethod(this, "tick")
    }

    start(quantity, delay) {
        this.active := 1
        this.current_tick := 0
        this.quantity := quantity
        this.delay := delay

        fn := this.tick_fn
        SetTimer, % fn, % delay
    }

    stop() {
        this.active := 0

        fn := this.tick_fn
        setTimer, % fn, Off
    }

    tick() {
        if (this.required_window and not winActive(this.required_window)) {
            this.stop()
            return
        }

        if (this.current_tick++ < this.quantity) {
            this.callback.Call(this.current_tick, this.quantity, this.delay)
        } else {
            this.stop()
        }
    }
}