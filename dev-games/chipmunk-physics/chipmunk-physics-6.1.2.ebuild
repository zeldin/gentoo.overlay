# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=8

inherit cmake

SRC_URI="http://chipmunk-physics.net/release/Chipmunk-6.x/Chipmunk-${PV}.tgz"

KEYWORDS="~ppc"

DESCRIPTION="Chipmunk is a fast, free, and lightweight 2D physics library written in C."
HOMEPAGE="http://chipmunk-physics.net/"

LICENSE="MIT"
SLOT="0"
IUSE=""

S="${WORKDIR}/Chipmunk-${PV}"

RDEPEND=""

DEPEND="${RDEPEND}"
