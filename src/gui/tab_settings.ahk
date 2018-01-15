; UI Group for auto-clicker settings
Gui, Add, GroupBox, Section h100 w140, Clicker
	cfg := config.actions.Repeat_Clicks

	; Click qauntity
	gui, add, edit, Section hwnd_ui_clicker_quantity xs+10 ys+20 w50 h20 g_cb_clicker_quantity, % cfg.quantity
	gui, add, text, ys+3, Quantity

	; Delays between clicks
	gui, add, edit, Section hwnd_ui_clicker_delay xs w50 h20 g_cb_clicker_delay, % cfg.delay
	gui, add, text, ys+3, Delay (ms)

	; Disable mouse when running
	gui, add, Checkbox, % "hwnd_ui_clicker_disablemouse AltSubmit xs h20 g_cb_clicker_disablemouse", Disable Mouse
	GuiControl, , % _ui_clicker_disablemouse, % cfg.disablemouse

; UI Group for in-game operational settings
Gui, Add, GroupBox, Section h130 w200 xm+160 ym+28, In-Game

	; Cube Location
	cfg := config.coords.cube
	point := cfg.x ", " cfg.y
	Gui, add, button, Section hwnd_ui_cube_location xs+10 ys+20 w70 h20 g_cb_cube_coords, % point
	Gui, add, text, ys+3, Cube Location (px)

	; Transmute Location
	cfg := config.coords.transmute
	point := cfg.x ", " cfg.y
	Gui, add, button, Section hwnd_ui_cube_transmute xs w70 h20 g_cb_transmute_coords, % point
	Gui, add, text, ys+3, Transmute (px)

	; In-game Inventory Keybind
	cfg := config.game.keybinds
	Gui, add, button, Section hwnd_ui_gameinventory_keybind xs w70 h20 g_cb_game_inv, % cfg.inventory
	Gui, add, text, ys+3, Toggle Inventory

	; Manual item pickup
	cfg := config.game
	Gui, add, Checkbox, % "Section hwnd_ui_manualpickup AltSubmit xs h20 g_cb_manualpickup", Manual Item Pickup
	GuiControl, , % _ui_manualpickup, % cfg.manualpickup



; Trigger key when assigning location
confirm_key := "Shift"

; Event handlers

_cb_clicker_quantity() {
	global

	cfg := config.actions.Repeat_Clicks
	ControlGetText, quantity, , % "ahk_id " _ui_clicker_quantity
	cfg.quantity := quantity
}


_cb_clicker_delay() {
	global

	cfg := config.actions.Repeat_Clicks
	ControlGetText, delay, , % "ahk_id " _ui_clicker_delay
	cfg.delay := delay
}


_cb_clicker_disablemouse() {
	global

	cfg := config.actions.Repeat_Clicks
	GuiControlGet, state,, % _ui_clicker_disablemouse
    cfg.disablemouse := state
}


_cb_cube_coords() {
	global

	msg := Format("Place mouse over {} and press {}", "Horadric Cube", confirm_key)

	; Prompt for user input
	point := prompt_mouse_coords(confirm_key, msg, d2_window)

	if (point) {
		; Update config data
		config.coords.cube := point

		; Update view
		GuiControl, , % _ui_cube_location, % point.x ", " point.y	
	}
}


_cb_transmute_coords() {
	global

	msg := Format("Place mouse over {} and press {}", "Transmute Button", confirm_key)
	
	; Prompt for user input
	point := prompt_mouse_coords(confirm_key, msg, d2_window)

	if (point) {
		; Update config data
		config.coords.transmute := point

		; Update view
		GuiControl, , % _ui_cube_transmute, % point.x ", " point.y	
	}
}


_cb_game_inv() {
	global

	; Prompt for user input
	newHK := HotkeyGUI()

	if (newHK) {
		; Update config data
		config.game.keybinds.inventory := newHK

		; Update view
		GuiControl, , % _ui_gameinventory_keybind, % newHK
	}
}


_cb_manualpickup() {
	global

	cfg := config.game
	GuiControlGet, state,, % _ui_manualpickup
    cfg.manualpickup := state
}