import os
import sys
import subprocess
import pytest
import openpyxl

BASEDIR = os.path.dirname(os.path.realpath(__file__))
sys.path.append(BASEDIR)

BUILD_XLSX_PATH = os.path.realpath(os.path.join(BASEDIR, "../../build-xlsx"))
TEST_PARAMS = [
    BUILD_XLSX_PATH, "-v", "-t", "-o", "config.xlsx", "-b", BASEDIR,
    "-d", "ESR91:esr91.conf", "-d", "ESR102:esr102.conf"
]

def test_privacy_3_1_conflict_with_privacy_1_3():
    result = subprocess.run(TEST_PARAMS, capture_output=True, text=True, check=True)
    workbook =  openpyxl.load_workbook(os.path.join(BASEDIR, "./config.xlsx"))
    sheet = workbook['基本設定']
    expected = [
        "Privacy-1-3 と Privacy-3-1 は同時に選択することができない項目です。",
        "Privacy-3-1 と Privacy-1-3 は同時に選択することができない項目です。",
        "Privacy-3-3 は Privacy-1-3 の適用により自動的に挙動が決まるため、選択していないと矛盾します。"
    ]
    comments = [sheet["I5"].comment.text, sheet["I11"].comment.text, sheet["I13"].comment.text]
    assert expected == comments
