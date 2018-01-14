Gui, New, hwnd_win_main +labelWinMain, d2qol

; Help Link
Gui, Add, Link, xm+255 ym, <a href="https://forum.median-xl.com/viewtopic.php?f=4&t=3302">Median XL Forum Thread</a>

; Tabs
Gui, add, Tab3, xm ym w380, Keybinds|Settings

Gui, Tab, Keybinds
#Include, tab_actions.ahk

Gui, Tab, Settings
#Include, tab_settings.ahk

Gui, Show
