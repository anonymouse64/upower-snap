---
title: "Release Notes"
table_of_contents: False
---

# Release Notes

The version numbers mentioned on this page correspond to those released in the
Ubuntu Snap Store.

You can check with the following command which version you have currently
installed:

```
 $ snap info upower
 name:      upower
 summary:   "UPower Power Source Monitoring daemon"
 publisher: canonical
 description: |
   UPower is an abstraction for enumerating power devices, listening to
   device events and querying history and statistics. Any application
   or service on the system can access the org.freedesktop.UPower
   service via the system message bus.

   Please find the source code at
   https://code.launchpad.net/~snappy-hwe-team/snappy-hwe-snaps/+git/upower

 commands:
   - upower
 tracking:    stable
 installed:   0.99.4-3 (22) 9MB -
 refreshed:   2017-02-08 15:17:41 +0000 UTC
 channels:                  
   stable:    0.99.4-3 (22) 9MB -
   candidate: 0.99.4-3 (22) 9MB -
   beta:      0.99.4-3 (22) 9MB -
   edge:      0.99.4-3 (33) 9MB -
```

## 0.99.4-3

 * Initial snap packaging for UPower 0.99.4
