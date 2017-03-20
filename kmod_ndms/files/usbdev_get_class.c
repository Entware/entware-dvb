/*
 * Copyright (c) 2013-2017 NDM Systems. All rights reserved.
 * McMCC <mcmcc@mail.ru>
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>

#include <sys/types.h>
#include <fcntl.h>

#include <sys/ioctl.h>
#include <usb.h>

enum support_usbdev_class {
	CLASS_PER_INTERFACE = 0,
	CLASS_AUDIO = 1,
	CLASS_COMM = 2,
	CLASS_HID = 3,
	CLASS_PHYSICAL = 5,
	CLASS_PTP = 6,
	CLASS_PRINTER = 7,
	CLASS_MASS_STORAGE = 8,
	CLASS_HUB = 9,
	CLASS_DATA = 10,
	CLASS_SMART_CARD = 0x0b,
	CLASS_CONTENT_SECURITY = 0x0d,
	CLASS_VIDEO = 0x0e,
	CLASS_PERSONAL_HEALTHCARE = 0x0f,
	CLASS_DIAGNOSTIC_DEVICE = 0xdc,
	CLASS_WIRELESS = 0xe0,
	CLASS_APPLICATION = 0xfe,
	CLASS_VENDOR_SPEC = 0xff
};

struct usbdev_class {
	int class;
	char *class_name;
	int skip;
};

static struct usbdev_class usbdev_class_list[] = {
	{ CLASS_AUDIO, "audio", 0 },
	{ CLASS_COMM, "comm", 0 },
	{ CLASS_HID, "hid", 0 },
	{ CLASS_PTP, "ptp", 0 },
	{ CLASS_PRINTER, "printer", 0 },
	{ CLASS_MASS_STORAGE, "storage", 0 },
	{ CLASS_HUB, "hub", 0 },
	{ CLASS_DATA, "data", 0 },
	{ CLASS_SMART_CARD, "ccid", 0 },
	{ CLASS_VIDEO, "video", 0 },
	{ CLASS_DIAGNOSTIC_DEVICE, "debug", 0 },
	{ CLASS_WIRELESS, "wireless", 0 },
	/* Not used, skiped */
	{ CLASS_PER_INTERFACE, "pic", 1 },
	{ CLASS_VENDOR_SPEC, "vsc", 1 },
	{ CLASS_APPLICATION, "app", 1 },
	{ CLASS_PERSONAL_HEALTHCARE, "phdc", 1 }, /* Glucose meter, pulse oximeter and blood-pressure monitor... */
	{ CLASS_CONTENT_SECURITY, "csc", 1 },     /* Content Security Class */
	{ CLASS_PHYSICAL, "pid", 1 },             /* HID extension for real-time feedback */
	/* End */
	{ -1, NULL, 1 },
};

static struct usb_device *find_usbdev(int vid, int pid)
{
	struct usb_bus *busses;

	usb_init();
	usb_find_busses();
	usb_find_devices();

	busses = usb_get_busses();

	struct usb_bus *bus;

	for (bus = busses; bus; bus = bus->next) {
		struct usb_device *dev;

		for (dev = bus->devices; dev; dev = dev->next) {
			if(dev->descriptor.idVendor == vid && dev->descriptor.idProduct == pid)
			{
				return dev;
			}
		}
	}

	return NULL;
}

static void print_support_usbdev_class(int class)
{
	int i = 0;

	for (;;) {
		if (usbdev_class_list[i].class == -1)
			break;
		if ((usbdev_class_list[i].class == class) && !usbdev_class_list[i].skip) {
			printf("%s ", usbdev_class_list[i].class_name);
			usbdev_class_list[i].skip = 1;
			break;
		}
		i++;
	}
}

static void print_altsetting(struct usb_interface_descriptor *interface)
{
	print_support_usbdev_class(interface->bInterfaceClass);
}

static void print_interface(struct usb_interface *interface)
{
	int i;

	for (i = 0; i < interface->num_altsetting; i++)
		print_altsetting(&interface->altsetting[i]);
}

static void print_configuration(struct usb_config_descriptor *config)
{
	int i;

	for (i = 0; i < config->bNumInterfaces; i++)
		print_interface(&config->interface[i]);
}

static void print_support_class(struct usb_device *dev)
{
	int i;

	for (i = 0; i < dev->descriptor.bNumConfigurations; i++)
		print_configuration(&dev->config[i]);
}

int main(int argc, char **argv)
{
	int num_config;
	unsigned int vid, pid;
	struct usb_device *dev;

	if (argc < 2)
	{
		printf("Usage: %s VID PID\n", argv[0]);
		exit(1);
	}

	vid = strtoul(argv[1], NULL, *argv[1] && *(argv[1] + 1) == 'x' ? 16 : 10);
	pid = strtoul(argv[2], NULL, *argv[2] && *(argv[2] + 1) == 'x' ? 16 : 10);

	dev = find_usbdev((int)vid, (int)pid);
	if(!dev)
		return 0;

	print_support_class(dev);
	/* printf("\n"); */

	return 0;
}
