#!/usr/bin/env make

deps:
	busybox sh _build/tool -p deps make
ramfs:
	busybox sh _build/tool -p ramfs make
build:
	busybox sh _build/tool -p build make
upload:
	busybox sh _build/tool -p upload make
rebuild:
	busybox sh _build/tool make
shell:
	busybox sh _build/tool -d bash
update:
	busybox sh _build/tool -d 'apt update && apt upgrade -y'
	busybox sh _build/tool make
rebuild-debug:
	busybox sh _build/tool -v make
ramfs-to-stick: ramfs
	mount /dev/sdb1 /mnt
	cp x86_64/initramfs.gz /mnt/boot/
	umount /mnt
	sync
stick:
	busybox sh _build/tool -v -p stick -D /dev/sdb make
softstick:
	busybox sh _build/tool -v -p softstick make
card:
	busybox sh _build/tool -v -p stick -D /dev/mmcblk0p make
test:
	busybox sh _build/tool -p tests make

update-x86_64:
	# DESTARCH=x86_64 sudo make deps build ramfs upload
	DESTARCH=x86_64 make upload

all: rebuild-debug
