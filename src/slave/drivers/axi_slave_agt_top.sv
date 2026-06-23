class axi_slave_agt_top extends uvm_agent;
    `uvm_component_utils(axi_slave_agt_top)

    axi_aw_channel_s_agt aw_agt;
    axi_w_channel_s_agt w_agt; 
    axi_slave_ar_channel_agt ar_agt;
    axi_r_channel_s_agt r_agt;

    function new(string name="axi_slave_agt_top", uvm_component parent);
        super.new(name, parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        aw_agt=axi_aw_channel_s_agt::type_id::create("aw_agt", this);
        w_agt=axi_w_channel_s_agt::type_id::create("w_agt", this);
        ar_agt=axi_slave_ar_channel_agt::type_id::create("ar_agt", this);
        r_agt=axi_r_channel_s_agt::type_id::create("r_agt", this);
    endfunction 
endclass 
