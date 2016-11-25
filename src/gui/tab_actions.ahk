for idx, action in action_list {

	Gui, add, text, % "Section w100 xm+" tabPadding " y+" tabPadding, % action.label
	Gui, add, button, hwnd_hwnd ys-5 w75, % config.keybinds.action[action.fn]
	
	fn := func("change_action_hk_handler").bind(_hwnd, action)
	GuiControl +g, % _hwnd, % fn
}

change_action_hk_handler(hwnd, action) {
	global

	; Attempt user input
	newHK := HotkeyGUI()

	if (newHK) {
		
		; Update model/OS
		update_action_hk(action, newHK)

		; Update view
		GuiControl, , % hwnd, % newHK
	}
}