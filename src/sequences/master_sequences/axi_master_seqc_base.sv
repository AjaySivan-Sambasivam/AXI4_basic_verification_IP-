class axi_master_seqc_base extends uvm_sequence#(axi_master_trans);
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
        repeat(no_itr) begin 
            req=axi_master_trans::type_id::create("req"); 
            start_item(req);
                req.randomize() with {awaddr<256; awlen < 10; awsize==4; awburst inside {[1:2]};};
            finish_item(req);
        end 
    endtask 
endclass

class axi_m_w_channel_seqc extends axi_master_seqc_base;
    `uvm_object_utils(axi_m_w_channel_seqc)

    function new(string name="axi_m_w_channel_seqc"); 
        super.new(name);
    endfunction

    task body(); 
        super.body(); 
        req=axi_master_trans::type_id::create("req");
        start_item(req);
            req.randomize(); 
        finish_item(req);
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
