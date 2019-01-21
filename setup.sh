### These instructions assume that you are running Debian 9. After completing these instructions
### you will have a basic installation with database and webserver.
# https://www.debian.org/distrib/
# debian-9.3.0-amd64-netinstall.iso  
# graphical (debian desktop environment) installed with default system tools 

#!/bin/bash
#
# https://github.com/Igel18/Berlussimo
#
# Copyright (c) 2018 GNU Affero General Public License v3.0

### Attention: You should only use this script for develop becouse of default passwords and usernames

# Detect Debian users running the script with "sh" instead of bash
if readlink /proc/$$/exe | grep -q "dash"; then
	echo "This script needs to be run with bash, not sh"
	exit
fi

if [[ "$EUID" -ne 0 ]]; then
	echo "Sorry, you need to run this as root"
	exit
fi

if [[ -e /etc/debian_version ]]; then
	OS=debian
	GROUPNAME=nogroup
	RCLOCAL='/etc/rc.local'
else
	echo "Looks like you aren't running this installer on Debian, Ubuntu or CentOS"
	exit
fi

echo
echo 'Welcome to this code installer!'
echo

# upgrade debian
echo
echo 'update linux'
echo

apt update --yes
apt upgrade --yes
apt dist-upgrade --yes

apt install docker --yes
apt install nginx --yes

docker run -t -d -p 9980:9980 --name collabora_nextcloud --restart always --cap-add MKNOD collabora/code
