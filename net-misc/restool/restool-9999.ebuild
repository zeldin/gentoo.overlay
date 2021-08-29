EAPI=7

inherit git-r3

EGIT_REPO_URI="https://source.codeaurora.org/external/qoriq/qoriq-components/restool"
EGIT_BRANCH="integration"

KEYWORDS="arm64"
IUSE="man"

DESCRIPTION="DPAA2 Resource Manager Tool"

LICENSE="BSD"
SLOT="0"

RDEPEND="app-shells/bash sys-apps/dtc"
BDEPEND="man? ( app-text/pandoc )"

pkg_setup() {
    MAKEOPTS+=" prefix=/usr "
}

src_prepare() {
        default
	if ! use man; then
		sed -i -e '/call get_manpage_destination/d' -e '/^MANPAGE/d' Makefile
	fi
}
