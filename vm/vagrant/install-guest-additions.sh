#!/bin/bash
GUEST_ADDITION_VERSION=5.2.4
GUEST_ADDITION_ISO=VBoxGuestAdditions_${GUEST_ADDITION_VERSION}.iso
GUEST_ADDITION_MOUNT=/media/VBoxGuestAdditions

apt-get install linux-headers-$(uname -r) build-essential dkms

# Download the VirtualBox Guest Additions ISO file
wget http://download.virtualbox.org/virtualbox/${GUEST_ADDITION_VERSION}/${GUEST_ADDITION_ISO}

# Create a directory to mount the ISO file
mkdir -p ${GUEST_ADDITION_MOUNT}

# Mount the ISO file to the specified directory with read-only option
mount -o loop,ro ${GUEST_ADDITION_ISO} ${GUEST_ADDITION_MOUNT}

# Run the VBoxLinuxAdditions installation script
sh ${GUEST_ADDITION_MOUNT}/VBoxLinuxAdditions.run

# Remove the downloaded ISO file
rm ${GUEST_ADDITION_ISO}

# Unmount the ISO file from the directory
umount ${GUEST_ADDITION_MOUNT}

# Remove the directory used for mounting
rmdir ${GUEST_ADDITION_MOUNT}
