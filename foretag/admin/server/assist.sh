#!/bin/bash

zenity --question --title "Request for Assistance" --no-wrap --text "Do you want to notify the IT Department at Televinken for Assistance? \n\nPlease be aware that support is only available\:
\nMonday to Friday from 09\:00 until 18\:00."
  if [[ $? = 1 ]]; then
    zenity --info --width=50 --title "Request Status" --text "\nRequest has been cancelled!" --no-wrap --timeout=5 && exit
  else

    szAnswer=$(zenity --entry --text "What seems to be the problem?" --entry-text "");

    if [[ $szAnswer < 1 ]]; then
      zenity --info --width=50 --title "Request Status" --text "\nRequest has NOT been sent! \n\nPlease state your issue and try again." --no-wrap --timeout=5 && exit
    else
      echo "assistance needed by `getent passwd $USER | cut -d ':' -f 5 | cut -d ',' -f 1` ($USER) on $HOSTNAME. ***$szAnswer***" | /mnt/.system/foretag/admin/server/slacktee.sh -p -c assistance -a danger
      zenity --info --width=50 --title "Request Status" --text "\nRequest has been sent! \n\nPlease allow up to 10 minutes for a response." --no-wrap --timeout=5
    fi
fi
