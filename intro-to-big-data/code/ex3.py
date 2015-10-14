"""
Updates the JSON in HDFS by appending the day of the week (DOW) to the "dow"
key and writes the updated JSON back to HDFS. This script is meant to illustrate 
a combination of HDFS read + local compute + HDFS write. To use it type the
following on a bash prompt:

$ hadoop fs -cat ibd2015/random_data.json | \
  python ex3.py | \
  hadoop fs -put - ibd2015/output2.txt
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
