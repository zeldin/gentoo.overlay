# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
inherit eutils

DESCRIPTION="Electronic Japanese-English Dictionary Program"
HOMEPAGE="http://www.csse.monash.edu.au/~jwb/xjdic/"
SRC_URI="http://ftp.monash.edu.au/pub/nihongo/xjdic24.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
PDEPEND="app-dicts/kanjidic app-dicts/edict"

src_unpack () {
    unpack ${A} || die
    epatch ${FILESDIR}/${P}.patch || die
    epatch ${FILESDIR}/${P}-termios.patch || die
    epatch ${FILESDIR}/${PN}-fix-reply-overrun.patch || die
}

src_compile () {
    emake || die
}

src_install () {
    mv xjdic_sa xjdic
    dobin xjdic
    dobin xjdxgen
    insinto /usr/share/xjdic
    doins kanjstroke \
	radicals.tm \
	radkfile \
	romkana.cnv \
	vconj
}
