EAPI=5

inherit unpacker

DESCRIPTION="LabNation SmartScope"
HOMEPAGE="http://www.lab-nation.com/"
SRC_URI="https://www.lab-nation.com/package/SmartScope/${PV//.//}/Linux/get -> SmartScope-Linux-${PV//./-}.deb"
QA_PREBUILT="*"
S=${WORKDIR}

SLOT="0"
KEYWORDS="~ppc"
IUSE=""

RDEPEND="dev-lang/mono
         >=media-libs/sdl-mixer-1.2:0"

DEPEND="${RDEPEND}"

src_unpack() {
        unpack_deb ${A}
}

src_prepare() {
	# QA: udev rules should go in lib
	[ -d etc ] && mv etc lib

	# Disable broken XInput integration
	sed -i -e '/os="linux" dll="libXi"/s:"/>:.disabled&:' opt/smartscope/OpenTK.dll.config
}

src_install() {
        mv * "${D}" || die
}

