#!/bin/bash

#store use input in STAGE var
STAGE=$1
ADB_REMOUNT_CMD="/adb remount "
ADB_PUSH_CMD="/adb push "
ADB_PULL_CMD="/adb pull "
HOSTS_FILE="hosts "
ANDROID_HOSTS_LOCATION="/system/etc "
ANDROID_HOSTS_FILE="/system/etc/hosts "


if [ $STAGE ]
then
  	#Get path of adb
	ADB_PATH=`find ~/ -type d -name platform-tools`
	#Pull the hosts file from the device
	$ADB_PATH$ADB_PULL_CMD$ANDROID_HOSTS_FILE$HOSTS_FILE
    #Update the hosts file
    sed -e '/10.0.2.2/d' hosts > hosts.tmp; mv hosts.tmp hosts
    echo "10.0.2.2                    $STAGE" >> hosts
	#Remount the device so you can edit the file system
	$ADB_PATH$ADB_REMOUNT_CMD
	#Push the modifed hosts file to the device
	$ADB_PATH$ADB_PUSH_CMD$HOSTS_FILE$ANDROID_HOSTS_LOCATION
	#Remove the hosts file
	rm $HOSTS_FILE
else
  echo "Please specify stage host"
fi

