#!/usr/bin/env bash

cd /tmp/$(ls /tmp/ | grep ^ssh | head -n1)
pid=$(ls | cut -d '.' -f2)
socket=$(pwd)/$(ls)
echo "SSH_AUTH_SOCK=$socket"
echo "SSH_AGENT_PID=$pid"
