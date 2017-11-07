#!/bin/bash

####################################################################################
########################              LDAP INSTALL          ########################
####################################################################################


#### VARIABLES ####

APP1=nfs-common
APP2=libnss-ldap
APP3=libpam-ldap
APP4=nscd
APP5=autofs
NFSIP=172.20.100.11
SERVERDIR=/media/rdata/home/users
CLIENTDIR=/home/users
HOST=ldapserver
TLD=lan
USER=cn=admin
BRIA=172.20.188.35/Bria32.deb

#### END VARIABLES ####


function system_makeroot {
# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "ERROR: Uh oh...this script must be run as root" 1>&2
   exit 1
fi
}

function welcome {
	echo "==========================================================="
	echo "This script will configure the following:"
	echo "Change /etc/apt/sources.list with local repository (trusty)"
	echo "Install nfs-common, libpam-ldap, libnss-ldap, autofs"
	echo "Blacklist Intel Audio Devices"
	echo "This script should only be used on a fresh install of Ubuntu 14.04 LTS"
	echo "==========================================================="
	echo ""
  sleep 10
}

function configure_sources {
	SOURCES=/etc/apt/sources.list
	cp $SOURCES $SOURCES.bak
	rm $SOURCES
	echo '
deb ftp://172.20.100.50/ubuntu/ trusty main restricted universe multiverse
deb ftp://172.20.100.50/ubuntu/ trusty-security main restricted universe multiverse
deb ftp://172.20.100.50/ubuntu/ trusty-updates main restricted universe multiverse
deb ftp://172.20.100.50/ubuntu/ trusty-backports main restricted universe multiverse
deb ftp://172.20.100.50/ubuntu/ trusty-proposed main restricted universe multiverse
' >> $SOURCES
	echo "==========================================================="
	echo "New Sources have been added"
	echo "==========================================================="
  sleep 3
}

function system_update {
    apt-get update
      echo "==========================================================="
      echo "Sources have been updated"
      echo "==========================================================="
      sleep 3
}

function system_upgrade {
    apt-get dist-upgrade -y
      echo "==========================================================="
	     echo "System has been upgraded"
	echo "==========================================================="
}

function system_install_dependancies {
	apt-get install -f -y
}

function system_restart_services {
    # restarts services that have a file in /tmp/needs-restart/

    for service in $(ls /tmp/restart-* | cut -d- -f2-10); do
        /etc/init.d/$service restart
        rm -f /tmp/restart-$service
    done
}

function system_reboot {
	shutdown -r now
}


function install_nfs_common {
	APP1=nfs-common
	echo "Checking if $APP1 is installed..."
if [ $(dpkg-query -W -f='${Status}' $APP1 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
	echo "$APP1 is not installed..."
	echo "$APP1 will now be installed..."
  	apt-get install -y $APP1;
  	echo "$APP1 Installed!"
else echo "$APP1 is already installed..."
fi

    echo "==========================================================="
	echo "nfs-common has been installed"
	echo "==========================================================="
}

function install_libnss_ldap {
	echo "Checking if $APP2 is installed..."
if [ $(dpkg-query -W -f='${Status}' $APP2 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
	echo "$APP2 is not installed..."
	echo "$APP2 will now be installed..."
  	apt-get install -y $APP2;
  	echo "$APP2 Installed!"
else echo "$APP2 is already installed..."
fi
	echo "Reconfiguring libnss-ldap"
dpkg-reconfigure libnss-ldap
    echo "==========================================================="
	echo "libnss-ldap has been installed"
	echo "==========================================================="

}

libpam-ldap

function install_libpam_ldap {
	echo "Checking if $APP3 is installed..."
if [ $(dpkg-query -W -f='${Status}' $APP3 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
	echo "$APP3 is not installed..."
	echo "$APP3 will now be installed..."
  	apt-get install $APP3;
  	echo "$APP3 Installed!"
else echo "$APP3 is already installed..."
fi

    echo "==========================================================="
	echo "libpam-ldap has been installed"
	echo "==========================================================="

}

function install_nscd {
	echo "Checking if $APP4 is installed..."
if [ $(dpkg-query -W -f='${Status}' $APP4 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
	echo "$APP4 is not installed..."
	echo "$APP4 will now be installed..."
  	apt-get install $APP4;
  	echo "$APP4 Installed!"
else echo "$APP4 is already installed..."
fi

    echo "==========================================================="
	echo "nscd has been installed"
	echo "==========================================================="
}

function ldap_conf {
	cp /etc/ldap/ldap.conf /etc/ldap/ldap.conf.bak
	echo "...backing up /etc/ldap/ldap.conf to /etc/ldap/ldap.conf.bak "
	sed -i "s/#BASE/BASE/" /etc/ldap/ldap.conf
	sed -i "s/dc=example,dc=com/dc=$HOST,dc=$TLD/" /etc/ldap/ldap.conf
	sed -i "s/#URI/URI/" /etc/ldap/ldap.conf
	sed -i "s/ldap\:\/\/ldap.example.com ldap\:\/\/ldap-master\.example\.com\:666/ldap\:\/\/$NFSIP/" /etc/ldap/ldap.conf
	echo "...replacing text "
	echo "Complete!"
}

function nss_conf {
	cp /etc/nsswitch.conf /etc/nsswitch.conf.bak
	sed -i "s/compat/compat ldap/" /etc/nsswitch.conf
	sed -i "s/nis/ldap/" /etc/nsswitch.conf
	/etc/init.d/nscd restart
}

function pam_conf {
cp /etc/pam.d/common-auth /etc/pam.d/common-auth.bak
rm /etc/pam.d/common-auth
echo '
# The original file can be found at /etc/pam.d/common-auth.bak
auth    [success=2 default=ignore]      pam_unix.so nullok_secure try_first_pass
auth    [success=1 default=ignore]      pam_ldap.so use_first_pass
auth    requisite                       pam_deny.so
auth    required                        pam_permit.so
auth    optional                        pam_cap.so
' >> /etc/pam.d/common-auth

cp /etc/pam.d/common-account /etc/pam.d/common-account.bak
rm /etc/pam.d/common-account
echo '
# The original file can be found at /etc/pam.d/common-account.bak
account [success=2 new_authtok_reqd=done default=ignore]        pam_unix.so
account [success=1 default=ignore]      pam_ldap.so
account requisite                       pam_deny.so
account required                        pam_permit.so
' >> /etc/pam.d/common-account

cp /etc/pam.d/common-password /etc/pam.d/common-password.bak
rm /etc/pam.d/common-password
echo '
# The original file can be found at /etc/pam.d/common-password.bak
password        [success=2 default=ignore]      pam_unix.so obscure sha512
password        [success=1 user_unknown=ignore default=die]     pam_ldap.so use_authtok try_first_pass
password        requisite                       pam_deny.so
password        required                        pam_permit.so
password        optional                        pam_gnome_keyring.so
' >> /etc/pam.d/common-password

cp /etc/pam.d/common-session /etc/pam.d/common-session.bak
echo '
# The original file can be found at /etc/pam.d/common-session.bak
session  required                                         pam_mkhomedir.so
' >> /etc/pam.d/common-session

cp /etc/pam.d/common-session-noninteractive /etc/pam.d/common-session-noninteractive.bak
rm /etc/pam.d/common-session-noninteractive
echo '
# The original file can be found at common-session-noninteractive.bak
session [default=1]                     pam_permit.so
session requisite                       pam_deny.so
session required                        pam_permit.so
session optional                        pam_umask.so
session required                        pam_unix.so
session optional                        pam_ldap.so
' >> /etc/pam.d/common-session-noninteractive
}

function lightdm_conf {
	cp /etc/lightdm/lightdm.conf /etc/lightdm/lightdm.conf.bak
rm /etc/lightdm/lightdm.conf
echo '
[SeatDefaults]
greeter-session=unity-greeter
user-session=ubuntu
autologin-user=
greeter-whoe-manual-login=true
greeter-hide-users=true
allow-guest=false
' >> /etc/lightdm/lightdm.conf
}

function install_bria {
	wget $BRIA
	dpkg -i Bria32.deb
}

function install_openssh {
	apt-get install openssh-server -y
}

function install_rdesktop {
	apt-get install rdesktop -y
}

function install_pidgin {
	apt-get install pidgin -y
}

function install_virtualbox {
	wget http://download.virtualbox.org/virtualbox/5.0.14/virtualbox-5.0_5.0.14-105127~Ubuntu~trusty_amd64.deb
	dpkg -i virtualbox-5.0_5.0.14-105127~Ubuntu~trusty_amd64.deb
}


function install_autofs {
	echo "Checking if $APP5 is installed..."
if [ $(dpkg-query -W -f='${Status}' $APP5 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
	echo "$APP5 is not installed..."
	echo "$APP5 will now be installed..."
  	apt-get install -y $APP5;
  	echo "$APP5 Installed!"
else echo "$APP5 is already installed..."
fi

    echo "==========================================================="
	echo "autofs has been installed"
	echo "==========================================================="
}

function blacklist_hdmi_audio {
	echo 'blacklist snd_hda_intel' >> /etc/modprobe.d/blacklist.conf
}

function autofs_conf {
	echo '/mnt    /etc/auto.home' >> /etc/auto.master
	echo 'users    -fstype=nfs4    172.20.100.11:/media/rdata/home/users' >> /etc/auto.home
	service autofs restart
}
