#!/bin/bash

#includes
. /mnt/.system/global/functions.sh

PERSON=`getent passwd $USER | cut -d ':' -f 5 | cut -d ',' -f 1`


# Force Zenity Status message box to always be on top.
sleep 1 && wmctrl -r "Starting up" -b add,above &

(
# =================================================================
set_background_telesales
slacktee_logon_telesales
set_launcher_telesales
set_menues_telesales
backup_bria
wmctrl -r "Starting up" -b add,above &
echo "# Setting Preferences" ; sleep 4

# =================================================================
start_pidgin
start_slack
wmctrl -r "Starting up" -b add,above &
echo "30"
echo "# Starting IM Client" ; sleep 2

# =================================================================
start_firefox_telesales
wmctrl -r "Starting up" -b add,above &
echo "40"
echo "# Starting Web Browser" ; sleep 2

# =================================================================
startvm_telesales
timeout_telesales &
wmctrl -r "Starting up" -b add,above &
echo "60"
echo "# Starting Virtual Machine" ; sleep 3

# =================================================================
start_remote_telesales
wmctrl -r "Starting up" -b add,above &
echo "70"
echo "# Starting RDS" ; sleep 2

# =================================================================
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

zenity --info --text "Welcome, $PERSON. System ready for use. V2.1" --timeout 5

exit 0
