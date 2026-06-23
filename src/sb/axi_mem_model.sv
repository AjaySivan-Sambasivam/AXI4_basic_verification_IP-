class axi_mem_model extends uvm_component; 
    `uvm_component_utils(axi_mem_model)

   bit [MEM_DATA_WIDTH-1:0] data_mem [bit[ADDR_WIDTH-1:0]];

   axi_slave_trans read_queue [int][$];

   axi_slave_trans write_queue [int][$];

    function new(string name="axi_mem_model", uvm_component parent);
        super.new(name, parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // Initialize memory with some random data for the first 1024 addresses
        for(int i = 0; i < 1024; i++) begin
            data_mem[i] = {$urandom(), $urandom(), $urandom(), $urandom()};
        end
    endfunction 

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction

    function bit write_push(axi_slave_trans tx);
        write_queue[tx.awid].push_front(tx);
        `uvm_info(get_type_name(), $sformatf("Pushed to write_queue[AWID:%0d]. Queue Size: %0d\nTransaction Details:\n%s", tx.awid, write_queue[tx.awid].size(), tx.sprint()), UVM_LOW)
        return 1; 
    endfunction 

    function bit read_push(axi_slave_trans tx);
        read_queue[tx.arid].push_front(tx);
`uvm_info(get_type_name(), $sformatf("Pushed to read_queue[ARID:%0d]. Queue Size: %0d\nTransaction Details:\n%s", tx.arid, read_queue[tx.arid].size(), tx.sprint()), UVM_LOW)
        return 1; 
    endfunction

        // AXI Address Calculation Function
    // Calculates addresses for every beat in a burst based on AXI4 specification
    typedef bit [ADDR_WIDTH-1:0] addr_q_t [$];

    function automatic addr_q_t addrs_cal(
        input  bit [ADDR_WIDTH-1:0] start_addr,
        input  bit [1:0]            burst_type,  // 00=FIXED, 01=INCR, 10=WRAP
        input  bit [7:0]            burst_len,   // AXI burst length minus 1 (arlen/awlen)
        input  bit [2:0]            burst_size   // 000=1B, 001=2B, 010=4B, etc.
    );
        addr_q_t beat_addrs;
        int unsigned number_bytes;
        int unsigned burst_length;
        bit [ADDR_WIDTH-1:0] aligned_addr;
        bit [ADDR_WIDTH-1:0] lower_wrap_boundary;
        bit [ADDR_WIDTH-1:0] upper_wrap_boundary;
        bit [ADDR_WIDTH-1:0] current_addr;
        
        // Calculate bytes per beat and total beats
        number_bytes = 1 << burst_size; 
        burst_length = burst_len + 1;
        
        // 1st beat address is always the start address (unaligned or aligned)
        current_addr = start_addr;
        beat_addrs.push_back(current_addr);
        
        // Calculate the aligned address (used for subsequent beats in INCR/WRAP)
        aligned_addr = (start_addr / number_bytes) * number_bytes;
        
        // If WRAP, calculate boundaries
        if (burst_type == 2'b10) begin 
            lower_wrap_boundary = (start_addr / (number_bytes * burst_length)) * (number_bytes * burst_length);
            upper_wrap_boundary = lower_wrap_boundary + (number_bytes * burst_length);
        end
        
        // Calculate addresses for the remaining beats
        for (int i = 1; i < burst_length; i++) begin
            
            if (burst_type == 2'b00) begin 
                // FIXED burst: address remains exactly the same for every beat
                beat_addrs.push_back(current_addr);
            end
            
            else if (burst_type == 2'b01) begin 
                // INCR burst
                if (i == 1) begin
                    // The second beat address must be aligned
                    current_addr = aligned_addr + number_bytes;
                end else begin
                    // Subsequent beats increment normally
                    current_addr = current_addr + number_bytes;
                end
                beat_addrs.push_back(current_addr);
            end
            
            else if (burst_type == 2'b10) begin 
                // WRAP burst
                if (i == 1) begin
                    current_addr = aligned_addr + number_bytes;
                end else begin
                    current_addr = current_addr + number_bytes;
                end
                
                // Wrap around logic: if we reach or exceed upper boundary, wrap to the lower boundary
                if (current_addr >= upper_wrap_boundary) begin
                    current_addr = lower_wrap_boundary;
                end
                beat_addrs.push_back(current_addr);
            end
        end
        return beat_addrs;
    endfunction
endclass 
