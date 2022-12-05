EAPI=6

DESCRPTION="Metamail replacement using mutt"
SRC_URI="https://www.spinnaker.de/mutt/metamutt -> ${P}"
HOMEPAGE="https://www.spinnaker.de/mutt/#metamutt"

SLOT="0"
LICENSE="GPL-2+"
KEYWORDS="arm64 ppc64"
IUSE=""

RDEPEND="mail-client/mutt[mbox]
         mail-filter/procmail[mbox]"

S="${WORKDIR}"

src_install() {
	newbin "${DISTDIR}/${P}" metamutt
}
