interface axi_master_if (input aclk, aresetn); 

    parameter int unsigned ADDR_WIDTH=32;
    parameter int unsigned DATA_WIDTH=128; 
    parameter int unsigned ID_WIDTH=6; 

    //master AW_Channel 
    logic awvalid;
    logic awready;
    logic [ADDR_WIDTH-1:0] awaddr; 
    logic [2:0] awsize;
    logic [7:0] awlen;
    logic [1:0] awburst;
    logic [ID_WIDTH-1:0] awid; 
    logic [(DATA_WIDTH/8):0] awstrb;

    //w_channel 
    logic wvalid; 
    logic wready; 
    logic [DATA_WIDTH-1:0] wdata; 
    logic [(DATA_WIDTH/8):0] wstrb;
    logic wlast; 

    //AR channel
    logic arvalid;
    logic arready; 
    logic [5:0] arid; 
    logic [ADDR_WIDTH-1:0]araddr;
    logic [7:0] arlen; 
    logic [2:0] arsize;
    logic [1:0] arburst;
    logic [(DATA_WIDTH/8):0] arstrb; 

    //r_channel 
    logic rready; 
    logic rvalid; 
    logic [DATA_WIDTH-1:0]rdata; 
    logic [ID_WIDTH-1:0]rid; 
    logic rlast; 
    logic [1:0] rresp; 

    clocking master_drv_cb @(posedge aclk);
        default input #1 output #0;

        //aw_channel 
        output awvalid, awaddr, awlen, awsize, awstrb, awid, awburst; 
        input awready;
        //w_channel 
        output wvalid, wdata, wlast, wstrb; 
        input wready; 
        //ar_channel 
        input arready;
        output arvalid, araddr, arlen, arsize, arstrb, arburst, arid;
        //r_channel
        output rready; 
        input rid, rvalid, rresp, rlast, rdata;

    endclocking 

    clocking master_mon_cb @(posedge aclk);
        default input #1 output #0;
        input arready;
        input arvalid, araddr, arlen, arsize, arstrb, arburst, 
            rid, rvalid, rresp, rlast, rdata, rready,awvalid, 
            awaddr, awlen, awsize, awstrb, awid, awburst,awready;
    endclocking 

endinterface 
