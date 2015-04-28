#!/usr/bin/python

import json
import sys

from ClassifyBuckets import *

# Script pulls out daily weather summary data,
# classifies it, and prints out the resulting
# classification to the console.

if __name__ == "__main__":
   print ("Attempting to process: " + str(sys.argv[1]))
   try:
      jsonFile = open(str(sys.argv[1]), 'r')
      jsonRep = json.load(jsonFile)
      summaryDict = jsonRep['history']['dailysummary'][0]
      try:
         meantempi = float(summaryDict['meantempi'])
      except:
         meantempi = 0

      try:
         meanpressi = float(summaryDict['meanpressurei'])
      except:
         meanpressi = 0

      try:
         precipi = float(summaryDict['precipi'])
      except:
         precipi = 0

      # Determine to which bucket each data item belongs
      temp_bucket = ClassifyValue(meantempi, temp_buckets)
      press_bucket = ClassifyValue(meanpressi, press_buckets)
      precip_bucket = ClassifyValue(precipi, precip_buckets)
      print (str(temp_bucket)+","+str(press_bucket)+","+str(precip_bucket))
   
   except Exception as e:
      print ("And it failed...")
      print (e)
