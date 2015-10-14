#! /usr/bin/python
"""
Mapper script for Hadoop MapReduce example. For standalone invokation, the
script needs to have a shebang "#!" as the first line. The script itself
extracts values of "userid", "state", and "message" keys from the input JSON and
outputs a control-A delimited fields.

The invokation is via launching MapReduce job by runnning
$ ./mrdriver_ex5.sh
"""

import sys
import json

keys = ["userid", "state", "message"]
delim = '\x01'

for line in sys.stdin:
    obj = json.loads(line)
    
    try:
        row = [obj[k] for k in keys]
        print delim.join(row)
    except Exception:
        pass


