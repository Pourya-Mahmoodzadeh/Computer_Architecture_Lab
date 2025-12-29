#!/bin/bash

echo "Starting the test..."

WIDTHS=(1 2 3)

DEST="$(pwd)/build"
SOURCE="$(pwd)"
REPORT_DIR="${DEST}/reports"
WAVE_DIR="${DEST}/waveforms"



DEC_REC="${SOURCE}/decoder_rec.vhd"
DEC_REC_TB="${SOURCE}/decoder_rec_tb.vhd"
DEC_REC_TB_E="decoder_rec_tb"


if [[ -d "$DEST" ]]; then
    rm -r "$DEST"
else
    mkdir "$DEST"
fi
mkdir -p "$WAVE_DIR"
mkdir -p "$REPORT_DIR"

cd "$DEST"

ghdl -a  "$DEC_REC" "$DEC_REC_TB"
ghdl -e "$DEC_REC_TB_E"

for W in "${WIDTHS[@]}"
do
    REPORT_FILE="${REPORT_DIR}/width=$W"
    touch "$REPORT_FILE"
    echo "Initiating test for WIDTH = $W" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    ghdl -r $DEC_REC_TB_E -gwidth=$W --vcd="${WAVE_DIR}/width=${W}.vcd" --stop-time=120sec >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    echo "Test for width=$W is done."
    echo "Testing done." >> "$REPORT_FILE"   
done

echo "Testing done."
