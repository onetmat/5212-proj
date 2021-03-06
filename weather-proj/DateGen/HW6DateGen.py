#! /usr/bin/python

# A small script to generate all of the days between
# 1 January, 1970 and 1 January 2000 (not inclusive
# of 1 Jan. 2000).
from datetime import date, timedelta as td

d1 = date(1985, 4, 1)
d2 = date(2000, 1, 1)

delta = d2-d1

baseDir = '/home/msa/projects/cs5212/weather-proj/IA/data/'

cities = ['Algona', 'Ames', 'Atlantic', 'Audubon', 'Boone']

# Dates are printed YYYY-MM-DD format
# Which is almost perfect for WUnderground API
for i in range(delta.days):
   newDay = d1+td(days=i)
   if newDay.day < 29:
      for city in cities:
         yearMonth = str(newDay.year) + str(newDay.month)
         print("python ClassifyDay.py " + baseDir + city + '/' + \
            str(newDay) + ".json >> " + yearMonth)
