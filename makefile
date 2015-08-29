#!/usr/bin/env make

rebuild:
		busybox sh _build/tool make installer debug

rebuild-debug:
		busybox sh _build/tool make installer debug


ramfs:
		busybox sh _build/tool -p ramfs,tests make

stick:
		busybox sh _build/tool stick

test:
		busybox sh _build/tool -p ramfs,tests make


rebuild-stick:
		busybox sh _build/tool make installer debug


rebuild-x86_64:
		busybox sh _build/tool -a x86_64 make installer debug


rebuild-pi:
		busybox sh _build/tool -a armpi make installer debug

pi-card:
		busybox sh _build/tool -a armpi -p ramfs,stick -D /dev/mmcblk0p make

rebuild-pi2:
		busybox sh _build/tool -a armpi2 make installer debug

pi2-card:
		busybox sh _build/tool -a armpi2 -p ramfs,stick -D /dev/mmcblk0p make

all: rebuild-x86_64 rebuild-pi rebuild-pi2
