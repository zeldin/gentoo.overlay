EAPI=4

DESCRIPTION="NVIDIA Jetson TX1 firmware package"
HOMEPAGE="https://developer.nvidia.com/embedded/linux-tegra"
SRC_URI="http://developer.nvidia.com/embedded/dlc/l4t-jetson-tx1-driver-package-${PV//./-} -> l4t-jetson-tx1-driver-package-${PV}.tar.bz2"

SLOT="0"
KEYWORDS="arm arm64"
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
