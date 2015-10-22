#!/usr/bin/env make

bin/busybox:
	mkdir -p contrib bin
	test -d contrib/busybox || git clone --depth=1 git://git.busybox.net/busybox contrib/busybox
	cp _build/arch/src/busybox_config contrib/.config
	# make -C contrib/busybox -j 2 menuconfig
	make -C contrib/busybox -j 2
	cp contrib/busybox/busybox bin/

bin/usplash: bin/busybox
	mkdir -p bin
	diet gcc -g -Os -static -o bin/usplash _build/arch/src/usplash.c

rebuild:
		busybox sh _build/tool make installer debug

rebuild-debug:
		busybox sh _build/tool -v make installer debug

ramfs:
		busybox sh _build/tool -p build,ramfs make
ramfs-to-stick: ramfs
	mount /dev/sdb1 /mnt
	cp x86_64/initramfs.gz /mnt/boot/
	umount /mnt
	sync

test:
		busybox sh _build/tool -v -p tests make

rebuild-x86_64:
		busybox sh _build/tool -a x86_64 make installer debug
rebuild-pi:
		busybox sh _build/tool -a armpi  make installer debug
rebuild-pi2:
		busybox sh _build/tool -a armpi2 make installer debug

stick:
		busybox sh _build/tool -v -p stick -D /dev/sdb make
pi-card:
		busybox sh _build/tool -a armpi -p ramfs,stick -D /dev/mmcblk0p make
pi2-card:
		busybox sh _build/tool -a armpi2 -p ramfs,stick -D /dev/mmcblk0p make

all: rebuild-x86_64 rebuild-pi rebuild-pi2
