## SlimBatteryMonitor

I use [SlimBatteryMonitor](http://www.orange-carb.org/SBM/) instead of the default Mac OS X menu bar item for the battery status.

SBM has many more options than the built-in menu bar item, including the ability to change what it is showing you in the menu bar.

It can be configured to "minimize" itself when the battery is fully charged, but it still retains some width in the menu bar -- and that is prime real estate.

I realized that it would be better to only run SBM when I was running on battery, but knew better than to trust my own memory, so I told the computer to do it for me.

## slimbatterymonitor.sh 

This shell script will check the current Mac OS X battery status by running this command:

	FULLY_CHARGED=$(ioreg -c AppleSmartBattery | awk -F' ' '/FullyCharged/{print $NF}')
	
The `$FULLY_CHARGED` variable will either be set to 'Yes' or 'No' (well, assuming that the Mac in question has a battery).

The script then uses that variable to either:

1.	launch SlimBatteryMonitor.app (IFF it is not already running) when the battery is *not* fully charged.

2.	quit SlimBatteryMonitor.app (IFF it is running) when the battery *is* fully charged.

See the comments in the shell script for more info.

## Installation

1. You *must* install the plist file to `~/Library/LaunchAgents` (you may have to create that folder if it doesn't exist)

2. You *should* install `slimbatterymonitor.sh` at `/usr/local/bin/slimbatterymonitor.sh` because that is where the plist file will look for it. If you install it somewhere else, you *must* edit the plist to reflect the new path.

3. After moving the plist into place, you *must* either reboot or enter this in Terminal.app:

	launchctl load ~/Library/LaunchAgents/com.tjluoma.slimbatterymonitor.plist

4. After moving `slimbatterymonitor.sh` into place, you *must* make sure it is executable:

	chmod 755 /usr/local/bin/slimbatterymonitor.sh
	
If you installed it somewhere else, change the path as appropriate.

## Debugging

If something doesn't seem to work, make sure that your battery reports its charge status. If you enter this in Terminal:

	ioreg -c AppleSmartBattery | fgrep FullyCharged             

you ought to see something like this:

    | |           "FullyCharged" = No

or


    | |           "FullyCharged" = Yes

If you do not, this script will probably not work properly for you. (I tested it on 10.7.3)

If SlimBatteryMonitor.app does not launch as expected, be sure that 

	open -a SlimBatteryMonitor
	
works when entered on the command line.

## Links

I had already written this before I read 
"Have battery status only show in menu bar when running on battery power" at <http://apple.stackexchange.com/questions/46723/have-battery-status-only-show-in-menu-bar-when-running-on-battery-power>
but that was what "inspired" me to share it via GitHub.

## Disclaimer

I am not affiliated with the official SlimBatteryMonitor.app in any way.

Use at your own risk, etc.

