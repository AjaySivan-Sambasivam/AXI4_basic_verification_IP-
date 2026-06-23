class axi_slave_seqc_base extends uvm_sequence#(axi_slave_trans);
    `uvm_object_utils(axi_slave_seqc_base)

    function new(string name="axi_slave_seqc_base");
        super.new(name);
    endfunction 

    virtual task body();
        `uvm_info(get_type_name(), "slave_body_start's", UVM_LOW)
    endtask 
endclass

class axi_s_aw_channel_seqc extends axi_slave_seqc_base;
    `uvm_object_utils(axi_s_aw_channel_seqc)

    function new(string name="axi_s_aw_channel_seqc");
        super.new(name);
    endfunction 

    task body();
        super.body();
        req=axi_slave_trans::type_id::create("req");
        start_item(req);

        finish_item(req);
    endtask 
endclass 

class axi_s_ar_channel_seqc extends axi_slave_seqc_base; 
    `uvm_object_utils(axi_s_ar_channel_seqc)

    function new(string name="axi_s_ar_channel_seqc");
        super.new(name);
    endfunction 

    task body(); 
        super.body();
        repeat(no_itr) begin 
            req=axi_slave_trans::type_id::create("req");
            start_item(req); 
                
            finish_item(req);
        end 
    endtask 
endclass

class axi_s_r_channel_seqc extends axi_slave_seqc_base;
    `uvm_object_utils(axi_s_r_channel_seqc)

    function new(string name="axi_s_r_channel_seqc");
        super.new(name);
    endfunction 
   
    task body; 
        req=axi_slave_trans::type_id::create("req");
            start_item(req);
                
            finish_item(req);
    endtask 

endclass 
