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

def human_readable_size(size_bytes):
    for unit in ['B','KiB','MiB','GiB','TiB','PiB']:
        if size_bytes < 1024:
            break
        size_bytes /= 1024
    else:
        unit = 'EiB'
    return f"{size_bytes:,.1f} {unit}"

total = sum(
    os.path.getsize(f)
    for pattern in sys.argv[1:]
    for f in glob.glob(pattern, recursive=True)
    if os.path.isfile(f)
)

print(human_readable_size(total))
