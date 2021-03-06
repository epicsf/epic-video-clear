#!/bin/bash

# for safety: https://sipb.mit.edu/doc/safe-shell/
set -uf -o pipefail

while true; do

  echo
  echo "================================================================================"
  echo

  read -p "Enter the disk letter to clear: " -n 1 -r
  echo

  DISK_LETTER=$(echo "$REPLY" | tr '[:lower:]' '[:upper:]')
  VOLUME_PATH="/Volumes/Video ${DISK_LETTER}"

  read -p "This will permanently delete all files on \"${VOLUME_PATH}\". Proceed? [yN] " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "OK, doing nothing."
    continue
  fi

  diskutil reformat "$VOLUME_PATH"

  EXIT_CODE=$?
  if [[ $EXIT_CODE != 0 ]]; then
    echo "================================================================================"
    echo "================================================================================"
    echo "======                                                                    ======"
    echo "======                    WARNING: Disk not cleared                       ======"
    echo "======                                                                    ======"
    echo "================================================================================"
    echo "================================================================================"
    continue
  fi

  touch "${VOLUME_PATH}/FILE NAMING CONVENTION"
  touch "${VOLUME_PATH}/No need to rename backup recording files"
  touch "${VOLUME_PATH}/YYYY-MM-DD HHHH N"

  echo
  echo "Finished. Current space on Video ${DISK_LETTER}:"

  df -h "$VOLUME_PATH"
  diskutil unmount "$VOLUME_PATH"

  EXIT_CODE=$?
  if [[ $EXIT_CODE != 0 ]]; then
    echo "====== WARNING: Disk not ejected ======"
    continue
  fi

done
