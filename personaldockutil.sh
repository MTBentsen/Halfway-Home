#!/bin/sh

# This script comes from a jamfnation post
# https://jamfnation.jamfsoftware.com/discussion.html?id=12786
# Below is the original script with documentation and edits


#This script wipes the current lib account dock and rebuilds.  The dock
#is locked using the contents-immutable flag

#sleep 25

user=$(python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')
plist="/Users/$user/Library/Preferences/com.apple.dock.plist"
lab=$(echo $user | cut -c -2)

killall cfprefsd

/usr/local/bin/dockutil --remove all --no-restart $plist

sleep 5

/usr/local/bin/dockutil --add /Applications/Launchpad.app --no-restart $plist

/usr/local/bin/dockutil --add /Applications/Safari.app --after 'Launchpad' --no-restart $plist

/usr/local/bin/dockutil --add /Applications/Firefox.app --after 'Safari' --no-restart $plist

/usr/local/bin/dockutil --add /Applications/Google\ Chrome.app --after 'Firefox' --no-restart $plist

/usr/local/bin/dockutil --add /Applications/Microsoft\ Outlook.app --after 'Google Chrome' --no-restart $plist

/usr/local/bin/dockutil --add /Applications/Skype\ for\ Business.app --after 'Microsoft Outlook' --no-restart $plist

/usr/local/bin/dockutil --add /Applications/Slack.app --after 'Skype for Business' --no-restart $plist

/usr/local/bin/dockutil --add /Applications/Self\ Service.app --after 'Slack' --no-restart $plist

/usr/local/bin/dockutil --add /Applications/ParklandOne\ Password\ Station.webloc --position 1 --no-restart $plist

/usr/local/bin/dockutil --add /Users/$user/Documents/ --after 'ParklandOne Password Station.webloc' --no-restart $plist

#killall cfprefsd

killall Dock
