#! /bin/bash

# Creates a histogram of state count from the file "random_data.json".
# This example is meant to illustrate the combination of an HDFS-read
# and local compute.

hadoop fs -cat  ibd2015/random_data.json | \
grep -oiE '"state": "([a-zA-Z]*)"' | \
sort | \
uniq -c | \
sort -k1nr
