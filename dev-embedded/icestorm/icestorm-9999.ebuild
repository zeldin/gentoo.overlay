EAPI=5

PYTHON_COMPAT=( python3_{3,4} )

inherit eutils python-single-r1

EGIT_REPO_URI="git://github.com/cliffordwolf/icestorm.git"
inherit git-2
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
