inherit latex-package

TUDDESIGNHOME="http://exp1.fkp.physik.tu-darmstadt.de/tuddesign"
DESCRIPTION="Common files of the TUD-Design LaTeX document classes"
HOMEPAGE="http://exp1.fkp.physik.tu-darmstadt.de/tuddesign"
SRC_URI="${TUDDESIGNHOME}/latex/latex-tuddesign/latex-tuddesign_0.0.20090923.zip"
KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="as-is"
IUSE=""
RESTRICT="mirror"
DEPEND="app-arch/unzip
		dev-texlive/texlive-latexextra
		dev-texlive/texlive-latexrecommended
		dev-texlive/texlive-latex
		dev-tex/xcolor"

src_install() {
	TEX_SRC="${WORKDIR}/texmf/tex"
	TEXMF_DIST_DIR="/usr/share/texmf-dist"
	TUDDESIGN_DST_DIR="${TEXMF_DIST_DIR}/tex/latex/tuddesign"
	COMMON_SRC="${TEX_SRC}/latex/tuddesign/base
				${TEX_SRC}/latex/tuddesign/colours
				${TEX_SRC}/latex/tuddesign/logo"

	dodir ${TUDDESIGN_DST_DIR}
	cp -R ${COMMON_SRC} ${D}/${TUDDESIGN_DST_DIR} \
		|| die failed to copy common
}

