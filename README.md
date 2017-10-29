# gear0x
gear0x is, in a nutshell, a bootdisk ready for expansion based on debian and the Linux kernel.
Heavily inspired by The Core Project and the sum of my frustration, essentially :)
It is menu-driven, but allows you to drop to a comfy' tmux/bash if you ever feel the need.

## In it's current state the minimum OS enables you to:
  - Boot various Linux systems
  - Install debian via debootstrap (with optional luks)
  - Rapidly integrate tools using squashfs overlays

## Building
    git clone https://github.com/hakt0r/gear0x
    cd gear0x
    sudo sh _build/deps
    sudo sh _build/deps.test # for testing
    sudo make deps build ramfs test

## License
gear0x is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2, or (at your option)
any later version.

gear0x is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this software; see the file COPYING.  If not, write to
the Free Software Foundation, Inc., 59 Temple Place, Suite 330,
Boston, MA 02111-1307 USA
