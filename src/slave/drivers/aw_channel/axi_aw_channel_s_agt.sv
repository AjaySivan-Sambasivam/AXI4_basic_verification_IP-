class axi_aw_channel_s_agt extends uvm_driver#(axi_slave_trans);
    `uvm_component_utils(axi_aw_channel_s_agt)
    
    typedef uvm_sequencer#(axi_slave_trans) axi_aw_channel_s_seqr; 

    axi_aw_channel_s_seqr seqr_h; 
    axi_aw_channel_s_drv drv_h;


    function new(string name="axi_aw_channel_s_agt", uvm_component parent);
        super.new(name, parent);
    endfunction
    

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        seqr_h=axi_aw_channel_s_seqr::type_id::create("seqr_h", this); 
        drv_h=axi_aw_channel_s_drv::type_id::create("drv_h", this);
    endfunction 

    function void connect_phase(uvm_phase phase); 
        super.connect_phase(phase);
        drv_h.seq_item_port.connect(seqr_h.seq_item_export);
    endfunction
endclass
