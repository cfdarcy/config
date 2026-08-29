#Requires AutoHotkey v2.0

*CapsLock::
{
    startTime := A_TickCount
    Send("{Ctrl down}{Shift down}{Alt down}")
    KeyWait("CapsLock")
    Send("{Ctrl up}{Shift up}{Alt up}")
    
    if (A_TickCount - startTime < 200) && (A_PriorKey = "CapsLock")
    {
        SetCapsLockState(!GetKeyState("CapsLock", "T"))
    }
}

; Hyper+T: Open Wezterm
^!+t::Run("wezterm-gui.exe")

; Hyper+B: Open Browser
^!+b::Run("chrome.exe")


