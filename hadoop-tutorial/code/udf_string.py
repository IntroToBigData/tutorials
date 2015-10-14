#!/usr/bin/python
import sys

def add_dashes(word):
    return "-".join(c for c in word)

for line in sys.stdin:
    name, city = map(str, line.strip().split("\t"))
    # print "%s, %s" %(name, city)
    print "%s:%s" %(add_dashes(name), city.capitalize())
    
