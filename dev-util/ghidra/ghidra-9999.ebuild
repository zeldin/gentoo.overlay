EAPI=8

inherit java-pkg-2 multiprocessing

DESCRIPTION="NSA software reverse engineering suite of tools"
HOMEPAGE="https://www.ghidra-sre.org/"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/NationalSecurityAgency/${PN}.git"
else
	SRC_URI="https://github.com/NationalSecurityAgency/${PN}/archive/Ghidra_${PV}_build.tar.gz"
	S="${WORKDIR}/${PN}-Ghidra_${PV}_build"
	KEYWORDS="~arm64 ~ppc64"
fi

SRC_URI+="
	https://github.com/pxb1988/dex2jar/releases/download/2.0/dex-tools-2.0.zip
   	https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/android4me/AXMLPrinter2.jar
        mirror://sourceforge/catacombae/hfsexplorer-0_21-bin.zip
	mirror://sourceforge/yajsw/yajsw-stable-12.12.zip
	https://services.gradle.org/distributions/gradle-5.0-bin.zip
"

# Dependencies which gradle would try to fetch if we let it
# (which would fail due to network sandbox)

SRC_URI+="
	https://repo.maven.apache.org/maven2/cglib/cglib-nodep/2.2/cglib-nodep-2.2.jar
	https://repo.maven.apache.org/maven2/ch/ethz/ganymed/ganymed-ssh2/262/ganymed-ssh2-262.jar
	https://repo.maven.apache.org/maven2/com/google/code/findbugs/jsr305/1.3.9/jsr305-1.3.9.jar
	https://repo.maven.apache.org/maven2/com/google/guava/guava/19.0/guava-19.0.jar
	https://repo.maven.apache.org/maven2/com/googlecode/json-simple/json-simple/1.1.1/json-simple-1.1.1.jar
	https://repo.maven.apache.org/maven2/com/toedter/jcalendar/1.4/jcalendar-1.4.jar
	https://repo.maven.apache.org/maven2/commons-cli/commons-cli/1.2/commons-cli-1.2.jar
	https://repo.maven.apache.org/maven2/javax/help/javahelp/2.0.05/javahelp-2.0.05.jar
	https://repo.maven.apache.org/maven2/junit/junit/4.12/junit-4.12.jar
	https://repo.maven.apache.org/maven2/msv/isorelax/20050913/isorelax-20050913.jar
	https://repo.maven.apache.org/maven2/msv/msv/20050913/msv-20050913.jar
	https://repo.maven.apache.org/maven2/msv/relaxngDatatype/20050913/relaxngDatatype-20050913.jar
	https://repo.maven.apache.org/maven2/msv/xsdlib/20050913/xsdlib-20050913.jar
	https://repo.maven.apache.org/maven2/net/java/dev/javacc/javacc/5.0/javacc-5.0.jar
	https://repo.maven.apache.org/maven2/net/java/dev/timingframework/timingframework/1.0/timingframework-1.0.jar
	https://repo.maven.apache.org/maven2/net/sf/jung/jung-algorithms/2.1.1/jung-algorithms-2.1.1.jar
	https://repo.maven.apache.org/maven2/net/sf/jung/jung-api/2.1.1/jung-api-2.1.1.jar
	https://repo.maven.apache.org/maven2/net/sf/jung/jung-graph-impl/2.1.1/jung-graph-impl-2.1.1.jar
	https://repo.maven.apache.org/maven2/net/sf/jung/jung-visualization/2.1.1/jung-visualization-2.1.1.jar
	https://repo.maven.apache.org/maven2/net/sf/sevenzipjbinding/sevenzipjbinding-all-platforms/9.20-2.00beta/sevenzipjbinding-all-platforms-9.20-2.00beta.jar
	https://repo.maven.apache.org/maven2/net/sf/sevenzipjbinding/sevenzipjbinding/9.20-2.00beta/sevenzipjbinding-9.20-2.00beta.jar
	https://repo.maven.apache.org/maven2/org/antlr/ST4/4.0.8/ST4-4.0.8.jar
	https://repo.maven.apache.org/maven2/org/antlr/antlr-master/3.5.2/antlr-master-3.5.2.pom
	https://repo.maven.apache.org/maven2/org/antlr/antlr-runtime/3.5.2/antlr-runtime-3.5.2.pom
	https://repo.maven.apache.org/maven2/org/antlr/antlr-runtime/3.5.2/antlr-runtime-3.5.2.jar
	https://repo.maven.apache.org/maven2/org/antlr/antlr/3.5.2/antlr-3.5.2.pom
	https://repo.maven.apache.org/maven2/org/antlr/antlr/3.5.2/antlr-3.5.2.jar
	https://repo.maven.apache.org/maven2/org/apache/commons/commons-collections4/4.1/commons-collections4-4.1.jar
	https://repo.maven.apache.org/maven2/org/apache/commons/commons-compress/1.18/commons-compress-1.18.jar
	https://repo.maven.apache.org/maven2/org/apache/commons/commons-lang3/3.5/commons-lang3-3.5.jar
	https://repo.maven.apache.org/maven2/org/apache/logging/log4j/log4j-api/2.8.2/log4j-api-2.8.2.jar
	https://repo.maven.apache.org/maven2/org/apache/logging/log4j/log4j-core/2.8.2/log4j-core-2.8.2.jar
	https://repo.maven.apache.org/maven2/org/hamcrest/hamcrest-all/1.3/hamcrest-all-1.3.jar
	https://repo.maven.apache.org/maven2/org/jdom/jdom-legacy/1.1.3/jdom-legacy-1.1.3.jar
	https://repo.maven.apache.org/maven2/org/jmockit/jmockit/1.44/jmockit-1.44.jar
	https://repo.maven.apache.org/maven2/org/lucee/commons-io/2.6.0/commons-io-2.6.0.jar
	https://repo.maven.apache.org/maven2/org/ow2/asm/asm-debug-all/4.1/asm-debug-all-4.1.jar
	https://repo.maven.apache.org/maven2/org/python/jython-standalone/2.7.1/jython-standalone-2.7.1.jar
	https://repo.maven.apache.org/maven2/org/sonatype/oss/oss-parent/9/oss-parent-9.pom
	https://jcenter.bintray.com/org/smali/baksmali/1.4.0/baksmali-1.4.0.pom
	https://jcenter.bintray.com/org/smali/baksmali/1.4.0/baksmali-1.4.0.jar
	https://jcenter.bintray.com/org/smali/dexlib/1.4.0/dexlib-1.4.0.pom
	https://jcenter.bintray.com/org/smali/dexlib/1.4.0/dexlib-1.4.0.jar
	https://jcenter.bintray.com/org/smali/util/1.4.0/util-1.4.0.pom
	https://jcenter.bintray.com/org/smali/util/1.4.0/util-1.4.0.jar
"

PATCHES=( "${FILESDIR}"/archs.patch
	  "${FILESDIR}"/types.patch )

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""
RESTRICT="splitdebug strip"

RDEPEND="virtual/jre:11
         app-shells/bash"

DEPEND="virtual/jdk:11"

WANT_JARS="
	csframework.jar
	hfsx_dmglib.jar
	hfsx.jar
        iharder-base64.jar
	dex-*.jar
"

extract_jars() {
  local archive="$1"
  local destdir="$2"
  local find_args=()
  for jar in ${WANT_JARS}; do
    find_args+=( -o -name ${jar} )
  done
  mkdir tmpunpack
  cd tmpunpack || die
  unpack "${archive}"
  find . '(' ${find_args[*]:1} ')' -print | while read jar; do
    echo ">>>> Copying ${jar} to ${destdir}"
    cp "${jar}" "${destdir}" || die
  done
  cd ..
  rm -rf tmpunpack
}

src_unpack() {
  local file
  local lib

  [[ ${PV} == *9999* ]] && git-r3_src_unpack
  mkdir flatRepo
  mkdir -p ghidra.bin/Ghidra/Features/GhidraServer
  for file in ${A}; do
    case ${file} in
      yajsw*.zip)
	cp "${DISTDIR}/${file}" ghidra.bin/Ghidra/Features/GhidraServer/ || die;;
      gradle*.zip)
	unpack ${file};;
      *.zip)
	extract_jars ${file} "${WORKDIR}/flatRepo";;
      *.jar|*.pom)
	cp "${DISTDIR}/${file}" flatRepo || die;;
      *)
	unpack ${file};;
    esac
  done
}

mvnify_package() {
  local group=$1
  local version=$2
  local pkg
  shift
  shift
  for pkg; do
    mkdir -p "${WORKDIR}/mvnRepo/${group}/${pkg}/${version}"
    mv "${WORKDIR}/flatRepo/${pkg}-${version}".* "${WORKDIR}/mvnRepo/${group}/${pkg}/${version}/" || die
  done
}

src_prepare() {
  default 
  # antlr and baksmali needs pom files to work, and flat repos do not
  # support them, so set up a local maven repo too...
  mvnify_package org/antlr 3.5.2 antlr antlr-master antlr-runtime
  mvnify_package org/sonatype/oss 9 oss-parent
  mvnify_package org/smali 1.4.0 baksmali dexlib util
  mkdir -p "${WORKDIR}/gradle_home/init.d"
  cat > "${WORKDIR}/gradle_home/init.d/repos.gradle" <<EOF
allprojects {
  repositories {
    maven { url "${WORKDIR}/mvnRepo" }
    flatDir name:'flat', dirs:["${WORKDIR}/flatRepo"]
  }
}
EOF
}

gradle() {
  "${WORKDIR}"/gradle-5.0/bin/gradle -g "${WORKDIR}"/gradle_home \
	--no-daemon --parallel --max-workers $(makeopts_jobs) --offline \
	"$@" || die
}

src_compile() {
  gradle yajswDevUnpack
  gradle buildGhidra
}

src_install() {
  insinto "/usr/$(get_libdir)"
  unzip -q "${S}/build/dist/"ghidra_*.zip -d "${D}/usr/$(get_libdir)/" || die
  local my_p=$(cd "${D}/usr/$(get_libdir)/" && ls -1)
  dosym "/usr/$(get_libdir)/${my_p}/${PN}Run" /usr/bin/${PN}
}
