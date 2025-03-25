EAPI=7

DESCRIPTION="Multi pass optimizing macro assembler for the 65xx series of processors"
HOMEPAGE="https://sourceforge.net/projects/tass64/"
SRC_URI="https://downloads.sourceforge.net/tass64/${P}-src.zip"

LICENSE="GPL-2+"
SLOT="0" 
KEYWORDS="arm64 ppc64" 
IUSE="" 

S="${WORKDIR}/${P}-src"

pkg_setup() {
    MAKEOPTS+=" prefix=/usr docdir=${EPREFIX}/usr/share/doc/${PF} "
}

src_prepare() {
    default
    sed -i 's/gzip/:/' Makefile
}
