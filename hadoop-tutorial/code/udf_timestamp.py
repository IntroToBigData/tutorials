#!/usr/bin/python
import sys
import datetime

for line in sys.stdin:
    time_units = map(int, line.strip().split("\t"))
    dt = datetime.datetime(*time_units)
    print int(dt.strftime("%s"))
    #all_time = "%s:%s:%s:%s" %(time_units[0], time_units[1], time_units[2], time_units[3])
    #print all_time

