; Cube Location
point := config.coords.cube.x ", " config.coords.cube.y
Gui, add, text, % "Section w100 xm+" tabPadding " y+" tabPadding, Cube (px)
Gui, add, button, hwnd_hwnd ys-5 w75 gcube_coords_handler, % point
hwnd_cubecoords := _hwnd

; Transmute Location
point := config.coords.transmute.x ", " config.coords.transmute.y
Gui, add, text, % "Section w100 xm+" tabPadding " y+" tabPadding, Transmute (px)
Gui, add, button, hwnd_hwnd ys-5 w75 gtransmute_coords_handler, % point
hwnd_transmutecoords := _hwnd

; In-game Inventory Keybind
Gui, add, text, % "Section w100 xm+" tabPadding " y+" tabPadding, Inventory Pane
Gui, add, button, hwnd_hwnd ys-5 w75 ggame_inv_handler, % config.game.keybinds.inventory
hwnd_gameinv := _hwnd


; Event handlers
transmute_coords_handler() {
	global

	key := "Shift"
	msg := "Place mouse over the Transmute button and press " key

	; Prompt for user input
	point := get_mouse_coords_from_user(key, msg)

	if (point) {

		config.coords.transmute := point

		; Update view
		GuiControl, , % hwnd_transmutecoords, % point.x ", " point.y	
	}
}


cube_coords_handler() {
	global

	key := "Shift"
	msg := "Place mouse over Horadric Cube and press " key

	; Prompt for user input
	point := get_mouse_coords_from_user(key, msg)

	if (point) {

		config.coords.cube := point

		; Update view
		GuiControl, , % hwnd_cubecoords, % point.x ", " point.y	
	}
}


game_inv_handler() {
	global

	; Prompt for user input
	newHK := HotkeyGUI()

	if (newHK) {
		
		config.game.keybinds.inventory := newHK

		; Update view
		GuiControl, , % hwnd_gameinv, % newHK
	}
}