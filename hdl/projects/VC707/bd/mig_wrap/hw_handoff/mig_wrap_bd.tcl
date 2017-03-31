
################################################################
# This is a generated script based on design: mig_wrap
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2016.4
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source mig_wrap_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7vx485tffg1761-2
   set_property BOARD_PART xilinx.com:vc707:part0:1.3 [current_project]
}


# CHANGE DESIGN NAME HERE
set design_name mig_wrap

# This script was generated for a remote BD. To create a non-remote design,
# change the variable <run_remote_bd_flow> to <0>.

set run_remote_bd_flow 1
if { $run_remote_bd_flow == 1 } {
  # Set the reference directory for source file relative paths (by default 
  # the value is script directory path)
  set origin_dir ./bd

  # Use origin directory path location variable, if specified in the tcl shell
  if { [info exists ::origin_dir_loc] } {
     set origin_dir $::origin_dir_loc
  }

  set str_bd_folder [file normalize ${origin_dir}]
  set str_bd_filepath ${str_bd_folder}/${design_name}/${design_name}.bd

  # Check if remote design exists on disk
  if { [file exists $str_bd_filepath ] == 1 } {
     catch {common::send_msg_id "BD_TCL-110" "ERROR" "The remote BD file path <$str_bd_filepath> already exists!"}
     common::send_msg_id "BD_TCL-008" "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0>."
     common::send_msg_id "BD_TCL-009" "INFO" "Also make sure there is no design <$design_name> existing in your current project."

     return 1
  }

  # Check if design exists in memory
  set list_existing_designs [get_bd_designs -quiet $design_name]
  if { $list_existing_designs ne "" } {
     catch {common::send_msg_id "BD_TCL-111" "ERROR" "The design <$design_name> already exists in this project! Will not create the remote BD <$design_name> at the folder <$str_bd_folder>."}

     common::send_msg_id "BD_TCL-010" "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0> or please set a different value to variable <design_name>."

     return 1
  }

  # Check if design exists on disk within project
  set list_existing_designs [get_files */${design_name}.bd]
  if { $list_existing_designs ne "" } {
     catch {common::send_msg_id "BD_TCL-112" "ERROR" "The design <$design_name> already exists in this project at location:
    $list_existing_designs"}
     catch {common::send_msg_id "BD_TCL-113" "ERROR" "Will not create the remote BD <$design_name> at the folder <$str_bd_folder>."}

     common::send_msg_id "BD_TCL-011" "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0> or please set a different value to variable <design_name>."

     return 1
  }

  # Now can create the remote BD
  # NOTE - usage of <-dir> will create <$str_bd_folder/$design_name/$design_name.bd>
  create_bd_design -dir $str_bd_folder $design_name
} else {

  # Create regular design
  if { [catch {create_bd_design $design_name} errmsg] } {
     common::send_msg_id "BD_TCL-012" "INFO" "Please set a different value to variable <design_name>."

     return 1
  }
}

current_bd_design $design_name


##################################################################
# MIG PRJ FILE TCL PROCs
##################################################################

proc write_mig_file_mig_wrap_mig_7series_0_0 { str_mig_prj_filepath } {

   set mig_prj_file [open $str_mig_prj_filepath  w+]

   puts $mig_prj_file {<?xml version='1.0' encoding='UTF-8'?>}
   puts $mig_prj_file {<!-- IMPORTANT: This is an internal file that has been generated by the MIG software. Any direct editing or changes made to this file may result in unpredictable behavior or data corruption. It is strongly advised that users do not edit the contents of this file. Re-run the MIG GUI with the required settings if any of the options provided below need to be altered. -->}
   puts $mig_prj_file {<Project NoOfControllers="1" >}
   puts $mig_prj_file {    <ModuleName>mig_wrap_mig_7series_0_0</ModuleName>}
   puts $mig_prj_file {    <dci_inouts_inputs>1</dci_inouts_inputs>}
   puts $mig_prj_file {    <dci_inputs>1</dci_inputs>}
   puts $mig_prj_file {    <Debug_En>OFF</Debug_En>}
   puts $mig_prj_file {    <DataDepth_En>1024</DataDepth_En>}
   puts $mig_prj_file {    <LowPower_En>ON</LowPower_En>}
   puts $mig_prj_file {    <XADC_En>Enabled</XADC_En>}
   puts $mig_prj_file {    <TargetFPGA>xc7vx485t-ffg1761/-2</TargetFPGA>}
   puts $mig_prj_file {    <Version>4.0</Version>}
   puts $mig_prj_file {    <SystemClock>Single-Ended</SystemClock>}
   puts $mig_prj_file {    <ReferenceClock>Use System Clock</ReferenceClock>}
   puts $mig_prj_file {    <SysResetPolarity>ACTIVE LOW</SysResetPolarity>}
   puts $mig_prj_file {    <BankSelectionFlag>TRUE</BankSelectionFlag>}
   puts $mig_prj_file {    <InternalVref>0</InternalVref>}
   puts $mig_prj_file {    <dci_hr_inouts_inputs>50 Ohms</dci_hr_inouts_inputs>}
   puts $mig_prj_file {    <dci_cascade>0</dci_cascade>}
   puts $mig_prj_file {    <FPGADevice>}
   puts $mig_prj_file {        <selected>7v/xc7v585t-ffg1761</selected>}
   puts $mig_prj_file {    </FPGADevice>}
   puts $mig_prj_file {    <Controller number="0" >}
   puts $mig_prj_file {        <MemoryDevice>DDR3_SDRAM/SODIMMs/MT8JTF12864HZ-1G6</MemoryDevice>}
   puts $mig_prj_file {        <TimePeriod>1250</TimePeriod>}
   puts $mig_prj_file {        <VccAuxIO>2.0V</VccAuxIO>}
   puts $mig_prj_file {        <PHYRatio>4:1</PHYRatio>}
   puts $mig_prj_file {        <InputClkFreq>200</InputClkFreq>}
   puts $mig_prj_file {        <UIExtraClocks>0</UIExtraClocks>}
   puts $mig_prj_file {        <MMCM_VCO>800</MMCM_VCO>}
   puts $mig_prj_file {        <MMCMClkOut0> 1.000</MMCMClkOut0>}
   puts $mig_prj_file {        <MMCMClkOut1>1</MMCMClkOut1>}
   puts $mig_prj_file {        <MMCMClkOut2>1</MMCMClkOut2>}
   puts $mig_prj_file {        <MMCMClkOut3>1</MMCMClkOut3>}
   puts $mig_prj_file {        <MMCMClkOut4>1</MMCMClkOut4>}
   puts $mig_prj_file {        <DataWidth>64</DataWidth>}
   puts $mig_prj_file {        <DeepMemory>1</DeepMemory>}
   puts $mig_prj_file {        <DataMask>1</DataMask>}
   puts $mig_prj_file {        <ECC>Disabled</ECC>}
   puts $mig_prj_file {        <Ordering>Normal</Ordering>}
   puts $mig_prj_file {        <BankMachineCnt>4</BankMachineCnt>}
   puts $mig_prj_file {        <CustomPart>FALSE</CustomPart>}
   puts $mig_prj_file {        <NewPartName></NewPartName>}
   puts $mig_prj_file {        <RowAddress>14</RowAddress>}
   puts $mig_prj_file {        <ColAddress>10</ColAddress>}
   puts $mig_prj_file {        <BankAddress>3</BankAddress>}
   puts $mig_prj_file {        <MemoryVoltage>1.5V</MemoryVoltage>}
   puts $mig_prj_file {        <C0_MEM_SIZE>1073741824</C0_MEM_SIZE>}
   puts $mig_prj_file {        <UserMemoryAddressMap>BANK_ROW_COLUMN</UserMemoryAddressMap>}
   puts $mig_prj_file {        <BankSelection>}
   puts $mig_prj_file {            <Bank T2="DQ[48-55]" T3="DQ[56-63]" name="37" T0="DQ[32-39]" T1="DQ[40-47]" />}
   puts $mig_prj_file {            <Bank T2="Address/Ctrl-2" name="38" T0="Address/Ctrl-0" T1="Address/Ctrl-1" />}
   puts $mig_prj_file {            <Bank T2="DQ[16-23]" T3="DQ[24-31]" name="39" T0="DQ[0-7]" T1="DQ[8-15]" />}
   puts $mig_prj_file {        </BankSelection>}
   puts $mig_prj_file {        <System_Clock>}
   puts $mig_prj_file {            <Pin PADName="J25(MRCC_P)" Bank="36" name="sys_clk_i" />}
   puts $mig_prj_file {        </System_Clock>}
   puts $mig_prj_file {        <System_Control>}
   puts $mig_prj_file {            <Pin PADName="No connect" Bank="Select Bank" name="sys_rst" />}
   puts $mig_prj_file {            <Pin PADName="No connect" Bank="Select Bank" name="init_calib_complete" />}
   puts $mig_prj_file {            <Pin PADName="No connect" Bank="Select Bank" name="tg_compare_error" />}
   puts $mig_prj_file {        </System_Control>}
   puts $mig_prj_file {        <TimingParameters>}
   puts $mig_prj_file {            <Parameters twtr="7.5" trrd="6" trefi="7.8" tfaw="30" trtp="7.5" tcke="5" trfc="110" trp="13.75" tras="35" trcd="13.75" />}
   puts $mig_prj_file {        </TimingParameters>}
   puts $mig_prj_file {        <mrBurstLength name="Burst Length" >8 - Fixed</mrBurstLength>}
   puts $mig_prj_file {        <mrBurstType name="Read Burst Type and Length" >Sequential</mrBurstType>}
   puts $mig_prj_file {        <mrCasLatency name="CAS Latency" >11</mrCasLatency>}
   puts $mig_prj_file {        <mrMode name="Mode" >Normal</mrMode>}
   puts $mig_prj_file {        <mrDllReset name="DLL Reset" >No</mrDllReset>}
   puts $mig_prj_file {        <mrPdMode name="DLL control for precharge PD" >Slow Exit</mrPdMode>}
   puts $mig_prj_file {        <emrDllEnable name="DLL Enable" >Enable</emrDllEnable>}
   puts $mig_prj_file {        <emrOutputDriveStrength name="Output Driver Impedance Control" >RZQ/7</emrOutputDriveStrength>}
   puts $mig_prj_file {        <emrMirrorSelection name="Address Mirroring" >Disable</emrMirrorSelection>}
   puts $mig_prj_file {        <emrCSSelection name="Controller Chip Select Pin" >Enable</emrCSSelection>}
   puts $mig_prj_file {        <emrRTT name="RTT (nominal) - On Die Termination (ODT)" >RZQ/4</emrRTT>}
   puts $mig_prj_file {        <emrPosted name="Additive Latency (AL)" >0</emrPosted>}
   puts $mig_prj_file {        <emrOCD name="Write Leveling Enable" >Disabled</emrOCD>}
   puts $mig_prj_file {        <emrDQS name="TDQS enable" >Enabled</emrDQS>}
   puts $mig_prj_file {        <emrRDQS name="Qoff" >Output Buffer Enabled</emrRDQS>}
   puts $mig_prj_file {        <mr2PartialArraySelfRefresh name="Partial-Array Self Refresh" >Full Array</mr2PartialArraySelfRefresh>}
   puts $mig_prj_file {        <mr2CasWriteLatency name="CAS write latency" >8</mr2CasWriteLatency>}
   puts $mig_prj_file {        <mr2AutoSelfRefresh name="Auto Self Refresh" >Enabled</mr2AutoSelfRefresh>}
   puts $mig_prj_file {        <mr2SelfRefreshTempRange name="High Temparature Self Refresh Rate" >Normal</mr2SelfRefreshTempRange>}
   puts $mig_prj_file {        <mr2RTTWR name="RTT_WR - Dynamic On Die Termination (ODT)" >Dynamic ODT off</mr2RTTWR>}
   puts $mig_prj_file {        <PortInterface>AXI</PortInterface>}
   puts $mig_prj_file {        <AXIParameters>}
   puts $mig_prj_file {            <C0_C_RD_WR_ARB_ALGORITHM>RD_PRI_REG</C0_C_RD_WR_ARB_ALGORITHM>}
   puts $mig_prj_file {            <C0_S_AXI_ADDR_WIDTH>30</C0_S_AXI_ADDR_WIDTH>}
   puts $mig_prj_file {            <C0_S_AXI_DATA_WIDTH>512</C0_S_AXI_DATA_WIDTH>}
   puts $mig_prj_file {            <C0_S_AXI_ID_WIDTH>4</C0_S_AXI_ID_WIDTH>}
   puts $mig_prj_file {            <C0_S_AXI_SUPPORTS_NARROW_BURST>1</C0_S_AXI_SUPPORTS_NARROW_BURST>}
   puts $mig_prj_file {        </AXIParameters>}
   puts $mig_prj_file {    </Controller>}
   puts $mig_prj_file {</Project>}

   close $mig_prj_file
}
# End of write_mig_file_mig_wrap_mig_7series_0_0()



##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set DDR3 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR3 ]
  set S00_AXI [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI ]
  set_property -dict [ list \
CONFIG.ADDR_WIDTH {32} \
CONFIG.ARUSER_WIDTH {0} \
CONFIG.AWUSER_WIDTH {0} \
CONFIG.BUSER_WIDTH {0} \
CONFIG.DATA_WIDTH {32} \
CONFIG.HAS_BRESP {1} \
CONFIG.HAS_BURST {1} \
CONFIG.HAS_CACHE {1} \
CONFIG.HAS_LOCK {1} \
CONFIG.HAS_PROT {1} \
CONFIG.HAS_QOS {1} \
CONFIG.HAS_REGION {0} \
CONFIG.HAS_RRESP {1} \
CONFIG.HAS_WSTRB {1} \
CONFIG.ID_WIDTH {4} \
CONFIG.MAX_BURST_LENGTH {256} \
CONFIG.NUM_READ_OUTSTANDING {8} \
CONFIG.NUM_READ_THREADS {1} \
CONFIG.NUM_WRITE_OUTSTANDING {8} \
CONFIG.NUM_WRITE_THREADS {1} \
CONFIG.PROTOCOL {AXI4} \
CONFIG.READ_WRITE_MODE {READ_WRITE} \
CONFIG.RUSER_BITS_PER_BYTE {0} \
CONFIG.RUSER_WIDTH {0} \
CONFIG.SUPPORTS_NARROW_BURST {1} \
CONFIG.WUSER_BITS_PER_BYTE {0} \
CONFIG.WUSER_WIDTH {0} \
 ] $S00_AXI

  # Create ports
  set ACLK [ create_bd_port -dir I -type clk ACLK ]
  set_property -dict [ list \
CONFIG.ASSOCIATED_BUSIF {S00_AXI} \
CONFIG.ASSOCIATED_RESET {ARESETN:S00_ARESETN} \
CONFIG.FREQ_HZ {50000000} \
 ] $ACLK
  set ARESETN [ create_bd_port -dir I -type rst ARESETN ]
  set S00_ARESETN [ create_bd_port -dir I -type rst S00_ARESETN ]
  set sys_clk_i [ create_bd_port -dir I -type clk sys_clk_i ]
  set sys_rst [ create_bd_port -dir I -type rst sys_rst ]

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [ list \
CONFIG.NUM_MI {1} \
 ] $axi_interconnect_0

  # Create instance: mig_7series_0, and set properties
  set mig_7series_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mig_7series:4.0 mig_7series_0 ]

  # Generate the PRJ File for MIG
  set str_mig_folder [get_property IP_DIR [ get_ips [ get_property CONFIG.Component_Name $mig_7series_0 ] ] ]
  set str_mig_file_name mig_b.prj
  set str_mig_file_path ${str_mig_folder}/${str_mig_file_name}

  write_mig_file_mig_wrap_mig_7series_0_0 $str_mig_file_path

  set_property -dict [ list \
CONFIG.BOARD_MIG_PARAM {Custom} \
CONFIG.MIG_DONT_TOUCH_PARAM {Custom} \
CONFIG.RESET_BOARD_INTERFACE {Custom} \
CONFIG.XML_INPUT_FILE {mig_b.prj} \
 ] $mig_7series_0

  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_ports S00_AXI] [get_bd_intf_pins axi_interconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins axi_interconnect_0/M00_AXI] [get_bd_intf_pins mig_7series_0/S_AXI]
  connect_bd_intf_net -intf_net mig_7series_0_DDR3 [get_bd_intf_ports DDR3] [get_bd_intf_pins mig_7series_0/DDR3]

  # Create port connections
  connect_bd_net -net ACLK_1 [get_bd_ports ACLK] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK]
  connect_bd_net -net ARESETN_1 [get_bd_ports ARESETN] [get_bd_pins axi_interconnect_0/ARESETN]
  connect_bd_net -net S00_ARESETN_1 [get_bd_ports S00_ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN]
  connect_bd_net -net mig_7series_0_mmcm_locked [get_bd_pins mig_7series_0/mmcm_locked] [get_bd_pins proc_sys_reset_0/dcm_locked]
  connect_bd_net -net mig_7series_0_ui_clk [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins mig_7series_0/ui_clk] [get_bd_pins proc_sys_reset_0/slowest_sync_clk]
  connect_bd_net -net mig_7series_0_ui_clk_sync_rst [get_bd_pins mig_7series_0/ui_clk_sync_rst] [get_bd_pins proc_sys_reset_0/ext_reset_in]
  connect_bd_net -net proc_sys_reset_0_peripheral_aresetn [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins mig_7series_0/aresetn] [get_bd_pins proc_sys_reset_0/peripheral_aresetn]
  connect_bd_net -net sys_clk_i_1 [get_bd_ports sys_clk_i] [get_bd_pins mig_7series_0/sys_clk_i]
  connect_bd_net -net sys_rst_1 [get_bd_ports sys_rst] [get_bd_pins mig_7series_0/sys_rst]

  # Create address segments
  create_bd_addr_seg -range 0x01000000 -offset 0x01000000 [get_bd_addr_spaces S00_AXI] [get_bd_addr_segs mig_7series_0/memmap/memaddr] SEG_mig_7series_0_memaddr

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.6.5b  2016-09-06 bk=1.3687 VDI=39 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port S00_AXI -pg 1 -y 230 -defaultsOSRD
preplace port sys_rst -pg 1 -y 440 -defaultsOSRD
preplace port ACLK -pg 1 -y 250 -defaultsOSRD
preplace port ARESETN -pg 1 -y 270 -defaultsOSRD
preplace port S00_ARESETN -pg 1 -y 310 -defaultsOSRD
preplace port DDR3 -pg 1 -y 410 -defaultsOSRD
preplace port sys_clk_i -pg 1 -y 460 -defaultsOSRD
preplace inst mig_7series_0 -pg 1 -lvl 3 -y 450 -defaultsOSRD
preplace inst proc_sys_reset_0 -pg 1 -lvl 1 -y 130 -defaultsOSRD
preplace inst axi_interconnect_0 -pg 1 -lvl 2 -y 290 -defaultsOSRD
preplace netloc sys_rst_1 1 0 3 NJ 440 NJ 440 NJ
preplace netloc mig_7series_0_mmcm_locked 1 0 4 40 420 NJ 420 660J 360 920
preplace netloc sys_clk_i_1 1 0 3 NJ 460 NJ 460 NJ
preplace netloc mig_7series_0_DDR3 1 3 1 N
preplace netloc ACLK_1 1 0 2 NJ 250 360
preplace netloc ARESETN_1 1 0 2 NJ 270 NJ
preplace netloc mig_7series_0_ui_clk 1 0 4 30 330 360 410 650J 340 930
preplace netloc S00_AXI_1 1 0 2 NJ 230 NJ
preplace netloc axi_interconnect_0_M00_AXI 1 2 1 670
preplace netloc proc_sys_reset_0_peripheral_aresetn 1 1 2 370 170 680J
preplace netloc mig_7series_0_ui_clk_sync_rst 1 0 4 20 430 NJ 430 690J 330 940
preplace netloc S00_ARESETN_1 1 0 2 NJ 310 NJ
levelinfo -pg 1 0 200 520 810 970 -top 0 -bot 540
",
}

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


