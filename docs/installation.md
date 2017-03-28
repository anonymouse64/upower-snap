---
title: "Install UPower"
table_of_contents: False
---

# Install UPower

The UPower snap is currently available from the Ubuntu Store. It can be
installed on any system that supports snaps but is only recommended on [Ubuntu
Core](https://www.ubuntu.com/core) at the moment.

You can install the snap with the following command:

```
 $ snap install upower
 upower 0.99.4-3 from 'canonical' installed
```

Although the upower snap ins available from other channels (candidate, beta,
edge), only the stable version should be used for production devices. Their
menaing is internal to the development team of the upower snap.

All necessary plugs and slots will be automatically connected within the
installation process. You can verify this with:

```
 $ snap interfaces upower
 Slot               Plug
 :hardware-observe  upower
 upower:service     upower:client

```

Once the installation has successfully finished the UPower service is running
in the background. You can check uts current status with:

```
 $ systemctl status snap.upower.upowerd
 ● snap.upower.upowerd.service - Service for snap application upower.upowerd
    Loaded: loaded (/etc/systemd/system/snap.upower.upowerd.service; enabled; vendor preset: enabled)
    Active: active (running) since Mon 2017-03-27 20:10:07 UTC; 13min ago
  Main PID: 3094 (upowerd)
    CGroup: /system.slice/snap.upower.upowerd.service
            └─3094 /snap/upower/22/usr/libexec/upowerd
 
```

Now you have UPower successfully installed.
