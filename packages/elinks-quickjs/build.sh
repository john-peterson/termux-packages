TERMUX_PKG_HOMEPAGE=https://github.com/rkd77/elinks
TERMUX_PKG_DESCRIPTION="experimental quickjs browser support"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=$(date +"%y%m%d")
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=git+https://github.com/rkd77/elinks
TERMUX_PKG_GIT_BRANCH=master
TERMUX_PKG_DEPENDS="libandroid-execinfo, libexpat, libiconv, libidn, openssl, libbz2, zlib"
#TERMUX_PKG_BUILD_DEPENDS="netsurf"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_BUILD_IN_SRC=true

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--enable-256-colors
--enable-true-color
--mandir=$TERMUX_PREFIX/share/man
--with-openssl
--with-quickjs
--without-brotli
--without-zstd
"

TERMUX_PKG_MAKE_PROCESSES=1

termux_step_post_get_source() {
git clone --depth 1 https://github.com/bellard/quickjs
make -C quickjs
}

termux_step_pre_configure() {
	LDFLAGS+=" -landroid-execinfo"
	LIBRARY_PATH+=$TERMUX_TOPDIR/netsurf/src/inst-gtk3/lib/libcss.a       
	echo $TERMUX_PKG_MAKE_PROCESSES
	./autogen.sh
}

termux_step_make_install(){
install -Dm755 "$TERMUX_PKG_SRCDIR/src/elinks" -t "$TERMUX_PREFIX/bin/elinks-qjs"
}