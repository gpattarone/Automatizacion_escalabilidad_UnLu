#!/usr/bin/env python3
# transcribe.py
# Description: Transcribes a DNA sequence into RNA

from Bio.Seq import Seq
import sys

if len(sys.argv) < 2:
    print("Usage: python3 transcribe.py <DNA_sequence>")
    sys.exit(1)

seq = Seq(sys.argv[1])
print(seq.transcribe())
