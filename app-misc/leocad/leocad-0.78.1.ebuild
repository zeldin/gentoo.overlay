# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=3

inherit base

SRC_URI="http://leocad.googlecode.com/files/${P}-src.tgz \
	http://leocad.googlecode.com/files/pieces-6152.zip"

KEYWORDS="~ppc"

DESCRIPTION="LeoCAD is a CAD program that can be used to create virtual LEGO models"
HOMEPAGE="http://www.leocad.org/"

LICENSE="GPL-2"
SLOT="0"
IUSE="jpeg png zlib"

S="${WORKDIR}/${PN}"

RDEPEND=">=x11-libs/gtk+-2.0
	media-libs/mesa
	jpeg? ( virtual/jpeg )
	png? ( media-libs/libpng:0 )
	zlib? ( sys-libs/zlib )"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

PATCHES=( "${FILESDIR}"/${P}-bigendian.patch
	"${FILESDIR}"/${P}-infotype.patch
	"${FILESDIR}"/${P}-libs.patch )

src_configure() {
        make PREFIX=/usr config || die
}

src_install() {
	base_src_install

	insinto /usr/share/leocad
	doins "${WORKDIR}"/pieces.*
}
