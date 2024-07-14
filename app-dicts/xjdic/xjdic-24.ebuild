# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit toolchain-funcs

DESCRIPTION="Electronic Japanese-English Dictionary Program"
HOMEPAGE="http://www.csse.monash.edu.au/~jwb/xjdic/"
SRC_URI="http://ftp.monash.edu.au/pub/nihongo/xjdic24.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
PDEPEND="app-dicts/kanjidic app-dicts/edict"

PATCHES=( "${FILESDIR}/${P}.patch" "${FILESDIR}/${P}-termios.patch"
          "${FILESDIR}/${PN}-fix-reply-overrun.patch" )

S="${WORKDIR}"

src_compile () {
    emake CC="$(tc-getCC) -fcommon"
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
