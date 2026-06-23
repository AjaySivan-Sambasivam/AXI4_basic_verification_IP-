class axi_master_trans extends uvm_sequence_item;

    //AW_Channel 
    bit awvalid;
    bit  awready;
    rand bit [ADDR_WIDTH-1:0] awaddr; 
    rand bit [2:0] awsize;
    rand bit [7:0] awlen;
    rand bit [1:0] awburst;
    rand bit [(DATA_WIDTH/8):0] awstrb;
    rand bit [ID_WIDTH-1:0] awid;

    //w_channel 
    rand bit [DATA_WIDTH-1:0] wdata; 
    rand bit [(DATA_WIDTH/8):0] wstrb;
    bit wlast; 
    bit wready;
    bit wvalid;

    //ar_channel 
    bit arready;
    bit arvalid; 
    rand bit [ID_WIDTH-1:0] arid; 
    rand bit [ADDR_WIDTH-1:0] araddr;
    rand bit [2:0] arsize;
    rand bit [1:0] arburst;
    rand bit [7:0] arlen; 
    rand bit [DATA_WIDTH/8:0] arstrb; 
    
    //r_channel
    rand bit rready; 
    bit rvalid; 
    bit [DATA_WIDTH-1:0]rdata; 
    bit [ID_WIDTH-1:0]rid; 
    bit rlast; 
    bit [1:0] rresp; 
    
        `uvm_object_utils_begin(axi_master_trans)
            `uvm_field_int(awready, UVM_ALL_ON)
            `uvm_field_int(awvalid, UVM_ALL_ON)
            `uvm_field_int(awsize, UVM_ALL_ON)
            `uvm_field_int(awburst, UVM_ALL_ON)
            `uvm_field_int(awlen, UVM_ALL_ON)
            `uvm_field_int(awstrb, UVM_ALL_ON)
            `uvm_field_int(awid, UVM_ALL_ON)
            `uvm_field_int(awaddr, UVM_ALL_ON)

            `uvm_field_int(arready, UVM_ALL_ON)
            `uvm_field_int(arvalid, UVM_ALL_ON)
            `uvm_field_int(arsize, UVM_ALL_ON)
            `uvm_field_int(arburst, UVM_ALL_ON)
            `uvm_field_int(arlen, UVM_ALL_ON)
            `uvm_field_int(arstrb, UVM_ALL_ON)
            `uvm_field_int(arid, UVM_ALL_ON)
            `uvm_field_int(araddr, UVM_ALL_ON)

            `uvm_field_int(rid, UVM_ALL_ON)
            `uvm_field_int(rvalid, UVM_ALL_ON)
            `uvm_field_int(rready, UVM_ALL_ON)
            `uvm_field_int(rresp, UVM_ALL_ON)
            `uvm_field_int(rlast, UVM_ALL_ON)
            `uvm_field_int(rdata, UVM_ALL_ON)
        `uvm_object_utils_end

        constraint ar_id {arid inside {[1:16]};}
        constraint aw_id {awid inside {[1:16]};}
        

    function new(string name="axi_master_trans");
        super.new(name);
    endfunction 
    
endclass 
