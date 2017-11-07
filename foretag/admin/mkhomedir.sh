#!/bin/bash
# version 1.0
# Author George Neophytou

#1.intro
clear
echo "This will create a new home directory for your user"

#2.questions
echo "What is the name of your user's home directory?"
read USERNAME
clear
echo "What is the uidNumber for the user?"
read USERID
clear
echo "What is the gidNumber for the user?"
read GROUPID
clear
echo "Okay got it!"
sleep 1
clear

#3.process
echo "making home directory..."
mkdir /home/users/telesales/$USERNAME
echo "done"
sleep 1
echo "setting owner..."
chown -R '$USERID:$GROUP' /home/users/telesales/$USERNAME/
echo "setting permissions..."
chmod -R 0700 /home/users/$USERNAME
echo "done"
sleep 2
echo "complete!"
sleep 2

