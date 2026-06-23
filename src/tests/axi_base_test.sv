class axi_base_test extends uvm_test; 
    `uvm_component_utils(axi_base_test);
    
     axi_env env_h;

     axi_m_aw_channel_seqc m_aw_seqc;
     axi_s_aw_channel_seqc s_aw_seqc;

     axi_m_w_channel_seqc m_w_seqc;

     ar_m_chennal_seqc m_ar_seqc;
     axi_s_ar_channel_seqc s_ar_seqc;

     axi_m_r_channel_seqc m_r_seqc;
     axi_s_r_channel_seqc s_r_seqc;

    function new(string name="axi_base_test", uvm_component parent);
        super.new(name, parent);
    endfunction 
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env_h=axi_env::type_id::create("env_h", this);
    endfunction

    function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        uvm_top.print_topology();
    endfunction 

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
            m_aw_seqc=axi_m_aw_channel_seqc::type_id::create("m_aw_seqc");
            s_aw_seqc=axi_s_aw_channel_seqc::type_id::create("s_aw_seqc");
            m_w_seqc=axi_m_w_channel_seqc::type_id::create("m_w_seqc");
            m_ar_seqc=ar_m_chennal_seqc::type_id::create("m_ar_seqc");
            s_ar_seqc=axi_s_ar_channel_seqc::type_id::create("a_ar_seqc");
            m_r_seqc=axi_m_r_channel_seqc::type_id::create("m_r_seqc");
            s_r_seqc=axi_s_r_channel_seqc::type_id::create("s_r_seqc");

            fork 
                m_aw_seqc.start(env_h.axi_m_agt.aw_agt.seqr_h);
                m_w_seqc.start(env_h.axi_m_agt.w_agt.seqr_h);
                m_ar_seqc.start(env_h.axi_m_agt.ar_channel_agt.seqr_h);
                s_ar_seqc.start(env_h.axi_s_agt.ar_agt.seqr_h);
                m_r_seqc.start(env_h.axi_m_agt.r_agt.seqr_h);
            join_none 
            #2000;
        phase.drop_objection(this);
    endtask 

endclass 
