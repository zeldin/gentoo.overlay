EAPI=8

inherit cmake

DESCRIPTION="SDK for developing with the llvm-mos compiler"
HOMEPAGE="https://github.com/llvm-mos/llvm-mos-sdk"

SRC_URI="https://github.com/llvm-mos/llvm-mos-sdk/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~ppc64"

LICENSE="Apache-2.0-with-LLVM-exceptions"
SLOT="0"
IUSE=""

RDEPEND="dev-embedded/llvm-mos"
DEPEND="${RDEPEND}"

RESTRICT="strip binchecks"

CMAKE_BUILD_TYPE="MinSizeRel"

PATCHES=( "${FILESDIR}"/symlink-destdir.patch )

src_configure() {
  local mycmakeargs=(
      -DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr/lib/llvm-mos"
      -DBUILD_SHARED_LIBS=OFF
      -DLLVM_MOS_BOOTSTRAP_COMPILER=Off
      -DLLVM_MOS=/usr/lib/llvm-mos
   )
   cmake_src_configure
}

src_install() {
   cmake_src_install
   rm -rf "${D}/${WORKDIR}"
}
