#! /bin/bash
SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
INSTALLPATH=/home/pi/fullscreenviewer
if [ "$SCRIPTPATH" != "$INSTALLPATH" ]; then
  echo "not running from $INSTALLPATH -> first copying files there."
  echo "removing $INSTALLPATH"
  rm -rf $INSTALLPATH
  echo "creating $INSTALLPATH"
  mkdir -p $INSTALLPATH
  echo "copying $SCRIPTPATH/* to $INSTALLPATH"
  cp -r $SCRIPTPATH/* $INSTALLPATH
fi

echo "install dependencies ..."

sudo apt-get update && apt-get install -y gphoto2 rsync

echo "setting up gphoto2 autostart by:"
echo "copying $SCRIPTPATH/gphoto2.desktop to /etc/xdg/autostart/"

sudo cp $SCRIPTPATH/gphoto2.desktop /etc/xdg/autostart/ 

echo "INSTALLATION PROCESS DONE - PLEASE REBOOT (e.g. via 'sudo reboot')"