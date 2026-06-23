class axi_r_channel_m_drv extends uvm_driver#(axi_master_trans);
    `uvm_component_utils(axi_r_channel_m_drv)
    
    virtual axi_master_if vif;

    axi_mem_model mem; 

    function new(string name="axi_r_channel_m_drv", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual axi_master_if)::get(this, "", "mif", vif))
            `uvm_fatal(get_type_name(), "config_vif_fatal")
        if(!uvm_config_db#(axi_mem_model)::get(this, "", "mem", mem))
            `uvm_fatal(get_type_name(), "config_mem_fatal")
    endfunction 

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction 

     task initi();
        @(vif.master_drv_cb);
        vif.master_drv_cb.rready <= 0;
    endtask

    task run_phase(uvm_phase phase); 
        initi();
        wait(vif.aresetn == 1);
        forever begin 
            seq_item_port.get_next_item(req);
            
            vif.master_drv_cb.rready <= req.rready;
            
            if (req.rready == 1) begin
                do begin
                    @(vif.master_drv_cb);
                end while (vif.master_drv_cb.rvalid === 0);
            end else begin
                @(vif.master_drv_cb);
            end
            vif.master_drv_cb.rready <= 0;
            seq_item_port.item_done();
        end 
    endtask  
endclass 
