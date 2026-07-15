EAPI=8

inherit qmake-utils xdg

SRC_URI="https://github.com/leozide/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz \
	https://github.com/leozide/${PN}/releases/download/v${PV}/Library-25.08.zip"

KEYWORDS="~ppc ~ppc64"

DESCRIPTION="LeoCAD is a CAD program that can be used to create virtual LEGO models"
HOMEPAGE="http://www.leocad.org/"

LICENSE="GPL-2"
SLOT="0"
IUSE="jpeg png zlib"

S="${WORKDIR}/${P}"

RDEPEND="dev-qt/qtbase:6[gui,widgets,concurrent,network,opengl,xml]
	media-libs/mesa
	jpeg? ( virtual/jpeg )
	png? ( media-libs/libpng:0 )
	zlib? ( sys-libs/zlib )"

DEPEND="${RDEPEND}
        dev-qt/qttools:6[linguist]
	virtual/pkgconfig"

src_configure() {
	local qmake_args=(DOCS_DIR=/usr/share/doc/"${P}")
        eqmake6 "${qmake_args[@]}"
}

src_install() {
        emake INSTALL_ROOT="${ED}" install

	insinto /usr/share/leocad
	doins "${WORKDIR}"/library.bin
}
