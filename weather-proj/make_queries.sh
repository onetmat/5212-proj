#! /bin/bash
# Construct a WU API query for a particular day.
# Two inputs required:
# 1) State
# 2) date file

file="$1/city_list"
datefile=$2
exec 4<$file

while read -u4 city ; do
   exec 5<$datefile
   while read -u5 date ; do
      echo history_$date/q/$1/$city.json
   done
done
