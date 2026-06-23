class axi_aw_channel_s_drv extends uvm_driver#(axi_slave_trans);
    `uvm_component_utils(axi_aw_channel_s_drv)

    virtual axi_slave_if vif;

    axi_mem_model mem; 

    int delay; 

    function new(string name="axi_aw_channel_s_drv", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual axi_slave_if)::get(this, "", "sif", vif))
            `uvm_fatal(get_type_name(), "vif_fatal");
        if(!uvm_config_db#(axi_mem_model)::get(this, "", "mem",mem))
            `uvm_fatal(get_type_name(), "mem_fatal")
    endfunction

    task run_phase(uvm_phase phase);
        vif.slave_drv_cb.awready<=0;

        wait(vif.aresetn==1);  
        forever begin 
            delay=$urandom_range(0, 10);
            req=axi_slave_trans::type_id::create("req");
            //seq_item_port.get_next_item(req);
            
            @(vif.slave_drv_cb);
            vif.slave_drv_cb.awready<=0;

            while(vif.slave_drv_cb.awvalid===0) begin 
                @(vif.slave_drv_cb);
            end 

            repeat(delay) begin 
                @(vif.slave_drv_cb);
            end 

            vif.slave_drv_cb.awready<=1; 

            req.awid=vif.slave_drv_cb.awid; 
            req.awaddr=vif.slave_drv_cb.awaddr; 
            req.awvalid=vif.slave_drv_cb.awvalid; 
            req.awstrb=vif.slave_drv_cb.awstrb; 
            req.awsize=vif.slave_drv_cb.awsize; 
            req.awlen=vif.slave_drv_cb.awlen;
            req.awburst=vif.slave_drv_cb.awburst;

            if(!mem.write_push(req))
                `uvm_error(get_type_name(), "mem_write_push_not_done_yet")

            @(vif.slave_drv_cb)
            vif.slave_drv_cb.awready<=0;
            //seq_item_port.item_done();
        end 
    endtask 
    
endclass 
