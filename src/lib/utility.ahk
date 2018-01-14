unregister_hk(hk) {
    Hotkey, % "~" hk, Off
}


register_hk(hk, fn) {
    Hotkey, % "~" hk, % fn, On
}

get_mouse_coords_from_user(trigger, msg) {
    winTitle := winClass := "Diablo II"
    result := 0

    if (hwnd := WinExist(winTitle " ahk_class " winClass)) {
        
        msgbox, 1, Get Coords, % msg
        IfMsgBox OK
        {
            WinActivate, % "ahk_id " hwnd

            KeyWait, % trigger, D
            MouseGetPos, mX, mY

            result := {"x": mX, "y": mY}
        }
    } else {

        msgbox % "No " winTitle " window!"
    }

    return result
}