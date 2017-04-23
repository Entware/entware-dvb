#!/opt/bin/sh
# Copyright (C) 2015-2017 NDM Systems, McMCC

SERV_DIR=/opt/etc/default/usb_services/$usb_subsystem

start() {
	if [ -d $SERV_DIR ]; then
		for service in `ls $SERV_DIR`; do
			/opt/etc/init.d/$service stop
			sleep 1
			/opt/etc/init.d/$service start
		done
	fi
}

stop() {
	if [ -d $SERV_DIR ]; then
		for service in `ls $SERV_DIR`; do
			/opt/etc/init.d/$service stop
		done
	fi
}

services() {
	IS_DVB=`echo $usb_devname | grep $1`
	if [ -n "$IS_DVB" ]; then
		sleep 1
		case "$2" in
			start)
				start
				;;
			stop)
				stop
				;;
		esac
	fi
}

case "$usb_subsystem" in
	dvb)
		services frontend $1
		;;
esac

exit 0
