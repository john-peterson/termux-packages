# shellcheck disable=SC2086
termux_step_make_install() {
	[ "$TERMUX_PKG_METAPACKAGE" = "true" ] && return
	if test -f build.ninja; then
		if $TERMUX_SAFE_BUILD; then
			# sed -i --debug s,$TERMUX_PREFIX_INSTALL,$TERMUX_PKG_MASSAGEDIR_BASE, $TERMUX_PKG_BUILDDIR/meson-info/intro-installed.json
			# replace_in_binary $TERMUX_PREFIX_INSTALL $TERMUX_PKG_MASSAGEDIR_BASE $TERMUX_PKG_BUILDDIR/meson-private/install.dat
			$TERMUX_SCRIPTDIR/scripts/meson_replace.py prefix $TERMUX_PKG_MASSAGEDIR_BASE $TERMUX_PKG_BUILDDIR/meson-private/install.dat
			# cat $TERMUX_PKG_BUILDDIR/meson-info/intro-installed.json
			# echo 
			strings  $TERMUX_PKG_BUILDDIR/meson-private/install.dat | ack prefix -A
			read -p "confirm  path"
		fi
		ninja -j $TERMUX_PKG_MAKE_PROCESSES $TERMUX_PKG_NINJA_INSTALL_TARGET 
	elif test -f setup.py || test -f pyproject.toml || test -f setup.cfg; then
		pip install --no-deps . --prefix $TERMUX_PREFIX_BASE
	elif ls ./*.cabal &>/dev/null; then
		# Workaround until `cabal install` is fixed.
		while read -r bin; do
			[[ -f "$bin" ]] || termux_error_exit "'$bin', no such file. Has build completed?"
			echo "INFO: Installing '$bin' component..."
			cp "$bin" "$TERMUX_PREFIX_RUN/bin"
		done< <(cat ./dist-newstyle/cache/plan.json | jq -r '."install-plan"[]|select(."component-name"? and (."component-name"|test("exe:.*")) and (.style == "local") )|."bin-file"')
	elif ls ./*akefile &>/dev/null || [ -n "$TERMUX_PKG_EXTRA_MAKE_ARGS" ]; then
		# Some packages have problem with parallell install, and it does not buy much, so use -j 1.
		if [ -z "$TERMUX_PKG_EXTRA_MAKE_ARGS" ]; then
			make -j 1 ${TERMUX_PKG_MAKE_INSTALL_TARGET}
		else
			make -j 1 ${TERMUX_PKG_EXTRA_MAKE_ARGS} ${TERMUX_PKG_MAKE_INSTALL_TARGET}
		fi
	elif test -f Cargo.toml; then
		termux_setup_rust
		# this has no effect 
		# CARGO_TARGET_DIR=$TERMUX_PKG_CARGO_INSTALL_TARGET \
		cargo install \
			--jobs $TERMUX_PKG_MAKE_PROCESSES \
			--path . \
			--force \
			--locked \
			--no-track \
			--target $CARGO_TARGET_NAME \
			--root $TERMUX_PKG_CARGO_INSTALL_TARGET \
			$TERMUX_PKG_EXTRA_CONFIGURE_ARGS
	fi
}
