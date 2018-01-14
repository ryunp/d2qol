Class Action_Loop {

    _requiredWindow := ""
    _action_fn := {}
    _timer := {}

    __New(quantity:=100, delay:=200, fn:="") {
        this.quantity := quantity
        this.current_tick := 0
        this.delay := delay
        this._action_fn := fn
        this.active := 0
    }

    setRequiredWindow(str) {
        this._requiredWindow := str
    }

    setActionFn(fn) {
        this._action_fn := fn
    }

    setQuantity(quantity) {
        this.quantity := quantity
    }

    getQuantity() {
        return this.quantity
    }

    setDelay(newDelay) {
        this.delay := newDelay
    }

    getDelay() {
        return this.delay
    }



    ; timer logic
    start() {
        this.active := 1
        this._timer := ObjBindMethod(this, "tick")
        
        fn := this._timer
        delay := this.delay
        SetTimer, % fn, % delay
    }

    stop() {
        this.active := 0

        fn := this._timer
        setTimer, % fn, Off
    }

    tick() {
        if not (WinActive(this._requiredWindow)) {
            this.stop()
            return
        }

        if (this.current_tick < this.quantity) {
            ; Execute callback with current parameters
            this.current_tick += 1
            this._action_fn.Call(this.current_tick, this.quantity, this.delay)
        } else {
            this.stop()
        }
    }
}