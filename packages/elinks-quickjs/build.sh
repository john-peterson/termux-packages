TERMUX_PKG_HOMEPAGE=https://github.com/rkd77/elinks
TERMUX_PKG_DESCRIPTION="experimental terminal JavaScript browser"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=$(date +"%y%m%d")
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=git+https://github.com/john-peterson/elinks
TERMUX_PKG_GIT_BRANCH=make
TERMUX_PKG_DEPENDS="libandroid-execinfo, libexpat, libiconv, libidn, openssl, libbz2, zlib,quickjs"
TERMUX_PKG_BUILD_DEPENDS="netsurf"
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
TERMUX_PKG_EXTRA_MAKE_ARGS="VERBOSE=1"
TERMUX_PKG_MAKE_PROCESSES=1

termux_step_post_get_source() {
#pwd; exit 
git clone --depth 1 https://github.com/bellard/quickjs
make -C quickjs
echo 
}

termux_step_pre_configure() {
	./autogen.sh
	#export LIBRARY_PATH+=$TERMUX_TOPDIR/netsurf/src/inst-gtk3/lib
	export LIBRARY_PATH+=".:$PREFIX/lib"
	#echo $LIBRARY_PATH;exit
	export PKG_CONFIG_PATH+="$TERMUX_TOPDIR/netsurf/src/inst-gtk3/lib/pkgconfig"
	#echo $PKG_CONFIG_PATH;exit
}

termux_step_post_configure(){
	export CFLAGS+="-w -Wfatal-errors"
	export LDFLAGS+=" -landroid-execinfo"
}
