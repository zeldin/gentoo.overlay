EAPI=8

DESCRIPTION="NVIDIA Jetson TX2 firmware package"
HOMEPAGE="https://developer.nvidia.com/embedded/linux-tegra"
MY_P="jetson_linux_r${PV}"
SRC_URI="http://developer.nvidia.com/downloads/embedded/l4t/r$(ver_cut 1)_release_v$(ver_cut 2-)/t186/${MY_P}_aarch64.tbz2"

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
