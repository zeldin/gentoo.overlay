EAPI=8

inherit unpacker

DESCRIPTION="NVIDIA CUDA for Tegra"
HOMEPAGE="https://developer.nvidia.com/embedded/linux-tegra"
MY_PV1="$(ver_cut 1-2 $(ver_rs 1 '-'))"
MY_PV2="$(ver_rs 3 _)"
MY_PV2="${MY_PV2//_p/-}"
SRC_URI="https://developer.nvidia.com/assets/embedded/secure/tools/files/jetpack-sdks/jetpack-4.5.1/jetpack_451_b17/cuda-repo-l4t-${MY_PV1}-local-${MY_PV2}_arm64.deb"
RESTRICT="fetch"

SLOT="$(ver_cut 1-2 $(ver_rs 1 '.'))"
KEYWORDS="-* arm64"
IUSE=""

S="${WORKDIR}/var/cuda-repo-${MY_PV1}-local-$(ver_cut 1-3)"

src_unpack() {
    unpack_deb ${A}
    cd "${S}"
    local deb
    for deb in ./*.deb; do
	unpack_deb ${deb}
    done
    mv usr/lib/aarch64-linux-gnu/* usr/local/cuda-*/targets/aarch64-linux/lib/
    rmdir usr/lib/aarch64-linux-gnu
    mv usr/include/* usr/local/cuda-*/targets/aarch64-linux/include/
    rmdir usr/include
}


src_install() {
    dodir /etc
    dodir /usr
    cp -R etc "${D}/" || die "Install failed!"
    cp -R usr "${D}/" || die "Install failed!"
}

pkg_nofetch() {
    einfo "Please download"
    einfo "  ${SRC_URI}"
    einfo "and place in your DISTDIR directory."
}
