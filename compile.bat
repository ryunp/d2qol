@echo off
set "compilerDir=%programfiles%\AutoHotkey\Compiler"

echo Compiling 32-bit..
"%compilerDir%\Ahk2Exe.exe" /bin "%compilerDir%\Unicode 32-bit.bin" /in src/d2qol.ahk /out build\d2qol.exe /icon icon.ico

REM echo Compiling 64-bit..
REM "%compilerDir%\Ahk2Exe.exe" /bin "%compilerDir%\Unicode 64-bit.bin" /in src/d2qol.ahk /out build\d2qolx64.exe /icon icon.ico
