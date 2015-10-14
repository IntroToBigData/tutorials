#!/bin/bash

# Driver for Python MapReduce job with ex4.py as the mapper. Invokation:
# $ bash mrdriver_ex4.sh

HADOOP_STREAMING_JAR_PATH="/opt/cloudera/parcels/CDH/lib/hadoop-0.20-mapreduce/contrib/streaming"
PROJECT_HOME="/home/rkekatpure-admin/sandbox/tutorials"
HDFS_INPUT_PATH="/user/rkekatpure-admin/ibd2015/random_data.json"
HDFS_OUTPUT_PATH="/user/rkekatpure-admin/ibd2015/mroutput_ex4"

hadoop fs -rm -r "$HDFS_OUTPUT_PATH"

hadoop jar "$HADOOP_STREAMING_JAR_PATH/hadoop-streaming.jar" \
-Dmapreduce.job.queuename=exp_dsa \
-file "$PROJECT_HOME/ex4.py" \
-mapper ex4.py \
-input "$HDFS_INPUT_PATH" \
-output "$HDFS_OUTPUT_PATH"
