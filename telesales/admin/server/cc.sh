#!/bin/bash

CHOICE=$(zenity --height=280 --width=360 --list \
   --title="Televinken Control Center" \
   --column="Task" --column="Description" \
   "1" "Logout Session" \
   "2" "Restart Bria" \
   "3" "Restore Bria Settings" \
   "4" "Refresh Logon Process" \
   "5" "Kill Remote" \
   "6" "Check Latency Dialing" \
   "7" "Check Latency Remote" \
   "8" "Refresh Sound System" \

)

if [[ $CHOICE = "1" ]]; then
  /mnt/.system/telesales/admin/server/./logout.sh &
elif [[ $CHOICE = "2" ]]; then
  /mnt/.system/telesales/admin/server/./fixbria.sh &
elif [[ $CHOICE = "3" ]]; then
  /mnt/.system/telesales/admin/server/./restorebria.sh &
elif [[ $CHOICE = "4" ]]; then
  /mnt/.system/telesales/admin/server/./logon.sh &
elif [[ $CHOICE = "5" ]]; then
  killall rdesktop &
elif [[ $CHOICE = "6" ]]; then
  gnome-terminal --geometry=800x800 -e "mtr sip06.dialing.se" &
elif [[ $CHOICE = "7" ]]; then
  gnome-terminal --geometry=800x800 -e "mtr 172.28.64.150" &
elif [[ $CHOICE = "8" ]]; then
  /mnt/.system/telesales/admin/server/./fixpulse.sh &
      exit
fi
