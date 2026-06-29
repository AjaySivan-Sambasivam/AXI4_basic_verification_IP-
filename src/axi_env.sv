class axi_env extends uvm_env;
    `uvm_component_utils(axi_env)
        
    axi_master_agent_top axi_m_agt;
    axi_slave_agt_top axi_s_agt;

    axi_m_vsequencer m_vseqr;
    
    axi_mem_model mem_h; 

    function new (string name="axi_env", uvm_component parent);
        super.new(name, parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        axi_m_agt=axi_master_agent_top::type_id::create("axi_m_agt", this);
        axi_s_agt=axi_slave_agt_top::type_id::create("axi_s_agt", this);
        mem_h=axi_mem_model::type_id::create("mem_h", this);
        
        //virtual_sequencer
        m_vseqr=axi_m_vsequencer::type_id::create("m_vseqr", this); 

        //stream the mem to lower components
        uvm_config_db#(axi_mem_model)::set(this, "*", "mem", mem_h);
    endfunction 

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        m_vseqr.aw_seqr=axi_m_agt.aw_agt.seqr_h; 
        m_vseqr.w_seqr=axi_m_agt.w_agt.seqr_h; 
        m_vseqr.ar_seqr=axi_m_agt.ar_channel_agt.seqr_h; 
        m_vseqr.r_seqr=axi_m_agt.r_agt.seqr_h;
    endfunction 

endclass 

