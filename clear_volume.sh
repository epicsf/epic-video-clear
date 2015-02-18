#!/bin/bash

# for safety: https://sipb.mit.edu/doc/safe-shell/
set -euf -o pipefail

VOLUME_PATH="/Volumes/${VOLUME_NAME}"

read -p "This will permanently delete all files on ${VOLUME_PATH}. Are you sure? [yN] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  diskutil reformat ${VOLUME_PATH}
else
  echo "OK, doing nothing."
fi

echo
echo "Finished. Current space on Video A:"

df -h ${VOLUME_PATH}
diskutil unmount ${VOLUME_PATH}
