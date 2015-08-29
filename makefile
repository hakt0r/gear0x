#!/usr/bin/env make

rebuild:
		busybox sh _build/tool rebuild installer debug

rebuild-debug:
		busybox sh _build/tool rebuild installer debug


ramfs:
		busybox sh _build/tool -p ramfs,tests rebuild

stick:
		busybox sh _build/tool stick

test:
		busybox sh _build/tool -p ramfs,tests rebuild


rebuild-stick:
		busybox sh _build/tool rebuild installer debug


rebuild-x86_64:
		busybox sh _build/tool -a x86_64 rebuild installer debug


rebuild-pi:
		busybox sh _build/tool -a armpi rebuild installer debug

pi-card:
		busybox sh _build/tool -a armpi -p ramfs,stick -D /dev/mmcblk0p rebuild

rebuild-pi2:
		busybox sh _build/tool -a armpi2 rebuild installer debug

pi2-card:
		busybox sh _build/tool -a armpi2 -p ramfs,stick -D /dev/mmcblk0p rebuild

all: rebuild-x86_64 rebuild-pi rebuild-pi2
