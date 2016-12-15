#!/bin/sh
wait_for_systemd_service() {
	while ! systemctl status $1 ; do
		sleep 1
	done
	sleep 1
}

wait_for_upower() {
	wait_for_systemd_service snap.upower.upowerd
}
