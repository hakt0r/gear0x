#!/usr/bin/env make

rebuild:
		busybox sh _build/tool rebuild installer debug

stick:
		busybox sh _build/tool -S stick

rebuild-sick:
		busybox sh _build/tool -S rebuild installer debug

test:
		busybox sh _build/tool -r -x

rebuild-x86_64:
		busybox sh _build/tool -a x86_64 rebuild installer debug
	
rebuild-pi2:
		busybox sh _build/tool -a armpi2 rebuild installer debug

rebuild-pi2-card:
		busybox sh _build/tool -a armpi2 -S rebuild installer debug

all: rebuild-x86_64 rebuild-pi2
