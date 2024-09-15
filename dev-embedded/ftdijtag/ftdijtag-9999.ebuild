EAPI=7

inherit git-r3

EGIT_REPO_URI="https://github.com/BerkeleyLab/XVC-FTDI-JTAG"

SLOT="0"
KEYWORDS="ppc64"
IUSE=""
LICENSE="BSD"

DESCRIPTION="Xilinx virtual cable server for generic FTDI 4232H"
HOMEPAGE="https://github.com/BerkeleyLab/XVC-FTDI-JTAG"

RDEPEND="dev-libs/libusb:1"
DEPEND="${RDEPEND}"

src_install() {
  dobin ftdiJTAG
  doman ftdiJTAG.1
}
