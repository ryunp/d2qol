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
global config := {"coords": {"cube": {"x": 0, "y": 0 }, "transmute": {"x": 0, "y": 0 } }, "keybinds": {"action": {"Cube_Transmute": "F2", "Drop_Item": "F4", "Open_Inv_Cube": "F1", "Place_In_Cube": "F3"}, "game": {"inv": "b"} } }


; Override config if config file exists
if (FileExist(config_file)) {

	FileRead, config_file_string, % config_file
	config := json.read(config_file_string)
}


; Register actions with user hotkeys
for idx, action in action_list
	register_action_hk(action)


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



; Misc app logic
update_action_hk(action, newHK) {

	unregister_hk(config.keybinds.action[action.fn])
	config.keybinds.action[action.fn] := newHK
	register_hk(newHK, action.fn)
}


register_action_hk(action) {

	key := config.keybinds.action[action.fn]
	register_hk(key, action.fn)
}


revert_mouse(fn) {

	SetDefaultMouseSpeed, 0

	MouseGetPos, mX, mY
	fn.Call()	
	MouseMove, % mX, % mY
}

unregister_hk(hk) {

	Hotkey, % "~"hk, Off
}


register_hk(hk, fn) {

	Hotkey, % "~"hk, % fn
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