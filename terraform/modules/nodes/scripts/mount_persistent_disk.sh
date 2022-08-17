#!/bin/bash
set -uxo pipefail

# DISK_NAME = Name of the disk in terraform
# DEVICE_NAME = When $DISK_NAME is mounted in the compute instance at `/dev/` 

MOUNT_DIR=/mnt/disks/persistent_storage

# Check if entry exists in fstab
grep -q "$MOUNT_DIR" /etc/fstab
if [[ $? -eq 0 ]]; then # Entry exists
	exit
else
	set -e # The grep above returns non-zero for no matches & we don't want to exit then.

	# Find persistent disk's drive value, prefixed by `google-` # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance#device_name
	DEVICE_NAME="/dev/$(basename $(readlink /dev/disk/by-id/google-${DISK_NAME}))"

	sudo mkfs.ext4 -m 0 -F -E lazy_itable_init=0,lazy_journal_init=0,discard $DEVICE_NAME
	sudo mkdir -p $MOUNT_DIR
	sudo mount -o discard,defaults $DEVICE_NAME $MOUNT_DIR

	# Add fstab entry
	echo UUID=$(sudo blkid -s UUID -o value $DEVICE_NAME) $MOUNT_DIR ext4 discard,defaults,nofail 0 2 | sudo tee -a /etc/fstab
fi
