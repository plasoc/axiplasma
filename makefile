BASE_DIR = $(shell pwd)

# ideally PROJ_DIR points to the directory where all the generated project files will reside
# (proj.runs/, proj.sim/, etc.). Currently it doesn't because of the way the TCL file was generated
ifndef PROJ_DIR
	PROJ_DIR = $(BASE_DIR)/projects/plasoc/
endif
# PROJ_FILE is the TCL file for generating the project
ifndef PROJ_FILE
	PROJ_FILE = $(BASE_DIR)/hdl/projects/Nexys4/create_project.tcl
endif
# ORIGIN_DIR is equivalent to the directory where the original project that made the TCL file was located
# For example, using Xilinx's naming convention, it would be the directory where the original porj.runs/ dir existed
ifndef ORIGIN_DIR
	ORIGIN_DIR = $(dir $(PROJ_FILE))
endif

# To make a proper TCL file, in Vivado cd to the directory of the project in Vivado using the TCL shell, i.e. if your
# project is named 'CPU' then navigate to the directory containing CPU.runs/, CPU.sim/, etc. and then run the 
# "generate project TCL" command in Vivado. This way everything will be made relative to the base project dir
# and this makefile will run smoothly.

.PHONY: project
project: |$(PROJ_DIR)/$(PROJECT).xpr

$(PROJ_DIR):
	mkdir -p $(PROJ_DIR)

$(PROJ_DIR)/$(PROJECT).xpr: |$(PROJ_DIR)
	cd $(PROJ_DIR); \
	vivado -mode batch -nojournal -nolog -source $(PROJ_FILE) -tclargs --origin_dir $(ORIGIN_DIR); \
	cd $(BASE_DIR)

.PHONY: clean
clean:
	rm -rf $(PROJ_DIR)

.PHONY: open
open:
	cd $(PROJ_DIR); \
	vivado -mode gui $(PROJECT).xpr
