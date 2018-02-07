about_text := ["Author: ryunp"
    ,"Version: " APP_VERSION
    ,"Github: https://github.com/ryunp/d2qol"
    ,"MXL Forum: https://forum.median-xl.com/viewtopic.php?f=4&t=3302"
    ,""
    ,"HotkeyGUI: jballi"
    ,"https://autohotkey.com/board/topic/15577-function-hotkeygui-v04/"
    ,""
    ,"JSON: cocobelgica"
    ,"https://github.com/cocobelgica/AutoHotkey-JSON"]

Gui, Add, Edit, ReadOnly w350 r12, % join(about_text, "`n")