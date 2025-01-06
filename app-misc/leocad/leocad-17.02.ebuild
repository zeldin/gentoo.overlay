# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=7

inherit qmake-utils xdg

SRC_URI="https://github.com/leozide/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz \
	https://github.com/leozide/${PN}/releases/download/v${PV}/Library-Linux-9781.zip"

KEYWORDS="~ppc ~ppc64"

DESCRIPTION="LeoCAD is a CAD program that can be used to create virtual LEGO models"
HOMEPAGE="http://www.leocad.org/"

LICENSE="GPL-2"
SLOT="0"
IUSE="jpeg png zlib"

S="${WORKDIR}/${P}"

RDEPEND="dev-qt/qtcore:5
	media-libs/mesa
	jpeg? ( virtual/jpeg )
	png? ( media-libs/libpng:0 )
	zlib? ( sys-libs/zlib )"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	local qmake_args=(DOCS_DIR=/usr/share/doc/"${P}")
        eqmake5 "${qmake_args[@]}"
}

src_install() {
        emake INSTALL_ROOT="${ED}" install

	insinto /usr/share/leocad
	doins "${WORKDIR}"/library.bin
}
