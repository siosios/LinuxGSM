#!/bin/bash
# LGSM command_serveradmin_password.sh function
# Author: Daniel Gibbs
# Contributor : UltimateByte
# Website: http://gameservermanagers.com
lgsm_version="070116"

# Description: Changes TS3 serveradmin password

local modulename="TS3 Server Password"
function_selfname="$(basename $(readlink -f "${BASH_SOURCE[0]}"))"


fn_serveradmin_password_prompt(){
echo ""
echo "${gamename} ServerAdmin Password Change"
echo "============================"
echo ""
echo "Press \"CTRL+b d\" to exit console."
fn_printwarningnl "You are about to change the ${gamename} ServerAdmin password"
echo ""
while true; do
	read -e -i "y" -p "Continue? [y/N]" yn
	case $yn in
	[Yy]* ) break;;
	[Nn]* ) echo Exiting; return;;
	* ) echo "Please answer yes or no.";;
esac
done
fn_scriptlog "Initiating ${gamename} ServerAdmin password change"
read -p "Enter new password : " newpassword
}


fn_serveradmin_password_set(){
fn_printinfo "Applying new password"
fn_scriptlog "Applying new password"
sleep 1
# Stop any running server
command_stop.sh
# Start server in "new password mode"
ts3serverpass="1"
command_start.sh
# Stop server in "new password mode"
command_stop.sh
fn_printok "Applying new password"
fn_scriptlog "New ServerAdmin password has been applyed"
sleep 1
}

# Running functions
check.sh
fn_serveradmin_password_prompt
info_ts3status.sh

if [ "${ts3status}" == "Server is running" ]; then
	fn_serveradmin_password_set
	command_start.sh
else
	fn_serveradmin_password_set
fi