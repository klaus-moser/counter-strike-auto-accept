#Persistent
#SingleInstance ignore
; alle 3 Sekunde klickt die Maus mit der linken Taste genau in die Mitte vom Bildschirm

SetTimer, Mittig, 1000

Mittig:

SendEvent {Click 1252 650}
;Click 1252, 720
Return


; Alles beenden
F11::
ExitApp 
return