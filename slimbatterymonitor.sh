#!/bin/sh

	# If `$FULLY_CHARGED` = 'Yes' then your battery is fully charged, and you can quit SlimBatteryMonitor:

FULLY_CHARGED=$(ioreg -c AppleSmartBattery | awk -F' ' '/FullyCharged/{print $NF}')

if [ "$FULLY_CHARGED" = "Yes" ]
then

	# IF we are fully charged AND SlimBatteryMonitor is running, quit it 
	ps cx | fgrep -q SlimBatteryMonitor && osascript -e 'tell application "SlimBatteryMonitor" to quit'

else

	# If we get here, we are NOT fully charged 

	# if SlimBatteryMonitor is not already running, open it
	ps cx | fgrep -q SlimBatteryMonitor || open -a SlimBatteryMonitor

fi

#EOF
