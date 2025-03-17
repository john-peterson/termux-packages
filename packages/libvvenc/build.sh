TERMUX_PKG_DESCRIPTION="H.266/VVC video stream encoder library"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="0"
TERMUX_PKG_SRCURL=git+https://github.com/fraunhoferhhi/vvenc
TERMUX_PKG_GIT_BRANCH=master
TERMUX_PKG_DEPENDS="libandroid-posix-semaphore, libc++"
# TERMUX_PKG_BUILD_DEPENDS="llvmgold"
TERMUX_NO_CLEAN_SRC=true
TERMUX_PKG_MAKE_PROCESSES=4
TERMUX_PKG_EXTRA_MAKE_ARGS="-d explain"

termux_step_pre_configure1() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=215

	local v=$(sed -En 's/^.*set\(X265_BUILD ([0-9]+).*$/\1/p' \
			source/CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		termux_error_exit "SOVERSION guard check failed."
	fi

	local _TERMUX_CLANG_TARGET=

	# Not sure if this is necessary for on-device build
	# Follow termux_step_configure_cmake.sh for now
	if [ "$TERMUX_ON_DEVICE_BUILD" = false ]; then
		_TERMUX_CLANG_TARGET="--target=${CCTERMUX_HOST_PLATFORM}"
	fi

	if [ "$TERMUX_ARCH" = arm ] || [ "$TERMUX_ARCH" = i686 ]; then
		# Avoid text relocations and/or build failure.
		TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-DENABLE_ASSEMBLY=OFF"
	fi

	TERMUX_PKG_SRCDIR="$TERMUX_PKG_SRCDIR/source"

	sed -i "s/@TERMUX_CLANG_TARGET_${TERMUX_ARCH^^}@/${_TERMUX_CLANG_TARGET}/" \
		${TERMUX_PKG_SRCDIR}/CMakeLists.txt

	LDFLAGS+=" -landroid-posix-semaphore"
}

termux_step_post_massage1() {
	local _GUARD_FILE="lib/${TERMUX_PKG_NAME}.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		termux_error_exit "Error: file ${_GUARD_FILE} not found."
	fi
}
