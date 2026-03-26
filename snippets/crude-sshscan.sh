#!/bin/sh

cnetwork=192.168.1
check_ip()
{
  nr=$1
  ipnr="$cnetwork.$nr"
  exitcode=$(ping -c 1 -W 3 $ipnr > /dev/null 2>&1; echo $?)
  if [ $exitcode -eq 0 ]; then
    nc -z -w 1 $ipnr 22 || echo "Connection to $ipnr port 22 [tcp/ssh] failed"
  fi
}

echo "start checking"
for nr in $(seq 1 254); do
  check_ip $nr &
done
wait

echo "done checking"

