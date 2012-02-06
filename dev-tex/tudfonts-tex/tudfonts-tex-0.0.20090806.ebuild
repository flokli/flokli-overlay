inherit latex-package

TUDDESIGNHOME="http://exp1.fkp.physik.tu-darmstadt.de/tuddesign"
DESCRIPTION="Required LaTeX fonts for the corporate design of the TU Darmstadt"
HOMEPAGE="http://exp1.fkp.physik.tu-darmstadt.de/tuddesign"
SRC_URI="${TUDDESIGNHOME}/latex/tudfonts-tex/tudfonts-tex_0.0.20090806.zip"
KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="proprietary"
IUSE=""
RESTRICT="mirror"
DEPEND="app-arch/unzip"

src_install() {
	UPDMAP_SRC_CFG="${WORKDIR}/texmf/updmap.d/20tex-tudfonts.cfg"
	FONTS_SRC="${WORKDIR}/texmf/fonts"
	TEX_SRC="${WORKDIR}/texmf/tex"
	UPDMAP_DST_DIR="/etc/texmf/updmap.d"
	TEXMF_DIST_DIR="/usr/share/texmf-dist"

	insinto "${UPDMAP_DST_DIR}"
	doins "${UPDMAP_SRC_CFG}"

	dodir "${TEXMF_DIST_DIR}"
	cp -R "${FONTS_SRC}" "${D}/${TEXMF_DIST_DIR}" || die failed to copy fonts
	cp -R "${TEX_SRC}" "${D}/${TEXMF_DIST_DIR}" || die failed to copy tex
}

