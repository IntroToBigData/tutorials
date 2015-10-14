#!/usr/bin/python -O

import sys
import string
sys.path.append(".")

def standardize(word):
    translations = string.maketrans("", "")
    deletions = string.punctuation + string.whitespace
    return word.translate(translations, deletions).lower()

for line in sys.stdin:
    words = line.strip().split()
    for word in words:
        print "%s\t%d" %(standardize(word), 1)

