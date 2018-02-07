join(array, delim:="`n") {
    str := ""
    
    for i,v in array {
        str .= v (i < array.MaxIndex() ? delim : "")
    }

    return str
}

unregister_hk(key) {
    hk := "*~" key

    ;https://autohotkey.com/docs/commands/Hotkey.htm#ErrorLevel
    ; Only unregister if already registered
    Hotkey, % hk,, UseErrorLevel
    if (ErrorLevel != 5 && ErrorLevel != 6) {
        Hotkey, % hk, Off
    }
}

register_hk(key, fn, win_title:=0) {
    hk := "*~" key

    if (win_title) {
        Hotkey, IfWinActive, % win_title
    }

    Hotkey, % hk, % fn, On
}

block_mouse_input(state) {
    if (state) {
        BlockInput, MouseMove
    } else {
        BlockInput, Off
        BlockInput, MouseMoveOff
    }
}

prompt_mouse_coords(target_key, msg, win_title:="") {
    result := false

    if (hwnd := WinExist(win_title)) {
        MsgBox, 1, Get Coords, % msg
        IfMsgBox, OK
        {
            WinActivate, % "ahk_id " hwnd
            KeyWait, % target_key, D
            MouseGetPos, mX, mY
            result := {"x": mX, "y": mY}
        }
    } else {
        MsgBox, % "Target window does not exist!"
    }

    return result
}


; Break up long strings based set width, respecting newline literals
format_textblock(str, width:=50) {
    lines := []

    Loop {
        ; Check for newline within max width
        pNewLn := InStr(str, "`n")
        if (pNewLn && (pNewLn < width)) {
            ; Set ending before newline then remove from string
            pEnd := pNewLn - 1
            str := StrReplace(str, "`n",,,1)
        } else {
            pEnd := StrLen(str)
            ; Too long, set to the end of the last word within max width
            if (pEnd > width) {
                pEnd := width
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

LV_Update(hwnd_gui, hwnd_lv, items) {
    Gui, % hwnd_gui ":Default"
    Gui, ListView, % hwnd_lv

    ; Remove current items
    LV_Delete()

    ; Repopulate with new items
    for i, params in items {
        LV_Add(params*)
    }
}

; https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/assign
; Recursive shallow copy dictionary objects. Overwrite arrays due to needing an 
; index mapping of some kind when mismatches happen.
object_merge(target, source, path:="") {
    mismatches := []

    for key, val in target {
        ; Build new pathing string
        new_path := path ? path "." key : key

        ; Check if source has the same dictionary key
        if (source.HasKey(key)) {
            ; Debug info
            ; t := (isObject(target[key]) ? (target[key].MaxIndex() ? "[" join(target[key], ",") "]" : "Object") : target[key])
            ; s := (isObject(source[key]) ? (source[key].MaxIndex() ? "[" join(source[key], ",") "]" : "Object") : source[key])
            ; b := (isObject(val) && isObject(source[key]) && !val.MaxIndex() && !source[key].MaxIndex()) ? "Recursion" : "Copying"
            ; msgbox % "[" b "] " (path ? path "." key : key) "`ntarget: " t "`nsource: " s

            ; Both objects
            if (isObject(val) && isObject(source[key])) {
                ; Both dictionaries recurse deeper, concat any deeper mismatches
                if (!val.MaxIndex() && !source[key].MaxIndex()) {
                    mismatches.push(object_merge(val, source[key], new_path)*)
                } else {
                    ; Record mismatch
                    mismatches.push(new_path)
                }
            } else {
                ; Primitive values, copy over default
                target[key] := source[key]
            }
        } else {
            ; Record mismatch
            mismatches.push(new_path)
        }
    }

    return mismatches
}