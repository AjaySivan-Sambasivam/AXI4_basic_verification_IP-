class axi_r_channel_s_drv extends uvm_driver#(axi_slave_trans);
    `uvm_component_utils(axi_r_channel_s_drv)

    virtual axi_slave_if vif;

    axi_mem_model mem; 

    function new (string name="axi_r_channel_s_drv", uvm_component parent);
        super.new(name, parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual axi_slave_if)::get(this, "", "sif", vif))
            `uvm_fatal(get_type_name(), "config_vif_fatal")
        if(!uvm_config_db#(axi_mem_model)::get(this, "", "mem", mem))
            `uvm_fatal(get_type_name(), "mem_config_fatal")
    endfunction 
    
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction

    task initi();
        @(vif.slave_drv_cb); 
        vif.slave_drv_cb.rvalid<=0;
        vif.slave_drv_cb.rid<=0;
        vif.slave_drv_cb.rresp<=0;
        vif.slave_drv_cb.rlast<=0;
        vif.slave_drv_cb.rdata<=0;
        //vif.slave_drv_cb.rready<=0;
    endtask 

    task run_phase(uvm_phase phase);
        bit [ADDR_WIDTH-1:0] addrs_queue [$];
        bit [ID_WIDTH-1:0] current_id;
        bit found_req;
        axi_slave_trans tx_h;

        `uvm_info(get_type_name(), "starting_main_phase", UVM_LOW)

        initi; 
        wait(vif.aresetn==1); 
        forever begin
            
            @(vif.slave_drv_cb);
            found_req=0;

            foreach(mem.read_queue[id]) begin 
                if(mem.read_queue[id].size() > 0) begin 
                    current_id=id;
                    found_req=1;
                    break; 
                end 
            end 

            if(found_req==1) begin 
                tx_h=mem.read_queue[current_id].pop_back();

                addrs_queue = mem.addrs_cal(tx_h.araddr, tx_h.arburst, tx_h.arlen, tx_h.arsize);

                foreach(addrs_queue[i]) begin 
                    if(mem.data_mem.exists(addrs_queue[i])) begin 
                        vif.slave_drv_cb.rdata<=mem.data_mem[addrs_queue[i]];
                    end 
                    else begin 
                        vif.slave_drv_cb.rdata<=0;
                    end 

                    if(i==addrs_queue.size()-1) begin 
                        vif.slave_drv_cb.rlast<=1;
                    end 
                    else begin 
                        vif.slave_drv_cb.rlast<=0;
                    end

                    vif.slave_drv_cb.rid<=current_id;
                    vif.slave_drv_cb.rresp<=2'b00;
                    vif.slave_drv_cb.rvalid<=1; 

                    do begin 
                        @(vif.slave_drv_cb);
                    end while(vif.slave_drv_cb.rready === 0); 
                end 
                
                vif.slave_drv_cb.rlast<=0;
                vif.slave_drv_cb.rvalid<=0;
            end 
        end 
    endtask 
endclass 
