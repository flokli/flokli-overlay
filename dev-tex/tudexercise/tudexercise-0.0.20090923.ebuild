inherit latex-package

TUDDESIGNHOME="http://exp1.fkp.physik.tu-darmstadt.de/tuddesign"
DESCRIPTION="LaTeX docment class for exercise sheets using the TUD-Design"
HOMEPAGE="http://exp1.fkp.physik.tu-darmstadt.de/tuddesign"
SRC_URI="${TUDDESIGNHOME}/latex/latex-tuddesign/latex-tuddesign_0.0.20090923.zip"
KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="as-is"
IUSE="examples"
RESTRICT="mirror"
DEPEND="app-arch/unzip
		dev-tex/tuddesign-common
		dev-tex/tudfonts-tex
		dev-tex/tudposter
		dev-tex/tudreport"

src_install() {
	TEX_SRC="${WORKDIR}/texmf/tex"
	DOC_SRC="${WORKDIR}/texmf/doc/latex/tuddesign"
	TEXMF_DIST_DIR="/usr/share/texmf-dist"
	TUDDESIGN_DST_DIR="${TEXMF_DIST_DIR}/tex/latex/tuddesign"
	EXERCISE_SRC="${TEX_SRC}/latex/tuddesign/exercise
				  ${TEX_SRC}/latex/tuddesign/tudexercise.cls"

	dodir ${TUDDESIGN_DST_DIR}
	cp -R ${EXERCISE_SRC} ${D}/${TUDDESIGN_DST_DIR} \
		|| die failed to copy exercise

	cd $DOC_SRC
	dodoc copyright changelog TUD_doc.pdf
	if use examples ; then
		EXAMPLES_DIR="/usr/share/doc/${PF}/examples"
		dodir ${EXAMPLES_DIR}
		cp examples/tudexercise/* ${D}/${EXAMPLES_DIR} || die failed to copy examples
	fi
}
