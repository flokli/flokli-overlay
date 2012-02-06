inherit latex-package

TUDDESIGNHOME="http://exp1.fkp.physik.tu-darmstadt.de/tuddesign"
DESCRIPTION="LaTeX document class for thesis documents following the TUD-Design"
HOMEPAGE="http://exp1.fkp.physik.tu-darmstadt.de/tuddesign"
SRC_URI="${TUDDESIGNHOME}/latex/latex-tuddesign-thesis/latex-tuddesign-thesis_0.0.20090714.zip"
KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="as-is"
IUSE="examples"
RESTRICT="mirror"
DEPEND="app-arch/unzip
		dev-tex/tuddesign-common
		dev-tex/tudfonts-tex
		dev-tex/tudreport"

src_install() {
	TEX_SRC="${WORKDIR}/texmf/tex"
	DOC_SRC="${WORKDIR}/texmf/doc/latex/tuddesign"
	TEXMF_DIST_DIR="/usr/share/texmf-dist"
	TUDDESIGN_DST_DIR="${TEXMF_DIST_DIR}/tex/latex/tuddesign"
	THESIS_SRC="${TEX_SRC}/latex/tuddesign/thesis
				${TEX_SRC}/latex/tuddesign/tudthesis.cls"

	dodir ${TUDDESIGN_DST_DIR}
	cp -R ${THESIS_SRC} ${D}/${TUDDESIGN_DST_DIR} \
		|| die failed to copy thesis

	cd ${DOC_SRC}
	dodoc copyright changelog TUDthesis.pdf
	if use examples ; then
		EXAMPLES_DIR="/usr/share/doc/${PF}/examples"
		dodir ${EXAMPLES_DIR}
		cp TUDthesis.pdf TUDthesis.ps TUDthesis.tex ${D}/${EXAMPLES_DIR} || die failed to copy examples
	fi
}
