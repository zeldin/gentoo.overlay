EAPI=7

PYTHON_COMPAT=( python3_{5,6,7,8,9} )
CMAKE_MIN_VERSION="3.5"
CMAKE_IN_SOURCE_BUILD="1"
inherit cmake-utils python-single-r1

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="https://github.com/YosysHQ/prjtrellis.git"
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
else
        SRC_URI="https://github.com/YosysHQ/prjtrellis/archive/${PV}.tar.gz -> ${P}.tar.gz"
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

CMAKE_USE_DIR="${S}/libtrellis"

src_unpack() {
	if [[ ${PV} = *9999* ]]; then
		git-r3_src_unpack
	else
		default_src_unpack
		# prjtrellis tars are missing the database, and there
		# is no release available of the database repo...
		cd "${S}/database"
		git clone https://github.com/YosysHQ/prjtrellis-db .
		case ${PV} in
			1.0) git checkout d0b219a;;
			1.1|1.2|1.2.1) git checkout 0ee729d;;
			*) die "No prjtrellis-db hash for ${PV}??";;
		esac
	fi
}

src_prepare() {
	cmake-utils_src_prepare
	sed -i -e '/find_package(Git)/d' "${CMAKE_USE_DIR}"/CMakeLists.txt
}
