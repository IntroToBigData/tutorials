#!/usr/bin/python
import sys
import datetime

for line in sys.stdin:
    time_units = map(int, line.strip().split("\t"))
    dt = datetime.datetime(*time_units)
    print int(dt.strftime("%s"))

