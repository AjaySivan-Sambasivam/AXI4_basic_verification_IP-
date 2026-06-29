class axi_w_channel_s_drv extends uvm_driver#(axi_slave_trans);
    `uvm_component_utils(axi_w_channel_s_drv)

    virtual axi_slave_if vif; 

    axi_mem_model mem;
    bit [DATA_WIDTH-1:0] data_queue [$];
    bit [(DATA_WIDTH/8):0] strb_queue [$];

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
             data_queue.push_back(vif.slave_drv_cb.wdata);
             strb_queue.push_back(vif.slave_drv_cb.wstrb);
                
             if(vif.slave_drv_cb.wlast==1) begin 
                /*if(!mem.write_excute(data_queue, strb_queue))
                    `uvm_fatal(get_type_name(), "write_address_queue_is_not_exsist")*/
                    mem.data_q=data_queue;
                    mem.strb_q=strb_queue;
                    data_queue.delete();
                    strb_queue.delete();
             end 
                
             @(vif.slave_drv_cb)
             vif.slave_drv_cb.wready<=0; 

        end 
    endtask 
endclass 
