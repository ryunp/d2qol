#NoEnv
SetDefaultMouseSpeed, 0
SendMode Input
DetectHiddenWindows, On

; Globals
global d2_window := "Diablo II ahk_class Diablo II"
global app_version := "1.3.7"


; Run as Admin guard
if not A_IsAdmin {
    Msgbox You must 'Run As Administrator' for this to work
    ExitApp
}


; App dependencies
#Include, lib\HotkeyGui.ahk
#Include, lib\json.ahk
#Include, lib\lv_update.ahk
#Include, lib\action_loop.ahk
#Include, lib\utility.ahk


; Define action models
global action_list := []
action_list.push({"id": "Open_Cube", "label": "Open Cube", "desc": "Opens cube"})
action_list.push({"id": "Open_Inv_Cube", "label": "Open Inv & Cube", "desc": "Opens inventory panel, then cube"})
action_list.push({"id": "Cube_Transmute", "label": "Cube Transmute", "desc": "Activate cube transmute"})
action_list.push({"id": "Place_In_Cube", "label": "Place In Cube", "desc": "Places item into cube"})
action_list.push({"id": "Drop_Item", "label": "Drop Item", "desc": "Drops item onto ground"})
action_list.push({"id": "Repeat_Clicks", "label": "Clicker", "desc": "Continuous clicking"})


; Set default config
global config_file := "d2qol.json"
global config := {"confirm_key": "Shift"
    ,"coords":{"cube":{"x":0,"y":0}
        ,"transmute":{"x":0,"y":0}}
	,"actions":{"Open_Cube":{"enabled":0,"hotkey":"F1"}
        ,"Open_Inv_Cube":{"enabled":0,"hotkey":"F2"}
        ,"Cube_Transmute":{"enabled":0,"hotkey":"F3"}
        ,"Place_In_Cube":{"enabled":0,"hotkey":"F4"}
        ,"Drop_Item":{"enabled":0,"hotkey":"F5"}
        ,"Repeat_Clicks":{"enabled":0,"hotkey":"F6","quantity":60,"delay":260,"disablemouse":1,"notifyprogress":1}}
	,"game":{"manualpickup":0
        ,"interactiondelay": 84
        ,"keybinds":{"inventory":"i"}}}


; Override config if config file exists
if (FileExist(config_file)) {
	FileRead, config_file_string, % config_file
	config := json.read(config_file_string)
}


; Register actions with user hotkeys
for idx, action in action_list {
    cfg := config.actions[action.id]

    if (cfg.hotkey && cfg.enabled) {
	   register_hk(cfg.hotkey, action.id)
    }
}


; Init Gui
#include, gui\
#Include, main.ahk
#include, ..\

return ; END AUTOEXEC


; Action definitions
#include, actions\
#Include, open_cube.ahk
#Include, open_inv_cube.ahk
#Include, cube_transmute.ahk
#Include, place_in_cube.ahk
#Include, drop_item.ahk
#Include, repeat_clicks.ahk
#include, ..\


; Save config on exit
OnExit("WinMainClose")
WinMainClose() {
    global
    static configsaved := 0

    if not (configsaved) {
        fh := FileOpen(config_file, "w")
        fh.Write(json.write(config))
        fh.Close()

        configsaved := 1
    }

    BlockInput, Off
    BlockInput, MouseMoveOff
    ExitApp
}