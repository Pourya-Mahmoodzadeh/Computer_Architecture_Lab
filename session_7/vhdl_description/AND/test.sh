#!/bin/bash 

# build directory 
BUILD_DIR="$(pwd)/build"

if [[ -d "$BUILD_DIR" ]]
then 
    rm -r "$BUILD_DIR"
fi

# source and top module
SRC1="/home/pourya/Uni/term_3/Computer_Architecture_Lab/session_7/vhdl_description/AND/generic_and.vhd"
SRC2="/home/pourya/Uni/term_3/Computer_Architecture_Lab/session_7/vhdl_description/AND/generic_and_tb.vhd"
TOP_MOD="generic_and_tb"

# parameters
NUM=30
WIDTHS=(3 4 5 8)
SEED1=1
SEED2=2
STOP_TIME="1sec"

# reading non-important info. Can be safely and easily removed for convineice later 
# echo "Please enter number of iterations."
# read NUM
# echo "Please provide the two seeds"
# read SEED1
# read SEED2

# Starting the test
echo "Starting to build."
mkdir "$BUILD_DIR"
cd "$BUILD_DIR"
ghdl -a "$SRC1" "$SRC2"
ghdl -e "$TOP_MOD"

#starting the test
echo "Build done. Starting the test."
for W in "${WIDTHS[@]}"
do 
    HOT_DIR="${BUILD_DIR}/width=$W"
    WAVE_FILE="${HOT_DIR}/wave.vcd"
    REPORT_FILE="${HOT_DIR}/report.txt"

    mkdir "$HOT_DIR"
    touch "$REPORT_FILE"

    ghdl -r "$TOP_MOD" -gNUM=$NUM -gWIDTH=$W -gSEED1=$SEED1 -gSEED2=$SEED2 --stop-time=$STOP_TIME --vcd="$WAVE_FILE" | tee -a "$REPORT_FILE"
done
