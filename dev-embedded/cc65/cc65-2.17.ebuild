EAPI=6

DESCRIPTION="complete cross development package for 65(C)02 systems"
HOMEPAGE="https://cc65.github.io/cc65/"
SRC_URI="https://github.com/cc65/${PN}/archive/V${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="arm64 ppc64" 
IUSE=""

pkg_setup() {
    MAKEOPTS+=" PREFIX=/usr "
}

src_prepare() {
    default
    sed -i '/^else # TARGET/i\
.NOTPARALLEL:\
' libsrc/Makefile
}
