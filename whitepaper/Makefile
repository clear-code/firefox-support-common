# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

TODAY=$(shell date +%Y%m%d)

VERIFY_MANUAL_OPT= -c assets/esr78.conf -a assets/esr78.var

# How to generate a PDF document:
#
#   $ sudo apt install texlive-full pandoc fonts-noto-cjk
#   $ make migration-report
#
PANDOC_OPT_PDF= -N --toc-depth=2 --table-of-contents -f markdown \
                --wrap=preserve \
                --template=eisvogel.tex \
                -V documentclass=ltjsarticle \
                -V classoption=titlepage \
                --pdf-engine=xelatex

PANDOC_OPT_DOCX= --toc-depth=2 --table-of-contents \
                 -f markdown+east_asian_line_breaks \
                 -t docx \
                 --reference-doc="$(BASE)/assets/template.docx"


all: thunderbird.pdf

thunderbird.pdf: build-always
	cat thunderbird.md | pandoc ${PANDOC_OPT_PDF} -o "thunderbird-$(TODAY).pdf"

clean:
	rm -f *.pdf

.PHONY: build-always
