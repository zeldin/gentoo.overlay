EAPI=8

DESCRIPTION="Emulations (running on Linux/Unix/Windows/macOS, utilizing SDL2) of some - mainly - 8 bit machines, including the Commodore LCD, Commodore 65, and the MEGA65 as well."
HOMEPAGE="https://github.com/lgblgblgb/xemu"

EGIT_REPO_URI="https://github.com/lgblgblgb/xemu.git"
inherit git-r3
SRC_URI=""
KEYWORDS=""

LICENSE="GPL-2"
SLOT="0"

IUSE_DEFAULT_TARGETS="c65 clcd ep128 mega65 primo tvc"
IUSE_EXTRA_TARGETS="cx16 cvic20 cgeos"

IUSE=""
IUSE+="$(printf ' +target-%s' ${IUSE_DEFAULT_TARGETS})"
IUSE+="$(printf ' target-%s' ${IUSE_EXTRA_TARGETS})"

RDEPEND="media-libs/libsdl2 x11-libs/gtk+:3 sys-libs/readline"
DEPEND="${RDEPEND}"

src_prepare() {
  sed -i -e '/#define HAVE_MM_MALLOC/s:^:// :' xemu/emutools.h || die
  sed -i -e '/strip $(PRG)/d' build/Makefile.common || die
  sed -i -e '/^LDFLAGS_TARGET_xgeos/s/$/ -lm/' targets/cgeos/Makefile || die
  default
}

src_configure() {
  targets=
  for target in ${IUSE_DEFAULT_TARGETS} ${IUSE_EXTRA_TARGETS} ; do
    if use "target-${target}"; then
       targets+=" ${target}"
     fi
  done
  sed -i -e '/^TARGETS/s/=.*$/='"${targets}"'/' Makefile || die
  emake config
}

src_compile() {
  emake all
}

src_install() {
  emake INSTALL_BINDIR="${D}/usr/bin" install
}
