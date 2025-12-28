#!/bin/bash

echo "Starting the test..."

WIDTHS=(2 4 8)

DEST="$(pwd)/build"
REPORT_DIR="${DEST}/reports"
WAVE_DIR="${DEST}/waveforms"



D_FF="/home/pourya/Uni/term 3/Computer_Architecture_Lab/session_6/vhdl_description/flip_flop/minimal/behavioral/D_FF.vhd"
MIN_REG_GEN="/home/pourya/Uni/term 3/Computer_Architecture_Lab/session_6/vhdl_description/register/minimal/generic/minimal_reg_nbit.vhd"
MIN_REG_GEN_TB="/home/pourya/Uni/term 3/Computer_Architecture_Lab/session_6/vhdl_description/register/minimal/generic/minimal_reg_nbit_tb.vhd"
MIN_REG_GEN_TB_E="minimal_reg_nbit_tb"


if [[ -d "$DEST" ]]; then
    rm -r "$DEST"
else
    mkdir "$DEST"
fi
mkdir -p "$WAVE_DIR"
mkdir -p "$REPORT_DIR"

cd "$DEST"

ghdl -a "$D_FF" "$MIN_REG_GEN" "$MIN_REG_GEN_TB"
ghdl -e "$MIN_REG_GEN_TB_E"
#echo "This is what that meant:"
# echo "${WIDTHS[@]}"

for W in "${WIDTHS[@]}"
do
    REPORT_FILE="${REPORT_DIR}/width=$W"
    touch "$REPORT_FILE"
    echo "Initiating test for WIDTH = $W" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    ghdl -r $MIN_REG_GEN_TB_E -gWIDTH=$W --vcd="${WAVE_DIR}/width=${W}.vcd" --stop-time=60sec >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    echo "Test for width=$W is done."
    echo "Testing done." >> "$REPORT_FILE"   
done

echo "Testing done."
