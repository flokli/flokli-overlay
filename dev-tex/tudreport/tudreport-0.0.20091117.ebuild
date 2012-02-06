inherit latex-package

TUDDESIGNHOME="http://exp1.fkp.physik.tu-darmstadt.de/tuddesign"
DESCRIPTION="LaTeX document class for generic text following following the TUD-Design"
HOMEPAGE="http://exp1.fkp.physik.tu-darmstadt.de/tuddesign"
SRC_URI="${TUDDESIGNHOME}/latex/latex-tuddesign/latex-tuddesign_0.0.20091117.zip"
KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="as-is"
IUSE="examples"
RESTRICT="mirror"
DEPEND="app-arch/unzip
		dev-tex/tuddesign-common
		dev-tex/tudfonts-tex
		dev-texlive/texlive-fontsextra"

src_install() {
	TEX_SRC="${WORKDIR}/texmf/tex"
	DOC_SRC="${WORKDIR}/texmf/doc/latex/tuddesign"
	TEXMF_DIST_DIR="/usr/share/texmf-dist"
	TUDDESIGN_DST_DIR="${TEXMF_DIST_DIR}/tex/latex/tuddesign"
	REPORT_SRC="${TEX_SRC}/latex/tuddesign/report
				${TEX_SRC}/latex/tuddesign/tudreport.cls"

	dodir ${TUDDESIGN_DST_DIR}
	cp -R ${REPORT_SRC} ${D}/${TUDDESIGN_DST_DIR} \
		|| die failed to copy report

	cd $DOC_SRC
	dodoc copyright changelog TUD_doc.pdf
	if use examples ; then
		EXAMPLES_DIR="/usr/share/doc/${PF}/examples"
		dodir ${EXAMPLES_DIR}
		cp examples/tudreport/* ${D}/${EXAMPLES_DIR} || die failed to copy examples
	fi
}

