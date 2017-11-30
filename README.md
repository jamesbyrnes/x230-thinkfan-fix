# Thinkfan Fix for X230
Fixes "changing hwmon" issue after system reboot

## Summary
This is one of those "quick and dirty" fixes for a known but unfixed issue related to the hwmon subdirs in (for the ThinkPad X230) /sys/devices/platform/coretemp.0.

Various discussions of this issue can be seen by googling "hwmon not persistent" or something similar. This is not specific to any particular distro or even thinkfan, but rather anything that refers to temperature input under the hwmon directories in /sys/devices.

To summarize the discussions, basically, the subdirectories under that folder, which contain the temperature input files for thinkfan (so pretty important) will change between hwmon0, hwmon1, hwmon2, etc. between each reboot. This will cause pre-v1.0 thinkfan (in our case) to fail on boot for some ThinkPad models (like the X230) because it relies on knowing which directory the temperature input files reside in.

*Please note:* After v1.0 of thinkfan this issue can be circumvented by using YAML configs, so if you're looking for a clean solution, I highly recommend that. See closed thinkfan issue [here](https://github.com/vmatare/thinkfan/issues/17).

For the rest of us, however... ;)

## Installation
Check out the code before installing (pretty normal bash stuff) and make sure to run as root or some other authorized account since we're modifying systemd and config files in /etc.
