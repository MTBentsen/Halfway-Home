#!/bin/sh

#############################################################################
#############################################################################
###
### Copyright FileMaker, Inc. 2012
###
###	Purpose:	Create a PackageMaker installer package suitable for mass
###				deploying FileMaker Pro via Apple Remote Desktop.
###
### Usage:	
###				sudo chmod +x ./AppleRemoteDesktopDeployment.sh
###				./AppleRemoteDesktopDeployment.sh "<folder 1>"
###
###				Make it an executable script by changing the permissions
###				of the script via chmod.
###
###				Where "<folder 1>" contains the original FileMaker Pro
###				or FileMaker Pro Advanced installer along with the
###				Assisted Install.txt file.
###
### Required:
###				1.  The command line tool pkgbuild is required.  pkgbuild
###					is available by default on OS X Systems 10.7 and greater.
###					For Systems 10.6.x, pkgbuild can be installed on the
###					System by installing XCode available from Apple, Inc.
###				2.  A folder, ie. "<folder 1>" containing a FileMaker Pro or
###					FileMaker Pro Advanced installer; and containing an
###					Assisted Install.txt file.
###				3.  The Assisted Install.txt file should contain a username
###					and license key.  The other Assisted Install.txt options,
###					such as AI_DISABLEPLUGINS, etc., should be set as needed.
###
###	Output:		The output of this script is an installer package named
###				"* ARD.pkg", placed in "<folder 1>", that is suitable for
###				mass deploying FileMaker Pro via Apple Remote Desktop.
###
#############################################################################
#############################################################################

root=$1

if [ -d "$root" ] ; then
	AppleRemoteDesktopRoot=$root/AppleRemoteDesktopPackage
	scriptsFolder=$AppleRemoteDesktopRoot/Scripts
	postinstall=$scriptsFolder/postinstall

	pushd "${root}"
	installerPackage=`ls *.pkg`
	popd

	installerPackageWithoutSpaces=`echo "${installerPackage}" | sed -e s/\ //g`
	installerPackageWithoutFileExtension=`echo "${installerPackage}" | sed -e s/.pkg//g`

	identifier=com.filemaker.ardwrapper.$installerPackageWithoutSpaces

	CreatePostInstallScript(){
		echo '#!/bin/sh' > "${postinstall}"

		echo 'PACKAGE_PATH=${1}' >> "${postinstall}"
		echo 'TARGET_LOCATION=${2}' >> "${postinstall}"

		echo 'if [ -e "$TARGET_LOCATION/'${installerPackage}'" ]' >> "${postinstall}"
		echo 'then' >> "${postinstall}"
		echo 	'installer -package "$TARGET_LOCATION/'${installerPackage}'" -target /' >> "${postinstall}"
		echo 	'rm -dfR "$TARGET_LOCATION/'${installerPackage}'"' >> "${postinstall}"
		echo 'fi' >> "${postinstall}"

		echo 'if [ -e "$TARGET_LOCATION/Assisted Install.txt" ]' >> "${postinstall}"
		echo 'then' >> "${postinstall}"
		echo 	'rm -dfR "$TARGET_LOCATION/Assisted Install.txt"' >> "${postinstall}"
		echo 'fi' >> "${postinstall}"
	}

	mkdir -p "${AppleRemoteDesktopRoot}" "${scriptsFolder}"
	CreatePostInstallScript
	chmod +x "${postinstall}"
	cp "${root}/${installerPackage}" "${AppleRemoteDesktopRoot}/${installerPackage}"
	cp "${root}/Assisted Install.txt" "${AppleRemoteDesktopRoot}/Assisted Install.txt"
	pkgbuild --identifier $identifier --scripts "${scriptsFolder}" --install-location "${TMPDIR}" --root "${AppleRemoteDesktopRoot}" "${root}/${installerPackageWithoutFileExtension} ARD.pkg" 
	rm -dfR "${AppleRemoteDesktopRoot}"
else
	echo 
	echo Usage:		./AppleRemoteDesktopDeployment.sh "<folder 1>"
	echo 
	echo 			Where "<folder 1>" contains the original FileMaker Pro
	echo 			or FileMaker Pro Advanced installer along with the
	echo 			Assisted Install.txt file.
	echo 
fi