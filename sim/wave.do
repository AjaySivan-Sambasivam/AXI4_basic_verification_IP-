onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /axi_tb_top/clk
add wave -noupdate -radix unsigned /axi_tb_top/rstn
add wave -noupdate -expand -group aw_channel_master_if -radix unsigned /axi_tb_top/mif/aclk
add wave -noupdate -expand -group aw_channel_master_if -radix unsigned /axi_tb_top/mif/aresetn
add wave -noupdate -expand -group aw_channel_master_if -radix unsigned /axi_tb_top/mif/awvalid
add wave -noupdate -expand -group aw_channel_master_if -radix unsigned /axi_tb_top/mif/awready
add wave -noupdate -expand -group aw_channel_master_if -radix unsigned /axi_tb_top/mif/awaddr
add wave -noupdate -expand -group aw_channel_master_if -radix unsigned /axi_tb_top/mif/awsize
add wave -noupdate -expand -group aw_channel_master_if -radix unsigned /axi_tb_top/mif/awlen
add wave -noupdate -expand -group aw_channel_master_if -radix unsigned /axi_tb_top/mif/awburst
add wave -noupdate -expand -group aw_channel_master_if -radix unsigned /axi_tb_top/mif/awid
add wave -noupdate -expand -group aw_channel_master_if -radix unsigned /axi_tb_top/mif/awstrb
add wave -noupdate -expand -group w_channel_master_if /axi_tb_top/mif/wvalid
add wave -noupdate -expand -group w_channel_master_if /axi_tb_top/mif/wready
add wave -noupdate -expand -group w_channel_master_if -radix unsigned /axi_tb_top/mif/wdata
add wave -noupdate -expand -group w_channel_master_if /axi_tb_top/mif/wstrb
add wave -noupdate -expand -group w_channel_master_if /axi_tb_top/mif/wlast
add wave -noupdate -group ar_channel_master_if -radix unsigned /axi_tb_top/mif/arvalid
add wave -noupdate -group ar_channel_master_if -radix unsigned /axi_tb_top/mif/arready
add wave -noupdate -group ar_channel_master_if -radix unsigned /axi_tb_top/mif/arid
add wave -noupdate -group ar_channel_master_if -radix unsigned /axi_tb_top/mif/araddr
add wave -noupdate -group ar_channel_master_if -radix unsigned /axi_tb_top/mif/arlen
add wave -noupdate -group ar_channel_master_if -radix unsigned /axi_tb_top/mif/arsize
add wave -noupdate -group ar_channel_master_if -radix unsigned /axi_tb_top/mif/arburst
add wave -noupdate -group ar_channel_master_if -radix unsigned /axi_tb_top/mif/arstrb
add wave -noupdate -group r_channel_master_if -radix unsigned /axi_tb_top/mif/rready
add wave -noupdate -group r_channel_master_if -radix unsigned /axi_tb_top/mif/rvalid
add wave -noupdate -group r_channel_master_if -radix unsigned /axi_tb_top/mif/rdata
add wave -noupdate -group r_channel_master_if -radix unsigned /axi_tb_top/mif/rid
add wave -noupdate -group r_channel_master_if -radix unsigned /axi_tb_top/mif/rlast
add wave -noupdate -group r_channel_master_if -radix unsigned /axi_tb_top/mif/rresp
add wave -noupdate -group aw_channel_slave_if -radix unsigned /axi_tb_top/sif/aclk
add wave -noupdate -group aw_channel_slave_if -radix unsigned /axi_tb_top/sif/aresetn
add wave -noupdate -group aw_channel_slave_if -radix unsigned /axi_tb_top/sif/awvalid
add wave -noupdate -group aw_channel_slave_if -radix unsigned /axi_tb_top/sif/awready
add wave -noupdate -group aw_channel_slave_if -radix unsigned /axi_tb_top/sif/awaddr
add wave -noupdate -group aw_channel_slave_if -radix unsigned /axi_tb_top/sif/awsize
add wave -noupdate -group aw_channel_slave_if -radix unsigned /axi_tb_top/sif/awlen
add wave -noupdate -group aw_channel_slave_if -radix unsigned /axi_tb_top/sif/awburst
add wave -noupdate -group aw_channel_slave_if -radix unsigned /axi_tb_top/sif/awstrb
add wave -noupdate -group aw_channel_slave_if -radix unsigned /axi_tb_top/sif/awid
add wave -noupdate -group ar_channel_slave_if -radix unsigned /axi_tb_top/sif/arvalid
add wave -noupdate -group ar_channel_slave_if -radix unsigned /axi_tb_top/sif/arready
add wave -noupdate -group ar_channel_slave_if -radix unsigned /axi_tb_top/sif/arid
add wave -noupdate -group ar_channel_slave_if -radix unsigned /axi_tb_top/sif/araddr
add wave -noupdate -group ar_channel_slave_if -radix unsigned /axi_tb_top/sif/arlen
add wave -noupdate -group ar_channel_slave_if -radix unsigned /axi_tb_top/sif/arsize
add wave -noupdate -group ar_channel_slave_if -radix unsigned /axi_tb_top/sif/arburst
add wave -noupdate -group ar_channel_slave_if -radix unsigned /axi_tb_top/sif/arstrb
add wave -noupdate -group r_channel_slave_if /axi_tb_top/sif/rready
add wave -noupdate -group r_channel_slave_if /axi_tb_top/sif/rvalid
add wave -noupdate -group r_channel_slave_if /axi_tb_top/sif/rdata
add wave -noupdate -group r_channel_slave_if /axi_tb_top/sif/rid
add wave -noupdate -group r_channel_slave_if /axi_tb_top/sif/rlast
add wave -noupdate -group r_channel_slave_if /axi_tb_top/sif/rresp
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_drv_cb/rid
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_drv_cb/rvalid
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_drv_cb/rresp
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_drv_cb/rlast
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_drv_cb/rdata
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_drv_cb/rready
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_drv_cb/arvalid
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_drv_cb/araddr
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_drv_cb/arlen
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_drv_cb/arsize
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_drv_cb/arstrb
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_drv_cb/arburst
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_drv_cb/arid
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_drv_cb/arready
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_drv_cb/awready
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_drv_cb/awvalid
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_drv_cb/awaddr
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_drv_cb/awlen
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_drv_cb/awsize
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_drv_cb/awstrb
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_drv_cb/awid
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_drv_cb/awburst
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_drv_cb/master_drv_cb_event
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_mon_cb/arvalid
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_mon_cb/araddr
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_mon_cb/arlen
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_mon_cb/arsize
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_mon_cb/arstrb
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_mon_cb/arburst
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_mon_cb/rid
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_mon_cb/rvalid
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_mon_cb/rresp
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_mon_cb/rlast
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_mon_cb/rdata
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_mon_cb/rready
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_mon_cb/awvalid
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_mon_cb/awaddr
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_mon_cb/awlen
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_mon_cb/awsize
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_mon_cb/awstrb
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_mon_cb/awid
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_mon_cb/awburst
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_mon_cb/awready
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_mon_cb/arready
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/mif/master_mon_cb/master_mon_cb_event
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_drv_cb/awready
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_drv_cb/awvalid
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_drv_cb/awaddr
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_drv_cb/awlen
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_drv_cb/awsize
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_drv_cb/awstrb
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_drv_cb/awid
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_drv_cb/awburst
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_drv_cb/rvalid
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_drv_cb/rdata
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_drv_cb/rid
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_drv_cb/rlast
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_drv_cb/rresp
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_drv_cb/rready
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_drv_cb/arvalid
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_drv_cb/araddr
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_drv_cb/arlen
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_drv_cb/arsize
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_drv_cb/arstrb
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_drv_cb/arburst
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_drv_cb/arid
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_drv_cb/arready
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_drv_cb/slave_drv_cb_event
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_mon_cb/arvalid
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_mon_cb/araddr
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_mon_cb/arlen
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_mon_cb/arsize
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_mon_cb/arstrb
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_mon_cb/arburst
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_mon_cb/rready
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_mon_cb/rvalid
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_mon_cb/rdata
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_mon_cb/rid
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_mon_cb/rlast
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_mon_cb/rresp
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_mon_cb/awvalid
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_mon_cb/awaddr
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_mon_cb/awlen
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_mon_cb/awsize
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_mon_cb/awstrb
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_mon_cb/awid
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_mon_cb/awburst
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_mon_cb/awready
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_mon_cb/arready
add wave -noupdate -group {slave_master_clocking_siganls } /axi_tb_top/sif/slave_mon_cb/slave_mon_cb_event
add wave -noupdate -group w_channel_slave_if /axi_tb_top/sif/wvalid
add wave -noupdate -group w_channel_slave_if /axi_tb_top/sif/wready
add wave -noupdate -group w_channel_slave_if /axi_tb_top/sif/wdata
add wave -noupdate -group w_channel_slave_if /axi_tb_top/sif/wstrb
add wave -noupdate -group w_channel_slave_if /axi_tb_top/sif/wlast
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {380950 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 226
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {625231 ps}
