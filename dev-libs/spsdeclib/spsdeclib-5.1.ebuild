# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5

inherit base eutils unpacker flag-o-matic autotools-multilib

DESCRIPTION="A library to decode IPF files"
HOMEPAGE="http://www.kryoflux.com/"
SRC_URI="http://www.kryoflux.com/download/${PN}_${PV}_source.zip"

LICENSE="XMAME"
SLOT="0"
KEYWORDS="~ppc ~ppc64"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

PATCHES=( "${FILESDIR}"/${P}-intel.patch )

S="${WORKDIR}/capsimg_source_linux_macosx"

append-ldflags -static-libgcc -static-libstdc++

src_unpack() {
	unpack ${A}
	unpack_zip capsimg_source_linux_macosx.zip
}

src_prepare() {
	base_src_prepare
	chmod +x CAPSImg/configure
	multilib_copy_sources
}

multilib_src_configure() {
	cd ${BUILD_DIR}/CAPSImg && econf
}

multilib_src_compile() {
	emake -C CAPSImg || die
	sed \
	-e 's|@prefix@|/usr|g' \
	-e 's|@exec_prefix@|${prefix}|g' \
	-e 's|@libdir@|${exec_prefix}/'$(get_libdir)'|g' \
	-e 's|@includedir@|${prefix}/include|g' \
	-e 's|@VERSION@|'${PV}'|g' \
	"${FILESDIR}"/libcapsimage.pc.in > libcapsimage.pc || die
}

multilib_src_install() {
	insinto /usr/$(get_libdir)/pkgconfig
	doins libcapsimage.pc
	into /usr
	dolib CAPSImg/libcapsimage.so.${PV}
	dosym libcapsimage.so.${PV} /usr/$(get_libdir)/libcapsimage.so
	dosym libcapsimage.so.${PV} /usr/$(get_libdir)/libcapsimage.so.${PV%%.*}
	insinto /usr/include/CAPSImg
	doins LibIPF/*.h
}
