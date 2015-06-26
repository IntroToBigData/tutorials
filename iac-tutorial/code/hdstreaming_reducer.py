#!/usr/bin/python -O

import sys
import string
sys.path.append(".")

current_word = ""
current_count = 0
for line in sys.stdin:
    try:
        word, count = line.strip().split("\t", 1)
        if word == current_word:
            current_count += 1
        else:   
            print "%s\t%s" % (current_word, current_count)
            current_count = 1
            current_word = word
    except ValueError:
        pass
        
