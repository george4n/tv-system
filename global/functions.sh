#!/bin/bash

#######################################
#          LOGON FUNCTIONS
#######################################

function slacktee_logon_kundservice {
  echo "$HOSTNAME logon session by `getent passwd $USER | cut -d ':' -f 5 | cut -d ',' -f 1` ($USER)" | /mnt/.system/kundservice/admin/server/slacktee.sh -p -a good
}
function slacktee_logout_kundservice {
  echo "$HOSTNAME logout session by `getent passwd $USER | cut -d ':' -f 5 | cut -d ',' -f 1` ($USER)" | /mnt/.system/kundservice/admin/server/slacktee.sh -p -a good
}

function slacktee_logon_foretag {
  echo "$HOSTNAME logon session by `getent passwd $USER | cut -d ':' -f 5 | cut -d ',' -f 1` ($USER)" | /mnt/.system/foretag/admin/server/slacktee.sh -p -a good
}
function slacktee_logout_foretag {
  echo "$HOSTNAME logout session by `getent passwd $USER | cut -d ':' -f 5 | cut -d ',' -f 1` ($USER)" | /mnt/.system/foretag/admin/server/slacktee.sh -p -a good
}

function slacktee_logon_telesales {
  echo "$HOSTNAME logon session by `getent passwd $USER | cut -d ':' -f 5 | cut -d ',' -f 1` ($USER)" | /mnt/.system/telesales/admin/server/slacktee.sh -p -a good
}
function slacktee_logout_telesales {
  echo "$HOSTNAME logout session by `getent passwd $USER | cut -d ':' -f 5 | cut -d ',' -f 1` ($USER)" | /mnt/.system/telesales/admin/server/slacktee.sh -p -a good
}

function slacktee_logon_televinken {
  echo "$HOSTNAME logon session by `getent passwd $USER | cut -d ':' -f 5 | cut -d ',' -f 1` ($USER)" | /mnt/.system/televinken/admin/server/slacktee.sh -p -a good
}
function slacktee_logout_televinken {
  echo "$HOSTNAME logout session by `getent passwd $USER | cut -d ':' -f 5 | cut -d ',' -f 1` ($USER)" | /mnt/.system/televinken/admin/server/slacktee.sh -p -a good
}


function start_bria {
  killall -15 bria
  nohup bria &
}

function backup_bria  {
  mkdir ~/.cpspacebak
  cp -R ~/.cpspace/* ~/.cpspacebak/
}

function backup_vm_conf {
  mkdir ~/.config/VirtualBoxBak
  cp -R ~/.config/VirtualBox/* ~/.config/VirtualBoxBak/
}

function start_pidgin {
  nohup pidgin &
}

function start_slack {
  nohup slack &
}
function start_firefox_foretag {
  nohup firefox https://login06.dialing.se &
}

function start_firefox_telesales {
  nohup firefox https://login06.dialing.se &
}

function start_firefox_televinken {
  nohup firefox https://tv.dialingozone.com &
}

function start_firefox_kundservice {
  nohup firefox https://crm.tre.se &
}

function start_remote_foretag {
  /mnt/.system/foretag/admin/server/./remote.sh &
}

function start_remote_kundservice {
  /mnt/.system/kundservice/admin/server/./remote.sh &
}

function start_remote_telesales {
  /mnt/.system/telesales/admin/server/./remote.sh &
}

function startvm_foretag {
  VBoxManage startvm winux001
  VBoxManage startvm winux002
  VBoxManage startvm winux003
  VBoxManage startvm winux004
  VBoxManage startvm winux005
  VBoxManage startvm winux006
  VBoxManage startvm winux007
  VBoxManage startvm winux008
  VBoxManage startvm winux009
  VBoxManage startvm winux010
  VBoxManage startvm winux011
  VBoxManage startvm winux012
  VBoxManage startvm winuc078
  VBoxManage startvm winuc079
  VBoxManage startvm winuc080
  VBoxManage startvm winuc081
  VBoxManage startvm winuc082
  VBoxManage startvm winuc083
  VBoxManage startvm winuc084
  VBoxManage startvm winuc085
  VBoxManage startvm winuc086
  VBoxManage startvm winuc087
  VBoxManage startvm winuc088
  VBoxManage startvm winuc089
  VBoxManage startvm winuc090
  VBoxManage startvm winuc091
  VBoxManage startvm winuc092
  VBoxManage startvm winuc093
  VBoxManage startvm winuc094
  VBoxManage startvm winuc095
  VBoxManage startvm nux001
  VBoxManage startvm nux002
  VBoxManage startvm nux003
  VBoxManage startvm nux004
  VBoxManage startvm nux005
  VBoxManage startvm nux006
  VBoxManage startvm nux007
  VBoxManage startvm nux008
  VBoxManage startvm nux009
  VBoxManage startvm nux010
  VBoxManage startvm nux011
  VBoxManage startvm nux012
  VBoxManage startvm nux013
  VBoxManage startvm nux014
  VBoxManage startvm nux015
  VBoxManage startvm nux016
  VBoxManage startvm nux017
  VBoxManage startvm nux018
  VBoxManage startvm nux019
  VBoxManage startvm nux020
}

function startvm_telesales {
  ls
}

function startvm_televinken {
  VBoxManage startvm winux069
}

function set_background_foretag {
  gsettings set org.gnome.desktop.background picture-uri 'file:///mnt/.system/foretag/admin/wallpaper/3logo.jpg'
  #gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/warty-final-ubuntu.png'
}

function set_background_telesales {
  gsettings set org.gnome.desktop.background picture-uri 'file:///mnt/.system/telesales/admin/wallpaper/3logo.jpg'
  #gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/warty-final-ubuntu.png'
}

function set_background_televinken {
  gsettings set org.gnome.desktop.background picture-uri 'file:///mnt/.system/televinken/admin/wallpaper/wallpaper6.jpg'
  #gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/warty-final-ubuntu.png'
}

function set_background_kundservice {
  gsettings set org.gnome.desktop.background picture-uri 'file:///mnt/.system/kundservice/admin/wallpaper/3logo.jpg'
  #gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/warty-final-ubuntu.png'
}

function set_launcher_foretag {

gsettings set com.canonical.Unity.Launcher favorites "[
'application://nautilus-home.desktop',
'application://google-chrome.desktop',
'application://firefox.desktop',
'application:///mnt/.system/foretag/admin/client/remote.desktop',
'application://virtualbox.desktop',
'application://bria.desktop',
'application://gnome-calculator.desktop',
'application://xpad.desktop',
'application://slack.desktop',
'unity://running-apps',
'application:///mnt/.system/foretag/admin/client/assist.desktop',
'application:///mnt/.system/foretag/admin/client/cc.desktop',
'application:///mnt/.system/foretag/admin/client/logout.desktop',
'application:///mnt/.system/foretag/admin/client/reboot.desktop',
'unity://expo-icon',
'unity://devices']"


}

function set_launcher_telesales {

gsettings set com.canonical.Unity.Launcher favorites "[
'application://nautilus-home.desktop',
'application://google-chrome.desktop',
'application://firefox.desktop',
'application:///mnt/.system/telesales/admin/client/remote.desktop',
'application://bria.desktop',
'application://gnome-calculator.desktop',
'application://xpad.desktop',
'unity://running-apps',
'application:///mnt/.system/telesales/admin/client/assist.desktop',
'application:///mnt/.system/telesales/admin/client/cc.desktop',
'application:///mnt/.system/telesales/admin/client/logout.desktop',
'unity://expo-icon',
'unity://devices']"

}

function set_launcher_televinken {

gsettings set com.canonical.Unity.Launcher favorites "[
'application://nautilus-home.desktop',
'application://google-chrome.desktop',
'application://gnome-calculator.desktop',
'application://xpad.desktop',
'application://slack.desktop',
'unity://running-apps',
'application://wps-office-et.desktop',
'application://wps-office-wps.desktop',
'application:///mnt/.system/televinken/admin/client/assist.desktop',
'application:///mnt/.system/televinken/admin/client/cc.desktop',
'application:///mnt/.system/televinken/admin/client/logout.desktop',
'application:///mnt/.system/televinken/admin/client/reboot.desktop',
'unity://expo-icon',
'unity://devices']"

}

function set_launcher_kundservice {

gsettings set com.canonical.Unity.Launcher favorites "[
'application://nautilus-home.desktop',
'application://google-chrome.desktop',
'application:///mnt/.system/kundservice/admin/client/remote.desktop',
'application://gnome-calculator.desktop',
'application://xpad.desktop',
'application://bria.desktop',
'unity://running-apps',
'application:///mnt/.system/kundservice/admin/client/assist.desktop',
'application:///mnt/.system/kundservice/admin/client/cc.desktop',
'application:///mnt/.system/kundservice/admin/client/logout.desktop',
'unity://expo-icon',
'unity://devices']"

}

function set_menues_foretag {

echo "

  gsettings set com.canonical.indicator.session show-real-name-on-panel true
  gsettings set com.canonical.indicator.session suppress-logout-menuitem true
  gsettings set com.canonical.indicator.session suppress-restart-menuitem true
  gsettings set com.canonical.indicator.session suppress-shutdown-menuitem true
  gsettings set com.canonical.indicator.session suppress-logout-restart-shutdown true
  gsettings set com.canonical.indicator.session user-show-menu true
  gsettings set com.canonical.indicator.datetime custom-time-format '%l:%M %p'
  #
  gsettings set com.canonical.indicator.datetime show-calendar true
  gsettings set com.canonical.indicator.datetime show-clock true
  gsettings set com.canonical.indicator.datetime show-date true
  gsettings set com.canonical.indicator.datetime show-day true
  gsettings set com.canonical.indicator.datetime show-events true
  gsettings set com.canonical.indicator.datetime show-locations true
  gsettings set com.canonical.indicator.datetime show-seconds true
  gsettings set com.canonical.indicator.datetime show-week-numbers true
  gsettings set com.canonical.indicator.datetime time-format '24-hour'
  gsettings set com.canonical.indicator.datetime timezone-name 'Asia/Nicosia Nicosia'
  #
  gsettings set org.gnome.desktop.session idle-delay 7200
  #
  gsettings set org.gnome.Vino enabled true
  gsettings set org.gnome.Vino view-only false
  gsettings set org.gnome.Vino prompt-enabled false
  gsettings set org.gnome.Vino icon-visibility never
  gsettings set org.gnome.Vino vnc-password 'YWRtaW4pIT0='

" | bash

}

function set_menues_telesales {

echo "

  gsettings set com.canonical.indicator.session show-real-name-on-panel true
  gsettings set com.canonical.indicator.session suppress-logout-menuitem true
  gsettings set com.canonical.indicator.session suppress-restart-menuitem true
  gsettings set com.canonical.indicator.session suppress-shutdown-menuitem true
  gsettings set com.canonical.indicator.session suppress-logout-restart-shutdown true
  gsettings set com.canonical.indicator.session user-show-menu true
  gsettings set com.canonical.indicator.datetime custom-time-format '%l:%M %p'
  #
  gsettings set com.canonical.indicator.datetime show-calendar true
  gsettings set com.canonical.indicator.datetime show-clock true
  gsettings set com.canonical.indicator.datetime show-date true
  gsettings set com.canonical.indicator.datetime show-day true
  gsettings set com.canonical.indicator.datetime show-events true
  gsettings set com.canonical.indicator.datetime show-locations true
  gsettings set com.canonical.indicator.datetime show-seconds true
  gsettings set com.canonical.indicator.datetime show-week-numbers true
  gsettings set com.canonical.indicator.datetime time-format '24-hour'
  gsettings set com.canonical.indicator.datetime timezone-name 'Asia/Nicosia Nicosia'
  #
  gsettings set org.gnome.desktop.session idle-delay 7200
  #
  gsettings set org.gnome.Vino enabled true
  gsettings set org.gnome.Vino view-only false
  gsettings set org.gnome.Vino prompt-enabled false
  gsettings set org.gnome.Vino icon-visibility never
  gsettings set org.gnome.Vino vnc-password 'YWRtaW4pIT0='
  #
  gsettings set org.gtk.Settings.FileChooser show-hidden false

" | bash

}

function set_menues_televinken {

echo "

  gsettings set com.canonical.indicator.session show-real-name-on-panel true
  gsettings set com.canonical.indicator.session suppress-logout-menuitem true
  gsettings set com.canonical.indicator.session suppress-restart-menuitem true
  gsettings set com.canonical.indicator.session suppress-shutdown-menuitem true
  gsettings set com.canonical.indicator.session suppress-logout-restart-shutdown true
  gsettings set com.canonical.indicator.session user-show-menu true
  gsettings set com.canonical.indicator.datetime custom-time-format '%l:%M %p'
  #
  gsettings set com.canonical.indicator.datetime show-calendar true
  gsettings set com.canonical.indicator.datetime show-clock true
  gsettings set com.canonical.indicator.datetime show-date true
  gsettings set com.canonical.indicator.datetime show-day true
  gsettings set com.canonical.indicator.datetime show-events true
  gsettings set com.canonical.indicator.datetime show-locations true
  gsettings set com.canonical.indicator.datetime show-seconds true
  gsettings set com.canonical.indicator.datetime show-week-numbers true
  gsettings set com.canonical.indicator.datetime time-format '24-hour'
  gsettings set com.canonical.indicator.datetime timezone-name 'Asia/Nicosia Nicosia'
  #
  gsettings set org.gnome.desktop.session idle-delay 7200
  #
  gsettings set org.gnome.Vino enabled true
  gsettings set org.gnome.Vino view-only false
  gsettings set org.gnome.Vino prompt-enabled false
  gsettings set org.gnome.Vino icon-visibility never
  gsettings set org.gnome.Vino vnc-password 'YWRtaW4pIT0='
  #
  gsettings set org.gtk.Settings.FileChooser show-hidden false

" | bash

}

function set_menues_kundservice {

echo "

  gsettings set com.canonical.indicator.session show-real-name-on-panel true
  gsettings set com.canonical.indicator.session suppress-logout-menuitem true
  gsettings set com.canonical.indicator.session suppress-restart-menuitem true
  gsettings set com.canonical.indicator.session suppress-shutdown-menuitem true
  gsettings set com.canonical.indicator.session suppress-logout-restart-shutdown true
  gsettings set com.canonical.indicator.session user-show-menu true
  gsettings set com.canonical.indicator.datetime custom-time-format '%l:%M %p'
  #
  gsettings set com.canonical.indicator.datetime show-calendar true
  gsettings set com.canonical.indicator.datetime show-clock true
  gsettings set com.canonical.indicator.datetime show-date true
  gsettings set com.canonical.indicator.datetime show-day true
  gsettings set com.canonical.indicator.datetime show-events true
  gsettings set com.canonical.indicator.datetime show-locations true
  gsettings set com.canonical.indicator.datetime show-seconds true
  gsettings set com.canonical.indicator.datetime show-week-numbers true
  gsettings set com.canonical.indicator.datetime time-format '24-hour'
  gsettings set com.canonical.indicator.datetime timezone-name 'Asia/Nicosia Nicosia'
  #
  gsettings set org.gnome.desktop.session idle-delay 1800
  #
  gsettings set org.gnome.Vino enabled true
  gsettings set org.gnome.Vino view-only false
  gsettings set org.gnome.Vino prompt-enabled false
  gsettings set org.gnome.Vino icon-visibility never
  gsettings set org.gnome.Vino vnc-password 'YWRtaW4pIT0='
  #
  gsettings set org.gtk.Settings.FileChooser show-hidden false

" | bash

}

#######################################
#          LOGOUT FUNCTIONS
#######################################

function savevm_foretag {
  VBoxManage controlvm nux001 acpipowerbutton
  VBoxManage controlvm nux002 acpipowerbutton
  VBoxManage controlvm nux003 acpipowerbutton
  VBoxManage controlvm nux004 acpipowerbutton
  VBoxManage controlvm nux005 acpipowerbutton
  VBoxManage controlvm nux006 acpipowerbutton
  VBoxManage controlvm nux007 acpipowerbutton
  VBoxManage controlvm nux008 acpipowerbutton
  VBoxManage controlvm nux009 acpipowerbutton
  VBoxManage controlvm nux010 acpipowerbutton
  VBoxManage controlvm nux011 acpipowerbutton
  VBoxManage controlvm nux012 acpipowerbutton
  VBoxManage controlvm nux013 acpipowerbutton
  VBoxManage controlvm nux014 acpipowerbutton
  VBoxManage controlvm nux015 acpipowerbutton
  VBoxManage controlvm nux016 acpipowerbutton
  VBoxManage controlvm nux017 acpipowerbutton
  VBoxManage controlvm nux018 acpipowerbutton
  VBoxManage controlvm nux019 acpipowerbutton
  VBoxManage controlvm nux020 acpipowerbutton
}

function savevm_telesales {

  VBoxManage controlvm winux001 savestate
  VBoxManage controlvm winux002 savestate
  VBoxManage controlvm winux003 savestate
  VBoxManage controlvm winux004 savestate
  VBoxManage controlvm winux005 savestate
  VBoxManage controlvm winux006 savestate
  VBoxManage controlvm winux007 savestate
  VBoxManage controlvm winux008 savestate
  VBoxManage controlvm winux009 savestate
  VBoxManage controlvm winux010 savestate
  VBoxManage controlvm winux011 savestate
  VBoxManage controlvm winux012 savestate

}

function savevm_televinken {

  VBoxManage controlvm winux069 savestate

}

function logout_wallpaper {

  gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/warty-final-ubuntu.png'

}

function timeout_televinken {

  until date | fgrep -q "01:00:"; do
    sleep 1
  done
    /mnt/.system/televinken/admin/server/./force-logout.sh

}

function timeout_telesales {

  until date | fgrep -q "01:00:"; do
    sleep 1
  done
    /mnt/.system/telesales/admin/server/./force-logout.sh

}

function timeout_foretag {

  until date | fgrep -q "19:00:"; do
    sleep 1
  done
    /mnt/.system/foretag/admin/server/./force-logout.sh

}

function timeout_kundservice {

  until date | fgrep -q "01:00:"; do
    sleep 1
  done
    /mnt/.system/kundservice/admin/server/./force-logout.sh

}


function close_apps {

  killall -15 firefox
  killall -15 pidgin
  killall -15 nautilus
  killall -15 gnome-calculator
  killall -15 slack
  killall -15 bria
  killall -15 google-chrome
  killall -15 google-chrome-stable

}

function set_logon_script_foretag {

  rm -rf ~/.config/autostart/*
  cp -r /mnt/.system/foretag/admin/client/logon.desktop ~/.config/autostart/
  cp -r /mnt/.system/foretag/admin/client/bria.desktop ~/.config/autostart/

}

function set_logon_script_kundservice {

  rm -rf ~/.config/autostart/*
  cp -r /mnt/.system/kundservice/admin/client/logon.desktop ~/.config/autostart/
  cp -r /mnt/.system/kundservice/admin/client/bria.desktop ~/.config/autostart/

}

function set_logon_script_telesales {

  rm -rf ~/.config/autostart/*
  cp -r /mnt/.system/telesales/admin/client/logon.desktop ~/.config/autostart/
  cp -r /mnt/.system/telesales/admin/client/bria.desktop ~/.config/autostart/

}

function set_logon_script_televinken {

  rm -rf ~/.config/autostart/*
  cp -r /mnt/.system/televinken/admin/client/logon.desktop ~/.config/autostart/
  cp -r /mnt/.system/televinken/admin/client/bria.desktop ~/.config/autostart/

}

function check_rdesktop {

  if (( $(ps -ef | grep -v grep | grep rdesktop | wc -l) > 0 ))
    then
      zenity --title="You forgot something..." --error --text="\n\n\n\n\nERROR You must logout from Remote Desktop services before your session can be terminated" --width=400 --height=50
    else
      zenity --timeout=10 --title "System Authority" --question --text="Are you sure you want to logout?"
      if [[ $? = 0 ]]; then
        logout_procedure
      else
        exit
      fi
  fi

}
