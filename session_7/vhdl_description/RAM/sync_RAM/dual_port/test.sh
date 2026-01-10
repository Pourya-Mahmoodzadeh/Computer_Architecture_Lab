#!/bin/bash 

mux="/home/pourya/Uni/term_3/Computer_Architecture_Lab/session_4/vhdl_description/multiplexer/generic/rec/mux.vhd"
decoder_rec="/home/pourya/Uni/term_3/Computer_Architecture_Lab/session_7/vhdl_description/decoder/generic/decoder_rec.vhd"
D_latch="/home/pourya/Uni/term_3/Computer_Architecture_Lab/session_7/vhdl_description/latch/D/behavioral/reset_to_0/D_latch.vhd"
D_latch_async_fill="/home/pourya/Uni/term_3/Computer_Architecture_Lab/session_7/vhdl_description/latch/D/behavioral/reset_to_1/D_latch_async_fill.vhd"
minimal_D_FF="/home/pourya/Uni/term_3/Computer_Architecture_Lab/session_6/vhdl_description/flip_flop/minimal/behavioral/minimal_D_FF.vhd"
minimal_reg_nbit="/home/pourya/Uni/term_3/Computer_Architecture_Lab/session_6/vhdl_description/register/minimal/generic/minimal_reg_nbit.vhd"
word="/home/pourya/Uni/term_3/Computer_Architecture_Lab/session_7/vhdl_description/word/generic/word.vhd"
sync_GBRAM_FSM="/home/pourya/Uni/term_3/Computer_Architecture_Lab/session_7/vhdl_description/RAM/sync_RAM/sync_GBRAM_FSM.vhd"
sync_GBRAM="/home/pourya/Uni/term_3/Computer_Architecture_Lab/session_7/vhdl_description/RAM/sync_RAM/sync_GBRAM.vhd"
sync_GBRAM_tb="/home/pourya/Uni/term_3/Computer_Architecture_Lab/session_7/vhdl_description/RAM/sync_RAM/sync_GBRAM_tb.vhd"

BUILD_DIR="$(pwd)/build"
WAVE_FILE="${BUILD_DIR}/wave.vcd"
TOP_MODULE="sync_GBRAM_tb"
STOP_TIME="1sec"
STD="08"
DATA_WIDTH=4
ADDR_WIDTH=2
RANDOM_RNUM=5 
RANDOM_WNUM=5


mkdir "${BUILD_DIR}"
cd "${BUILD_DIR}"

ghdl -a --std=$STD $mux $decoder_rec $D_latch $D_latch_async_fill $minimal_D_FF $minimal_reg_nbit $word $sync_GBRAM_FSM $sync_GBRAM $sync_GBRAM_tb  
ghdl -e  --std=$STD $TOP_MODULE
ghdl -r $TOP_MODULE  -gDATA_WIDTH=$DATA_WIDTH -gADDR_WIDTH=$ADDR_WIDTH -gRANDOM_RNUM=$RANDOM_RNUM -gRANDOM_WNUM=$RANDOM_WNUM --stop-time=$STOP_TIME --vcd=$WAVE_FILE