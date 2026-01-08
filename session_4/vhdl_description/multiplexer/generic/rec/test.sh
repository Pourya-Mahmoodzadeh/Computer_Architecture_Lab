#!/bin/bash

echo "Starting the test..."

SEL_WIDTH=(1 2 3)
DATA_WIDTH=(1 2 4 8)

DEST="$(pwd)/build"
SOURCE="$(pwd)"
SUMMARY="${DEST}/summary.txt"



UUT="${SOURCE}/mux.vhd"
TB="${SOURCE}/mux_tb.vhd"
TOP_MODULE="mux_tb"
STD="08"


if [[ -d "$DEST" ]]; then
    rm -r "$DEST"
fi


mkdir "$DEST"
cd "$DEST"
touch "${SUMMARY}"

ghdl -a  --std=$STD  "$UUT" "$TB"  | tee -a "$SUMMARY"
ghdl -e  --std=$STD "$TOP_MODULE"  | tee -a "$SUMMARY"

for SW in "${SEL_WIDTH[@]}"
do
    echo "Testing SEL_WIDTH = ${SW}" | tee -a "${SUMMARY}"
    HOT_DIR="${DEST}/sel=${SW}"
    REPORT_DIR="${HOT_DIR}/reports"
    WAVE_DIR="${HOT_DIR}/waveforms"

    mkdir $HOT_DIR
    mkdir -p "$WAVE_DIR"
    mkdir -p "$REPORT_DIR"


    for DW in "${DATA_WIDTH[@]}"
    do
        REPORT_FILE="${REPORT_DIR}/DATA_WIDTH=$DW"
        touch "$REPORT_FILE"
        echo "Initiating test for DATA_WIDTH = $DW" | tee -a "${SUMMARY}" "$REPORT_FILE"
        echo "" | tee -a "$SUMMARY" "$REPORT_FILE"
        ghdl -r $TOP_MODULE -gSEL_WIDTH=$SW -gDATA_WIDTH=$DW --vcd="${WAVE_DIR}/DATA_WIDTH=${DW}.vcd" --stop-time=120sec | tee -a "$SUMMARY" >> "$REPORT_FILE"
        echo "" | tee -a "$SUMMARY" "$REPORT_FILE"
        echo "Test for DATA_WIDTH=$DW is done."  | tee -a "$SUMMARY"
        echo "Testing done."  | tee -a "$SUMMARY" "$REPORT_FILE"   
    done

    echo "Done testing SEL_WIDTH = ${SW}"  | tee -a "$SUMMARY"
done

echo "Testing done."  | tee -a "$SUMMARY"
