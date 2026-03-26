#!/bin/sh

# Ensure password authentication is disabled.
if [ $(grep -c '^PasswordAuthentication no' /etc/ssh/sshd_config) -gt 0 ] ; then
	echo "password authentiction is already no"
  exit 0
fi

# Disable password authentication.
sed -i 's/^.*PasswordAuthentication yes/PasswordAuthentication no #/' /etc/ssh/sshd_config
if [ $(grep -c '^PasswordAuthentication no' /etc/ssh/sshd_config) -lt 1 ] ; then
  echo "" >> /etc/ssh/sshd_config
  echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
fi
if [ $(grep -c '^PasswordAuthentication no' /etc/ssh/sshd_config) -lt 1 ] ; then
  echo "Failed to configure PasswordAuthentication no in /etc/ssh/sshd_config"
  exit 1
fi
echo "password authentication disabled in /etc/sh/sshd_config"

if [ $(command -v systemctl | wc -l) -gt 0 ] ; then
  (set -x; systemctl restart sshd)
elif [ $(command -v service | wc -l) -gt 0 ] ; then
  (set -x; service sshd restart)
elif [ -f /etc/init.d/sshd ] ; then
  (set -x ; /etc/init.d/sshd restart)
else
  echo "unable to restart sshd, no systemctl, no service cmd and no /etc/init.d/sshd"
  exit 1
fi
echo "sshd password login disabled, sshd restarted"
