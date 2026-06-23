class axi_master_agent_top extends uvm_agent;
    `uvm_component_utils(axi_master_agent_top)

    axi_aw_channel_m_agt aw_agt;
    axi_w_channel_m_agt w_agt;
    axi_ar_channel_m_agent ar_channel_agt;
    axi_r_channel_m_agt r_agt;

    function new(string name="axi_master_agent_top", uvm_component parent);
        super.new(name, parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        aw_agt=axi_aw_channel_m_agt::type_id::create("aw_agt", this);
        w_agt=axi_w_channel_m_agt::type_id::create("w_agt", this);
        ar_channel_agt=axi_ar_channel_m_agent::type_id::create("ar_channel_agt", this);
        r_agt=axi_r_channel_m_agt::type_id::create("r_agt", this);
    endfunction 

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction 
endclass 
