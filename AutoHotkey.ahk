SetTitleMatchMode, 2

GroupAdd CliSwap, ahk_class ConsoleWindowClass
GroupAdd Browser, ahk_exe firefox.exe
GroupAdd Misc, - OneNote
GroupAdd Misc, ahk_exe slack.exe

F4::Send !{Tab}
F6::Send !{F4} ;; close window
F7::GroupActivate, Misc
F8::WinActivate, ahk_exe emacs.exe
F9::GroupActivate CliSwap, R
F10::GroupActivate Browser, R

; Add as many window titles to the group as you want.


;────────── ────────── ────────── ────────── ──────────
;; Mozilla Firefox

#IfWinActive ahk_class MozillaWindowClass

Home::Send ^{PgUp} ; previous tab
End::Send ^{PgDn} ; next tab

$F6::Send !{F4} ; close window
$F12::Send ^w ; close tab

Return

;; Slack
#IfWinActive ahk_exe slack.exe
$F6::Send !{F4} ; close window
Return

;; Windows Explorer
#IfWinActive ahk_exe explorer.exe
$F6::Send !{F4} ; close window
Return
