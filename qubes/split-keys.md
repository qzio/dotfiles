# Split-GPG


Keeps private key(s) in separate appVM without network etc.


1. Create a separate appVM (keys) based on debian-minimal-secure (./qubes-packages.sh with template `vault`).
2. Generate keypair in the keys appVM (ssh/gpg/etc)
3. In the appVM where you want to use ie gpg: `qubes-gpg-client-wrapper`

To allow a "user"-appVM, you'll need to add policy rules to dom0:

in /etc/qubes/policy.d/30-user.policy you need something like this for split-ssh:

```
qubes.SshAgent * user-appvm-name keys-appvm-name ask target=keys-appvm-name
```

Qubes has a graphical configuration thing for split-gpg: `Qubes Global Config` which writes to `/etc/qubes/policy.d/50-config-splitgpg.policy` ie

```
qubes.Gpg * user-appvm-name keys-appvm-name ask
qubes.Gpg * @anyvm          keys-appvm-name deny
```


split-ssh works similar, but is not as prepared as splig-gpg.

You don't need to run anything special in your keys app vm.
however, where you want to use it!:

```
$ cat > use-split-ssh <<EOF
#!/bin/sh
set -eu

export SSH_VAULT_VM=ssh-dev
export SSH_SOCK="/home/user/.ssh/run/SSH_AUTH_SOCK.${SSH_VAULT_VM}.sock"
set -x
[ -f "$SSH_SOCK" ] && rm $SSH_SOCK
sudo -u user /bin/sh -c "umask 177 && exec socat 'UNIX-LISTEN:$SSH_SOCK,fork' 'EXEC:qrexec-client-vm $SSH_VAULT_VM qubes.SshAgent'"
EOF
```

chmod +x that file!

and the `qubes.SshAgent * dev ssh-dev ask target` will enable hits.

In the template for your keys-appvm:
```
$ cat > /etc/qubes-rpc/qubes.SshAgent <<EOF
#!/bin/sh
# Qubes App Split SSH Script

# safeguard - Qubes notification bubble for each ssh request
notify-send "[$(qubesdb-read /name)] SSH agent access from: $QREXEC_REMOTE_DOMAIN"

# SSH connection
socat - "UNIX-CONNECT:$SSH_AUTH_SOCK"

EOF
```


chmod +x that file!


Now you can run `sh use-split-ssh` in your user-appvm!
