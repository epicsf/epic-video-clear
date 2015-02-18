#!/bin/bash

# for safety: https://sipb.mit.edu/doc/safe-shell/
set -euf -o pipefail

read -p "This will permanently delete all files on Video A. Are you sure? [yN] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  diskutil reformat /Volumes/Video\ A
else
  echo "OK, doing nothing."
fi

echo
echo "Finished. Current space on Video A:"

df -h /Volumes/Video\ A/
diskutil unmount  /Volumes/Video\ A
