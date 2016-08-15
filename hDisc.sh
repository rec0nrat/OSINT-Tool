#!/bin/bash
#**********************************************************************************
# hDisc.sh
#
# Author: Team StarDotStar
# Last Updated: 6/26/2016
# Description: Host Discovery + Port Scan & Service Version + Output files w/nmap
#**********************************************************************************

	### Creates a directory for the output files.
mkdir ~/Documents/scanning > /dev/null 2>&1


clear	### User input for the range.
echo -n "Default gateway and cidr: "
read ipa

if [ -z $ipa ];then
	echo
	echo "No entry, exiting."
	echo
	exit
fi
	### User input for the output file.
echo -n "File name: "
read fname

if [ -z $fname ];then
	echo
	echo "No entry, exiting."
	echo
	exit
fi
	### Ping scan for hostDiscovery + output into file.
asdf=$(nmap -sn $ipa | tee ~/Documents/scanning/$fname > /dev/null 2>&1)
	### Calls the command.
echo "$asdf"

	### Under the circumstances that an organization provides a list
	### of hosts that they do not want us to scan, this variable cats
	### the file, the "sed" command deletes those host addreses from
	### the hostDiscovery output file, "awk" command parses the file
	### for remaining hosts.
myVar=$(cat ~/Documents/scanning/DONOTTOUCHTHESE)

for line in $myVar;
do
	sed -i /$line/d ~/Documents/scanning/$fname
done

res=$(awk '/report/ {print $5;}' ~/Documents/scanning/$fname)


echo "$res"

	### -sS port scan, -sU UDP port scan, -sV service scan
sudo nmap -sS -sU -sV $res > ~/Documents/scanning/$fname
