class axi_ar_channel_m_agent extends uvm_agent;
    `uvm_component_utils(axi_ar_channel_m_agent)
    
    typedef uvm_sequencer#(axi_master_trans) axi_ar_channel_m_seqr;

    axi_ar_channel_m_drv drv_h;
    axi_ar_channel_m_seqr seqr_h; 

    function new(string name="axi_ar_channel_m_agent", uvm_component parent); 
        super.new(name, parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        drv_h=axi_ar_channel_m_drv::type_id::create("drv_h", this);
        seqr_h=axi_ar_channel_m_seqr::type_id::create("seqr_h", this);
    endfunction 

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        drv_h.seq_item_port.connect(seqr_h.seq_item_export);
    endfunction 


endclass 
