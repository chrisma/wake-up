#!/usr/bin/env bash

### Auto suspend and wake up script
# Puts the computer on suspend and automatically wakes it up 
# at specified time, running a custom script.
# Must be run as root (rtcwake requires it).

### Example:
# Takes a 24hour time HH:MM and (optional) script path as arguments
# wake_up 9:30
# wake_up 18:45 beepbeepbeep.sh

# Based on
# http://ubuntuforums.org/showthread.php?t=938533&page=4&p=10878570#post10878570
# (Romke van der Meulen)

# Check if rtcwake (util-linux) is installed
if ! type "rtcwake" > /dev/null; then
	echo "Error: rtcwake from package util-linux must be installed." 1>&2
	exit 1
fi

# Argument check
if [ $# -lt 1 ]; then
    echo "Usage: $0 HH:MM [SCRIPT_TO_RUN_ON_WAKEUP]"
    exit 1
fi
if [ -n "$2" ]; then # $2 set
	if [ ! -f "$2" ]; then # $2 doesn't exist
		echo "Error: $2 not found." 1>&2
		exit 1
	fi
	MESSAGE=", running commands in $2."
fi

# Root needed to run rtcwake
if [ "$(id -u)" != "0" ]; then
   echo "Error: rtcwake requires root. Please rerun with root permissions." 1>&2
   exit 1
fi

# Check whether specified time today or tomorrow
DESIRED=$((`date +%s -d "$1"`))
NOW=$((`date +%s`))
if [ $DESIRED -lt $NOW ]; then
    DESIRED=$((`date +%s -d "$1"` + 24*60*60))
fi

# Confirm action
DATE=`date -d @"$DESIRED" +%c`
echo "Will suspend till $DATE$MESSAGE"
read -p "Continue? [y/n] " -n 1 -r REPLY
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
	echo
	echo "Aborted."
	exit 1
fi
echo

# feedback
echo "Suspending..."

# Set RTC wakeup time
# Change mode for the suspend option (man rtcwake)
sudo rtcwake --auto --mode mem --time $DESIRED

# N.B. dont usually require this bit
# give rtcwake some time to do its stuff
# sleep 2
# then suspend
#sudo pm-suspend

# Any commands you want to launch after wakeup can be placed here
# Remember: sudo may have expired by now
source $2


