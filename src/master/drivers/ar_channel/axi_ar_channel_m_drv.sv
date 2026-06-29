class axi_ar_channel_m_drv extends uvm_driver#(axi_master_trans);
    `uvm_component_utils (axi_ar_channel_m_drv)

    virtual axi_master_if vif; 

    function new(string name="axi_ar_channel_m_drv", uvm_component parent);
        super.new(name, parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual axi_master_if)::get(this, "", "mif", vif))
            `uvm_fatal(get_type_name(), "Vif_fatal")
    endfunction 

    task init();
        @(vif.master_drv_cb);
        vif.master_drv_cb.arid<=0;
        vif.master_drv_cb.arvalid<=0;
        vif.master_drv_cb.araddr<=0;
        vif.master_drv_cb.arlen<=0;
        vif.master_drv_cb.arsize<=0;
        vif.master_drv_cb.arstrb<=0;
        vif.master_drv_cb.arburst<=0;

    endtask 

    task run_phase(uvm_phase phase);
        init();
        wait(vif.aresetn == 1);
        forever begin
            seq_item_port.get_next_item(req);
            drive(); 
            seq_item_port.item_done(); 
        end 
    endtask 


    task drive();
        vif.master_drv_cb.arvalid<=1; 
        vif.master_drv_cb.arid<=req.arid;
        vif.master_drv_cb.araddr<=req.araddr;
        vif.master_drv_cb.arlen<=req.arlen;
        vif.master_drv_cb.arsize<=req.arsize;
        vif.master_drv_cb.arstrb<=req.arstrb;
        vif.master_drv_cb.arburst<=req.arburst;

        @(vif.master_drv_cb);
        while(vif.master_drv_cb.arready==0) begin
            @(vif.master_drv_cb);
        end 
        
        //@(vif.master_drv_cb);
        vif.master_drv_cb.arvalid<=0;

    endtask 
endclass 
