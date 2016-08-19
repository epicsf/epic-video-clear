#!/bin/bash

# for safety: https://sipb.mit.edu/doc/safe-shell/
set -euf -o pipefail

read -p "Enter the disk letter to clear: " -n 1 -r

DISK_LETTER=$(echo "$REPLY" | tr '[:lower:]' '[:upper:]')

VOLUME_PATH="/Volumes/Video ${DISK_LETTER}"

read -p "This will permanently delete all files on ${VOLUME_PATH}. Are you sure? [yN] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  diskutil reformat ${VOLUME_PATH}
else
  echo "OK, doing nothing."
fi

echo
echo "Finished. Current space on Video ${VOLUME_PATH}:"

df -h ${VOLUME_PATH}
diskutil unmount ${VOLUME_PATH}
