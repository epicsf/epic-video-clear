#!/bin/bash

# for safety: https://sipb.mit.edu/doc/safe-shell/
set -uf -o pipefail

read -p "Enter the disk letter to clear: " -n 1 -r
echo

DISK_LETTER=$(echo "$REPLY" | tr '[:lower:]' '[:upper:]')
VOLUME_PATH="/Volumes/Video ${DISK_LETTER}"

read -p "This will permanently delete all files on \"${VOLUME_PATH}\". Proceed? [yN] " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "OK, doing nothing."
  exit
fi

diskutil reformat "$VOLUME_PATH"

EXIT_CODE=$?
if [[ $EXIT_CODE != 0 ]]; then
  echo "====== WARNING: Disk not cleared ======"
  exit $EXIT_CODE
fi

echo
echo "Finished. Current space on Video ${DISK_LETTER}:"

df -h "$VOLUME_PATH"
diskutil unmount "$VOLUME_PATH"

EXIT_CODE=$?
if [[ $EXIT_CODE != 0 ]]; then
  echo "====== WARNING: Disk not ejected ======"
  exit $EXIT_CODE
fi
