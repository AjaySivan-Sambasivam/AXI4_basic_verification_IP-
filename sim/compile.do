vlib work
set SRC_DIR "D:/AMBA/AXI4_new/src"
set RTL_DIR "D:/AMBA/AXI4_new/rtl"

set INC_DIRS [list \
    +incdir+$SRC_DIR \
    +incdir+$SRC_DIR/packages \
    +incdir+$SRC_DIR/sb \
    +incdir+$SRC_DIR/tests \
    +incdir+$SRC_DIR/vseq \
    +incdir+$SRC_DIR/vseq/vsequencer \
    +incdir+$SRC_DIR/vseq/vsequences \
    +incdir+$SRC_DIR/sequences \
    +incdir+$SRC_DIR/sequences/master_sequences \
    +incdir+$SRC_DIR/sequences/slave_sequences \
    +incdir+$SRC_DIR/master \
    +incdir+$SRC_DIR/master/drivers/aw_channel \
    +incdir+$SRC_DIR/master/drivers/w_channel \
    +incdir+$SRC_DIR/master/drivers/b_channel \
    +incdir+$SRC_DIR/master/drivers/ar_channel \
    +incdir+$SRC_DIR/master/drivers/r_channel \
    +incdir+$SRC_DIR/master/monitors/aw_channel \
    +incdir+$SRC_DIR/master/monitors/w_channel \
    +incdir+$SRC_DIR/master/monitors/b_channel \
    +incdir+$SRC_DIR/master/monitors/ar_channel \
    +incdir+$SRC_DIR/master/monitors/r_channel \
    +incdir+$SRC_DIR/slave \
    +incdir+$SRC_DIR/slave/drivers \
    +incdir+$SRC_DIR/slave/drivers/aw_channel \
    +incdir+$SRC_DIR/slave/drivers/w_channel \
    +incdir+$SRC_DIR/slave/drivers/b_channel \
    +incdir+$SRC_DIR/slave/drivers/ar_channel \
    +incdir+$SRC_DIR/slave/drivers/r_channel \
    +incdir+$SRC_DIR/slave/monitors/aw_channel \
    +incdir+$SRC_DIR/slave/monitors/w_channel \
    +incdir+$SRC_DIR/slave/monitors/b_channel \
    +incdir+$SRC_DIR/slave/monitors/ar_channel \
    +incdir+$SRC_DIR/slave/monitors/r_channel \
]

eval vlog -sv -timescale=1ns/1ps $INC_DIRS "$RTL_DIR/*.sv" "$SRC_DIR/packages/*.sv" "$SRC_DIR/axi_tb_top.sv"
quit
