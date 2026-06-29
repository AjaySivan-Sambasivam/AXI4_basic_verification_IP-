package axi_pkg; 
    
    parameter int unsigned ADDR_WIDTH=32;
    parameter int unsigned DATA_WIDTH=128; 
    parameter int unsigned ID_WIDTH=6;

    parameter int unsigned MEM_DATA_WIDTH=128;

    int unsigned no_itr=5;

    import uvm_pkg::*; 
    `include "uvm_macros.svh"

    typedef axi_mem_model;

    //trans class instances
    `include "axi_master_trans.sv"
    `include "axi_slave_trans.sv"

    //sequence_class_instances 
    `include "axi_master_seqc_base.sv"
    `include "axi_slave_seqc_base.sv"
    
    //aw_master_agents_component
    `include "axi_aw_channel_m_drv.sv"
    `include "axi_aw_channel_m_agt.sv"

    //w_master_agents_component
    `include "axi_w_channel_m_drv.sv"
    `include "axi_w_channel_m_agt.sv"

    //ar_master_agents_component's
    `include "axi_ar_channel_m_drv.sv"
    `include "axi_ar_channel_m_agent.sv"

    //r_master_agent_component's  
    `include "axi_r_channel_m_drv.sv"
    `include "axi_r_channel_m_agt.sv"

    //aw_slave_agents_component
    `include "axi_aw_channel_s_drv.sv"
    `include "axi_aw_channel_s_agt.sv"

    //w_slave_agents_component
    `include "axi_w_channel_s_drv.sv"
    `include "axi_w_channel_s_agt.sv"

    //r_channel_slave_component's 
    `include "axi_r_channel_s_drv.sv"
    `include "axi_r_channel_s_agt.sv"

    //ar_slave_agents_component
    `include "axi_slave_ar_channel_drv.sv"
    `include "axi_slave_ar_channel_agt.sv"

    //top_agents_instance
    `include "axi_master_agent_top.sv"
    `include "axi_slave_agt_top.sv"
    
    //axi_memory_model 
    `include "axi_mem_model.sv"
    
    //vsequencer_component
    `include "axi_m_vsequencer.sv"
    `include "axi_vseqc_pkg.sv"

    //top_components
    `include "axi_env.sv"
    `include "axi_test_pkg.sv"

endpackage 
