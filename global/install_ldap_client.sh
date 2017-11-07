#!/bin/bash

#includes
source /mnt/users/.system/global/install_functions.sh

system_makeroot
welcome
configure_sources
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
system_restart_services
blacklist_hdmi_audio

system_upgrade
system_restart_services
system_reboot







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



Make local root Database admin:                                                                                           │
        │                                                                                                                           │
        │                                    <Yes>                                       <No>                                       │
        │




preseed your config:

echo -e " \
libnss-ldap libnss-ldap/dblogin boolean false
libnss-ldap shared/ldapns/base-dn   string  dc=ldapserver,dc=lan
libnss-ldap libnss-ldap/binddn  string  cn=proxyuser,dc=example,dc=com
libnss-ldap libnss-ldap/dbrootlogin boolean true
libnss-ldap libnss-ldap/override    boolean true
libnss-ldap shared/ldapns/ldap-server   string  ldap://172.20.100.20
libnss-ldap libnss-ldap/confperm    boolean false
libnss-ldap libnss-ldap/rootbinddn  string  cn=admin,dc=ldapserver,dc=lan
libnss-ldap shared/ldapns/ldap_version  select  3
libnss-ldap libnss-ldap/nsswitch    note    \
" | debconf-set-selections

install your package unattended:

export DEBIAN_FRONTEND=noninteractive
aptitude --without-recommends install libnss-ldap
