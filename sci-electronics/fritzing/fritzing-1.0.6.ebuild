EAPI=8

inherit qmake-utils xdg git-r3

EGIT_REPO_URI="https://github.com/fritzing/fritzing-app"
EGIT_COMMIT="04e5bb0241e8f1de24d0fce9be070041c6d5b68e"

PARTS_EGIT_REPO_URI="https://github.com/fritzing/fritzing-parts"
PARTS_EGIT_COMMIT="73bc0559bb8399b2f895d68f032e41d7efc720c0"

DESCRIPTION="Electronic Design Automation"
HOMEPAGE="
	https://fritzing.org/
	https://github.com/fritzing/fritzing-app/
"
SRC_URI="
	https://github.com/svgpp/svgpp/archive/refs/tags/v1.3.1.tar.gz -> svgpp-1.3.1.tar.gz
"
LICENSE="CC-BY-SA-3.0 GPL-3+ Boost-1.0"
SLOT="0"
KEYWORDS="~arm64 ~ppc64"

RDEPEND="
	dev-libs/quazip:0=[qt6(+)]
	sci-electronics/ngspice
	sci-mathematics/polyclipping
	dev-libs/libgit2:=
	dev-qt/qtbase:6[concurrent,gui,network,sql,sqlite,widgets,xml]
	dev-qt/qtserialport:6
	dev-qt/qtsvg:6
"
DEPEND="${RDEPEND}
	dev-libs/boost
"

PATCHES=(
	"${FILESDIR}/0001-Quick-Dirty-patch-to-allow-finding-quazip-qt6-on-Gentoo.patch"
	"${FILESDIR}/0002-Quick-Dirty-patch-to-allow-finding-ngspice-on-Gentoo.patch"
	"${FILESDIR}/0003-Quick-Dirty-patch-to-allow-finding-Clipper1-on-Gentoo.patch"
	"${FILESDIR}/0004-Work-around-build-issues-with-Qt-6.9.patch"
	"${FILESDIR}/0005-Fix-build-with-Qt-6.10.patch"
	"${FILESDIR}/qt_version.patch"
)

src_unpack() {
	default
	git-r3_src_unpack
	git-r3_fetch "${PARTS_EGIT_REPO_URI}" "${PARTS_EGIT_COMMIT}" "${CATEGORY}/${PN}-parts/${SLOT%/*}"
	git-r3_checkout "${PARTS_EGIT_REPO_URI}" "${WORKDIR}/fritzing-parts" "${CATEGORY}/${PN}-parts/${SLOT%/*}"
}

src_prepare() {
	default

	# Disable broken font scaling (#3221)
	sed -i 's/Exec=Fritzing/Exec=env QT_AUTO_SCREEN_SCALE_FACTOR=0 Fritzing/' org.fritzing.Fritzing.desktop
}

src_configure() {
	eqmake6 'DEFINES=QUAZIP_INSTALLED PARTS_COMMIT=\\\"'"${PARTS_COMMIT}"'\\\"' phoenix.pro
}

src_install() {
	PARTS_DIR="${WORKDIR}/fritzing-parts"
	INSTALL_ROOT="${D}" default
	insinto /usr/share/fritzing/fritzing-parts
	doins -r ${PARTS_DIR}/*
	doins -r ${PARTS_DIR}/.git
	"${D}"/usr/bin/Fritzing \
	    -db "${D}"/usr/share/fritzing/fritzing-parts/parts.db \
	    -pp "${D}"/usr/share/fritzing/fritzing-parts \
	    -f  "${D}"/usr/share/fritzing \
	    -platform offscreen
	rm -rf "${D}"/usr/share/fritzing/fritzing-parts/.git
	einstalldocs
}
