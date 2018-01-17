## d2QoL
Median XL's end-game requires highly repetitive crafting mechanics. Working with the cube slowly not only eats away at game time, but can also cause physical stress on the wrists and fingers. Since the nature of these actions is so well defined, it makes perfect target for automation. This was designed foremost as a crafting QoL utility, but it easily extends out to enhance normal gameplay.

This utility does nothing more than clicks on command in locations you have specified. There is no memory peeking, no gameplay logic, nothing outside the capabilities a human can perform.

### Features
* GUI for configuration (no scripting required)
* Configurations are saved to *d2qol.json* on exit
* Toggle action hotkeys on/off
* Actions only operate within Diablo II window
* Configure action behavior to cover various situations
* Adjustable actions timing to compensate for latency issues

### Gui
!["Keybinds UI screenshot"](media/d2qol_keybinds.png)

!["Settings UI screenshot"](media/d2qol_settings.png)

!["Settings UI screenshot with Tooltip"](media/d2qol_settingstooltip.png)

### Install
Download [d2qol.exe](build/d2qol.exe).

### Usage
1. Run executable as Administrator (needs to send commands to the Diablo II window)
2. Configure hotkeys and settings

Setting | Description
--- | ---
Quantity | Amount of times for clicker to click the mouse
Delay | The time period, in milliseconds, between clicks.
Disable Mouse | Block any mouse movement during the clicking sequence.
Notify Progress | System tray tooltip showing sequence progress.
Cube Location | X & Y coordinates of the Horadric Cube.
Transmute Button | X & Y coordinates of the Horadric Cube's Transmute button.
Open Inventory Panel | In-game hotkey for opening the character inventory panel.
Disable Auto-Pickup | Disable auto pick-up during actions that involve moving items, requiring the item to be picked up before usage.
Interaction Delay | Time period, in milliseconds, to delay during interaction with the game client.

Quickly reducing shrines into vessels
![Reducing shrines into vessel](media/d2qol_shrines.gif)

### Settings Not Saving & Hotkey Errors
This happens when a new version modifies the config file layout. If certain settings aren't saving, let it recreate the default config file by deleting *d2qol.json* while the utility is NOT running. For now, unfortunately, this means resetting your configurations.

### Non-English Windows
Non-English Windows have been reported to produce '**Error: Nonexistent Hotkey**'. Possible workaround is installing AutoHotKey and running *src/d2qol.ahk* until further revelations. (Needs to be tested!)

### Bugs & Feedback
Tested under English version of Windows 7, 8, 10. If you leave an issue report please include OS version, error messages, config data, and specific changes before the error occurred.

This was designed and tested under windowed 800x600 resolution and DDraw. Everything is based on user defined x,y locations, and the sequence of UI commands is nearly identical to human execution. *What can go wrong?™*

### FAQ
**Q**: Run As Administrator? How can I trust you?  
**A**: See [src/](src/) files

**Q**: This thing is broken and/or sucks balls  
**A**: Yes.