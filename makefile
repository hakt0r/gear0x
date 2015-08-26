#!/usr/bin/env make

rebuild:
		busybox sh _build/tool rebuild installer debug

ramfs:
		PHASES=ramfs busybox sh _build/tool -v rebuild installer debug

stick:
		busybox sh _build/tool stick

rebuild-stick:
		busybox sh _build/tool rebuild installer debug

test:
		busybox sh _build/tool -r -x

rebuild-x86_64:
		busybox sh _build/tool -a x86_64 rebuild installer debug

rebuild-pi2:
		busybox sh _build/tool -a armpi2 rebuild installer debug

pi2-card:
		busybox sh _build/tool -D /dev/mmcblk0p -a armpi2 stick

all: rebuild-x86_64 rebuild-pi2
