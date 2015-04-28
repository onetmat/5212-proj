## Mathew Anderson CS5212 Sp 2015
# Weather Project

# Contains buckets for classifying various weather parameters
# Classifications taken from
# http://omahanebraskawx.com/wxbarodetail.php
# Except where noted

# Each value represents the max for that bucket, not inclusive.

# Pressure units are inHg (see meanpressurei)
press_buckets = [29.4, 29.5, 29.6, 29.7, 29.8, 29.9, 30, 30.1, 30.2, 30.3, \
   30.4, 30.5]

# Temperature units are degrees F (see meantempi)
temp_buckets = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110]

# Precipitation units are inches (see precipi)
precip_buckets = [0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2, 2.25, 2.5, \
   2.75, 3]

## Value classifier - given a value and a bucket,
# return the "classified" or "quantized" value that results.
def ClassifyValue(value, buckets):
   classIdx = 0
   for i in buckets:
      if value < i:
         return classIdx
      else:
         classIdx = classIdx + 1

   return classIdx

# Test pressure variant
if __name__ == "__main__":
   # Test pressure classifier
   print ("Bucket for 29.1: " + str(ClassifyValue(29.1, press_buckets)))
   print ("Bucket for 29.2: " + str(ClassifyValue(29.2, press_buckets)))
   print ("Bucket for 29.3: " + str(ClassifyValue(29.3, press_buckets)))
   print ("Bucket for 29.4: " + str(ClassifyValue(29.4, press_buckets)))
   print ("Bucket for 29.5: " + str(ClassifyValue(29.5, press_buckets)))
   print ("Bucket for 29.6: " + str(ClassifyValue(29.6, press_buckets)))
   print ("Bucket for 29.7: " + str(ClassifyValue(29.7, press_buckets)))
   print ("Bucket for 29.8: " + str(ClassifyValue(29.8, press_buckets)))
   print ("Bucket for 29.9: " + str(ClassifyValue(29.9, press_buckets)))
   print ("Bucket for 30.0: " + str(ClassifyValue(30.0, press_buckets)))
   print ("Bucket for 30.1: " + str(ClassifyValue(30.1, press_buckets)))
   print ("Bucket for 30.2: " + str(ClassifyValue(30.2, press_buckets)))
   print ("Bucket for 30.3: " + str(ClassifyValue(30.3, press_buckets)))
   print ("Bucket for 30.4: " + str(ClassifyValue(30.4, press_buckets)))
   print ("Bucket for 30.5: " + str(ClassifyValue(30.5, press_buckets)))
   print ("Bucket for 30.6: " + str(ClassifyValue(30.6, press_buckets)))
   print ("Bucket for 30.7: " + str(ClassifyValue(30.7, press_buckets)))
   print ("Bucket for 30.8: " + str(ClassifyValue(30.8, press_buckets)))
   print ("Bucket for 30.9: " + str(ClassifyValue(30.9, press_buckets)))
