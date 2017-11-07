#!/bin/bash

zenity --question --title "Request for Assistance" --no-wrap --text "Do you want to notify the IT Manager at Televinken for Assistance? \n\nPlease be aware that support is only available\:
\nMonday to Friday from 09\:00 until 18\:00. Remote support is available until 21\:00 daily."
  if [[ $? = 1 ]]; then
    exit
  else
    echo "assistance needed by `getent passwd $USER | cut -d ':' -f 5 | cut -d ',' -f 1` ($USER) on $HOSTNAME" | /mnt/.system/foretag/admin/server/slacktee.sh -p -c assistance -a danger
    zenity --info --width=50 --title "Request Status" --text "\nRequest has been sent! \n\nPlease allow up to 10 minutes for a response." --no-wrap --timeout=5
fi



szAnswer=$(zenity --entry --text "where are you?" --entry-text "at home"); echo $szAnswer
