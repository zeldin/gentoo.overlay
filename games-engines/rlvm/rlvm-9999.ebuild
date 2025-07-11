EAPI=8

PYTHON_COMPAT=( python3_{8..13} )

inherit python-any-r1 scons-utils toolchain-funcs gnome2-utils

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="https://github.com/eglaysher/${PN}.git"
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="https://github.com/eglaysher/${PN}/archive/release-${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-release-${PV}"
	KEYWORDS="~ppc ~arm64"
fi

LICENSE="GPL-3+"
SLOT="0"

IUSE="lua"
LANGS="en ja"

for X in ${LANGS} ; do
        IUSE="${IUSE} linguas_${X}"
done

RDEPEND="media-fonts/monafont[truetype]
         media-fonts/dejavu
         >=dev-libs/boost-1.40.0
	 >=media-libs/freetype-2
         media-libs/libogg
         media-libs/libvorbis
         media-libs/libmad
         media-libs/libsdl
         media-libs/sdl-image[png,jpeg]
         media-libs/sdl-mixer[vorbis,mad]
         media-libs/sdl-ttf
         media-libs/glew
         dev-games/guichan[opengl,sdl]
         lua? ( dev-lang/lua )"

DEPEND="$RDEPEND dev-util/pkgconf"

PATCHES=(
	"${FILESDIR}"/fontpath.patch
	"${FILESDIR}"/iostream.patch
	"${FILESDIR}"/memory.patch
)

src_configure() {
      MYSCONS=(
              CXX="$(tc-getCXX)"
              BUILD_LUA_TESTS=$(usex lua True False)
              --release
      )
}

src_compile() {
      escons "${MYSCONS[@]}"
}

src_test() {
      cd "${S}"
      ./build/rlvm_unittests || die "At least one test failed"
}

locale_install() {
        insinto /usr/share/locale/$@/LC_MESSAGES/
        doins build/locale/$@/LC_MESSAGES/rlvm.mo
}

src_install() {
      dobin build/release/rlvm
      domenu src/platforms/gtk/rlvm.desktop
      for res in 16 24 32 48 128 256 ; do
              insinto /usr/share/icons/hicolor/${res}x${res}/apps
              doins resources/${res}/rlvm.png
      done
      strip-linguas ${LANGS}
      local l
      for l in ${LANGS}; do
           if [ "$l" != "en" ]; then
                use linguas_$l && locale_install $l
           fi
      done
}

pkg_preinst() {
        gnome2_icon_savelist
}

pkg_postinst () {
        gnome2_icon_cache_update
}

pkg_postrm() {
        gnome2_icon_cache_update
}
