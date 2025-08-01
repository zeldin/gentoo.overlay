EAPI=8

PYTHON_COMPAT=( python3_{8..13} )
inherit python-single-r1

DESCRIPTION="Tools and Utilities for the MEGA65 Retro Computers"
HOMEPAGE="https://github.com/MEGA65/mega65-tools"

EGIT_REPO_URI="https://github.com/MEGA65/mega65-tools.git"
EGIT_BRANCH="development"
inherit git-r3
SRC_URI=""
KEYWORDS=""

LICENSE="GPL-3"
SLOT="0"
IUSE="static system-cc65 vnc"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	!static? ( sys-libs/ncurses sys-libs/readline )
	vnc? ( net-libs/libpcap net-libs/libvncserver )"
DEPEND="${RDEPEND}
        static? ( sys-libs/ncurses[static-libs]
		  sys-libs/readline[static-libs] )"
BDEPEND="system-cc65? ( dev-embedded/cc65 )"

src_prepare() {
	default
	test -d "${S}/src/mega65-libc/cc65/work" || mkdir "${S}/src/mega65-libc/cc65/work"
}

src_compile() {
	emake DO_STATIC=$(usex static 1 0) $(usex system-cc65 USE_LOCAL_CC65=1 "") DO_SMU=0 all $(usex vnc "bin/vncserver bin/videoproxy" "")
}

src_install() {
	dobin bin/m65
	dobin bin/mega65_ftp
	dobin bin/etherload
	dobin bin/bit2core
	dobin bin/bit2mcs
	dobin bin/romdiff
	python_newexe bin/coretool coretool
	if use vnc; then
		newbin bin/vncserver m65_vncserver
		newbin bin/videoproxy m65_videoproxy
	fi
}
