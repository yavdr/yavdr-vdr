
#
# VDR shutdown hook for suspend to ram (S3), power down or reboot - Holger Reichelt, Volker Richert
# --------------------------
#
# This shutdown hook checks wether "S3" is available and in case
# emits an upstart event to suspend the PC instead of powering
# it off.

<?cs if:(!?system.shutdown || system.shutdown == "s3") ?> 
if grep -q "mem" /sys/power/state ; then
	echo "SHUTDOWNCMD=\"stop vdr ; /sbin/initctl --quiet emit --no-wait init-s3\""
fi
<?cs elif:(system.shutdown == "s4") ?>
if grep -q "disk" /sys/power/state ; then
    echo "SHUTDOWNCMD=\"stop vdr ; /sbin/initctl --quiet emit --no-wait init-s4\""
fi
<?cs elif:(system.shutdown == "s5") ?>
echo "SHUTDOWNCMD=\"stop vdr ; /sbin/halt -p\""
<?cs elif:(system.shutdown == "reboot") ?>
echo "SHUTDOWNCMD=\"stop vdr ; /usr/sbin/grub-reboot PowerOff ; /sbin/reboot\""
<?cs /if ?>
