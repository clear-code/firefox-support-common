# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

VERSION = 1.1

DATE=$(shell date +%Y%m%d)
UPDATES_PDF = "Firefox_$(DATE).pdf"
BASE=$(shell pwd)

VERIFY_MANUAL_OPT= -c assets/esr78.conf -a assets/esr78.var

# How to generate a PDF document:
#
#   $ sudo apt install texlive-full pandoc fonts-noto-cjk
#   $ make migration-report
#
PANDOC_OPT_PDF= -N --toc-depth=2 --table-of-contents \
                -f markdown \
                --wrap=preserve \
                --template=eisvogel.tex \
                -V documentclass=ltjsarticle \
                -V classoption=titlepage \
                --pdf-engine=xelatex

PANDOC_OPT_DOCX= --toc-depth=2 --table-of-contents \
                 -f markdown+east_asian_line_breaks \
                 -t docx \
                 --reference-doc="$(BASE)/assets/template.docx"


all: configurations-sheet

fetch-policies-schema:
	rm -f assets/policies-schema.json
	wget https://hg.mozilla.org/mozilla-central/raw-file/tip/browser/components/enterprisepolicies/schemas/policies-schema.json
	mv policies-schema.json assets/

list-untracked-policies:
	cat assets/policies-schema.json | jq -r 'select(.. | .properties?).properties | keys[]' | sort | uniq | while read key; do grep -r "\"$${key}\"" esr* >/dev/null 2>&1 || echo "$${key}"; done

list-unverified-configs:
	grep -h "\(^[A-Z]\|:[0-9]:\)" verify/*  | grep -v 事前準備 | grep -v '\-0' > list-verify.txt
	grep -h "\(^[A-Z]\|:[0-9]:\)" esr91/*  | grep -v 廃止 > list-esr91.txt
	diff -U 6 list-esr91.txt list-verify.txt

verify-targets-to-chapters.csv:
	./cat-verify ${VERIFY_MANUAL_OPT} -i > "$(PWD)/$@"

configurations-sheet: verify-targets-to-chapters.csv
	./build-xlsx -o config-$(DATE).xlsx -d ESR78:assets/esr78.conf -d ESR91:assets/esr91.conf -d "ESR91 派生:assets/esr91-variation.conf" verify-targets-to-chapters.csv

verification-manual:
	./cat-verify ${VERIFY_MANUAL_OPT} | pandoc ${PANDOC_OPT_DOCX} -o verify-$(DATE).docx
	./cat-verify ${VERIFY_MANUAL_OPT} -l > verify-$(DATE)-checklist.csv

migration-report: migration-report-docx migration-report-pdf

migration-report-docx:
	cd migration && cat esr91.md | pandoc ${PANDOC_OPT_DOCX} -o "../migration-report-esr91-$(DATE).docx"

migration-report-pdf:
	cd migration && cat esr91.md | pandoc ${PANDOC_OPT_PDF} -o "../migration-report-esr91-$(DATE).pdf"

clean:
	rm -f config-*.xlsx
	rm -f migration-report-*.docx migration-report-*.pdf
	rm -f verify-*.docx

.PHONY: fetch-policies-schema list-untracked-policies clean all verify-targets-to-chapters.csv configurations-sheet verification-manual migration-report
