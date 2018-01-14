; Ryan Paul, 1/11/18
; Updating ListViews with new row data within object scopes

#Include, ..\lib\lv_update.ahk


;Create first GUI and change values after 3 seconds
global win1 := new Ex_LV_Window("Window 1", "x300")
SetTimer, callback, -3000
callback() {
    win1.update_setting("quantity", 150)
    win1.update_setting("delay", 300)
    win1.update_lv()
}

; Create second GUI and change values after 6 seconds
global win2 := new Ex_LV_Window("Window 2", "x600")
SetTimer, callback2, -6000
callback2() {
    win2.update_settings({"quantity": 2323, "delay": 3444})
    win2.update_lv()
}


Class Ex_LV_Window {

    hwnd_gui := 0
    hwnd_lv := 0

    settings := [{"name": "quantity", "value": 10}, {"name": "delay", "value": 50}]

    __New(title:="", options:="") {
        ; Create gui and save hwnd
        Gui, New, hwnd_hwnd
        this.hwnd_gui := _hwnd

        ; Create LV and save hwnd
        Gui, Add, ListView, hwnd_hwnd r5 w200, Name|Value
        this.hwnd_lv := _hwnd

        ; Set update function
        this.lv_render_fn := func("LV_Update").bind(this.hwnd_gui, this.hwnd_lv)

        ; Transform obj values to array
        row_data := []
        for i,obj in this.settings {
            row_data.push(["", obj.name, obj.value])
        }

        ; Populate UI
        this.lv_render_fn.Call(row_data)

        ; Align cols to data
        LV_ModifyCol(1, 75)
        LV_ModifyCol(2, "AutoHdr")

        Gui, Show, % options, % title
    }

    update_setting(key, value) {
        for i,obj in this.settings {
            if (obj.name = key) {
                obj.value := value
                break
            }
        }
    }

    update_settings(dict) {
        for k,v in dict {
            this.update_setting(k, v)
        }
    }

    update_lv() {
        ; Transform obj values to array
        row_data := []
        for i,obj in this.settings {
            row_data.push(["", obj.name, obj.value])
        }

        ; Repopulate ListView items
        this.lv_render_fn.Call(row_data)
    }
}


Class Repeat_Clicks_Obj {

    ; App Settings
    id := "Repeat_Clicks_Obj"
    desc := "Repeatedly click"
    label := "Clicker"
    enabled := 1
    hotkey := "F5"

    ; User Settings
    settings := [{"name": "quantity", "value": 60}
        , {"name": "delay", "value": 150}]

    ; UI binding
    hwnd_gui := 0
    hwnd_lv := 0
    settings_ui_map := {}


    settings_ui_init() {
        Gui, Settings:New, hwnd_hwnd
        this.hwnd_gui := _hwnd
        
        Gui, Font, Bold
        Gui, Add, Text, Center, % "Settings: "this.label
        Gui, Font

        Gui, Add, ListView, hwnd_hwnd r5 w220 AltSubmit, Name|Value ;gSettingsListView 
        this.hwnd_lv := _hwnd
        fn := ObjBindMethod(this, "listview_handler")
        GuiControl +g, % _hwnd, % fn

        row_data := []
        for i,s in this.settings {
            row_data.push([s.name, s.value])
        }
        LV_Update(this.hwnd_gui, this.hwnd_lv, row_data)

        LV_ModifyCol(1, 75)
        LV_ModifyCol(2, "AutoHdr")

        ; this.settings_ui_controls()

        Gui, Add, Button, hwnd_hwnd Section xm ym+140, OK
        fn := ObjBindMethod(this, "on_settings_ui_save")
        GuiControl +g, % _hwnd, % fn

        Gui, Add, Button, ys gCancel, Cancel

        Gui, Show, w240 h180
    }

    listview_handler() {
        ; Right click detected
        if (A_GuiEvent = "RightClick") {

            ; Set default listview explicitly
            Gui, ListView, % this.hwnd_lv
            
            ; Align UI selection with data model
            s := this.settings[A_EventInfo]

            ; Ask for new value
            InputBox, new_value, Update Setting, % A_EventInfo ", New value for " s.name
            if (ErrorLevel = 0) {
                ; Set data model value
                s.value := new_value

                ; Update LV
                row_data := []
                for i,item in this.settings {
                    row_data.push([item.name, item.value])
                }

                LV_Update(this.hwnd_gui, this.hwnd_lv, row_data)
            }
        }
    }

    settings_ui_controls() {
        Gui, Add, Text, Section w50 h25, Quantity:
        Gui, Add, Edit, hwnd_hwnd ys w75, % this.settings.quantity
        this.register_ui_map("quantity", _hwnd)

        Gui, Add, Text, Section xm w50 h25, Delay:
        Gui, Add, Edit, hwnd_hwnd ys w75, % this.settings.delay
        this.register_ui_map("delay", _hwnd)
    }

    register_ui_map(key, hwnd) {
        this.settings_ui_map[key] := hwnd
    }

    on_settings_ui_save() {
        for k,hwnd in this.settings_ui_map {
            ControlGetText, new_value,, % "ahk_id " hwnd
            this.settings[key] := new_value
            msgbox % k ", " hwnd ", " new_value
        }
        Gui, Settings:Destroy
    }

    run() {
        Click
    }
}


