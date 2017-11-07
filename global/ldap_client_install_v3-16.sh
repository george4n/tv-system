#!/bin/bash
# Version Information
# 1.0 - Initial Script
# 1.0.1 - Added "only root execution function"
#  		- Added function to check if packages are already installed
#		-
# 2.0   - Functions Everywhere

#### FUNCTIONS ####

#welcome
#configure_sources
#system_update
#system_install_dependancies
#system_upgrade
#system_restart_services
#system_reboot
#system_install_dependancies
#system_makeroot

#install_nfs_common
#install_libnss_ldap
#install_libpam_ldap
#install_nscd
#install_autofs
#install_openssh
#install_rdesktop
#install_pidgin
#install_bria
#install_virtualbox

#blacklist_hdmi_audio
#ldap_conf
#nss_conf
#pam_conf
#lightdm_conf
#autofs_conf

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
BRIA=172.20.10.250/bria32.deb

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
	echo "This script should only be used on a fresh install of Ubuntu 14.04.3 LTS"
	echo "==========================================================="
	echo ""
}

function set_hosts {
  mv /etc/hosts /etc/hosts.bak
  touch /etc/hosts
  echo "
127.0.0.1         localhost
127.0.1.1         $HOSTNAME
172.20.10.250     server
172.20.100.11     skynet.tvloc " >> /etc/hosts
}

function configure_sources {
	SOURCES=/etc/apt/sources.list
	cp $SOURCES $SOURCES.bak
	rm $SOURCES
	echo '
deb ftp://skynet.tvloc/ubuntu/ xenial main restricted universe multiverse
deb ftp://skynet.tvloc/ubuntu/ xenial-security main restricted universe multiverse
deb ftp://skynet.tvloc/ubuntu/ xenial-updates main restricted universe multiverse
deb ftp://skynet.tvloc/ubuntu/ xenial-backports main restricted universe multiverse
deb ftp://skynet.tvloc/ubuntu/ xenial-proposed main restricted universe multiverse
' >> $SOURCES
	echo "==========================================================="
	echo "New Sources have been added"
	echo "==========================================================="
mv /etc/apt/apt.conf.d/50appstream /etc/apt/apt.conf.d/50appstream.bak
}

function configure_sources_misc {
	SOURCES=/etc/apt/sources.list
	echo '
deb http://download.virtualbox.org/virtualbox/debian xenial contrib
' >> $SOURCES
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
	echo "==========================================================="
	echo "New Sources have been added"
	echo "==========================================================="
}

function system_update {
    apt-get update
    echo "==========================================================="
    echo "Sources have been updated"
    echo "==========================================================="
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
	dpkg -i bria32.deb
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

function install_xpad {
	apt-get install xpad -y
}

function install_virtualbox {
  apt-get install virtualbox-5.0
  wget http://download.virtualbox.org/virtualbox/5.0.22/Oracle_VM_VirtualBox_Extension_Pack-5.0.22-108108.vbox-extpack
  VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-5.0.22-108108.vbox-extpack
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
	echo '
#users    	-fstype=nfs4,rw,soft,intr,rsize=8192,wsize=8192    	172.20.100.11:/media/rdata/home/users
kundservice	-fstype=nfs4,rw,soft,intr,rsize=8192,wsize=8192		172.20.200.100:/media/kundservice
televinken	-fstype=nfs4,rw,soft,intr,rsize=8192,wsize=8192		172.20.210.100:/media/televinken
telesales	-fstype=nfs4,rw,soft,intr,rsize=8192,wsize=8192		172.20.220.100:/media/telesales
foretag		-fstype=nfs4,rw,soft,intr,rsize=8192,wsize=8192		172.20.220.100:/media/foretag
.system   	-fstype=nfs4,rw,soft,intr,rsize=8192,wsize=8192         172.20.100.11:/srv/users/.system' >> /etc/auto.home
	service autofs restart
}




system_makeroot
welcome
set_hosts
configure_sources
configure_sources_misc
system_update
install_nfs_common
install_libnss_ldap
install_libpam_ldap
install_nscd
install_autofs
ldap_conf
nss_conf
pam_conf
lightdm_conf
autofs_conf

install_bria
system_install_dependancies
install_openssh
system_install_dependancies
install_rdesktop
system_install_dependancies
install_pidgin
system_install_dependancies
install_virtualbox
system_install_dependancies
install_xpad
system_install_dependancies
system_restart_services
blacklist_hdmi_audio

system_upgrade
system_restart_services
system_reboot
