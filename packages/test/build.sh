TERMUX_PKG_DESCRIPTION="empty test packet for build system "
TERMUX_PKG_VERSION=0
TERMUX_PKG_LICENSE="WTFPL"
TERMUX_PKG_NO_ELF_CLEANER=true

termux_step_pre_configure() {
set +e
# echo $TERMUX_PREFIX
# echo $TERMUX_PREFIX_CLASSICAL
# echo $TERMUX_TOPDIR
# exit
$TERMUX_FAST_BUILD && echo fast build detected
$TERMUX_PKG_PROOT && echo proot build detected
$TERMUX_SAFE_BUILD && echo safe build detected
# exit
$TERMUX_SAFE_BUILD && test $TERMUX_PREFIX_INSTALL = $TERMUX_PREFIX_CLASSICAL && echo unsafe prefix detected && exit
# pwd
# touch a
# touch configure.in
# exit
set -e
}

termux_step_post_configure() {
	pwd
}

termux_step_post_make_install() {
	pwd
echo prefix=$TERMUX_PREFIX_INSTALL | tee a
touch b

mkdir man
touch man/c

	# mkdir -p $TERMUX_PREFIX_INSTALL
	mkdir -p $TERMUX_PKG_MASSAGEDIR_BASE
	# return
	# install results 
	cp $TERMUX_PKG_BUILDDIR/* $TERMUX_PKG_MASSAGEDIR_BASE/ -rv
	# cp $TERMUX_PKG_BUILDDIR/* $TERMUX_PREFIX_INSTALL/ -v
# install -Dm700 -t $TERMUX_PREFIX/ $TERMUX_PKG_SRCDIR/a
echo install done
echo

# cat $TERMUX_PKG_SRCDIR/configure.in
}

termux_step_post_massage() {
	pwd
	echo massage=$TERMUX_PKG_MASSAGEDIR
	tree $TERMUX_PKG_MASSAGEDIR
	# d=$TERMUX_PKG_MASSAGEDIR$TERMUX_PREFIX
	cat a
	# set +e
$TERMUX_SAFE_BUILD && grep $TERMUX_PKG_MASSAGEDIR a && echo massage failed && exit || true
	# set -e
}
