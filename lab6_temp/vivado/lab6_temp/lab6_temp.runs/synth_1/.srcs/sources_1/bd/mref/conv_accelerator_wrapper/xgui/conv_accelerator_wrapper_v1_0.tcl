# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "BRAM_DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_AXI_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_AXI_DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DIM_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "FILTER_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "FILTER_BRAM_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "INPUT_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "INPUT_BRAM_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "MAC_DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "MAC_OUTPUT_DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "OUTPUT_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "OUTPUT_BRAM_ADDR_WIDTH" -parent ${Page_0}


}

proc update_PARAM_VALUE.BRAM_DATA_WIDTH { PARAM_VALUE.BRAM_DATA_WIDTH } {
	# Procedure called to update BRAM_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BRAM_DATA_WIDTH { PARAM_VALUE.BRAM_DATA_WIDTH } {
	# Procedure called to validate BRAM_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_AXI_ADDR_WIDTH { PARAM_VALUE.C_AXI_ADDR_WIDTH } {
	# Procedure called to update C_AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_AXI_ADDR_WIDTH { PARAM_VALUE.C_AXI_ADDR_WIDTH } {
	# Procedure called to validate C_AXI_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_AXI_DATA_WIDTH { PARAM_VALUE.C_AXI_DATA_WIDTH } {
	# Procedure called to update C_AXI_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_AXI_DATA_WIDTH { PARAM_VALUE.C_AXI_DATA_WIDTH } {
	# Procedure called to validate C_AXI_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.DIM_WIDTH { PARAM_VALUE.DIM_WIDTH } {
	# Procedure called to update DIM_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DIM_WIDTH { PARAM_VALUE.DIM_WIDTH } {
	# Procedure called to validate DIM_WIDTH
	return true
}

proc update_PARAM_VALUE.FILTER_ADDR_WIDTH { PARAM_VALUE.FILTER_ADDR_WIDTH } {
	# Procedure called to update FILTER_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FILTER_ADDR_WIDTH { PARAM_VALUE.FILTER_ADDR_WIDTH } {
	# Procedure called to validate FILTER_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.FILTER_BRAM_ADDR_WIDTH { PARAM_VALUE.FILTER_BRAM_ADDR_WIDTH } {
	# Procedure called to update FILTER_BRAM_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FILTER_BRAM_ADDR_WIDTH { PARAM_VALUE.FILTER_BRAM_ADDR_WIDTH } {
	# Procedure called to validate FILTER_BRAM_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.INPUT_ADDR_WIDTH { PARAM_VALUE.INPUT_ADDR_WIDTH } {
	# Procedure called to update INPUT_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INPUT_ADDR_WIDTH { PARAM_VALUE.INPUT_ADDR_WIDTH } {
	# Procedure called to validate INPUT_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.INPUT_BRAM_ADDR_WIDTH { PARAM_VALUE.INPUT_BRAM_ADDR_WIDTH } {
	# Procedure called to update INPUT_BRAM_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INPUT_BRAM_ADDR_WIDTH { PARAM_VALUE.INPUT_BRAM_ADDR_WIDTH } {
	# Procedure called to validate INPUT_BRAM_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.MAC_DATA_WIDTH { PARAM_VALUE.MAC_DATA_WIDTH } {
	# Procedure called to update MAC_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MAC_DATA_WIDTH { PARAM_VALUE.MAC_DATA_WIDTH } {
	# Procedure called to validate MAC_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.MAC_OUTPUT_DATA_WIDTH { PARAM_VALUE.MAC_OUTPUT_DATA_WIDTH } {
	# Procedure called to update MAC_OUTPUT_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MAC_OUTPUT_DATA_WIDTH { PARAM_VALUE.MAC_OUTPUT_DATA_WIDTH } {
	# Procedure called to validate MAC_OUTPUT_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.OUTPUT_ADDR_WIDTH { PARAM_VALUE.OUTPUT_ADDR_WIDTH } {
	# Procedure called to update OUTPUT_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OUTPUT_ADDR_WIDTH { PARAM_VALUE.OUTPUT_ADDR_WIDTH } {
	# Procedure called to validate OUTPUT_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.OUTPUT_BRAM_ADDR_WIDTH { PARAM_VALUE.OUTPUT_BRAM_ADDR_WIDTH } {
	# Procedure called to update OUTPUT_BRAM_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OUTPUT_BRAM_ADDR_WIDTH { PARAM_VALUE.OUTPUT_BRAM_ADDR_WIDTH } {
	# Procedure called to validate OUTPUT_BRAM_ADDR_WIDTH
	return true
}


proc update_MODELPARAM_VALUE.C_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_AXI_ADDR_WIDTH PARAM_VALUE.C_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.C_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_AXI_DATA_WIDTH PARAM_VALUE.C_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.DIM_WIDTH { MODELPARAM_VALUE.DIM_WIDTH PARAM_VALUE.DIM_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DIM_WIDTH}] ${MODELPARAM_VALUE.DIM_WIDTH}
}

proc update_MODELPARAM_VALUE.INPUT_ADDR_WIDTH { MODELPARAM_VALUE.INPUT_ADDR_WIDTH PARAM_VALUE.INPUT_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INPUT_ADDR_WIDTH}] ${MODELPARAM_VALUE.INPUT_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.FILTER_ADDR_WIDTH { MODELPARAM_VALUE.FILTER_ADDR_WIDTH PARAM_VALUE.FILTER_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FILTER_ADDR_WIDTH}] ${MODELPARAM_VALUE.FILTER_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.OUTPUT_ADDR_WIDTH { MODELPARAM_VALUE.OUTPUT_ADDR_WIDTH PARAM_VALUE.OUTPUT_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OUTPUT_ADDR_WIDTH}] ${MODELPARAM_VALUE.OUTPUT_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.INPUT_BRAM_ADDR_WIDTH { MODELPARAM_VALUE.INPUT_BRAM_ADDR_WIDTH PARAM_VALUE.INPUT_BRAM_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INPUT_BRAM_ADDR_WIDTH}] ${MODELPARAM_VALUE.INPUT_BRAM_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.FILTER_BRAM_ADDR_WIDTH { MODELPARAM_VALUE.FILTER_BRAM_ADDR_WIDTH PARAM_VALUE.FILTER_BRAM_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FILTER_BRAM_ADDR_WIDTH}] ${MODELPARAM_VALUE.FILTER_BRAM_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.OUTPUT_BRAM_ADDR_WIDTH { MODELPARAM_VALUE.OUTPUT_BRAM_ADDR_WIDTH PARAM_VALUE.OUTPUT_BRAM_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OUTPUT_BRAM_ADDR_WIDTH}] ${MODELPARAM_VALUE.OUTPUT_BRAM_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.BRAM_DATA_WIDTH { MODELPARAM_VALUE.BRAM_DATA_WIDTH PARAM_VALUE.BRAM_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BRAM_DATA_WIDTH}] ${MODELPARAM_VALUE.BRAM_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.MAC_DATA_WIDTH { MODELPARAM_VALUE.MAC_DATA_WIDTH PARAM_VALUE.MAC_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MAC_DATA_WIDTH}] ${MODELPARAM_VALUE.MAC_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.MAC_OUTPUT_DATA_WIDTH { MODELPARAM_VALUE.MAC_OUTPUT_DATA_WIDTH PARAM_VALUE.MAC_OUTPUT_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MAC_OUTPUT_DATA_WIDTH}] ${MODELPARAM_VALUE.MAC_OUTPUT_DATA_WIDTH}
}

