#!/bin/bash

# Driver for Python MapReduce job with ex5.py as the mapper. Invokation:
# $ bash mrdriver_ex5.sh

HADOOP_STREAMING_JAR_PATH="/opt/cloudera/parcels/CDH/lib/hadoop-0.20-mapreduce/contrib/streaming"
PROJECT_HOME="/home/rkekatpure-admin/sandbox/tutorials"
HDFS_INPUT_PATH="/user/rkekatpure-admin/ibd2015/random_data.json"
HDFS_OUTPUT_PATH="/user/rkekatpure-admin/ibd2015/mroutput_ex5"

hadoop fs -rm -r "$HDFS_OUTPUT_PATH"

hadoop jar "$HADOOP_STREAMING_JAR_PATH/hadoop-streaming.jar" \
-Dmapreduce.job.queuename=exp_dsa \
-file "$PROJECT_HOME/ex5.py" \
-mapper ex5.py \
-input "$HDFS_INPUT_PATH" \
-output "$HDFS_OUTPUT_PATH"
