set_global_assignment -entity "COMPLEX_MULTIPLICATION" -library "lib_COMPLEX_MULTIPLICATION" -name IP_TOOL_NAME "altera_fp_functions"
set_global_assignment -entity "COMPLEX_MULTIPLICATION" -library "lib_COMPLEX_MULTIPLICATION" -name IP_TOOL_VERSION "20.1"
set_global_assignment -entity "COMPLEX_MULTIPLICATION" -library "lib_COMPLEX_MULTIPLICATION" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_COMPLEX_MULTIPLICATION" -name SPD_FILE [file join $::quartus(sip_path) "COMPLEX_MULTIPLICATION.spd"]

set_global_assignment -library "lib_COMPLEX_MULTIPLICATION" -name MISC_FILE [file join $::quartus(sip_path) "COMPLEX_MULTIPLICATION_sim/COMPLEX_MULTIPLICATION.vo"]
