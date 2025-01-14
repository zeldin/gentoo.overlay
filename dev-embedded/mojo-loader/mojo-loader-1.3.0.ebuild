EAPI=8

inherit java-pkg-2

DESCRIPTION="Loader for Mojo FPGA board"
HOMEPAGE="https://embeddedmicro.com/tutorials/mojo-software-and-updates/installing-mojo-loader"
SRC_URI="https://embeddedmicro.com/media/wysiwyg/mojo-loader/mojo-loader-1.3.0-linux64.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~arm64"

RDEPEND="
	>=virtual/jdk-1.7
	dev-java/swt:4.6
	dev-java/jssc:0
	virtual/udev"

src_install() {
	java-pkg_dojar lib/mojo-loader.jar
	java-pkg_register-dependency swt-4.6,jssc
	java-pkg_dolauncher ${PN} --main com.embeddedmicro.mojo.MainWindow
}
