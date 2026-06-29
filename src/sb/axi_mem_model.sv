class axi_mem_model extends uvm_component; 
    `uvm_component_utils(axi_mem_model)

   bit [MEM_DATA_WIDTH-1:0] data_mem [bit[ADDR_WIDTH-1:0]];

   axi_slave_trans read_queue [int][$];

   axi_slave_trans write_queue [$];

   bit [DATA_WIDTH-1:0] data_q [$];
   bit [(DATA_WIDTH/8):0] strb_q [$];

    function new(string name="axi_mem_model", uvm_component parent);
        super.new(name, parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        for(int i = 0; i < 1024; i++) begin
            data_mem[i] = {$urandom(), $urandom(), $urandom(), $urandom()};
        end
    endfunction 

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction

    function bit write_push(axi_slave_trans tx);
        write_queue.push_front(tx);
        `uvm_info(get_type_name(), $sformatf("Pushed to write_queue[AWID:%0d]. Queue Size: %0d\nTransaction Details:\n%s", tx.awid, write_queue.size(), tx.sprint()), UVM_LOW)
        return 1; 
    endfunction 

    function bit read_push(axi_slave_trans tx);
        read_queue[tx.arid].push_front(tx);
`uvm_info(get_type_name(), $sformatf("Pushed to read_queue[ARID:%0d]. Queue Size: %0d\nTransaction Details:\n%s", tx.arid, read_queue[tx.arid].size(), tx.sprint()), UVM_LOW)
        return 1; 
    endfunction

    typedef bit [ADDR_WIDTH-1:0] addr_q_t [$];

    function automatic addr_q_t addrs_cal(
        input  bit [ADDR_WIDTH-1:0] start_addr,
        input  bit [1:0]            burst_type,  
        input  bit [7:0]            burst_len,  
        input  bit [2:0]            burst_size   
    );
        addr_q_t beat_addrs;
        int unsigned number_bytes;
        int unsigned burst_length;
        bit [ADDR_WIDTH-1:0] aligned_addr;
        bit [ADDR_WIDTH-1:0] lower_wrap_boundary;
        bit [ADDR_WIDTH-1:0] upper_wrap_boundary;
        bit [ADDR_WIDTH-1:0] current_addr;
        
        number_bytes = 1 << burst_size; 
        burst_length = burst_len + 1;
        
        current_addr = start_addr;
        beat_addrs.push_back(current_addr);
        
        aligned_addr = (start_addr / number_bytes) * number_bytes;
        
        if (burst_type == 2'b10) begin 
            lower_wrap_boundary = (start_addr / (number_bytes * burst_length)) * (number_bytes * burst_length);
            upper_wrap_boundary = lower_wrap_boundary + (number_bytes * burst_length);
        end
        
        for (int i = 1; i < burst_length; i++) begin
            if (burst_type == 2'b00) begin 
                beat_addrs.push_back(current_addr);
            end
            else if (burst_type == 2'b01) begin 
                if (i == 1) begin
                    current_addr = aligned_addr + number_bytes;
                end else begin
                    current_addr = current_addr + number_bytes;
                end
                beat_addrs.push_back(current_addr);
            end
            else if (burst_type == 2'b10) begin 
                if (i == 1) begin
                    current_addr = aligned_addr + number_bytes;
                end else begin
                    current_addr = current_addr + number_bytes;
                end
                if (current_addr >= upper_wrap_boundary) begin
                    current_addr = lower_wrap_boundary;
                end
                beat_addrs.push_back(current_addr);
            end
        end
        return beat_addrs;
    endfunction

    function bit write_excute(bit [DATA_WIDTH-1:0] data_q [$], bit[(DATA_WIDTH/8):0] strb_q [$]);
        axi_slave_trans tx; 
        bit [ADDR_WIDTH-1:0] addrs [$];
        bit [7:0] len;

        if(write_queue.size()>0) begin 
            tx=write_queue.pop_front();
            addrs=addrs_cal(tx.awaddr, tx.awburst, tx.awlen, tx.awsize); 
            `uvm_info(get_type_name(), $sformatf("write_data_of_each_transaction::%0p", data_q), UVM_LOW)

            //len=tx.awlen+1;

            foreach(addrs[i]) begin 
                data_mem[addrs[i]] = data_q.pop_front();
            end 
            `uvm_info(get_type_name(), "write_excute_complete_successfully", UVM_LOW)
            return 1; 
        end 
        else 
            return 0; 
    endfunction

    task run_phase(uvm_phase phase); 
        forever begin 
            wait(write_queue.size>0) begin 
                if(!write_excute(data_q, strb_q))
                    `uvm_fatal(get_type_name(), "write_excute_wasn't_complete_successfully")
            end 
        end 
    endtask 
endclass 
