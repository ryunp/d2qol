for idx, action in action_list {

	Gui, add, text, % "Section w100 xm+" tabPadding " y+" tabPadding, % action.label
	Gui, add, button, hwnd_hwnd ys-5 w75, % config.keybinds.action[action.fn]
	
	; Attach callback bound to current control context
	fn := func("change_action_hk_handler").bind(_hwnd, action)
	GuiControl +g, % _hwnd, % fn
}

change_action_hk_handler(ctrlHwnd, action) {
	global

	; Attempt user input
	newHK := HotkeyGUI()

	if (newHK) {
		
		; Update model/OS
		unregister_hk(config.keybinds.action[action.fn])
		config.keybinds.action[action.fn] := newHK
		register_hk(newHK, action.fn)

		; Update view
		GuiControl, , % ctrlHwnd, % newHK
	}
}