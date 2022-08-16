EAPI=7

PYTHON_COMPAT=( python3_{5,6,7,8,9,10} )
inherit cmake python-single-r1

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="https://github.com/YosysHQ/nextpnr.git"
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
else
        SRC_URI="https://github.com/YosysHQ/${PN}/archive/refs/tags/${P}.tar.gz"
        S="${WORKDIR}/${PN}-${P}"
        KEYWORDS="~ppc64 ~arm64"
fi

LICENSE="ISC"
SLOT="0"
IUSE="ecp5 +generic +gui ice40 openmp +python"

REQUIRED_USE="|| ( ecp5 generic ice40 )
             gui? ( python )
             ${PYTHON_REQUIRED_USE}"

RDEPEND="gui? ( dev-qt/qtgui:5 )
         python? ( ${PYTHON_DEPS} )
         dev-libs/boost
         dev-cpp/eigen:3[openmp?]
         ecp5? ( dev-embedded/prjtrellis )
         ice40? ( dev-embedded/icestorm )"
DEPEND="$RDEPEND ${PYTHON_DEPS}"

pkg_pretend() {
        [[ ${MERGE_TYPE} != binary ]] && use openmp && tc-check-openmp
}

pkg_setup() {
        [[ ${MERGE_TYPE} != binary ]] && use openmp && tc-check-openmp
        python-single-r1_pkg_setup
}

src_configure() {

        local arches=()
        use ecp5 && arches+=( ecp5 )
        use generic && arches+=( generic )
        use ice40 && arches+=( ice40 )

        local mycmakeargs=(
                -DUSE_OPENMP="$(usex openmp)"
                -DBUILD_GUI="$(usex gui)"
                -DBUILD_PYTHON="$(usex python)"
                -DPYTHON_EXECUTABLE="${PYTHON}"
                -DPYTHON_INCLUDE_DIR="$(python_get_includedir)"
                -DPYTHON_LIBRARY="$(python_get_library_path)"
                -DARCH="$(IFS=';'; echo "${arches[*]}")"
        )
        use ecp5 && mycmakeargs+=( -DTRELLIS_INSTALL_PREFIX=/usr -DPYTRELLIS_LIBDIR=/usr/$(get_libdir)/trellis )
        use ice40 && mycmakeargs+=( -DICEBOX_ROOT=/usr/share/icebox )
        [[ ${PV} != *9999* ]] && mycmakeargs+=( -DCURRENT_GIT_VERSION=${PV} )
        cmake_src_configure
}
