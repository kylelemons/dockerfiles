#!/bin/bash

fail() {
  echo "Usage: $0 disk_name disk_size master_vm"
  echo "  disk_name: name of PD to create (e.g. git-server-data)"
  echo "  disk_size: size including unit (e.g. 500GB)"
  echo "  master_vm: name of the master VM (to use to format the disk)"
  echo "$@" >&2
  exit 1
}

# This assumes you have used `gcloud config set compute/zone <zone>`

DISK_NAME="$1"; shift
[[ -z "$DISK_NAME" ]] && fail "disk_name not specified"

DISK_SIZE="$1"; shift
[[ -z "$DISK_SIZE" ]] && fail "disk_size not specified"

MASTER_VM="$1"; shift
[[ -z "$MASTER_VM" ]] && fail "master_vm not specified"

TEMP_NAME="temp-pd-$RANDOM"

set -e

echo "Creating disk $DISK_NAME..."
gcloud compute disks create --size="$DISK_SIZE" "$DISK_NAME"

echo "Attaching disk $DISK_NAME to $MASTER_VM (as $TEMP_NAME)..."
gcloud compute instances attach-disk --disk="$DISK_NAME" --device-name="$TEMP_NAME" "$MASTER_VM"

echo "Formatting disk $DISK_NAME..."
gcloud compute ssh "$MASTER_VM" --command="sudo mkdir -p /mnt/tmp/$TEMP_NAME && sudo /usr/share/google/safe_format_and_mount /dev/disk/by-id/google-$TEMP_NAME /mnt/tmp/$TEMP_NAME"

echo "Detaching disk $DISK_NAME from $MASTER_VM..."
gcloud compute instances detach-disk --disk="$DISK_NAME" "$MASTER_VM"
