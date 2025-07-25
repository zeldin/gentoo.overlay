EAPI=8

PYTHON_COMPAT=( python3_{5,6,7,8,9,10,11,12,13} )
CMAKE_IN_SOURCE_BUILD="1"
inherit cmake python-single-r1

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="https://github.com/YosysHQ/prjtrellis.git"
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
else
        SRC_URI="https://github.com/YosysHQ/prjtrellis/archive/${PV}.tar.gz -> ${P}.tar.gz"
        if [[ ${PV} =~ ^1\.4 ]]; then
          SRC_URI="${SRC_URI} https://github.com/YosysHQ/prjtrellis/releases/download/${PV}/prjtrellis-db-${PV}.zip"
        fi
        KEYWORDS="~ppc64 ~arm64"
fi

RESTRICT="network-sandbox"

LICENSE="ISC"
SLOT="0"
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
         dev-libs/boost"
DEPEND="$RDEPEND
         dev-vcs/git"
BDEPEND=">=dev-build/cmake-3.5"

CMAKE_USE_DIR="${S}/libtrellis"

src_unpack() {
	if [[ ${PV} = *9999* ]]; then
		git-r3_src_unpack
	elif [[ ${A} = *prjtrellis-db* ]]; then
		default_src_unpack
		rmdir "${S}/database"
		mv "${WORKDIR}/prjtrellis-db-master" "${S}/database"
	else
		default_src_unpack
		# prjtrellis tars are missing the database, and there
		# is no release available of the database repo...
		cd "${S}/database"
		git clone https://github.com/YosysHQ/prjtrellis-db .
		case ${PV} in
			1.0) git checkout d0b219a;;
			1.1|1.2|1.2.1) git checkout 0ee729d;;
			1.3) git checkout 35d900a;;
			*) die "No prjtrellis-db hash for ${PV}??";;
		esac
	fi
}

src_prepare() {
	cmake_src_prepare
	sed -i -e '/find_package(Git)/d' "${CMAKE_USE_DIR}"/CMakeLists.txt
	eapply_user
}

src_configure() {
        local mycmakeargs=(
                -DPython3_EXECUTABLE="${PYTHON}"
                -DPython3_INCLUDE_DIR="$(python_get_includedir)"
                -DPython3_LIBRARY="$(python_get_library_path)"
        )
        cmake_src_configure
}
