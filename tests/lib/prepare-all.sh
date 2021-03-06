#!/bin/bash

# We don't have to build a snap when we should use one from a
# channel
if [ -n "$SNAP_CHANNEL" ] ; then
	exit 0
fi

NEED_SNAP_BUILD=1

# If there is a upower snap prebuilt for us, lets take
# that one to speed things up.
if [ -e /home/upower/upower_*_amd64.snap ] ; then
	NEED_SNAP_BUILD=0
fi

# Setup classic snap and build the upower snap in there
snap install --devmode --beta classic
cat <<-EOF > /home/test/build.sh
#!/bin/sh
set -ex
apt update
apt install -y --force-yes snapcraft
cd /home/upower
if [ $NEED_SNAP_BUILD -eq 1 ]; then
	snapcraft clean
	snapcraft
	# If we have any hooks we need to copy them in place as long as
	# snapcraft does not support them
	if [ -d hooks ]; then
		cp -r hooks prime/meta
		snapcraft snap prime
	fi
fi
apt install -y --force-yes build-essential linux-headers-`uname -r`
cd /home/upower/tests/lib/battery
make
EOF
chmod +x /home/test/build.sh
sudo classic /home/test/build.sh
snap remove classic

# Make sure we have a snap build
test -e /home/upower/upower_*_amd64.snap
