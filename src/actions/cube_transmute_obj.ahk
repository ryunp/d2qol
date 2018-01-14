class Cube_Transmute_Obj {

    ; App Settings
    id := "Cube_Transmute_Obj"
    desc := "Click on cube transmute button"
    label := "Cube Transmute"
    enabled := 1
    hotkey := "F2"

    __New() {
    }

    run() {
        point := config.coords.transmute

        ; Ignore user, save mouse
        BlockInput, On
        MouseGetPos, x, y

        ; Click at location
        MouseMove % point.x, % point.y
        Click

        MouseMove, % x, % y
        BlockInput, Off
    }

    save_settings(config) {
        config[this.id]
    }
}