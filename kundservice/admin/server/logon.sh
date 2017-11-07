#!/bin/bash

#includes
. /mnt/.system/global/functions.sh

PERSON=`getent passwd $USER | cut -d ':' -f 5 | cut -d ',' -f 1`


# Force Zenity Status message box to always be on top.
sleep 1 && wmctrl -r "Starting up" -b add,above &

(
# =================================================================
slacktee_logon_kundservice
set_background_kundservice
set_launcher_kundservice
set_menues_kundservice
backup_bria
wmctrl -r "Starting up" -b add,above &
echo "# Setting Preferences" ; sleep 4

# =================================================================
#start_remote_kundservice
timeout_kundservice &
wmctrl -r "Starting up" -b add,above &
echo "70"
echo "# Starting RDS" ; sleep 2

# =================================================================
remmina -i &
chown -R $USER:503 ~/.remmina/
chmod -R 700 ~/.remmina/
wmctrl -r "Starting up" -b add,above &
echo "# System Ready" ; sleep 2
echo "100"


) |
zenity --progress \
  --title="Starting up" \
  --text="First Task." \
  --percentage=0 \
  --pulsate \
  --auto-close \
  --auto-kill

(( $? != 0 )) && zenity --error --text="Error: Could not complete task."

zenity --info --text "Welcome, $PERSON. System ready for use. V2.1" --timeout 2 --no-wrap

exit 0
