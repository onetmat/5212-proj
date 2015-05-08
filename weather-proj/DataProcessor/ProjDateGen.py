#! /usr/bin/python

# A small script to generate all of the days between
# 1 January, 2004 and 1 January 2015 (not inclusive
# of 1 Jan. 2015).
from datetime import date, timedelta as td

d1 = date(2004, 1, 1)
d2 = date(2015, 1, 1)

delta = d2-d1

# baseDir must be an absolute reference to wherever the WU API raw data
# gets stored. I hesitated to keep the name of the dir 'data' because
# an improper subsequent invocation of make_queries would clobber everything
baseDir = '/home/msa/projects/cs5212/weather-proj/IA/proc_data/'

cities = ['Ames', 'Atlantic', 'Des_Moines', 'Dubuque', 'Estherville', \
   'Lamon', 'Mason_City', 'Ottumwa', 'Sioux_City', 'Waterloo']

# foreach day
for i in range(delta.days):
   newDay = d1+td(days=i)
   # only consider 28 days in a month for ease of use
   if newDay.day < 29:
      # foreach city
      for city in cities:
         # dump out an invocation of the data classification script
         yearMonth = str(newDay.year) + str(newDay.month)
         print("python ClassifyDay.py " + baseDir + city + '/' + \
            str(newDay) + ".json >> " + yearMonth)
