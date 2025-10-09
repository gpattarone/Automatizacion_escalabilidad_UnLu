#!/usr/bin/env python3
# translate.py
# Description: Translates a DNA sequence into a protein sequence

from Bio.Seq import Seq
import sys

if len(sys.argv) < 2:
    print("Usage: python3 translate.py <DNA_sequence>")
    sys.exit(1)

seq = Seq(sys.argv[1])
print(seq.translate())
