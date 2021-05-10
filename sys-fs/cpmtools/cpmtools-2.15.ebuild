# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5

SRC_URI="http://www.moria.de/~michael/cpmtools/cpmtools-${PV}.tar.gz"

KEYWORDS="~ppc"

DESCRIPTION="This package allows to access CP/M file systems similar to the well-known mtools package, which accesses MSDOS file systems."
HOMEPAGE="http://www.moria.de/~michael/cpmtools/"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND=""

DEPEND="${RDEPEND}"

src_configure() {
	econf LIBS="-ltinfo"
}

src_install() {
    dodir /usr/bin
    emake prefix="${D}/usr" MANDIR="${D}/usr/share/man" install || die "Install failed"
}
