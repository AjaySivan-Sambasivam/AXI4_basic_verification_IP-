class axi_vseqc_m_base extends uvm_sequence;
    `uvm_object_utils(axi_vseqc_m_base)

    typedef uvm_sequencer#(axi_master_trans) axi_aw_channel_m_seqr; 
    typedef uvm_sequencer#(axi_master_trans) axi_w_channel_m_seqr; 
    typedef uvm_sequencer#(axi_master_trans) axi_ar_channel_m_seqr; 
    typedef uvm_sequencer#(axi_master_trans) axi_r_channel_m_seqr; 

    //sequencer_handels
    axi_aw_channel_m_seqr aw_seqr; 
    axi_w_channel_m_seqr w_seqr; 
    axi_ar_channel_m_seqr ar_seqr; 
    axi_r_channel_m_seqr r_seqr; 

    //sequence_class 
    axi_m_aw_channel_seqc aw_seqc; 
    axi_m_w_channel_seqc w_seqc; 
    ar_m_chennal_seqc ar_seqc; 
    axi_m_r_channel_seqc r_seqc; 

    //virtual_sequencer_handels 
    axi_m_vsequencer m_vseqr; 

    function new(string name="axi_vseqc_m_base"); 
        super.new(name); 
    endfunction 

    virtual task body();
        //super.body(); 
        if(!($cast(m_vseqr, m_sequencer)))
            `uvm_fatal(get_type_name(), "sequencer casting fatal")

        aw_seqc=axi_m_aw_channel_seqc::type_id::create("aw_seqc"); 
        w_seqc=axi_m_w_channel_seqc::type_id::create("w_seqc"); 
        ar_seqc=ar_m_chennal_seqc::type_id::create("ar_seqc"); 
        r_seqc=axi_m_r_channel_seqc::type_id::create("r_seqc"); 

        aw_seqr=m_vseqr.aw_seqr; 
        w_seqr=m_vseqr.w_seqr; 
        ar_seqr=m_vseqr.ar_seqr; 
        r_seqr=m_vseqr.r_seqr;
    endtask 
endclass 
