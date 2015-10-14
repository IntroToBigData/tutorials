"""
The present script performs state histogram computation by streaming line-orinted data
from HDFS. This is a combination of HDFS read and local compute. This script is ex0.sh 
translated to Python. To use typ the following on a bash prompt:

$ hadoop fs -cat ibd2015/random_data.json | python ex1.py

"""

import sys
import json
from collections import defaultdict

counter = defaultdict(int)

# Count the number of states in a dictionary (hashmap)
for line in sys.stdin:
	obj = json.loads(line)
	counter[obj["state"]] += 1

print counter		
