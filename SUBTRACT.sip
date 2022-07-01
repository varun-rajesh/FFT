set_global_assignment -entity "SUBTRACT" -library "lib_SUBTRACT" -name IP_TOOL_NAME "altera_fp_functions"
set_global_assignment -entity "SUBTRACT" -library "lib_SUBTRACT" -name IP_TOOL_VERSION "20.1"
set_global_assignment -entity "SUBTRACT" -library "lib_SUBTRACT" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_SUBTRACT" -name SPD_FILE [file join $::quartus(sip_path) "SUBTRACT.spd"]

set_global_assignment -library "lib_SUBTRACT" -name MISC_FILE [file join $::quartus(sip_path) "SUBTRACT_sim/SUBTRACT.vo"]
