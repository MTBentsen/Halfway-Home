#!/bin/bash
#jamf helper syntax
HELPER=`/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper -windowType utility -icon /Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/Resources/Message.png -heading "place header here" -description "place description here" -button1 "Yes" -button2 "Cancel" -cancelButton "2"`
echo "jamf helper result was $HELPER";
if [ "$HELPER" == "0" ]; then
#[Action to take if users selects yes]
exit 0
else
#[Action to take if user selects no/Cancel]
exit 1
fi
