#!/bin/bash

#  BUILD DIRECTORY 
BUILD_DIR="$(pwd)/build"

if [[ -d "$BUILD_DIR" ]]
then
    rm -r "$BUILD_DIR";
fi 
mkdir "$BUILD_DIR"
cd "$BUILD_DIR"

# SOURCE
RIPPLE_ADDER="/home/pourya/Uni/term_3/Computer_Architecture_Lab/session_4/vhdl_description/adder/4bit/ripple_carry_adder/ripple_carry_adder_4bit.vhd"
FULL_ADDER="/home/pourya/Uni/term_3/Computer_Architecture_Lab/session_4/vhdl_description/adder/1bit/full_adder/full_adder.vhd"
DIVIDER="/home/pourya/Uni/term_3/Computer_Architecture_Lab/session_8/divider/naive/divider.vhd"
DIVIDER_TB="/home/pourya/Uni/term_3/Computer_Architecture_Lab/session_8/divider/naive/divider_tb.vhd"

#OTHER VARIABLES (CONSTANTS PRACTICALLY)
WAVE_FILE="${BUILD_DIR}/divider_wave.vcd"
TOP_MODULE="divider_tb"
STOP_TIME="1sec"
NUM=30


# GHDL 
ghdl -a $FULL_ADDER $RIPPLE_ADDER $DIVIDER $DIVIDER_TB 
ghdl -e $TOP_MODULE 
ghdl -r $TOP_MODULE --stop-time=$STOP_TIME --vcd=$WAVE_FILE -gNUM=$NUM


