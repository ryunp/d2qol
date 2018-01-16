join(array, delim:="`n") {
    str := ""
    for i,v in array {
        str .= v (i < array.MaxIndex() ? delim : "")
    }
    return str
}

unregister_hk(hk) {
    Hotkey, % "*~" hk, Off
}


register_hk(hk, fn) {
    Hotkey, % "*~" hk, % fn, On
}

block_mouse_input(state) {
    if (state) {
        BlockInput, MouseMove
    } else {
        BlockInput, Off
        BlockInput, MouseMoveOff
    }
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


; Break up long strings based set width, respecting newline literals
format_tooltip_text(str) {
    max_width := 50
    lines := []

    Loop {
        ; Check for newline within max width
        pNewLn := InStr(str, "`n")
        if (pNewLn && (pNewLn < max_width)) {
            ; Set ending before newline then remove from string
            pEnd := pNewLn - 1
            str := StrReplace(str, "`n",,,1)
        } else {
            pEnd := StrLen(str)
            ; Too long, set to the end of the last word within max width
            if (pEnd > max_width) {
                pEnd := max_width
                While (SubStr(str, pEnd, 1) != " ") {
                    pEnd--
                }
            }
        }

        ; Split
        lines.push(SubStr(str, 1, pEnd))
        str := SubStr(str, pEnd+1)
        
    ; Test to see if any is left over
    } Until not StrLen(str)

    ; Merge lines together with newline character
    return join(lines)
}