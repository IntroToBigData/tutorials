#! /usr/bin/python

"""
Mapper script for Hadoop MapReduce example. For standalone invokation, the
script needs to have a shebang "#!" as the first line. The script itself updates
the input JSON by appending a date of the week to the input JSON. This is the
same task that was performed in ex3.py, but this time we use the cluster for the
computation instead of our local machine.

The invokation is via launching MapReduce job by runnning
$ ./mrdriver_ex4.sh
"""

from datetime import datetime
import json
import sys

FMT = "%Y-%m-%d %H:%M:%S"

for line in sys.stdin:
    obj = json.loads(line)
    dt_str = obj["source_timestamp"]
    dt_obj = datetime.strptime(dt_str, FMT)
    dt_dow = dt_obj.strftime("%A")
    obj.update({"dow": dt_dow})
    print json.dumps(obj)
