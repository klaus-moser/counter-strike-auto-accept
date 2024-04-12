#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 1
#include .\Lib\OCR.ahk


^F11::																; Strg+F11 hotkey (change this hotkey to suit your preferences)
{
	MonitorCount := MonitorGetCount()								; Returns the total number of monitors. 
	
	if (MonitorCount > 1)
	{
		PrimaryMonitorNumber := MonitorGetPrimary()					; Returns the number of the primary monitor.
	} else {
		PrimaryMonitorNumber := 1
	}
	
	MonitorGet PrimaryMonitorNumber, &Left, &Top, &Right, &Bottom	; Get the dimensions of the monitor

	Offset := 0.08333												; Offset percentage of pixel of the 'ACCEPT' button
	Width := (Right - Left)											; Width of screen
	Height := (Bottom - Top)										; Height of screen
	Center_x := Round(Width/2)										; Half width of screen
	Center_y := Height/2											; Half height of screen
	Center_y_Offset := Round(Center_y - (Height * Offset))			; Center of 'ACCEPT" button


    static KeepStrgF11Running := false
	
    if KeepStrgF11Running											; An underlying thread is already running the loop below.
    {
        KeepStrgF11Running := false									; Signal that thread's loop to stop
        return														; End this thread so that the one underneath will resume and see the change made by the line above
    }
	
    KeepStrgF11Running := true
	
    while (KeepStrgF11Running) {
	
        ;result := OCR.FromWindow("A",,2)
        
        try {
            found := false ;result.FindString("ACCEPT")
        } catch {
            MouseMove Center_x + 5, Center_y_Offset
            Sleep 500
            
            MouseMove Center_x - 5, Center_y_Offset
            Sleep 500
        }
		if (found) {
			MouseMove Center_x + 5, Center_y_Offset
			MouseClick "left"
			Sleep 500
			
			MouseMove Center_x - 5, Center_y_Offset
			MouseClick "left"
			Sleep 500
			KeepStrgF11Running := false
		}
    }
    KeepStrgF11Running := false										; Reset in preparation for the next press of this hotkey.
}
