EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Command line toolkit for working with Arduino hardware"
HOMEPAGE="http://http://inotool.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~arm64 ~ppc64"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	dev-embedded/arduino
	net-dialup/picocom
	>=dev-python/jinja-2[${PYTHON_USEDEP}]
	dev-python/pyserial[${PYTHON_USEDEP}]
	dev-python/configobj[${PYTHON_USEDEP}]
	dev-python/ordereddict[${PYTHON_USEDEP}]

"
DEPEND="
        dev-python/setuptools[${PYTHON_USEDEP}]
	${RDEPEND}
"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
