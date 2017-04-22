# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=4

inherit qmake-utils

SRC_URI="https://github.com/leozide/${PN}/archive/v${PV}.tar.gz \
	https://github.com/leozide/${PN}/releases/download/v${PV}/Library-Linux-9781.zip"

KEYWORDS="~ppc ~ppc64"

DESCRIPTION="LeoCAD is a CAD program that can be used to create virtual LEGO models"
HOMEPAGE="http://www.leocad.org/"

LICENSE="GPL-2"
SLOT="0"
IUSE="+qt4 qt5 jpeg png zlib"
REQUIRED_USE="^^ ( qt4 qt5 )"

S="${WORKDIR}/${P}"

RDEPEND="qt4? ( dev-qt/qtcore:4 )
	qt5? ( dev-qt/qtcore:5 )
	media-libs/mesa
	jpeg? ( virtual/jpeg )
	png? ( media-libs/libpng:0 )
	zlib? ( sys-libs/zlib )"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
        use qt4 && eqmake4
        use qt5 && eqmake5
}

src_install() {
        emake INSTALL_ROOT="${ED}" install

	insinto /usr/share/leocad
	doins "${WORKDIR}"/library.bin
}
