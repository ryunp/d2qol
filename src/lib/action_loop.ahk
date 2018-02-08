Class Action_Loop {

    active := 0
    callbacks := {"tick": 0, "stop": 0, "start": 0}
    tick_fn := ""
    req_win := ""
    quantity := 0
    delay := 0
    current_tick := 0

    __New(req_win:="") {
        this.req_win := req_win
        this.tick_fn := ObjBindMethod(this, "tick")
    }

    set_callback(event_name, cb) {
        if (this.callbacks.HasKey(event_name)) {
            this.callbacks[event_name] := cb
        }
    }

    start(quantity, delay) {
        this.active := 1
        this.current_tick := 0
        this.quantity := quantity
        this.delay := delay

        fn := this.tick_fn
        SetTimer, % fn, % delay

        this.callbacks.start.Call(this._current_tick, this.quantity, this.delay)
    }

    stop() {
        this.active := 0

        fn := this.tick_fn
        setTimer, % fn, Off
        
        this.callbacks.stop.Call(this._current_tick, this.quantity, this.delay)
    }

    tick() {
        ; Stop when required window is not active
        if (this.req_win && !winActive(this.req_win)) {
            this.stop()
        } else {
            ; Continue until end
            if (this.current_tick++ < this.quantity) {
                this.callbacks.tick.Call(this.current_tick, this.quantity, this.delay)
            } else {
                this.stop()
            }
        }
    }
}