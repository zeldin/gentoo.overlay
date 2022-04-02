# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5

inherit cmake-utils git-r3

IUSE="examples luajit"

EGIT_REPO_URI="https://github.com/spacepluk/moai-dev"
EGIT_BRANCH="linux-cmake"

KEYWORDS=""

DESCRIPTION="Moai is a mobile game development platform."
HOMEPAGE="http://getmoai.com/"

LICENSE="CPAL-1.0"
SLOT="0"

CMAKE_USE_DIR="${S}/cmake"

RDEPEND="!luajit? ( >=dev-lang/lua-5.1.3 )
	luajit? ( dev-lang/luajit:2 )
	>=dev-libs/jansson-2.1
	>=dev-libs/openssl-1.0.0d
	dev-libs/tinyxml
	media-libs/alsa-lib
	media-libs/freeglut
	>=media-libs/freetype-2.4.4
	>=media-libs/glew-1.5.6
	virtual/glu
	virtual/jpeg
	media-libs/libpng:0
	>=media-libs/libvorbis-1.3.2
	virtual/opengl
	media-sound/pulseaudio
	>=net-misc/curl-7.19.7"

DEPEND="${RDEPEND}
	~dev-games/chipmunk-physics-5.3.4"

src_unpack() {
	use luajit && EGIT_BRANCH="linux-luajit"
	git-r3_src_unpack
}

src_prepare() {
	use luajit && PATCHES=( "${FILESDIR}"/luajit-library-version.patch )
	cmake-utils_src_prepare
}

src_install() {
	dobin "${CMAKE_BUILD_DIR}"/src/hosts/moai-untz || die
	if use examples; then
		docompress -x /usr/share/doc/${P}/examples
		docinto examples
		dodoc -r samples/*
	fi
}
