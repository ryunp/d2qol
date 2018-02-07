#NoEnv
SetDefaultMouseSpeed, 0
SendMode, Input


; Run as Admin safeguard
if not A_IsAdmin {
    Msgbox, You must 'Run As Administrator' for this to work
    ExitApp
}


;------------------
; Dependency Declarations (no logic should be executed)
;------------------

; App dependencies
#include, lib\
#Include, HotkeyGui.ahk
#Include, json.ahk
#Include, action_loop.ahk
#Include, utility.ahk
#include, ..\

; Action definitions
#include, actions\
#Include, open_cube.ahk
#Include, open_inv_cube.ahk
#Include, cube_transmute.ahk
#Include, place_in_cube.ahk
#Include, drop_item.ahk
#Include, repeat_clicks.ahk
#include, ..\


;------------------
; App Runtime Declarations (start executing stuff)
;------------------

; Global Vars
global APP_VERSION := "1.4.0"
global CONFIG_FILE := "d2qol.json"
global D2_WINDOW := "Diablo II ahk_class Diablo II"
global GAME_FPS := 25
global KEY_WAIT := "Shift"
global HWND_WIN_MAIN := 0

; Define UI action mapping
global action_list := [{"fn": "Open_Cube", "label": "Open Cube", "desc": "Opens cube"}
    ,{"fn": "Open_Inv_Cube", "label": "Open Inv & Cube", "desc": "Opens inventory panel, then cube"}
    ,{"fn": "Cube_Transmute", "label": "Cube Transmute", "desc": "Activate cube transmute"}
    ,{"fn": "Place_In_Cube", "label": "Place In Cube", "desc": "Places item into cube"}
    ,{"fn": "Drop_Item", "label": "Drop Item", "desc": "Drops item onto ground"}
    ,{"fn": "Repeat_Clicks", "label": "Clicker", "desc": "Continuous clicking"}]

; Define UI settings hover strings
global tooltips := {"ui_clicker_quantity": "Amount of times for clicker to click the mouse.`nRecommended:`nDouble for vendor purchases (due to dialog)"
    ,"ui_clicker_delay": "The time period, in milliseconds, between clicks.`nRecommended:`n260 - Vendor purchase spam`n75-100 - stat point spam (too low causes DC)"
    ,"ui_clicker_disable_mouse": "Block any mouse movement during the clicking sequence.`nRecommended:`nDo you really want a bunch of MOs instead?"
    ,"ui_clicker_notify": "System tray tooltip showing sequence progress."
    ,"ui_coords_cube": "(x,y) coordinates of the Horadric Cube.`nRecommended:`nCenter of the cube for best results"
    ,"ui_coords_transmute": "(x,y) coordinates of the Horadric Cube's Transmute button."
    ,"ui_game_inventory": "In-game hotkey for opening the character inventory panel."
    ,"ui_manual_pickup": "Disable auto pick-up during actions that involve moving items, requiring the item to be picked up before action usage."
    ,"ui_interaction_delay": "Time period, in milliseconds, to delay during interaction with the game client.`nRecommended:`nOffline - 40+`nOnline - 80-120+ (depends on latency)"}

; Set default config
global config := {"user": {"manual_pickup":0
        ,"interaction_delay":84
        ,"game_keybind_inventory":"CLICK ME"
        ,"coords_cube": {"x": "CLICK", "y": "ME"}
        ,"coords_transmute": {"x": "CLICK", "y": "ME"}}
    ,"actions": {"Open_Cube": {"enabled": 0, "hotkey": "F1"}
        ,"Open_Inv_Cube": {"enabled": 0, "hotkey": ""}
        ,"Cube_Transmute": {"enabled": 0, "hotkey": "F2"}
        ,"Place_In_Cube": {"enabled": 0, "hotkey": "F3"}
        ,"Drop_Item": {"enabled": 0, "hotkey": "F4"}
        ,"Repeat_Clicks": {"enabled":0, "hotkey":"F5", "quantity":60, "delay":260, "disable_mouse":1, "notify_progress":1}}}


;------------------
; App init (config and GUI)
;------------------

; Load config data
if (FileExist(CONFIG_FILE)) {
    FileRead, json_data, % CONFIG_FILE
    loaded_config := JSON.Load(json_data)

    ; Merge saved config with default config
    mismatches := object_merge(config, loaded_config)

    ; Alert user of config mismatches
    if (mismatches.MaxIndex()) {
        MsgBox,, Saved Configuration Mismatch, % "`Config Mismatch!`nEither an update changed the hardcoded config data structure, or the saved config file, " CONFIG_FILE ", was modified and contains mismatched data. The following settings were not detected and reverted to default:`n`n->" join(mismatches, "`n->")
    }
} 

; Register actions with user hotkeys
for idx, action in action_list {
    cfg := config.actions[action.fn]

    if (cfg.hotkey && cfg.enabled) {
	   register_hk(cfg.hotkey, action.fn, D2_WINDOW)
    }
}

; Init GUI stuff
#include, gui\
#Include, main.ahk
#include, ..\


; Register callback for app exit
OnExit("shutdown_sequence")

; What to do when main window is closed (X button)
win_mainClose() {
    ExitApp
}


;------------------
; Helpers
;------------------

shutdown_sequence() {
    ; In case of lingering async actions
    BlockInput, Off
    BlockInput, MouseMoveOff

    ; Persist user settings
    save_config(CONFIG_FILE, config)
}

save_config(file, data) {
    fh := FileOpen(file, "w")
    fh.Write(JSON.Dump(data,,"`t"))
    fh.Close()
}

