EAPI=8

inherit cmake

DESCRIPTION="Polygon clipping library"
HOMEPAGE="https://sourceforge.net/projects/polyclipping/"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="~arm64 ~ppc64"

SRC_URI="https://downloads.sourceforge.net/polyclipping/clipper_ver${PV}.zip"

PATCHES=( "${FILESDIR}/cmake_version.patch" )

S="${WORKDIR}"
CMAKE_USE_DIR="${S}/cpp"
