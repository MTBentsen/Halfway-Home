#!/bin/bash
echo user to allow?
read user
echo "$user"
echo dseditgroup -o edit -u mbentsen -p -a "$user" -t user _lpadmin
echo lpadmin -p PS1-D265LJC  -L "D265" -E -v smb://ps1.campus.parkland.edu/D265LJC -P /Library/Printers/PPDs/Contents/Resources/HP\ color\ LaserJet\ 3500.ppd.gz -o printer-is-shared=false -o auth-info-required=negotiate –u allow:$user
echo lpadmin -d PS1-D265LJC
lpstat –p
lpstat -d

#replace [admin-account] with user profile name of admin account
#replace [printer-name] with name of your printer
#replace [printer-location] with room location of printer
#replace [print_server_path] with path to server host of printer
#replace [printer_driver] with the path to the printer driver located under: /Library/Printers/PPDs/Contents/Resources/

