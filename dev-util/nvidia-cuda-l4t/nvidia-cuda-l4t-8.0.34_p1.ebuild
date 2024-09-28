EAPI=7

inherit unpacker

DESCRIPTION="NVIDIA CUDA for Tegra"
HOMEPAGE="https://developer.nvidia.com/embedded/linux-tegra"
MY_PV1="$(ver_cut 1-2 $(ver_rs 1 '-'))"
MY_PV2="${PV//_p/-}"
SRC_URI="http://developer.download.nvidia.com/devzone/devcenter/mobile/jetpack_l4t/006/linux-x64/cuda-repo-l4t-${MY_PV1}-local_${MY_PV2}_arm64.deb"

SLOT="$(ver_cut 1-2 $(ver_rs 1 '.'))"
KEYWORDS="-* arm64"
IUSE=""

S="${WORKDIR}/var/cuda-repo-${MY_PV1}-local"

src_unpack() {
    unpack_deb ${A}
    cd "${S}"
    local deb
    for deb in ./*.deb; do
	unpack_deb ${deb}
    done
}

src_install() {
    dodir /etc
    dodir /usr
    cp -R etc "${D}/" || die "Install failed!"
    cp -R usr "${D}/" || die "Install failed!"
}
