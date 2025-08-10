EAPI=8

inherit cmake

DESCRIPTION="Port of LLVM to the MOS 6502 and related processors"
HOMEPAGE="https://github.com/llvm-mos/llvm-mos"

EGIT_REPO_URI="https://github.com/llvm-mos/llvm-mos"
EGIT_COMMIT="648b01bb5909952891808d91892066264d2db3e6"
SRC_URI="https://github.com/llvm-mos/llvm-mos/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/llvm-mos-${EGIT_COMMIT}"
KEYWORDS="~ppc64"

LICENSE="Apache-2.0-with-LLVM-exceptions"
SLOT="0"
IUSE=""

CMAKE_USE_DIR="${S}/llvm"

PATCHES=( "${FILESDIR}"/MOSCodeGen-libdeps.patch
	  "${FILESDIR}"/runtimes-cflags.patch    )

src_configure() {
  local mycmakeargs=(
      -C "${S}/clang/cmake/caches/MOS.cmake"
      -DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr/lib/llvm-mos"
      -DCMAKE_INSTALL_MANDIR="${EPREFIX}/usr/lib/llvm-mos/share/man"
      -DBUILD_SHARED_LIBS=OFF
      -DLLVM_FORCE_VC_REPOSITORY="${EGIT_REPO_URI}"
      -DLLVM_FORCE_VC_REVISION="${EGIT_COMMIT}"
     )
   cmake_src_configure
}

src_install() {
   cmake_src_install
   dosym -r /usr/lib/llvm-mos/bin/mos-clang /usr/bin/mos-clang
   dosym -r /usr/lib/llvm-mos/bin/mos-clang++ /usr/bin/mos-clang++
   dosym -r /usr/lib/llvm-mos/bin/mos-clang-cpp /usr/bin/mos-clang-cpp
}
