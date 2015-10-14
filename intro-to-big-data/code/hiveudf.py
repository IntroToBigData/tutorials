#!/usr/bin/python

"""
Generates a SHA224 hash of the input userid and outputs a row with original keys
and the hash as the last field. Invokation is through a hive script:

$ hive -f hiveudf_driver.sql
"""

import sys
import hashlib

def gethash(s):
    """
    Returns SHA224 hash of input string s
    """
    hasher = hashlib.sha224()
    hasher.update(s)
    return hasher.hexdigest()


DELIM = "\t"
for line in sys.stdin:
    sline = line.strip()
    userid, state, message = sline.split(DELIM)
    print DELIM.join([userid, state, message, gethash(userid)])




