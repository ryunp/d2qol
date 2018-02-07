; Instruction text
Gui, Add, Text, Section, % "Checkbox toggles keybind on/off, Right-Click to change keybind"

; List of available actions
Gui, Add, ListView, hwndhwnd_lv_keybinds gcb_keybinds r6 xs w350 Checked NoSortHdr AltSubmit, % "|Key|Name|Description"
cb_keybinds(CtrlHwnd) {
    ; Map selected LV item index to action_list
    action := action_list[A_EventInfo]
    cfg := config.actions[action.fn]

    ; Right Clicked - Change hotkey
    if (A_GuiEvent = "RightClick") {
        ; Prompt for new hotkey
        new_hk := HotkeyGUI(hwnd_win_main,,,, action.label ": Select Hotkey")
        if (new_hk) {
            old_hk := cfg.hotkey
            cfg.hotkey := new_hk

            ; Reassign if in active state            
            if (cfg.enabled) {
                unregister_hk(old_hk)
                register_hk(new_hk, action.fn, D2_WINDOW)
            }

            LV_Update(hwnd_win_main, hwnd_lv_keybinds, actions_to_LVrows())
        }

    ; Checked - Enable hotkey
    } else if (InStr(ErrorLevel, "C", true)) {
        cfg.enabled := 1
        register_hk(cfg.hotkey, action.fn, D2_WINDOW)

    ; Unchecked - Disable hotkey
    } else if (InStr(ErrorLevel, "c", true)) {
        cfg.enabled := 0
        unregister_hk(cfg.hotkey)
    }
}

; Redraw listview
LV_Update(hwnd_win_main, hwnd_lv_keybinds, actions_to_LVrows())

; Adjust widths
LV_ModifyCol() ; Auto-size each column to fit its contents.
LV_ModifyCol(2, 50) ; Adjust HK column
LV_ModifyCol(4, "AutoHdr") ; Adjust Description column


;------------------
; UI helpers
;------------------

actions_to_LVrows() {
    ; Build list of fields to show as LV columns
    rows := []
    for i,action in action_list {
        cfg := config.actions[action.fn]
        rows.push([(cfg.enabled ? "check" : ""), "", cfg.hotkey, action.label, action.desc])
    }
    return rows
}