unregister_hk(hk) {
    Hotkey, % "~" hk, Off
}


register_hk(hk, fn) {
    Hotkey, % "~" hk, % fn, On
}

prompt_mouse_coords(trigger, msg, win_title:="") {
    result := false

    if (hwnd := WinExist(win_title)) {
        
        msgbox, 1, Get Coords, % msg
        IfMsgBox OK
        {
            WinActivate, % "ahk_id " hwnd

            KeyWait, % trigger, D
            MouseGetPos, mX, mY

            result := {"x": mX, "y": mY}
        }
    } else {

        msgbox % "Target window does not exist!"
    }

    return result
}