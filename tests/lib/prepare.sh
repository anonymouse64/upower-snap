#!/bin/bash

echo "Wait for firstboot change to be ready"
while ! snap changes | grep -q "Done"; do
	snap changes || true
	snap change 1 || true
	sleep 1
done

echo "Ensure fundamental snaps are still present"
. $TESTSLIB/snap-names.sh
for name in $gadget_name $kernel_name $core_name; do
	if ! snap list | grep -q $name ; then
		echo "Not all fundamental snaps are available, all-snap image not valid"
		echo "Currently installed snaps:"
		snap list
		exit 1
	fi
done

echo "Kernel has a store revision"
snap list | grep ^${kernel_name} | grep -E " [0-9]+\s+canonical"

if [ -n "$SNAP_CHANNEL" ] ; then
	# Don't reinstall if we have it installed already
	if ! snap list | grep upower ; then
		snap install --$SNAP_CHANNEL upower
	fi
else
	# Need first install from store to get all necessary assertions into
	# place. Second local install will then bring in our locally built
	# snap.
	# FIXME: Enable again once we have the first version of the snap
	# available in the store.
	# snap install upower
	snap install --devmode --dangerous /home/upower/upower_*_amd64.snap

	# FIXME: As long as we don't have the upower-control interface
	# available we test the snap in devmode and therefore need to
	# copy the dbus policy file in place
	cp /snap/upower/current/etc/dbus-1/system.d/* /etc/dbus-1/system.d/
	systemctl restart snap.upower.upowerd
fi

# Snapshot of the current snapd state for a later restore
if [ ! -f $SPREAD_PATH/snapd-state.tar.gz ] ; then
	systemctl stop snapd.service snapd.socket
	tar czf $SPREAD_PATH/snapd-state.tar.gz /var/lib/snapd
	systemctl start snapd.socket
fi

# For debugging dump all snaps and connected slots/plugs
snap list
snap interfaces
