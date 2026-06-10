#!/usr/bin/env -S uv run --script
"""
Compute the total size of files using one or more glob patterns.
"""
import sys
import glob
import os

if len(sys.argv) < 1:
    print("Usage: filesize <glob-pattern>...")
    sys.exit(1)

is_verbose = "-v" in sys.argv or "--verbose" in sys.argv
glob_args = [x for x in sys.argv[1:] if not x.startswith("-")]

def human_readable_size(size_bytes):
    for unit in ['B','KiB','MiB','GiB','TiB','PiB']:
        if size_bytes < 1024:
            break
        size_bytes /= 1024
    else:
        unit = 'EiB'
    return f"{size_bytes:,.1f} {unit}"

total = 0
for pattern in glob_args:
    for f in glob.glob(pattern, recursive=True):
        if not os.path.isfile(f):
            continue
        total += os.path.getsize(f)
        if is_verbose:
            print(f)

if is_verbose:
    print("=======")

print(human_readable_size(total))
