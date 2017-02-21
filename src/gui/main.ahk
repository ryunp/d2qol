Gui, New, hwnd_hwnd, d2qol
hwnd_main := _hwnd

gui, font, s11

Gui, add, Tab2, , Actions|Settings|About
tabPadding := 20

Gui, Tab, Actions
#Include, tab_actions.ahk

Gui, Tab, Settings
#Include, tab_settings.ahk

Gui, Tab, About
#Include, tab_about.ahk

Gui, Show