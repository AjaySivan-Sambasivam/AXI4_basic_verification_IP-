class axi_smoke_test extends axi_base_test; 
    `uvm_component_utils(axi_smoke_test)

    axi_vseqc_m_smoke smoke; 

    function new(string name="axi_smoke_test", uvm_component parent); 
        super.new(name, parent); 
    endfunction 

    task run_phase(uvm_phase phase); 
        phase.raise_objection(this); 
            smoke=axi_vseqc_m_smoke::type_id::create("smoke"); 
            smoke.start(env_h.m_vseqr);
            #2000;
        phase.drop_objection(this); 
    endtask 
endclass 
