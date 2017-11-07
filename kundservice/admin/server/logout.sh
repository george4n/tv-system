#!/bin/bash

#includes
. /mnt/.system/global/functions.sh

if (( $(ps -ef | grep -v grep | grep rdesktop | wc -l) > 0 ))
  then
    zenity --title="You forgot something..." --error --text="\n\n\n\n\nERROR: You must logout from Remote Desktop services before your session can be terminated" --width=400 --height=50
  else
    COUNT=11

    START=$COUNT                                                # Set a start point.

    until [ "$COUNT" -eq "0" ]; do                              # Countdown loop.
        ((COUNT-=1))                                            # Decrement seconds.
        PERCENT=$((100-100*COUNT/START))                        # Calc percentage.
        echo "#Automatic Logout$(echo "obase=60;$COUNT" | bc)"  # Convert to H:M:S.
          echo $PERCENT                                         # Outut for progbar.
        sleep 1
    done | zenity --title "System Authority" --progress --percentage=0 --text=""\
        --window-icon=$ICON --auto-close --height=100 --width=360
        if [ $? = 0 ]; then

      # Force Zenity Status message box to always be on top.
      sleep 1 && wmctrl -r "Logging out..." -b add,above &

      (
      # =================================================================
      set_logon_script_kundservice
      logout_wallpaper
      echo "# Reverting Preferences" ; sleep 3

      # =================================================================
      close_apps
      slacktee_logout_kundservice
      echo "90"
      echo "# Closing Applications"

      ) |
      zenity --progress \
        --title="Logging out..." \
        --text="First Task." \
        --percentage=0 \
        --pulsate \
        --auto-close \
        --auto-kill

      (( $? != 0 )) && zenity --error --text="Error: Could not complete task."
      DISPLAY=:0 gnome-session-quit --force
      DISPLAY=:0 gnome-session-quit --force
      sleep 3
      pkill -u $USER
      exit 0


  else
   exit
  fi
  fi
