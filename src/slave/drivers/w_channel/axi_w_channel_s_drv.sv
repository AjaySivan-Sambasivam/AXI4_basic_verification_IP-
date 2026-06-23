class axi_w_channel_s_drv extends uvm_driver#(axi_slave_trans);
    `uvm_component_utils(axi_w_channel_s_drv)

    virtual axi_slave_if vif; 

    axi_mem_model mem; 

    int delay; 

    function new(string name="axi_w_channel_s_drv", uvm_component parent); 
        super.new(name, parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual axi_slave_if)::get(this, "", "sif", vif))
            `uvm_fatal(get_type_name(), "virtual_fatal")
        if(!uvm_config_db#(axi_mem_model)::get(this, "", "mem", mem))
            `uvm_fatal(get_type_name(), "mem_fatal")
    endfunction

    function void connect_phase(uvm_phase phase); 
        super.connect_phase(phase); 
    endfunction 

    task run_phase(uvm_phase phase); 
        vif.slave_drv_cb.wready<=0;

        wait(vif.aresetn==1);
        forever begin
            delay=$urandom_range(0,10);    

            while(vif.slave_drv_cb.wvalid===0) begin 
                @(vif.slave_drv_cb);
            end 

            repeat(delay) begin 
                @(vif.slave_drv_cb); 
            end 
             vif.slave_drv_cb.wready<=1; 

             @(vif.slave_drv_cb)
             vif.slave_drv_cb.wready<=0; 
        end 
    endtask 
endclass 
