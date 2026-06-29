class axi_w_channel_m_drv extends uvm_driver#(axi_master_trans); 
    `uvm_component_utils(axi_w_channel_m_drv)

    virtual axi_master_if vif;

    function new (string name="axi_w_channel_m_drv", uvm_component parent); 
        super.new(name, parent); 
    endfunction 

    function void build_phase(uvm_phase phase); 
        super.build_phase(phase); 
        if(!uvm_config_db#(virtual axi_master_if)::get(this, "", "mif", vif))
            `uvm_fatal(get_type_name(), "vif_fatal")
        //if(!uvm_config_db#(axi))
    endfunction 

    function void connect_phase(uvm_phase phase); 
        super.connect_phase(phase); 
    endfunction 

    task initi(); 
        @(vif.master_drv_cb); 
        vif.master_drv_cb.wvalid<=0; 
        vif.master_drv_cb.wdata<=0; 
        vif.master_drv_cb.wlast<=0; 
        vif.master_drv_cb.wstrb<=0; 
    endtask 

    task run_phase(uvm_phase phase);
        initi(); 

        wait(vif.aresetn==1); 
        forever begin
          seq_item_port.get_next_item(req);

          @(vif.master_drv_cb);
          vif.master_drv_cb.wvalid<=1;
          vif.master_drv_cb.wdata<=req.wdata; 
          vif.master_drv_cb.wlast<=req.wlast; 
          vif.master_drv_cb.wstrb<=req.wstrb;
           
          do begin 
            @(vif.master_mon_cb);
          end 
          while(vif.master_drv_cb.wready===0);

          @(vif.master_drv_cb);
          vif.master_drv_cb.wvalid<=0;
            
          seq_item_port.item_done();
        end 
    endtask 
endclass 
