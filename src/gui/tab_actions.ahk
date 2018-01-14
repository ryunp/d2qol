; Instruction text
Gui, Add, Text, Section, Checkbox toggles keybind on/off`, Right-Click to change keybind

; List of available actions
Gui, Add, ListView, hwnd_lv_keybinds g_cb_lv_keybinds r5 xs w350 Checked NoSortHdr AltSubmit, |Key|Name|Description

; Redraw listview
items := []
for i,ui in action_list {
    cfg := config.actions[ui.id]
    items.push([(cfg.enabled ? "check" : ""), "", cfg.hotkey, ui.label, ui.desc])
}
LV_Update(_win_main, _lv_keybinds, items)

; Adjust widths
LV_ModifyCol() ; Auto-size each column to fit its contents.
LV_ModifyCol(2, 30) ; Adjust HK column


_cb_lv_keybinds() {
    global

    action := action_list[A_EventInfo]
    cfg := config.actions[action.id]

    ; Change hotkey on item right click
    if (A_GuiEvent = "RightClick") {
        ; Prompt for new hotkey
        new_hk := HotkeyGUI(_win_main,,,, action.label ": Select Hotkey")
        if (new_hk) {

            ; Turn off old hk
            unregister_hk(cfg.hotkey)

            ; Update config data
            cfg.hotkey := new_hk

            ; Register new hk
            register_hk(new_hk, action.id)

            ; Redraw listview
            items := []
            for i,action in action_list {
                cfg := config.actions[action.id]
                items.push([(cfg.enabled ? "check" : ""), "", cfg.hotkey, action.label, action.desc])
            }
            LV_Update(_win_main, _lv_keybinds, items)
        }
    } else if (InStr(ErrorLevel, "C", true)) {
        cfg.enabled := 1
        register_hk(cfg.hotkey, action.id)
    } else if (InStr(ErrorLevel, "c", true)) {
        cfg.enabled := 0
        unregister_hk(cfg.hotkey)
    }
}