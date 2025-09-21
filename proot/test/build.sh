TERMUX_PKG_DESCRIPTION="empty test packet for build system "
TERMUX_PKG_VERSION=0
TERMUX_PKG_LICENSE="WTFPL"

termux_step_pre_configure() {
	:
# echo $TERMUX_PREFIX
# echo $TERMUX_PREFIX_CLASSICAL
# echo $TERMUX_TOPDIR
# exit
$TERMUX_FAST_BUILD && echo fast build detected
$TERMUX_PKG_PROOT && echo proot build detected
$TERMUX_SAFE_BUILD && echo safe build detected
# exit
# $TERMUX_ON_DEVICE_BUILD && test TERMUX_PREFIX = TERMUX_PREFIX_CLASSICAL && echo unsafe prefix detected && exit
# pwd
# touch a
# touch configure.in
# exit
}

termux_step_post_configure() {
	pwd
echo prefix=$TERMUX_PREFIX | tee a
}

termux_step_post_make_install() {
	pwd
	mkdir -p $TERMUX_PREFIX_INSTALL
	# install results 
	# cp $TERMUX_PKG_BUILDDIR/* $TERMUX_PREFIX/ -v
	cp $TERMUX_PKG_BUILDDIR/* $TERMUX_PREFIX_INSTALL/ -v
# install -Dm700 -t $TERMUX_PREFIX/ $TERMUX_PKG_SRCDIR/a
# cat $TERMUX_PKG_SRCDIR/configure.in
}

termux_step_post_massage() {
	pwd
	cat a
}
