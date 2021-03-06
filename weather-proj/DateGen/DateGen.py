#! /usr/bin/python

# A small script to generate all of the days between
# 1 January, 1970 and 1 January 2000 (not inclusive
# of 1 Jan. 2000).
from datetime import date, timedelta as td

d1 = date(2004, 1, 1)
d2 = date(2015, 1, 1)

delta = d2-d1

# Dates are printed YYYY-MM-DD format
# Which is almost perfect for WUnderground API
for i in range(delta.days):
   print (d1 + td(days=i))
