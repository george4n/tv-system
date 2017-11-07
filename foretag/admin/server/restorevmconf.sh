#!/bin/bash

zenity --timeout=10 --height=50 --width=360 --title "System Authority" --question --text="Are you sure you want to restore VirtualBox Configuration? \n\nOnly use this if VirtualBox cannot start, or if it starts with error messages. This will restore the most recent backup of your virtual machine. This operation will take approximately 15 seconds to complete."
if [ $? = 0 ]; then
	killall -15 VirtualBox
	sleep 15
	rm ~/.config/VirtualBox/*
	cp -R ~/.config/VirtualBoxBak/* ~/.config/VirtualBox/
	nohup virtualbox &
else
	exit
fi
