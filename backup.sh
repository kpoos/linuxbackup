#!/bin/bash
#DESTDRIVE is the udisk mounted usb drive on my linux box, should have a Backup directory
DESTDRIVE=45B0E53A20A76EB5 
#DESTDRIVE=1ba2a2ef-bb9e-40c1-9c0e-31ae36f06f4e


ROOT=$(df | grep "/$" | awk {'print $1'} | awk -F/ {' print $3'})
VAR=$(df | grep "/var$" | awk {'print $1'} | awk -F/ {' print $3'})
apt-get clean
dpkg --get-selections > /home/$USER/Backup_`hostname`/selections-`date +%Y-%m-%d`
rsync -avh /etc/hosts /home/$USER/Backup_`hostname`/
rsync -avh /etc/network/interfaces /home/$USER/Backup_`hostname`/
tar -cf /home/$USER/Backup_`hostname`/etc-`date +%Y-%m-%d`.tar.gz /etc/*
cp /home/$USER/Backup_`hostname`/etc-`date +%Y-%m-%d`.tar.gz /media/$USER/$DESTDRIVE/Backup/`hostname`/
udisksctl mount -b /dev/sda2
udisksctl mount -b /dev/sda1
mkdir /media/$USER/$DESTDRIVE/Backup/`hostname`
cat /dev/zero > /a.out; rm /a.out
cat /dev/$ROOT | xz > /media/$USER/$DESTDRIVE/Backup/`hostname`/$ROOT-`date +%Y-%m-%d`.xz
cat /dev/zero > /var/a.out; rm /var/a.out
cat /dev/$VAR | xz > /media/$USER/$DESTDRIVE/Backup/`hostname`/$VAR-`date +%Y-%m-%d`.xz
