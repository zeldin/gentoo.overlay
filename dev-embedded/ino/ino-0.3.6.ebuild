EAPI=8

PYTHON_COMPAT=( python2_7 )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Command line toolkit for working with Arduino hardware"
HOMEPAGE="http://http://inotool.org/"
SRC_URI="$(pypi_sdist_url ${PN^} ${PV})"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~arm64 ~ppc64"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	dev-embedded/arduino
	net-dialup/picocom
	>=dev-python/jinja2-2[${PYTHON_USEDEP}]
	dev-python/pyserial[${PYTHON_USEDEP}]
	dev-python/configobj[${PYTHON_USEDEP}]

"
DEPEND="
        dev-python/setuptools[${PYTHON_USEDEP}]
	${RDEPEND}
"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
