EAPI=5

inherit eutils

EGIT_REPO_URI="git://github.com/cseed/arachne-pnr.git"
inherit git-2
SRC_URI=""
KEYWORDS=""

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="dev-embedded/icestorm"

src_compile() {
	emake ICEBOX="/usr/share/icebox" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}/usr" install
}
