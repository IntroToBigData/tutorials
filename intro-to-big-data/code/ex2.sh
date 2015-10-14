#! /bin/bash

# This script greps the "message" key and its value and performs a streaming put
# to HDFS, without a disk copy at any stage. This script is meant to illustrate
# a combination of HDFS READ/WRITE and a local compute (grep)
hadoop fs -cat ibd2015/random_data.json | \
grep -oiE '"message": "([a-zA-Z]*)"'| \
hadoop fs -put - ibd2015/output.txt
