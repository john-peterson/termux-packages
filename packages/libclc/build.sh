TERMUX_PKG_HOMEPAGE=https://libclc.llvm.org/
TERMUX_PKG_DESCRIPTION="Library requirements of the OpenCL C programming language"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=19.1.3
TERMUX_PKG_SRCURL=https://github.com/llvm/llvm-project/releases/download/llvmorg-$TERMUX_PKG_VERSION/libclc-$TERMUX_PKG_VERSION.src.tar.xz
TERMUX_PKG_SHA256=b49fab401aaa65272f0480f6d707a9a175ea8e68b6c5aa910457c4166aa6328f
# TERMUX_PKG_BUILD_DEPENDS="clang, python, spirv-llvm-translator"
# TERMUX_PKG_PLATFORM_INDEPENDENT=true
TERMUX_NO_CLEAN=true

termux_step_pre_configure() {
# it needs th LLVM optimiser opt ? ?  where is it ? ?
 	# -DCMAKE_C_COMPILER=$TERMUX_STANDALONE_TOOLCHAIN/bin/opt
	TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
 	-DCMAKE_C_COMPILER=$TERMUX_STANDALONE_TOOLCHAIN/bin/clang
	-DLIBCLC_CUSTOM_LLVM_TOOLS_BINARY_DIR=$TERMUX_STANDALONE_TOOLCHAIN/bin
	"
		# CMAKE_ADDITIONAL_ARGS+=("-DCMAKE_C_COMPILER=$TERMUX_STANDALONE_TOOLCHAIN/bin/clang")
		# CMAKE_ADDITIONAL_ARGS+=("-DCMAKE_CXX_COMPILER=$TERMUX_STANDALONE_TOOLCHAIN/bin/clang++")

}

termux_step_configure2() {
	termux_setup_ninja
	termux_setup_cmake

	local OLD_PATH="${PATH}"
	export PATH="${TERMUX_PREFIX}/bin:${PATH}"

	cmake ${TERMUX_PKG_SRCDIR} \
		-G Ninja \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX=$TERMUX_PREFIX

	export PATH=$OLD_PATH
}

termux_step_make1() {
	local OLD_PATH="${PATH}"
	export PATH="${TERMUX_PREFIX}/bin:${PATH}"

	ninja

	export PATH=$OLD_PATH
}
