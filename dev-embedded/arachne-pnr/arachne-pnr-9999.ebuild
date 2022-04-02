EAPI=5

inherit eutils

EGIT_REPO_URI="https://github.com/cseed/arachne-pnr.git"
inherit git-r3
SRC_URI=""
KEYWORDS=""

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="dev-embedded/icestorm"

src_compile() {
	emake PREFIX="/usr" || die "emake failed"
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" install
}
