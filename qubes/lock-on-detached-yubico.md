# Lock on detached yubico

Create a policy file in dom0 for the new qubes-exec command:

```
$ cat > /etc/qubes-rpc/policy/custom.LockScreen <<EOF
sys-usb dom0 allow
EOF
$
```

Create a the rpc script in dom0:

```
$ cat > /etc/qubes-rpc/custom.LockScreen <<EOF
#!/bin/sh
sleep 5 # important, let the key get ejected properly
DISPLAY=:0 i3lock --color 000000
EOF
$ chmod +x /etc/qubes-rpc/custom.LockScreen
```
The sleep 5 is there to wait for the yubico to be detached properly.
Without it, the lock will happen instantly.
It will render the yubico key unusable in the i3lock state when you plug it back in.
(This is annoying)

Important, see below:

Create the trigger script in sys-usb (or the dvm for the sys-usb):

```
$ cat > /rw/config/yubico-detach.sh <<EOF
#!/bin/sh
set -eu

lockfile=/tmp/yubico/locked
mkdir -p /tmp/yubico
[ -f $lockfile ] && exit 0

# check in sys-usb
if [ $(lsusb | grep -i yubico|wc -l) -gt 0 ] ; then
  lg "yubico still attached"
  exit 0
fi
touch $lockfile
/usr/bin/qrexec-client-vm dom0 custom.LockScreen & # the & at the end is important!
echo "done"
EOF
$ chmod +x /rw/config/yubico-detach.sh
```

the `&` at the end of the /usr/bin/qrexec-client-vm call is super important, without, it will stall until the script in dom0 is done, before properly letting go of the yubico device.

the lockfile is there to prevent multiple calls, since the rule will trigger the script multiple times for some reason.

Lets create an unlocker when the key is attached:

Create the trigger script in sys-usb (or the dvm for the sys-usb):


```
$ cat > /rw/config/yubico-attatch.sh <<EOF
!/bin/sh
set -eu
lockfile=/tmp/yubico/locked
mkdir -p /tmp/yubico
if [ -f $lockfile ]; then
  rm $lockfile
fi
echo "done"
EOF
```

To trigger the script(s) in sys-usb (or the dvm for the sys-usb):

```
$ cat > /rw/config/yubico.rules <<EOF
ACTION=="remove", SUBSYSTEM=="usb", ENV{PRODUCT}=="1050/*/*", RUN+="/rw/config/yubico-detach.sh"
ACTION=="add", SUBSYSTEM=="usb", ENV{PRODUCT}=="1050/*/*", RUN+="/rw/config/yubico-attach.sh"
EOF
```

Your key MIGHT have another PRODUCT number, to figure this out, put the key in, and in sys-usb:

```
$ lsusb |grep -i yubico
$ # or, to the env variables through udevadm monitor:
$ udevadm monitor --subsystem-match=usb --property

```

You could probably use `ENV{ID_VENDOR_FROM_DATABASE}=="Yubico.com"` as well..

