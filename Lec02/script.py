#!/usr/local/bin/env python
import sys

print(f"Running the script {sys.argv[0]}")
for arg in reversed(sys.argv[1:]):
    print(arg)
