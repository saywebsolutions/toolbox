#!/bin/sh

# Show date and time in other time zones
# https://stackoverflow.com/a/59751090

search=$1

zoneinfo=/usr/share/zoneinfo/posix/
format='%a %F %T'

find -L $zoneinfo -type f \
    | grep -i "$search" \
    | while read z
      do
          d=$(TZ=$z date +"$format")
          printf "%-34s %23s\n" ${z#$zoneinfo} "$d"
      done
