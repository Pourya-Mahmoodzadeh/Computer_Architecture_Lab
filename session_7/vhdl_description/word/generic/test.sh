#!/bin/bash

echo "Initiating the test..."

# Directories
WORD_DIR="$(pwd)"
BUILD_DIR="$(pwd)/build"
LATCH_DIR="$(pwd)/../../latch/D/behavioral"

# Files
LATCH0="${LATCH_DIR}/reset_to_0/D_latch.vhd"
LATCH1="${LATCH_DIR}/reset_to_1/D_latch_async_fill.vhd"
WORD="${WORD_DIR}/word.vhd"
WORD_TB="${WORD_DIR}/word_tb.vhd"
TOP_MOD="word_tb"

# setting up the environment
if [[ -d "${BUILD_DIR}" ]]
then
    rm -r "${BUILD_DIR}"
fi
mkdir "$BUILD_DIR"
cd "$BUILD_DIR"

# ghdl running and elaboration
ghdl -a "$LATCH0" "$LATCH1" "${WORD}" "${WORD_TB}"
ghdl -e $TOP_MOD

#loop variables
WORD_SIZE=(4 8 9 10)
RESET_TO=(0 1 2 3 4 8 10 13 15)

# The loop itself
for WS in "${WORD_SIZE[@]}"
do
    HOT_DIR="$(pwd)/word_size=$WS"
    mkdir -p "$HOT_DIR"
    
    WAVE_DIR="${HOT_DIR}/waveforms"
    REPORT_DIR="${HOT_DIR}/reports"
    mkdir "$WAVE_DIR" "$REPORT_DIR"

    for RS in "${RESET_TO[@]}" 
    do

        REPORT_FILE="${REPORT_DIR}/reset_to_bin=$(echo "obase=2;${RS}" | bc).txt"
        touch "$REPORT_FILE"

        ghdl -r $TOP_MOD -gword_size=$WS -greset_to_int_form=$RS --stop-time=20sec --vcd="${WAVE_DIR}/reset_to_bin=$(echo "obase=2;${RS}" | bc).vcd" >> "${REPORT_FILE}"
    done

    echo "Tested: word_size = $WS"
done

echo "Testing done"




