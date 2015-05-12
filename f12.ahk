;; ctrl+f12

SetWorkingDir %A_ScriptDir%
flag:=0

^F12::
If (flag=0)
{
  flag:=1
  SetTimer timer_flag, 60000
}
else
{
  flag:=0
  SetTimer timer_flag, off
}
Return

timer_flag:
;;title:="World of Warcraft"
title:="魔兽世界"
WinGet, id, list, %title%
Loop, %id%
{
    this_id := id%A_Index%
;;    WinActivate, ahk_id %this_id%
    ControlSend, , {SPACE}, ahk_id %this_id%
}
return
