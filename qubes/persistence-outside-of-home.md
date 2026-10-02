```
$ cat /rw/config/qubes-bind-dirs.d/50_user.conf <<EOF
binds+=( /var/lib/docker )
EOF
$ sudo mkdir -p /rw/bind-dirs/var/lib/docker
```
