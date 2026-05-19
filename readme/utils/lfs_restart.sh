#!/bin/bash

export LFS=/mnt/lfs
umask 022

mount -v -t ext4 /dev/sdb3 $LFS
/sbin/swapon -v /dev/sdb2
