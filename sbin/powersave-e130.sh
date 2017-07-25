#!/bin/sh

echo 'If you want to enable eth0,'
echo 'please check /etc/rc.local.'
echo 'If you want to modify wireless power management,'
echo 'please check /etc/modprobe.d/rtl8192ce.conf.'

# iw dev wlan0 set power_save on # instead of this, /etc/udev/rules.d/71-wifi-powersave.rules works
echo '1500' > '/proc/sys/vm/dirty_writeback_centisecs';
echo 'min_power' > '/sys/class/scsi_host/host2/link_power_management_policy';
echo 'min_power' > '/sys/class/scsi_host/host0/link_power_management_policy';
echo '1' > '/sys/module/snd_hda_intel/parameters/power_save';
echo 'min_power' > '/sys/class/scsi_host/host1/link_power_management_policy';
echo 'min_power' > '/sys/class/scsi_host/host3/link_power_management_policy';
echo 'min_power' > '/sys/class/scsi_host/host4/link_power_management_policy';
echo 'min_power' > '/sys/class/scsi_host/host5/link_power_management_policy';
echo '0' > '/proc/sys/kernel/nmi_watchdog';
echo 'auto' > '/sys/bus/pci/devices/0000:00:1c.5/power/control';
echo 'auto' > '/sys/bus/pci/devices/0000:00:00.0/power/control';
echo 'auto' > '/sys/bus/pci/devices/0000:00:02.0/power/control';
echo 'auto' > '/sys/bus/pci/devices/0000:00:14.0/power/control';
echo 'auto' > '/sys/bus/pci/devices/0000:00:1c.1/power/control';
echo 'auto' > '/sys/bus/pci/devices/0000:00:16.0/power/control';
echo 'auto' > '/sys/bus/pci/devices/0000:00:1a.0/power/control';
echo 'auto' > '/sys/bus/pci/devices/0000:00:1b.0/power/control';
echo 'auto' > '/sys/bus/pci/devices/0000:00:1c.2/power/control';
echo 'auto' > '/sys/bus/pci/devices/0000:00:1f.0/power/control';
echo 'auto' > '/sys/bus/pci/devices/0000:00:1f.2/power/control';
echo 'auto' > '/sys/bus/pci/devices/0000:00:1f.3/power/control';
echo 'auto' > '/sys/bus/pci/devices/0000:03:00.0/power/control';
echo 'auto' > '/sys/bus/pci/devices/0000:04:00.0/power/control';
echo 'auto' > '/sys/bus/pci/devices/0000:09:00.0/power/control';
echo 'auto' > '/sys/bus/pci/devices/0000:00:1c.0/power/control';
echo 'auto' > '/sys/bus/pci/devices/0000:00:1d.0/power/control';
