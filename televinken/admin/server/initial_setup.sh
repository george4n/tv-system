#!/bin/bash

echo "What user would you like to create a Firefox Profile for?"
read PERSON
echo "What is the UID of the user?"
read ID
echo "What is the GID of the user?"
read GID
cp -r ../../Skel-Televinken/.cpspace/ ../../$PERSON/
cp -r ../../Skel-Televinken/.mozilla/ ../../$PERSON/
cp -r ../client/logout.desktop ../../$PERSON/Desktop/
chown -R "$ID:$GID" ../../$PERSON/

echo "Complete"




