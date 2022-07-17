EAPI=6

PYTHON_COMPAT=( python3_{5,6,7,8,9,10} )

inherit distutils-r1

DESCRIPTION="Package manager and build abstraction tool for FPGA/ASIC development"
HOMEPAGE="http://github.com/olofk/fusesoc"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~arm64 ~ppc64"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	>=dev-python/edalize-0.1.6[${PYTHON_USEDEP}]
	>=dev-python/ipyxact-0.2.3[${PYTHON_USEDEP}]
	>=dev-python/simplesat-0.8.0[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
"
DEPEND="
        dev-python/setuptools[${PYTHON_USEDEP}]
	${RDEPEND}
"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
