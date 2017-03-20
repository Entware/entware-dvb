#!/opt/bin/sh
# Copyright (C) 2015-2017 NDM Systems, McMCC

export LANG=C

echo "/opt/sbin/modprobe" > /proc/sys/kernel/modprobe

VER_KMOD=`uname -r`
NEED_KMOD=`/opt/sbin/modprobe -c | grep -i v${usb_vendor}p${usb_model}d | cut -f3 -d " "`
GET_CLASS=`/opt/sbin/usbdev_get_class 0x${usb_vendor} 0x${usb_model}`
DIR_KMOD=/opt/lib/modules/$VER_KMOD
CHK_ALIAS=$DIR_KMOD/modules.alias
CHK_SYMS=$DIR_KMOD/modules.symbols

if [ ! -d $DIR_KMOD ]; then
	exit 0
fi

if [ ! -f $CHK_ALIAS ] && [ ! -f $CHK_SYMS ]; then
	/opt/sbin/depmod -a 2> /dev/null
fi

if [ "$1" = "start" ]; then

	if [ ! -n "$NEED_KMOD" ] && [ "$usb_subsystem" = "usb_device" ]; then
		if [ -n "$GET_CLASS" ]; then
			for class in $GET_CLASS; do
				case "$class" in
					audio)
						/opt/sbin/modprobe -q snd-usb-audio
						/opt/sbin/modprobe -q snd-usbmidi-lib
					;;
					video)
						/opt/sbin/modprobe -q uvcvideo
					;;
					hid)
						/opt/sbin/modprobe -q usbhid
					;;
				esac
			done
		fi
	fi

	if [ -n "$NEED_KMOD" ]; then
		/opt/sbin/modprobe -q $NEED_KMOD
	fi
fi

exit 0
