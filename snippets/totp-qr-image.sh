#!/usr/bin/env bash

set -eu

usage()
{
  echo "$0 label email secret"
  exit 1
}

[ $# -lt 3 ] && usage
label="$1"
shift
email="$1"
shift
secret="$1"

outfile="/tmp/${label}.png"
url="otpauth://totp/$label:$email?secret=$secret&issuer=custom"

qrencode -o "$outfile" "$url"
$(sleep 3 ; rm "$outfile") &
feh "$outfile"
