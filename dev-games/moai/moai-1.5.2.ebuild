# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=7

inherit cmake

IUSE="chipmunk +curl +crypto examples +jpeg json luajit +ssl +png sqlite tinyxml +truetype vorbis"

SRC_URI="https://github.com/moai/moai-dev/archive/Version-${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/moai-dev-Version-${PV}"

KEYWORDS="~ppc ~arm64"

DESCRIPTION="Moai is a mobile game development platform."
HOMEPAGE="http://getmoai.com/"

LICENSE="CPAL-1.0"
SLOT="0"

PATCHES=("${FILESDIR}"/curl-sizeof-long.patch
	 "${FILESDIR}"/rgba-endian.patch
	 "${FILESDIR}"/curl-stropts.patch
	 "${FILESDIR}"/sysctl.patch)

CMAKE_USE_DIR="${S}/cmake"

RDEPEND="!luajit? ( >=dev-lang/lua-5.1.3 )
	luajit? ( dev-lang/luajit:2 )
	json? ( >=dev-libs/jansson-2.1 )
	crypto? ( >=dev-libs/openssl-1.0.0d )
	ssl? ( >=dev-libs/openssl-1.0.0d )
	tinyxml? ( dev-libs/tinyxml )
	media-libs/alsa-lib
	media-libs/freeglut
	truetype? ( >=media-libs/freetype-2.4.4 )
	>=media-libs/glew-1.5.6
	virtual/glu
	jpeg? ( virtual/jpeg )
	png? ( media-libs/libpng:0 )
	vorbis? ( >=media-libs/libvorbis-1.3.2 )
	virtual/opengl
	media-sound/pulseaudio
	curl? ( >=net-misc/curl-7.19.7 )
	sqlite? ( dev-db/sqlite:3 )"

DEPEND="${RDEPEND}
	chipmunk? ( ~dev-games/chipmunk-physics-5.3.4 )"

src_configure() {
	local mycmakeargs=(
		-DBUILD_LINUX=ON
		-DSDL_HOST=ON
		-DSSEMATH=OFF
		-DMOAI_BOX2D=ON
		-DMOAI_CHIPMUNK=$(usex chipmunk)
		-DMOAI_CURL=$(usex curl)
		-DMOAI_CRYPTO=$(usex crypto)
		-DMOAI_FREETYPE=$(usex truetype)
		-DMOAI_JSON=$(usex json)
		-DMOAI_JPG=$(usex jpeg)
		-DMOAI_LUAEXT=ON
		-DMOAI_LUAJIT=$(usex luajit)
		-DMOAI_OPENSSL=$(usex ssl)
		-DMOAI_PNG=$(usex png)
		-DMOAI_SQLITE3=$(usex sqlite)
		-DMOAI_TINYXML=$(usex tinyxml)
		-DMOAI_VORBIS=$(usex vorbis)
		-DMOAI_UNTZ=ON
	)
	cmake_src_configure
}

src_install() {
	dobin "${BUILD_DIR}"/host-sdl/moai || die
	if use examples; then
		docompress -x /usr/share/doc/${P}/examples
		docinto examples
		dodoc -r samples/*
	fi
}
