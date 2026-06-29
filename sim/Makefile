# ==============================================================================
# AXI VIP Simulation Makefile (Channelized Architecture Layout)
# ==============================================================================

# --- Simulator Selection ---
# Options: vcs | questa
SIMULATOR ?= vcs

# --- Directory Paths ---
ROOT_DIR  := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/..
RTL_DIR   := $(ROOT_DIR)/rtl
SRC_DIR   := $(ROOT_DIR)/src
SIM_DIR   := $(ROOT_DIR)/sim

# --- Testbench Settings ---
TESTNAME  ?= axi_sanity_test 
VERBOSITY ?= UVM_HIGH
SEED      ?= random

# ==============================================================================
# EXPLICIT INCLUDE DIRECTORIES (Maps All VIP Folders)
# ==============================================================================
INC_DIRS += +incdir+$(SRC_DIR)
INC_DIRS += +incdir+$(SRC_DIR)/packages
INC_DIRS += +incdir+$(SRC_DIR)/sb
INC_DIRS += +incdir+$(SRC_DIR)/tests
INC_DIRS += +incdir+$(SRC_DIR)/vseq
INC_DIRS += +incdir+$(SRC_DIR)/vseq/vsequencer
INC_DIRS += +incdir+$(SRC_DIR)/vseq/vsequences
INC_DIRS += +incdir+$(SRC_DIR)/sequences
INC_DIRS += +incdir+$(SRC_DIR)/sequences/master_sequences
INC_DIRS += +incdir+$(SRC_DIR)/sequences/slave_sequences

# Master Core & Channel Drivers
INC_DIRS += +incdir+$(SRC_DIR)/master
INC_DIRS += +incdir+$(SRC_DIR)/master/drivers/aw_channel
INC_DIRS += +incdir+$(SRC_DIR)/master/drivers/w_channel
INC_DIRS += +incdir+$(SRC_DIR)/master/drivers/b_channel
INC_DIRS += +incdir+$(SRC_DIR)/master/drivers/ar_channel
INC_DIRS += +incdir+$(SRC_DIR)/master/drivers/r_channel

# Master Channel Monitors
INC_DIRS += +incdir+$(SRC_DIR)/master/monitors/aw_channel
INC_DIRS += +incdir+$(SRC_DIR)/master/monitors/w_channel
INC_DIRS += +incdir+$(SRC_DIR)/master/monitors/b_channel
INC_DIRS += +incdir+$(SRC_DIR)/master/monitors/ar_channel
INC_DIRS += +incdir+$(SRC_DIR)/master/monitors/r_channel

# Slave Core & Channel Responders
INC_DIRS += +incdir+$(SRC_DIR)/slave
INC_DIRS += +incdir+$(SRC_DIR)/slave/drivers
INC_DIRS += +incdir+$(SRC_DIR)/slave/drivers/aw_channel
INC_DIRS += +incdir+$(SRC_DIR)/slave/drivers/w_channel
INC_DIRS += +incdir+$(SRC_DIR)/slave/drivers/b_channel
INC_DIRS += +incdir+$(SRC_DIR)/slave/drivers/ar_channel
INC_DIRS += +incdir+$(SRC_DIR)/slave/drivers/r_channel

# Slave Channel Monitors
INC_DIRS += +incdir+$(SRC_DIR)/slave/monitors/aw_channel
INC_DIRS += +incdir+$(SRC_DIR)/slave/monitors/w_channel
INC_DIRS += +incdir+$(SRC_DIR)/slave/monitors/b_channel
INC_DIRS += +incdir+$(SRC_DIR)/slave/monitors/ar_channel
INC_DIRS += +incdir+$(SRC_DIR)/slave/monitors/r_channel

# ==============================================================================
# SOURCE FILES MATRIX
# ==============================================================================

# Target Design RTL files inside root RTL directory
RTL_FILES += $(wildcard $(RTL_DIR)/*.v) $(wildcard $(RTL_DIR)/*.sv)

# Explicit Package Order (Crucial for resolving structural dependencies)
PKG_FILES += $(SRC_DIR)/packages/axi_package.sv
#PKG_FILES += $(SRC_DIR)/packages/axi_seq_pkg.sv
#PKG_FILES += $(SRC_DIR)/packages/axi_test_pkg.sv

# Top level testbench module location
TB_TOP    := $(SRC_DIR)/axi_tb_top.sv

# --- Tool Command Arguments ---
VCS_FLAGS    := -sverilog -ntb_opts uvm -timescale=1ns/1ps +libext+.v+.svh \
                $(INC_DIRS) -l vcs_comp.log -debug_access+all

QUESTA_FLAGS := -sv -timescale=1ns/1ps $(INC_DIRS)

# ==============================================================================
# Targets Matrix
# ==============================================================================

.PHONY: default compile run wave clean

default: compile run

compile:
	@echo "=================================================================="
	@echo " Compiling using Simulator: $(SIMULATOR)"
	@echo "=================================================================="
	@if [ "$(SIMULATOR)" = "vcs" ]; then \
		vcs $(VCS_FLAGS) $(RTL_FILES) $(PKG_FILES) $(TB_TOP); \
	elif [ "$(SIMULATOR)" = "questa" ]; then \
		vlib work; \
		vlog $(QUESTA_FLAGS) $(RTL_FILES) $(PKG_FILES) $(TB_TOP) -l questa_comp.log; \
	else \
		echo "Error: Unknown SIMULATOR value '$(SIMULATOR)'. Use 'vcs' or 'questa'."; exit 1; \
	fi

run:
	@echo "=================================================================="
	@echo " Running Test: $(TESTNAME) | Seed: $(SEED)"
	@echo "=================================================================="
	@if [ "$(SIMULATOR)" = "vcs" ]; then \
		./simv +UVM_TESTNAME=$(TESTNAME) +UVM_VERBOSITY=$(VERBOSITY) -xmlinst +ntb_random_seed=$(SEED) -l vcs_sim.log; \
	elif [ "$(SIMULATOR)" = "questa" ]; then \
		vsim -c -voptargs="+acc" -do "log -r /*; run -all; quit;" work.axi_tb_top +UVM_TESTNAME=$(TESTNAME) +UVM_VERBOSITY=$(VERBOSITY) -sv_seed $(SEED) -l questa_sim.log; \
	fi

wave:
	@if [ "$(SIMULATOR)" = "vcs" ]; then \
		dve -vpd vcdplus.vpd & \
	elif [ "$(SIMULATOR)" = "questa" ]; then \
		vsim -view vsim.wlf -do wave.do & \
	fi

clean:
	@echo "Cleaning up compilation and simulation artifacts..."
	rm -rf simv* csrc DVEfiles inter.vpd vcdplus.vpd ucli.key *.log
	rm -rf work vsim.wlf transcript modelsim.ini
