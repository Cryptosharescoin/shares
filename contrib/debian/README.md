
Debian
====================
This directory contains files used to package cryptosharesd/cryptoshares-qt
for Debian-based Linux systems. If you compile cryptosharesd/cryptoshares-qt yourself, there are some useful files here.

## pivx: URI support ##


cryptoshares-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install cryptoshares-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your cryptoshares-qt binary to `/usr/bin`
and the `../../share/pixmaps/pivx128.png` to `/usr/share/pixmaps`

cryptoshares-qt.protocol (KDE)

