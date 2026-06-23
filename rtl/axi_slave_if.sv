interface axi_slave_if (input aclk, aresetn); 

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
    logic [(DATA_WIDTH/8):0] awstrb;
    logic [ID_WIDTH-1:0] awid;

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

    clocking slave_drv_cb @(posedge aclk);
        default input #1 output #0;
        output  arready;
        input arvalid, araddr, arlen, arsize, arstrb, arburst, arid;
        //rchannel_signals
        input rready; 
        output rvalid, rdata, rid, rlast, rresp;
        //aw_channel 
        input awvalid, awaddr, awlen, awsize, awstrb, awid, awburst; 
        output awready;
        //w_channel 
        input wvalid, wdata, wstrb, wlast; 
        output wready;
    endclocking 

    clocking slave_mon_cb @(posedge aclk);
        default input #1 output #0;
        input arready;
        input arvalid, araddr, arlen, arsize, arstrb, arburst, rready, rvalid, rdata,
                rid, rlast, rresp,awvalid, awaddr, awlen, awsize, awstrb, awid, awburst,
                awready;
    endclocking 
endinterface 
