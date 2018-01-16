Gui, New, hwnd_win_main +labelWinMain, d2qol

; Help Link
Gui, Add, Link, xm+210 ym, <a href="https://forum.median-xl.com/viewtopic.php?f=4&t=3302">Median XL Forum Thread</a>
Gui, Add, Text, xm+340 ym, v1.3.4

; Tabs
Gui, add, Tab3, xm ym w380, Keybinds|Settings

Gui, Tab, Keybinds
#Include, tab_actions.ahk

Gui, Tab, Settings
#Include, tab_settings.ahk


Gui, Show

global tooltips := {"_ui_text_clickerquantity": "Amount of times for clicker to click the mouse.`nRecommended:`nDouble for vendor purchases (due to dialog)"
    ,"_ui_text_clickerdelay": "The time period, in milliseconds, between clicks.`nRecommended:`n260 - Vendor purchase spam`n75-100 - stat point spam"
    ,"_ui_check_clickerdisablemouse": "Block any mouse movement during the clicking sequence.`nRecommended:`nDo you really want a bunch of MOs instead?"
    ,"_ui_check_clickernotify": "System tray tooltip showing sequence progress."
    ,"_ui_text_cubecoords": "X & Y coordinates of the Horadric Cube.`nRecommended:`nCenter of the cube for best results"
    ,"_ui_text_transmutecoords": "X & Y coordinates of the Horadric Cube's Transmute button."
    ,"_ui_text_gameinventory": "In-game hotkey for opening the character inventory panel."
    ,"_ui_check_manualpickup": "Disable auto pick-up during actions that involve moving items, requiring the item to be picked up before usage.`nRecommended:`nExpensive crafting may warrant more saftey"
    ,"_ui_text_interactiondelay": "Time period, in milliseconds, to delay during interaction with the game client.`nRecommended:`nOffline - 42`nOnline - 84-126+ (depends on latency)"}


OnMessage(0x200, "WM_MOUSEMOVE")
tt_prev := ""
WM_MOUSEMOVE() {
    global

    tt_cur := A_GuiControl
    If (tt_cur <> tt_prev and not InStr(tt_cur, " ")) {
        Tooltip
        if (tooltips.HasKey(A_GuiControl)) {
            SetTimer, DisplayToolTip, 1000
        }
        tt_prev := tt_cur
    }
    return

    DisplayToolTip:
    if (tt_cur = tt_prev) {
        SetTimer, DisplayToolTip, Off
        ToolTip % format_tooltip_text(tooltips[tt_cur])
        SetTimer, RemoveToolTip, 6000
    }
    return

    RemoveToolTip:
    SetTimer, RemoveToolTip, Off
    ToolTip
    return
}