class axi_slave_ar_channel_drv extends uvm_driver#(axi_slave_trans);
    `uvm_component_utils(axi_slave_ar_channel_drv)

    virtual axi_slave_if vif;
    axi_mem_model mem;

    int delay;
    
    function new(string name="axi_slave_ar_channel_drv", uvm_component parent);
        super.new(name, parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual axi_slave_if)::get(this, "", "sif", vif))
            `uvm_fatal(get_type_name(), "sif_fatal")
    endfunction 

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if(!uvm_config_db#(axi_mem_model)::get(this, "", "mem", mem))
            `uvm_fatal(get_type_name(), "axi_mem_model config")
    endfunction 

    task initi();
        @(vif.slave_drv_cb);
        vif.slave_drv_cb.arready<=0;
    endtask 

    task run_phase(uvm_phase phase);
        initi();
        wait(vif.aresetn == 1);
        
        forever begin
            seq_item_port.get_next_item(req);
            
            delay=$urandom_range(0, 10);

            while (vif.slave_drv_cb.arvalid === 0) begin
                @(vif.slave_drv_cb);
            end

            repeat(delay) begin 
                @(vif.slave_drv_cb);
            end 
            vif.slave_drv_cb.arready<=1;

            req.arid=vif.slave_drv_cb.arid;
            req.araddr=vif.slave_drv_cb.araddr;
            req.arvalid=vif.slave_drv_cb.arvalid;
            req.arready=1;
            req.arstrb=vif.slave_drv_cb.arstrb;
            req.arlen=vif.slave_drv_cb.arlen;
            req.arburst=vif.slave_drv_cb.arburst;
            req.arsize=vif.slave_drv_cb.arsize;
            
            if(!mem.read_push(req))
                `uvm_error(get_type_name(), "mem_read_push_not_done_yet")

            @(vif.slave_drv_cb); 
            vif.slave_drv_cb.arready<=0;

            //$display("vif.addrs:%0d,", vif.slave_drv_cb.araddr);
                    
            seq_item_port.item_done();
        end 
    endtask 
endclass 
