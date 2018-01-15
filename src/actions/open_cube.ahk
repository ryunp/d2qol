Open_Cube() {
    point := config.coords.cube

    ; Ignore user, save mouse
    BlockInput, On
    MouseGetPos, x, y

    ; move to cube location
    MouseMove % point.x, % point.y

    ; Open cube
    Click Right
    sleep % 42 ; wait 1 frame
    
    MouseMove, % x, % y
    BlockInput, Off
}