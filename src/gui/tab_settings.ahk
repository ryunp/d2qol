; gNOP callback is a workaround for geting text controls to register for tooltip

; UI Group for auto-clicker settings
Gui, Add, GroupBox, Section h120 w140, Clicker
	cfg := config.actions.Repeat_Clicks

	; Click qauntity
	gui, add, edit, Section xs+10 ys+20 w50 h20 g_cb_edit_clickerquantity, % cfg.quantity
	gui, add, text, v_ui_text_clickerquantity ys+3 gNOP, Quantity

	; Delays between clicks
	gui, add, edit, Section xs w50 h20 g_cb_edit_clickerdelay, % cfg.delay
	gui, add, text, v_ui_text_clickerdelay ys+3 gNOP, Delay (ms)

	; Disable mouse when running
	gui, add, Checkbox, % "v_ui_check_clickerdisablemouse AltSubmit xs h20 g_cb_check_clickerdisablemouse", Disable Mouse
	GuiControl, , _ui_check_clickerdisablemouse, % cfg.disablemouse
	
	; Disable mouse when running
	gui, add, Checkbox, % "v_ui_check_clickernotify AltSubmit xs yp+20 h20 g_cb_check_clickernotify", Notify Progress
	GuiControl, , _ui_check_clickernotify, % cfg.notifyprogress

; UI Group for in-game operational settings
Gui, Add, GroupBox, Section h120 w200 xm+160 ym+28, In-Game

	; Cube Location
	cfg := config.coords.cube
	point := cfg.x ", " cfg.y
	Gui, add, button, Section xs+10 ys+20 w70 h20 g_cb_button_cubecoords, % point
	Gui, add, text, v_ui_text_cubecoords ys+3 gNOP, Cube Location (px)

	; Transmute Location
	cfg := config.coords.transmute
	point := cfg.x ", " cfg.y
	Gui, add, button, Section xs w70 h20 g_cb_button_transmutecoords, % point
	Gui, add, text, v_ui_text_transmutecoords ys+3 gNOP, Transmute (px)

	; In-game Inventory Keybind
	cfg := config.game.keybinds
	Gui, add, button, Section xs w70 h20 g_cb_button_gameinventory, % cfg.inventory
	Gui, add, text, v_ui_text_gameinventory ys+3 gNOP, Open Inventory Panel

; UI Group for timing of actions
Gui, Add, GroupBox, Section h50 w348 xm+12 ym+151, Actions

	; Manual item pickup
	cfg := config.game
	Gui, add, Checkbox, Section v_ui_check_manualpickup AltSubmit xs+10 ys+20 h20 g_cb_check_manualpickup, Disable Auto-Pickup
	GuiControl, , % _ui_check_manualpickup, % cfg.manualpickup

	; Latency between game client interaction
	cfg := config.game
	Gui, add, Edit, Section ys xm+171 w50 h20 g_cb_edit_interactiondelay, % cfg.interactiondelay
	Gui, add, Text, v_ui_text_interactiondelay ys+3 gNOP, Interaction Delay (ms)



;------------------
; Event handlers
;------------------

; Clicker group
_cb_edit_clickerquantity(CtrlHwnd) {
	global

	cfg := config.actions.Repeat_Clicks
	ControlGetText, quantity, , % "ahk_id " CtrlHwnd
	cfg.quantity := quantity
}


_cb_edit_clickerdelay(CtrlHwnd) {
	global

	cfg := config.actions.Repeat_Clicks
	ControlGetText, delay, , % "ahk_id " CtrlHwnd
	cfg.delay := delay
}


_cb_check_clickerdisablemouse(CtrlHwnd) {
	global

	cfg := config.actions.Repeat_Clicks
	GuiControlGet, state,, % CtrlHwnd
    cfg.disablemouse := state
}


_cb_check_clickernotify() {
	global

	cfg := config.actions.Repeat_Clicks
	GuiControlGet, state,, % CtrlHwnd
    cfg.notifyprogress := state
}



; In-Game group
_cb_button_cubecoords(CtrlHwnd) {
	global

	msg := Format("Place mouse over {} and press {}", "Horadric Cube", config.confirm_key)

	; Prompt for user input
	point := prompt_mouse_coords(config.confirm_key, msg, d2_window)

	if (point) {
		; Update config data
		config.coords.cube := point

		; Update view
		GuiControl, , % CtrlHwnd, % point.x ", " point.y	
	}
}


_cb_button_transmutecoords(CtrlHwnd) {
	global

	msg := Format("Place mouse over {} and press {}", "Transmute Button", config.confirm_key)
	
	; Prompt for user input
	point := prompt_mouse_coords(config.confirm_key, msg, d2_window)

	if (point) {
		; Update config data
		config.coords.transmute := point

		; Update view
		GuiControl, , % CtrlHwnd, % point.x ", " point.y	
	}
}


_cb_button_gameinventory(CtrlHwnd) {
	global

	; Prompt for user input
	newHK := HotkeyGUI()

	if (newHK) {
		; Update config data
		config.game.keybinds.inventory := newHK

		; Update view
		GuiControl, , % CtrlHwnd, % newHK
	}
}



;------------------
; Action Timing group
;------------------

_cb_check_manualpickup(CtrlHwnd) {
	global

	cfg := config.game
	GuiControlGet, state,, % CtrlHwnd
    cfg.manualpickup := state
}


_cb_edit_interactiondelay(CtrlHwnd) {
	global

	cfg := config.game
	GuiControlGet, value,, % CtrlHwnd
    cfg.interactiondelay := value
}

NOP(){
	return
}