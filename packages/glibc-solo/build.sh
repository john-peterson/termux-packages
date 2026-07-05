TERMUX_PKG_HOMEPAGE=https://termux.dev
TERMUX_PKG_DESCRIPTION="glibc boot strap"
TERMUX_PKG_LICENSE="WTFPL"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="0"
TERMUX_PKG_SKIP_SRC_EXTRACT=true

termux_step_make_install() {
	# install -Dm644 /dev/null "${TERMUX_PREFIX}/opt/vendor/lib/libOpenCL.so"
	:
}

termux_step_create_debscripts() {
	cp -f "${TERMUX_PKG_BUILDER_DIR}/postinst" .
}

termux_step_post_massage() {
	local target=etc/apt
	local source=$TERMUX_PKG_BUILDER_DIR
	mkdir -p $target

	# local_replace_prefix $TERMUX_PKG_BUILDER_DIR/apt.conf.in  $target/apt.conf
	# cp $source/dpkgx  $target/
	cp $source/glibc.* $target/
	sed -i $target/glibc.conf -e "s|@TERMUX_PREFIX@|${TERMUX_PREFIX}|g"
}
