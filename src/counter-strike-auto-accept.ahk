#Requires AutoHotkey v2.0

; Function to concatenate arrays
ArrConcat(arr*) {
    new_arr := []
    for each, sub_arr in arr
        new_arr.push(sub_arr*)
    return new_arr
}

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

	; Main variables
	Offset := 0.08333 ; Offset percentage of pixel of the 'ACCEPT' button
	Width := (Right - Left)
	Hight := (Bottom - Top)
	Center_x := Round(Width/2)
	Center_y := Hight/2
	Center_y_Offset := Round(Center_y - (Hight * Offset))
	static KeepStrgF11Running := false
	
    ; Define color arrays
	targetColorsCS2MainMenu := ["87DD8B","82DB87","6CD47C","D2F4D3","9CE4A4","74D47C","ECFCEC","64D474","BCEEBC","95E497","C3F1C4","3CC45C","4FCC65","ADEBB0","5ECC6D","A4E7A4","8CE492","6CD474","E1F4E4","44C75C","B4ECBC","44CC64","79DC7C","74D484","94DC94","3CCC5C","D4E080","40C45C"]
	targetColorsCS2PremierMenu := ["34B454","23782D","133B09","1C6324","2C9D44","1B591B","2B903D","34AD4C","36BC54","2C8C34","34A44A","1C4C14","24843C","144C13","3CC455","0C2C04","34B858"]
	targetColorsCSGO := ["4CAC54","388736","225B13","337C2C","2C6F23","3C943D","2C742C","4CB454","24641B","449C44","44A44C","4CAC4C","44A444","449443","246C1F","4CA44C","245C1C","449C3C","246424","50AC54"]
	
	; Merge the arrays into one
    targetColors := ArrConcat(targetColorsCS2MainMenu, targetColorsCS2PremierMenu, targetColorsCSGO)
    

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
				MouseClick "left"
				KeepStrgF11Running := False ; Signal that thread's loop to stop.
				break  ; Break out of this loop.
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