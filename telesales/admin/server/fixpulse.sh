#!/bin/bash

pulseaudio -k
sleep 0.1
pulseaudio -D
zenity --title "System Authority" --info --text "Sound Service Restarted" --timeout 2
exit
