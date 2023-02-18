#Persistent
#SingleInstance ignore

; Get the scaling factor
SystemMetrics := DllCall("User32.dll\SystemParametersInfo", "UInt", 0x2000 /* SPI_GETLOGICALDPIOVERRIDE */, "UInt", 0, "UIntP", LogDPIX, "UInt", 0)
DPI := (LogDPIX ? LogDPIX : 96)
ScalingFactor := DPI / 96

SetTimer, Mittig, 1000

Offset := 70

Mittig:
; Get the primary monitor dimensions
SysGet, PrimaryMonitor, MonitorWorkArea
PrimaryScreenWidth := PrimaryMonitorRight - PrimaryMonitorLeft
PrimaryScreenHeight := PrimaryMonitorBottom - PrimaryMonitorTop

; Calculate the center point of the primary monitor, taking the scaling factor into account
PrimaryCenterX := Floor((PrimaryScreenWidth / 2) * ScalingFactor) - 10
PrimaryCenterY := Floor((PrimaryScreenHeight / 2) * ScalingFactor) - Offset

; Click the center point of the primary monitor
SendEvent {Click %PrimaryCenterX% %PrimaryCenterY%}

Return

F11::
ExitApp 
return
