#!/usr/bin/env bash

[ $(ls /tmp | grep ^ssh -c) -lt 1 ] && echo "no ssh in /tmp, ssh-agent not running?" && exit 1
cd /tmp/$(ls /tmp/ | grep ^ssh | head -n1)
pid=$(ls | cut -d '.' -f2)
socket=$(pwd)/$(ls)
echo "export SSH_AUTH_SOCK=$socket"
echo "export SSH_AGENT_PID=$pid"
