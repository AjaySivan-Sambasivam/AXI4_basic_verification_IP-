class axi_aw_channel_m_drv extends uvm_driver#(axi_master_trans); 
    `uvm_component_utils(axi_aw_channel_m_drv) 

    virtual axi_master_if vif;

    function new(string name = "axi_aw_channel_m_drv", uvm_component parent); 
        super.new(name, parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual axi_master_if)::get(this, "", "mif", vif))
            `uvm_fatal(get_type_name(), "vif_fatal")
    endfunction 

    task init(); 
        @(vif.master_drv_cb); 
        vif.master_drv_cb.awid<=0;
        vif.master_drv_cb.awaddr<=0; 
        vif.master_drv_cb.awvalid<=0;
        vif.master_drv_cb.awburst<=0; 
        vif.master_drv_cb.awstrb<=0;
        vif.master_drv_cb.awlen<=0; 
        vif.master_drv_cb.awsize<=0;

    endtask 

    task run_phase(uvm_phase phase);
        init();

        wait(vif.aresetn==1);
        forever begin 
            seq_item_port.get_next_item(req);
                vif.master_drv_cb.awid<=req.awid;
                vif.master_drv_cb.awaddr<=req.awaddr; 
                vif.master_drv_cb.awvalid<=1;
                vif.master_drv_cb.awburst<=req.awburst; 
                vif.master_drv_cb.awstrb<=req.awstrb;
                vif.master_drv_cb.awlen<=req.awlen; 
                vif.master_drv_cb.awsize<=req.awsize;
                
                @(vif.master_drv_cb);
                    
                while(vif.master_drv_cb.awready===0) begin 
                    @(vif.master_drv_cb);
                end 
                
                vif.master_drv_cb.awvalid<=0; 

            seq_item_port.item_done();
        end 
    endtask 

endclass 
