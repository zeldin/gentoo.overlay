EAPI=8

PYTHON_COMPAT=( python3_{3,4,5,6,7,8,9,10,11,12} )

inherit python-single-r1

EGIT_REPO_URI="https://github.com/cliffordwolf/icestorm.git"
inherit git-r3
SRC_URI=""
KEYWORDS=""

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
