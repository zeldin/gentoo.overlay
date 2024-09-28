EAPI=7

DESCRPTION="Ansi HTML Adapter"
SRC_URI="https://github.com/theZiz/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
HOMEPAGE="https://github.com/theZiz/aha"

SLOT="0"
LICENSE="|| ( LGPL-2+ MPL-1.1 )"
KEYWORDS="ppc64"
IUSE=""

MAKEOPTS+=" PREFIX=\"${EPREFIX}/usr\""
