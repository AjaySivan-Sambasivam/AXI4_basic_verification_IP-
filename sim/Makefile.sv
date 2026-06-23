# -----------------------------------------------------------------------------
# Makefile for SystemVerilog Compilation & Simulation with VCS and Verdi
# -----------------------------------------------------------------------------

# Usage:
#   1. Compile     : make -f Makefile.sv compile SRC=../code/your_file.sv
#   2. Run         : make -f Makefile.sv run
#   3. Waveform    : make -f Makefile.sv wave
#   4. Coverage    : make -f Makefile.sv cov
#   5. All-in-one  : make -f Makefile.sv all SRC=../code/your_file.sv
#   6. Clean       : make -f Makefile.sv clean

# Default variables
SRC ?= 
TOP ?= 

# Determine if TOP is provided, otherwise let VCS infer it
TOP_CMD = $(if $(TOP),-top $(TOP),)

# VCS Compilation Flags
COV_METRICS = line+cond+fsm+tgl+branch+assert
VCS_FLAGS = -sverilog -full64 -debug_access+all -kdb -assert enable_diag -cm $(COV_METRICS)

# Run Simulation Flags
RUN_FLAGS = -l run.log -cm $(COV_METRICS)

.PHONY: all compile run wave cov clean

all: clean compile run

# --- Compilation Target ---
compile:
	@if [ -z "$(SRC)" ]; then \
		echo "================================================================="; \
		echo " ERROR: Please specify the source file(s) to compile."; \
		echo " Example: make -f Makefile.sv compile SRC=../code/my_tb.sv"; \
		echo "================================================================="; \
		exit 1; \
	fi
	vcs $(VCS_FLAGS) $(TOP_CMD) $(SRC) -o simv -l compile.log
	@echo "================================================================="
	@echo " Compilation successful. You can now run the simulation: make -f Makefile.sv run"
	@echo "================================================================="

# --- Automatic Tcl script for dumping FSDB waveforms ---
dump.tcl:
	@echo "fsdbDumpfile \"novas.fsdb\"" > dump.tcl
	@echo "fsdbDumpvars 0 \"*\" +all" >> dump.tcl
	@echo "fsdbDumpSVA" >> dump.tcl
	@echo "run" >> dump.tcl
	@echo "exit" >> dump.tcl

# --- Simulation Target ---
run: dump.tcl
	@if [ ! -f simv ]; then \
		echo "ERROR: Executable 'simv' not found. Please run 'make -f Makefile.sv compile' first."; \
		exit 1; \
	fi
	./simv $(RUN_FLAGS) -ucli -i dump.tcl
	@echo "================================================================="
	@echo " Simulation finished."
	@echo " To view waveforms: make -f Makefile.sv wave"
	@echo " To view coverage : make -f Makefile.sv cov"
	@echo "================================================================="

# --- Waveform Target (Verdi) ---
wave:
	@if [ ! -f novas.fsdb ]; then \
		echo "WARNING: novas.fsdb not found. Ensure simulation ran successfully."; \
	fi
	verdi -nologo -simflow -dbdir simv.daidir -ssf novas.fsdb &

# --- Coverage Target (URG + Verdi) ---
cov:
	@if [ ! -d simv.vdb ]; then \
		echo "ERROR: Coverage database simv.vdb not found. Did you run the simulation?"; \
		exit 1; \
	fi
	urg -dir simv.vdb -format both -report urgReport
	verdi -nologo -cov -covdir simv.vdb &

# --- Clean Target ---
clean:
	rm -rf csrc simv simv.* *.log *.fsdb *.key novas* verdi* urgReport *.vdb DVEfiles *.vpd dump.tcl vc_hdrs.h .inter.vpd.uvm
