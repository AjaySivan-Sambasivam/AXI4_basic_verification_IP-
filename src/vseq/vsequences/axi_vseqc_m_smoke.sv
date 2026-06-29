class axi_vseqc_m_smoke extends axi_vseqc_m_base; 
    `uvm_object_utils(axi_vseqc_m_smoke)

    axi_master_trans wtxn;
    axi_master_trans rtxn; 

    function new(string name="axi_vseqc_m_smoke");
        super.new(name); 
    endfunction 

    task body(); 
        bit [7:0] len[$]; 
        super.body();

        repeat(no_itr) begin  
            wtxn=axi_master_trans::type_id::create("wtxn"); 
            rtxn=axi_master_trans::type_id::create("rtxn"); 
            
                assert(wtxn.randomize() with {awaddr<256; awsize==4; 
                                              awburst inside {[1:2]}; 
                                              awlen inside {[0:4]};});

                assert(aw_seqc.randomize() with {lawaddr==wtxn.awaddr; 
                                                 lawlen==wtxn.awlen; 
                                                 lawsize==wtxn.awsize; 
                                                 lawburst==wtxn.awburst;});
                assert(w_seqc.randomize() with {lawaddr==wtxn.awaddr; 
                                                lawlen==wtxn.awlen; 
                                                lawsize==wtxn.awsize; 
                                                lawburst==wtxn.awburst;});

        //start_seqc in the seqr.
            fork
               repeat(no_itr) aw_seqc.start(aw_seqr);
               repeat(no_itr)w_seqc.start(w_seqr); 
            join
        end 
    endtask 
endclass 
