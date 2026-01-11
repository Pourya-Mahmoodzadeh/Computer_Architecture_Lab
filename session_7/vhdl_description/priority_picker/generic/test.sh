#!/bin/bash

# build directory 
BUILD_DIR="$(pwd)/build"
if [[ -d "$BUILD_DIR" ]]
then
    rm -r "$BUILD_DIR"
fi
mkdir "$BUILD_DIR"

# source 
SRC1="$(pwd)/priority_picker.vhd"
SRC2="$(pwd)/priority_picker_tb.vhd"

# other vhdl related stuff 
TOP_MODULE="priority_picker_tb"
NUM=40
WIDTH=(4 5 6)

# Starting the simulation
echo "Enter number of random tests."
read NUM
echo "NUM = ${NUM}"
cd "${BUILD_DIR}"


ghdl -a "$SRC1" "$SRC2"
ghdl -e $TOP_MODULE


for W in "${WIDTH[@]}"
do 
    HOT_DIR="${BUILD_DIR}/width=${W}"
    mkdir $HOT_DIR
    WAVE_FILE="${HOT_DIR}/wave.vcd"
    ghdl -r $TOP_MODULE -gNUM=$NUM -gWIDTH=$W --vcd="${WAVE_FILE}" --stop-time=1sec

done

