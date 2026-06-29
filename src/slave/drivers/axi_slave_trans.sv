class axi_slave_trans extends uvm_sequence_item;

    //AW_Channel 
    bit awvalid;
    bit  awready;
    bit [ADDR_WIDTH-1:0] awaddr; 
    bit [2:0] awsize;
    bit [7:0] awlen;
    bit [1:0] awburst;
    bit [(DATA_WIDTH/8):0] awstrb;
    bit [ID_WIDTH-1:0] awid;

    //w_channel
    bit [DATA_WIDTH-1:0] wdata; 
    bit [(DATA_WIDTH/8):0] wstrb; 
    bit wlast; 
    bit wvalid; 
    bit wready; 

    //ar_channel
    bit arready;
    bit arvalid;
    bit [ID_WIDTH-1:0] arid;
    bit [ADDR_WIDTH-1:0]araddr; 
    bit [DATA_WIDTH/8:0]arstrb;
    bit [2:0] arsize;
    bit [7:0] arlen; 
    bit [1:0] arburst;

    //r_channel 
    bit rready; 
    bit rvalid; 
    bit [DATA_WIDTH-1:0]rdata; 
    bit [ID_WIDTH-1:0]rid; 
    bit rlast; 
    bit [1:0] rresp; 

    `uvm_object_utils_begin(axi_slave_trans)
        `uvm_field_int(awready, UVM_ALL_ON)
        `uvm_field_int(awvalid, UVM_ALL_ON)
        `uvm_field_int(awsize, UVM_ALL_ON)
        `uvm_field_int(awburst, UVM_ALL_ON)
        `uvm_field_int(awlen, UVM_ALL_ON)
        `uvm_field_int(awstrb, UVM_ALL_ON)
        `uvm_field_int(awid, UVM_ALL_ON)
        `uvm_field_int(awaddr, UVM_ALL_ON)

        `uvm_field_int(wdata, UVM_ALL_ON)
        `uvm_field_int(wlast, UVM_ALL_ON)
        `uvm_field_int(wdata, UVM_ALL_ON)
        `uvm_field_int(wstrb, UVM_ALL_ON)
        `uvm_field_int(wready, UVM_ALL_ON)
        `uvm_field_int(wvalid, UVM_ALL_ON)

        `uvm_field_int(arready, UVM_ALL_ON)
        `uvm_field_int(arvalid, UVM_ALL_ON)
        `uvm_field_int(arid, UVM_ALL_ON)
        `uvm_field_int(araddr, UVM_ALL_ON)
        `uvm_field_int(arstrb, UVM_ALL_ON)
        `uvm_field_int(arsize, UVM_ALL_ON)
        `uvm_field_int(arlen, UVM_ALL_ON)
        `uvm_field_int(arburst, UVM_ALL_ON)
        
        `uvm_field_int(rready, UVM_ALL_ON)
        `uvm_field_int(rvalid, UVM_ALL_ON)
        `uvm_field_int(rdata, UVM_ALL_ON)
        `uvm_field_int(rid, UVM_ALL_ON)
        `uvm_field_int(rlast, UVM_ALL_ON)
        `uvm_field_int(rresp, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name="axi_slave_trans");
        super.new(name);
    endfunction 

endclass 
