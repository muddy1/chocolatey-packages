#NoTrayIcon

wintitle := "Maintain nizima LIVE"

;Uninstall wizard start window
Winwait (winTitle),, 120
if WinExist(winTitle)
{
    WinActivate
	Send("{Enter}") ; Continues
	sleep 50
}

;Ready to Uninstall
Winwait (winTitle),, 120
if WinExist(winTitle)
{
    WinActivate
	Send("{Enter}") ; Continues
	sleep 50
}

;Uninstall finished
Winwait (winTitle),, 120
if WinExist(winTitle)
{
    WinActivate
	Send("{Enter}") ; Closes installer
	sleep 50
}

ExitApp