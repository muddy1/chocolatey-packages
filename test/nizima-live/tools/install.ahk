#NoTrayIcon

wintitle := "nizima LIVE Setup"

; Install wizard start window
Winwait (winTitle),, 120
if WinExist(winTitle)
{
    WinActivate
	Send("{Enter}") ; Continues
	sleep 50
}

; Chooses install location
; C:\Program Files (x86)/nizima Live (Default)
Winwait (winTitle)
if WinExist(winTitle)
{
    WinActivate
	Send("{Enter}") ; Continues
	sleep 50
}

; Component Selection
Winwait (winTitle)
if WinExist(winTitle)
{
    WinActivate
	Send("{Enter}") ; Continues
	sleep 50
}

; License Agreement
Winwait (winTitle)
if WinExist(winTitle)
{
    WinActivate
	Send("{Tab}")
	Send("{Space}") ; Accepts License Agreement
	Send("{Enter}") ; Continues
	sleep 50
}

; Shortcut Menu location
Winwait (winTitle)
if WinExist(winTitle)
{
    WinActivate
	Send("{Enter}") ; Continues
	sleep 50
}

; Ready to install
Winwait (winTitle)
if WinExist(winTitle)
{
    WinActivate
	Send("{Enter}") ; Starts installation
	sleep 1800
}

winTitle :="Windows Security" ; If nizma cam is not installed a prompt will pop up, trusts nizima signature and installs cam

Winwait (winTitle),, 40
if WinExist(winTitle)
{
    WinActivate
	Send("{Tab}")
	Send("{Tab}")
	Send("{Tab}")
	Send("{Enter}") ; Accepts cam installation and continues
	sleep 1800
}

wintitle := "nizima LIVE Setup"

; Closes install wizard
WinWait (winTitle)
if WinExist(winTitle)
{
    WinActivate
	Send("{Tab}")
	Send("{Space}")
	Send("{Tab}")
	Send("{Enter}") ; stops nizima from launching and ends installation
	sleep 50
}

ExitApp