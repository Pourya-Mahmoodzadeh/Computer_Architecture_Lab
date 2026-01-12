#!/bin/bash 

#directory
BUILD_DIR="/home/pourya/Uni/term_3/Computer_Architecture_Lab/session_7/vhdl_description/similarity_checker/generic/build"
if [[ -d "$BUILD_DIR" ]]
then 
    rm -r "$BUILD_DIR"
fi

# source 
SRC2="/home/pourya/Uni/term_3/Computer_Architecture_Lab/session_7/vhdl_description/similarity_checker/generic/simillarity_checker.vhd"
SRC3="/home/pourya/Uni/term_3/Computer_Architecture_Lab/session_7/vhdl_description/similarity_checker/generic/simillarity_checker_tb.vhd"
SRC1="/home/pourya/Uni/term_3/Computer_Architecture_Lab/session_7/vhdl_description/AND/generic_and.vhd"

# files 
REP_SUM="${BUILD_DIR}/summary.txt"

# parameters
NUM=20
DATA_WIDTHS=(2 3 4 8)
SEED1=1
SEED2=2
TOP_MOD="simillarity_checker_tb"
STOP_TIME="1sec"

# starting the build 

mkdir "$BUILD_DIR"
touch "$REP_SUM"

echo "Starting the build" | tee -a "$REP_SUM"

cd "$BUILD_DIR"

ghdl -a $SRC1 $SRC2 $SRC3 | tee -a "$REP_SUM"
ghdl -e $TOP_MOD | tee -a "$REP_SUM"

for W in "${DATA_WIDTHS[@]}"
do
    HOT_DIR="${BUILD_DIR}/width=$W"
    WAVE_FILE="${HOT_DIR}/wave.vcd"
    REPORT_FILE="${HOT_DIR}/report.txt"

    mkdir "$HOT_DIR"
    touch "$REPORT_FILE"

    ghdl -r $TOP_MOD -gDATA_WIDTH=$W -gNUM=$NUM -gSEED1=$SEED1 -gSEED2=$SEED2 --stop-time=$STOP_TIME --vcd="$WAVE_FILE" | tee -a "$REPORT_FILE" "$REP_SUM"
done
