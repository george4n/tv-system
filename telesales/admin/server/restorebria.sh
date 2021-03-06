#!/bin/bash

zenity --timeout=10 --height=50 --width=360 --title "System Authority" --question --text="Are you sure you want to restore Bria? \n\nOnly use this if you are experiencing problems with Bria. This will restore the most recent backup of your softphone profile."
if [ $? = 0 ]; then
	killall -15 bria
	rm ~/.cpspace/*
	cp -R ~/.cpspacebak/* ~/.cpspace/
	nohup bria &
else
	exit
fi
