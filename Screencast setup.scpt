-- Launch "System Preferences", open the "Displays" options and change to the "Display" tab
tell application "System Preferences"
	activate
	set the current pane to pane id "com.apple.preference.displays"
	reveal anchor "displaysDisplayTab" of pane id "com.apple.preference.displays"
end tell

local indexToUse

-- Now lets make the necessary changes
tell application "System Events"
	
	set scaled to false
	
	tell tab group 1 of window "SyncMaster" of application process "System Preferences" of application "System Events"
		tell radio group 1
			
			if (value of radio button "Scaled") = 0 then
				-- Click the "Scaled" radio button
				click radio button "Scaled"
				
				tell table 1 of scroll area 1 of tab group 1 of window "SyncMaster" of application process "System Preferences" of application "System Events"
					select row 4
				end tell
			else
				click radio button "Default for display"
				set scaled to true
			end if
		end tell
		
	end tell
	
	
	tell application process "SystemUIServer"
		try
			if scaled then
				key down option
				click menu bar item "NotificationCenter, Do Not Disturb enabled" of menu bar 2
				key up option
			else
				key down option
				click menu bar item "Notification Center" of menu bar 2
				key up option
			end if
		on error
			key up option
		end try
	end tell
	
end tell

-- Quit "System Preferences"
quit application "System Preferences"

