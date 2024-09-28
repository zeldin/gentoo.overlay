EAPI=7

inherit versionator

DESCRIPTION="NVIDIA Jetson TX1 firmware package"
HOMEPAGE="https://developer.nvidia.com/embedded/linux-tegra"
MY_P="Tegra210_Linux_R${PV}"
SRC_URI="http://developer.download.nvidia.com/embedded/L4T/r$(get_major_version)_Release_v$(get_after_major_version)/$(get_version_component_range 1-2)_64bit/t210ref_release_aarch64/${MY_P}_aarch64.tbz2"

SLOT="0"
KEYWORDS="-* arm arm64"
IUSE=""

S="${WORKDIR}/Linux_for_Tegra/nv_tegra"

src_unpack() {
    unpack ${A}
    cd "${S}"
    unpack ./nvidia_drivers.tbz2
}

src_install() {
    dodir /lib/firmware
    cp -R lib/firmware "${D}/lib/" || die "Install failed!"
}
