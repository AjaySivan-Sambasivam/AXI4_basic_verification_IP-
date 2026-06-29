class axi_master_seqc_base extends uvm_sequence#(axi_master_trans);

    
    //AW_Channel 
    bit lawvalid;
    bit  lawready;
    rand bit [ADDR_WIDTH-1:0] lawaddr; 
    rand bit [2:0] lawsize;
    rand bit [7:0] lawlen;
    rand bit [1:0] lawburst;
    rand bit [(DATA_WIDTH/8):0] lawstrb;
    rand bit [ID_WIDTH-1:0] lawid;

    //w_channel 
    rand bit [DATA_WIDTH-1:0] lwdata; 
    rand bit [(DATA_WIDTH/8):0] lwstrb;
    bit lwlast; 
    bit lwready;
    bit lwvalid;

    //ar_channel 
    bit larready;
    bit larvalid; 
    rand bit [ID_WIDTH-1:0] larid; 
    rand bit [ADDR_WIDTH-1:0] laraddr;
    rand bit [2:0] larsize;
    rand bit [1:0] larburst;
    rand bit [7:0] larlen; 
    rand bit [DATA_WIDTH/8:0] larstrb; 
    
    //r_channel
    rand bit lrready; 
    bit lrvalid; 
    bit [DATA_WIDTH-1:0] lrdata; 
    bit [ID_WIDTH-1:0] lrid; 
    bit lrlast; 
    bit [1:0] lrresp; 

        `uvm_object_utils(axi_master_seqc_base)

    function new(string name="axi_master_seqc_base");
        super.new(name);
    endfunction 

    virtual task body;
        `uvm_info(get_type_name(), "Base_Body_seqcs_start's", UVM_LOW)
    endtask 
endclass 

class axi_m_aw_channel_seqc extends axi_master_seqc_base;
    `uvm_object_utils(axi_m_aw_channel_seqc)

    function new(string name="axi_m_aw_channel_seqc"); 
        super.new(name);
    endfunction

    task body(); 
        super.body; 
        req=axi_master_trans::type_id::create("req"); 
        start_item(req);
            req.randomize() with {awaddr==lawaddr; awlen == lawlen; awsize==lawsize; awburst==lawburst;};
        finish_item(req);
    endtask 
endclass

class axi_m_w_channel_seqc extends axi_master_seqc_base;
    `uvm_object_utils(axi_m_w_channel_seqc)

    function new(string name="axi_m_w_channel_seqc"); 
        super.new(name);
    endfunction

    task body(); 
        super.body(); 
        `uvm_info(get_type_name(), $sformatf("lawlen:%0d", lawlen), UVM_LOW)
        for(int i=0; i<lawlen+1; i++) begin 
            req=axi_master_trans::type_id::create("req");
            start_item(req);
            assert(req.randomize() with {wdata<256;});
            if(i==lawlen) begin 
                req.wlast = 1;
            end else begin
                req.wlast = 0;
            end 
            finish_item(req);
        end 
    endtask 
endclass

class ar_m_chennal_seqc extends axi_master_seqc_base;
    `uvm_object_utils(ar_m_chennal_seqc)


    function new(string name="ar_m_chennal_seqc");
        super.new(name);
    endfunction 

    task body; 
        super.body();
        repeat(no_itr) begin 
            req=axi_master_trans::type_id::create("req");
            start_item(req);
            req.randomize() with { araddr < 256; arlen < 10; arsize==4; arburst==1;};
            finish_item(req);
        end
    endtask
endclass 

class axi_m_r_channel_seqc extends axi_master_seqc_base;
    `uvm_object_utils(axi_m_r_channel_seqc)

    function new(string name="axi_m_r_channel_seqc");
        super.new(name);
    endfunction 

    task body; 
        forever begin
            req=axi_master_trans::type_id::create("req");
            start_item(req);
                req.randomize() with{rready dist {1:=80,0:=20}; };
            finish_item(req);
        end
    endtask 
endclass 
