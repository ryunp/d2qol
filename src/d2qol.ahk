; Run as Admin guard
if not A_IsAdmin {
	Msgbox You must 'Run As Administrator' for this to work
	ExitApp
}

; Process settings
#NoEnv
SetDefaultMouseSpeed, 0
SendMode Input
Hotkey, IfWinActive, Diablo II

; Dependencies
#Include, lib\HotkeyGui.ahk
#Include, lib\json.ahk


; Define action models
action_list := []
action_list.push({"label": "Open Inv && Cube", "desc": "Opens inventory and cube", "fn": "Open_Inv_Cube"})
action_list.push({"label": "Cube Transmute", "desc": "Activate Cube Transmute", "fn": "Cube_Transmute"})
action_list.push({"label": "Place In Cube", "desc": "Places currently held item into cube", "fn": "Place_In_Cube"})
action_list.push({"label": "Drop Item", "desc": "Drops currently held item onto ground", "fn": "Drop_Item"})


; Set default config
config_file := "d2qol.json"
global config := {"coords":{"cube":{"x":0,"y":0},"transmute":{"x":0,"y":0}}
	,"actions":{"Open_Inv_Cube":{"enabled":1,"hotkey":"F1"},"Cube_Transmute":{"enabled":1,"hotkey":"F2"},"Place_In_Cube":{"enabled":1,"hotkey":"F3"},"Drop_Item":{"enabled":1,"hotkey":"F4"}}
	,"game":{"keybinds":{"inventory":"b"}}}


; Override config if config file exists
if (FileExist(config_file)) {

	FileRead, config_file_string, % config_file
	config := json.read(config_file_string)
}


; Register actions with user hotkeys
for idx, action in action_list
	register_hk(config.keybinds.action[action.fn], action.fn)


; Build/show gui
#include, gui\
#Include, main.ahk
#include, ..\
OnExit, exit_sequence

return ; END AUTOEXEC



; Action definitions
#include, actions\
#Include, open_inv_cube.ahk
#Include, cube_transmute.ahk
#Include, place_in_cube.ahk
#Include, drop_item.ahk
#include, ..\



; Helpers
unregister_hk(hk) {

	Hotkey, % "~"hk, Off
}


register_hk(hk, fn) {

	Hotkey, % "~"hk, % fn, On
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


GuiClose:
exit_sequence:

	fh := FileOpen(config_file, "w")
	fh.Write(json.write(config))
	fh.Close()

	ExitApp
return