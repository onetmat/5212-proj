#! /bin/bash
# Construct a WU API query for a particular day.
# Two inputs required:
# 1) State
# 2) date file

file="$1/city_list"
datefile=$2
exec 4<$file

# Clear out query directory to make new queries
rm -rvf $1/queries
mkdir -v $1/queries

# Clear out data directory
rm -rvf $1/data
mkdir -v $1/data

while read -u4 city ; do
   exec 5<$datefile
   rm -rvf $1/queries/$city

   rm -rvf $1/data/$city
   mkdir $1/data/$city
   while read -u5 date ; do
      querystr="history_$date/q/$1/$city.json"
      echo history_$date/q/$1/$city.json >> $1/queries/$city
      curl http://api.wunderground.com/api/5b0d8023c31797a8/$querystr > $1/data/$city/$date.json
   done
done
