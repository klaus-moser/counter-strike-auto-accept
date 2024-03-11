; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
; SOFTWARE.


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
	SendMode "Event" ; Used to show the mouse movement


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
		;SendEvent "{PgDn}" ; Press the Page Down key to look down
		sleep 100
		
		MouseMove Center_x + 10, Center_y_Offset, 10
		MouseClick "left"
		Sleep 1000
		
		MouseMove Center_x - 10, Center_y_Offset, 10
		MouseClick "left"
		Sleep 1000

        if not KeepStrgF11Running  ; The user signaled the loop to stop by pressing Win-Z again.
            break  ; Break out of this loop.
    }
	
    KeepStrgF11Running := false  ; Reset in preparation for the next press of this hotkey.
}
#MaxThreadsPerHotkey 1