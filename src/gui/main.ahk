Gui, New, hwndhwnd_win_main +labelwin_main, % "d2qol v" APP_VERSION

; Whitespace filler
; Gui, Add, Link, xm+210 ym, <a href="https://forum.median-xl.com/viewtopic.php?f=4&t=3302">Median XL Forum Thread</a>
; Gui, Add, Text, xm+340 ym, % "v" APP_VERSION

; Tabs
Gui, Add, Tab3, xm ym w380, Keybinds|Settings|About

Gui, Tab, Keybinds
#Include, tab_actions.ahk

Gui, Tab, Settings
#Include, tab_settings.ahk

Gui, Tab, About
#Include, tab_about.ahk

Gui, Show


OnMessage(0x200, "WM_MOUSEMOVE")
WM_MOUSEMOVE() {
    static tt_cur, tt_prev

    tt_cur := A_GuiControl
    If (tt_cur <> tt_prev and not InStr(tt_cur, " ")) {
        Tooltip,
        if (tooltips.HasKey(A_GuiControl)) {
            SetTimer, DisplayToolTip, 1000
        }
        tt_prev := tt_cur
    }
    return

    DisplayToolTip:
    if (tt_cur = tt_prev) {
        SetTimer, DisplayToolTip, Off
        ToolTip, % format_textblock(tooltips[tt_cur], 55)
        SetTimer, RemoveToolTip, 6000
    }
    return

    RemoveToolTip:
    SetTimer, RemoveToolTip, Off
    ToolTip,
    return
}