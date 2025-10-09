#!/usr/bin/env python3
# complement.py
# Description: Generates the DNA complement sequence from input string

from Bio.Seq import Seq
import sys

if len(sys.argv) < 2:
    print("Usage: python3 complement.py <DNA_sequence>")
    sys.exit(1)

seq = Seq(sys.argv[1])
print(seq.complement())
