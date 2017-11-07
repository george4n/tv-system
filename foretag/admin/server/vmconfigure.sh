#!/bin/bash




vboxmanage modifyvm winuc093 --memory 1536
--chipset ich9|piix3]
--mouse ps2|usb|usbtablet|usbmultitouch]
[--keyboard ps2|usb
[--audio none|null|oss|alsa|pulse]
                            [--audiocontroller ac97|hda|sb16]
                            [--audiocodec stac9700|ad1980|stac9221|sb16]
                            [--usb on|off]
