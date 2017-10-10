;; -*- coding: utf-8 -*-
;; ctrl+f12

SetWorkingDir %A_ScriptDir%
flag := 0
;;title := "World of Warcraft"
title := "ahk_exe Wow-64.exe"
WinGet, id, list, %title%

^f12::
If (flag=0)
{
  flag := 1
  SetTimer timer_flag, 1500
}
else
{
  flag := 0
  SetTimer timer_flag, off
}
Return

timer_flag:
Loop, %id%
{
    this_id := id%A_Index%
    WinGetClass, class, ahk_id %this_id%
    ;;WinActivate, ahk_id %this_id%
    ControlSend, , {f9}, ahk_id %this_id%
    ControlSend, , {f12}, ahk_id %this_id%
    ControlSend, , {f11}, ahk_id %this_id%
}
return
