#!/bin/bash
#source credit: user; Lisacherie URL: https://www.jamf.com/jamf-nation/feature-requests/751/jamfhelper-make-it-awesome
HELPER=`/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper -windowType utility -icon /Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/Resources/Message.png -heading "Software Updates are Available" -description "Would you like to install updates" -button1 "Yes" -button2 "Cancel" -cancelButton "2"`
echo "jamf helper result was $HELPER";
if [ "$HELPER" == "0" ]; then
/usr/sbin/jamf policy -trigger yourcustomtrigger
exit 0
else
echo "user chose No";   
exit 1
fi
