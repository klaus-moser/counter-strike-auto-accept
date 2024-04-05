#Requires AutoHotkey v2.0

#MaxThreadsPerHotkey 3
^F11:: ; Strg+F11 hotkey (change this hotkey to suit your preferences)
{

	MonitorCount := MonitorGetCount() ; Returns the total number of monitors. 
	
	if (MonitorCount > 1)
	{
		PrimaryMonitorNumber := MonitorGetPrimary() ; Returns the number of the primary monitor.
	} else {
		PrimaryMonitorNumber := 1
	}
	
	MonitorGet PrimaryMonitorNumber, &Left, &Top, &Right, &Bottom

	Offset := 0.08333 ; Offset percentage of pixel of the 'ACCEPT' button
	Width := (Right - Left)
	Hight := (Bottom - Top)
	Center_x := Round(Width/2)
	Center_y := Hight/2
	Center_y_Offset := Round(Center_y - (Hight * Offset))
	
    ; Define an array of target colors
    targetColors := ["14420C", "36B954", "123B07", "36B752", "113504", "38BE56", "36B752", "195418", "35B651", "133E09"]
    

    static KeepStrgF11Running := false
	
    if KeepStrgF11Running  ; This means an underlying thread is already running the loop below.
    {
        KeepStrgF11Running := false  ; Signal that thread's loop to stop.
        return  ; End this thread so that the one underneath will resume and see the change made by the line above.
    }
    ; Otherwise:
	
    KeepStrgF11Running := true
	
    Loop
    {
		MouseMove Center_x + 5, Center_y_Offset ; Move mouse
		
		pixelColor := PixelGetColor(Center_x, Center_y_Offset) ; Read out pixel color
		
		Sleep 50  ; Add a small delay for mouse movement
		
		for index, targetColor in targetColors ; Check if the current pixel color matches any of the target colors
		{
			if (pixelColor = "0x" . targetColor)
			{
				MsgBox pixelColor
				MouseClick "left"
				KeepStrgF11Running := False ; Signal that thread's loop to stop.
			}
		}
		Sleep 500
		MouseMove Center_x - 5, Center_y_Offset ; Move mouse
		Sleep 500
		
        ; But leave the rest below unchanged.
        if not KeepStrgF11Running  ; The user signaled the loop to stop by pressing Win-Z again.
            break  ; Break out of this loop.
    }
	
    KeepStrgF11Running := false  ; Reset in preparation for the next press of this hotkey.
}
#MaxThreadsPerHotkey 1