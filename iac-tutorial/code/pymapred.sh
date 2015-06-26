#!/bin/bash
HADOOP_STREAMING_JAR_PATH="/opt/cloudera/parcels/CDH/lib/hadoop-0.20-mapreduce/contrib/streaming"
PROJECT_HOME="/home/rkekatpure-admin/tutorials/hadooptut"
HDFS_INPUT_PATH="/user/rkekatpure-admin/streaming"
HDFS_OUTPUT_PATH="/user/rkekatpure-admin/streaming/output"

hadoop fs -rm -r "$HDFS_OUTPUT_PATH"

hadoop jar "$HADOOP_STREAMING_JAR_PATH/hadoop-streaming.jar" \
-Dmapreduce.job.queuename=exp_dsa \
-file "$PROJECT_HOME/hdstreaming_mapper.py" \
-file "$PROJECT_HOME/hdstreaming_reducer.py" \
-mapper hdstreaming_mapper.py \
-reducer hdstreaming_reducer.py \
-input "$HDFS_INPUT_PATH/*" \
-output "$HDFS_OUTPUT_PATH" 

