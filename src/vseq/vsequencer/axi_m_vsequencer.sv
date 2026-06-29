 class axi_m_vsequencer extends uvm_sequencer; 
    `uvm_component_utils(axi_m_vsequencer)
        
    typedef uvm_sequencer#(axi_master_trans) axi_aw_channel_m_seqr; 
    typedef uvm_sequencer#(axi_master_trans) axi_w_channel_m_seqr; 
    typedef uvm_sequencer#(axi_master_trans) axi_ar_channel_m_seqr; 
    typedef uvm_sequencer#(axi_master_trans) axi_r_channel_m_seqr; 

    axi_aw_channel_m_seqr aw_seqr; 
    axi_w_channel_m_seqr w_seqr; 
    axi_ar_channel_m_seqr ar_seqr; 
    axi_r_channel_m_seqr r_seqr; 

    function new(string name="axi_m_vsequencer", uvm_component parent);
        super.new(name, parent);
    endfunction 
 endclass 
