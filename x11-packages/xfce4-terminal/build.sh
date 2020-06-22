TERMUX_PKG_HOMEPAGE=https://docs.xfce.org/apps/terminal/start
TERMUX_PKG_DESCRIPTION="Terminal Emulator for the XFCE environment"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="Leonid Pliushch <leonid.pliushch@gmail.com>"
TERMUX_PKG_VERSION=0.8.9.2
TERMUX_PKG_REVISION=9
TERMUX_PKG_SRCURL=https://archive.xfce.org/src/apps/xfce4-terminal/${TERMUX_PKG_VERSION:0:3}/xfce4-terminal-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_SHA256=9ba23bf86d350ef8a95d2dfb50bbd1bbb2144d82985a779ec28caf47faaeeeeb
TERMUX_PKG_DEPENDS="desktop-file-utils, exo, hicolor-icon-theme, garcon, libxfce4ui, xfconf, libvte"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--enable-gtk3"
