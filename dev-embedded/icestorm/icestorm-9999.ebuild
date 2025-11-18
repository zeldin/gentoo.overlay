EAPI=8

PYTHON_COMPAT=( python3_{3..13} )

inherit python-single-r1

if [[ ${PV} = *9999* ]]; then
  EGIT_REPO_URI="https://github.com/YosysHQ/icestorm.git"
  inherit git-r3
  SRC_URI=""
  KEYWORDS=""
else
  SRC_URI="https://github.com/YosysHQ/icestorm/archive/v${PV}.tar.gz -> ${P}.tar.gz"
  KEYWORDS="~ppc64 ~arm64"
fi

SLOT="0"
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RDEPEND="${PYTHON_DEPS} dev-embedded/libftdi"
DEPEND="$RDEPEND"

src_compile() {
	emake PREFIX="/usr" CC="$(tc-getCC)" CXX="$(tc-getCXX)" || die "emake failed"
}

src_install() {
	emake PREFIX="/usr" CC="$(tc-getCC)" CXX="$(tc-getCXX)" DESTDIR="${D}" install
}
