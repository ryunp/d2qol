; UI Group for auto-clicker settings
Gui, Add, GroupBox, Section h120 w140, Clicker
	; Click qauntity
	Gui, Add, Edit, Section xs+10 ys+20 w50 h20 gcb_clicker_quantity, % config.actions.Repeat_Clicks.quantity
	Gui, Add, Text, vui_clicker_quantity ys+3 gNOP, Quantity
	cb_clicker_quantity(CtrlHwnd) {
		ControlGetText, quantity,, % "ahk_id " CtrlHwnd
		config.actions.Repeat_Clicks.quantity := quantity
	}

	; Delays between clicks
	Gui, Add, Edit, Section xs w50 h20 gcb_clicker_delay, % config.actions.Repeat_Clicks.delay
	Gui, Add, Text, vui_clicker_delay ys+3 gNOP, Delay (ms)
	cb_clicker_delay(CtrlHwnd) {
		ControlGetText, delay,, % "ahk_id " CtrlHwnd
		config.actions.Repeat_Clicks.delay := delay
	}

	; Toggle mouse control when running
	Gui, Add, Checkbox, vui_clicker_disable_mouse AltSubmit xs h20 gcb_clicker_disable_mouse, Disable Mouse
	GuiControl,, ui_clicker_disable_mouse, % config.actions.Repeat_Clicks.disable_mouse 
	cb_clicker_disable_mouse(CtrlHwnd) {
		GuiControlGet, state,, % CtrlHwnd
	    config.actions.Repeat_Clicks.disable_mouse := state
	}

	; Toggle traytip when running
	Gui, Add, Checkbox, vui_clicker_notify AltSubmit xs yp+20 h20 gcb_clicker_notify, Notify Progress
	GuiControl,, ui_clicker_notify, % config.actions.Repeat_Clicks.notify_progress
	cb_clicker_notify(CtrlHwnd) {
		GuiControlGet, state,, % CtrlHwnd
	    config.actions.Repeat_Clicks.notify_progress := state
	}


; UI Group for in-game operational settings
Gui, Add, GroupBox, Section h120 w200 xm+160 ym+28, In-Game

	; Cube Location
	point := config.user.coords_cube
	Gui, Add, Button, Section xs+10 ys+20 w70 h20 gcb_coords_cube, % point.x ", " point.y
	Gui, Add, Text, vui_coords_cube ys+3 gNOP, Cube Location (px)
	cb_coords_cube(CtrlHwnd) {
		msg := Format("Place mouse over {} and press {}", "Horadric Cube", KEY_WAIT)
		point := prompt_mouse_coords(KEY_WAIT, msg, D2_WINDOW)
		if (point) {
			config.user.coords_cube := point
			GuiControl,, % CtrlHwnd, % point.x ", " point.y
		}
	}

	; Transmute Location
	point := config.user.coords_transmute
	Gui, Add, Button, Section xs w70 h20 gcb_coords_transmute, % point.x ", " point.y
	Gui, Add, Text, vui_coords_transmute ys+3 gNOP, Transmute (px)
	cb_coords_transmute(CtrlHwnd) {
		msg := Format("Place mouse over {} and press {}", "Transmute Button", KEY_WAIT)
		point := prompt_mouse_coords(KEY_WAIT, msg, D2_WINDOW)
		if (point) {
			config.user.coords_transmute := point
			GuiControl,, % CtrlHwnd, % point.x ", " point.y
		}
	}

	; In-game inventory keybind
	Gui, Add, Button, Section xs w70 h20 gcb_game_inventory, % config.user.game_keybind_inventory
	Gui, Add, Text, vui_game_inventory ys+3 gNOP, Open Inventory Panel
	cb_game_inventory(CtrlHwnd) {
		newHK := HotkeyGUI()
		if (newHK) {
			config.user.game_keybind_inventory := newHK
			GuiControl,, % CtrlHwnd, % newHK
		}
	}


; UI Group for timing of actions
Gui, Add, GroupBox, Section h50 w348 xm+12 ym+151, Actions

	; Manual item pickup
	Gui, Add, Checkbox, Section vui_manual_pickup AltSubmit xs+10 ys+20 h20 gcb_manual_pickup, Disable Auto-Pickup
	GuiControl,, % ui_manual_pickup, % config.user.manual_pickup
	cb_manual_pickup(CtrlHwnd) {
		GuiControlGet, state,, % CtrlHwnd
	    config.user.manual_pickup := state
	}

	; Latency during game client interaction
	Gui, Add, Edit, Section ys xm+171 w50 h20 gcb_interaction_delay, % config.user.interaction_delay
	Gui, Add, Text, vui_interaction_delay ys+3 gNOP, Interaction Delay (ms)
	cb_interaction_delay(CtrlHwnd) {
		GuiControlGet, value,, % CtrlHwnd
	    config.user.interaction_delay := value
	}


;----------
; Helpers
;--------

; Workaround helper function for text controls to show tooltip
NOP(){
}
