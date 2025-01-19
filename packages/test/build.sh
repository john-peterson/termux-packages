
TERMUX_PKG_VERSION="1.22.6"
TERMUX_PKG_LICENSE="GPL-2.0"

#

termux_step_pre_configure() {
# echo $TERMUX_PREFIX
pwd
touch a
# touch configure.in
# exit
}

termux_step_post_make_install() {
	pwd
install -Dm700 -t $TERMUX_PREFIX/ $TERMUX_PKG_SRCDIR/a
# cat $TERMUX_PKG_SRCDIR/configure.in
}
