EAPI=6

inherit versionator

DESCRIPTION="NVIDIA Jetson TX2 firmware package"
HOMEPAGE="https://developer.nvidia.com/embedded/linux-tegra"
MY_P="Tegra186_Linux_R${PV}"
SRC_URI="http://developer.download.nvidia.com/embedded/L4T/r$(get_major_version)_Release_v$(get_after_major_version)/t186ref_release_aarch64/${MY_P}_aarch64.tbz2"

SLOT="0"
KEYWORDS="-* arm arm64"
IUSE=""

DEPEND="|| ( <app-arch/bzip2-1.0.6 >=app-arch/bzip2-1.0.8 )"

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
