;; -*- coding: utf-8 -*-
;; ctrl+f12

SetWorkingDir %A_ScriptDir%
flag := 0

^f12::
If (flag=0)
{
  flag := 1
  SetTimer timer_flag, 20000
}
else
{
  flag := 0
  SetTimer timer_flag, off
}
Return

timer_flag:
;;title := "World of Warcraft"
title := "ahk_exe dtyxj.exe"
WinGet, id, list, %title%
Loop, %id%
{
    this_id := id%A_Index%
    WinGetClass, class, ahk_id %this_id%
    WinActivate, ahk_id %this_id%
    MouseGetPos, px, py, this_id
    ToolTip, ahk_id %this_id%`nahk_class %class%`n%title%`nControl: %px%  %py%, 100, 100
    Random, rand, 1000, 3000
    Sleep, rand
    Random, randx, 910, 1000
    Random, randy, 510, 550
    Random, rands, 20, 80
    MouseMove, randx, randy, rands
    Click
    ;;ControlSend, , {SPACE}, ahk_id %this_id%
}
return
