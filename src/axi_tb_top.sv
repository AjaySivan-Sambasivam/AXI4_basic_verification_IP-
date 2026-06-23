module axi_tb_top;
    
    `include "uvm_macros.svh"
    import uvm_pkg::*;
    import axi_pkg::*;

    bit clk, rstn;

    always #5 clk = ~clk;

    axi_master_if mif(clk, rstn);
    axi_slave_if sif(clk, rstn);

    initial begin 
        @(posedge clk);
            rstn = 0; 
            #50;
            rstn = 1;
    end 

    initial begin 
       uvm_config_db#(virtual axi_master_if)::set(null, "*", "mif", mif);
       uvm_config_db#(virtual axi_slave_if)::set(null, "*", "sif", sif);
       run_test();
    end 
      
    //aw_channel 
    assign sif.awid=mif.awid;
    assign sif.awaddr=mif.awaddr;
    assign sif.awvalid=mif.awvalid;
    assign sif.awlen=mif.awlen;
    assign sif.awsize=mif.awsize;
    assign sif.awstrb=mif.awstrb;
    assign sif.awburst=mif.awburst;

    assign mif.awready=sif.awready;

    //w_channel 
    assign sif.wvalid=mif.wvalid;
    assign sif.wdata=mif.wdata; 
    assign sif.wstrb=mif.wstrb;
    assign sif.wlast=mif.wlast; 

    assign mif.wready=sif.wready;

    //ar_channel 
    assign sif.arid=mif.arid;
    assign sif.araddr=mif.araddr;
    assign sif.arvalid=mif.arvalid;
    assign sif.arlen=mif.arlen;
    assign sif.arsize=mif.arsize;
    assign sif.arburst=mif.arburst;
    assign sif.arstrb=mif.arstrb;

    assign mif.arready=sif.arready;

    //r_channel
    assign mif.rid=sif.rid; 
    assign mif.rvalid=sif.rvalid;
    assign mif.rdata=sif.rdata; 
    assign mif.rresp=sif.rresp; 
    assign mif.rlast=sif.rlast; 
    
    assign sif.rready=mif.rready;

endmodule 
