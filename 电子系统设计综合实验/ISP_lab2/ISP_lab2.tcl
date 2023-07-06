
########## Tcl recorder starts at 04/14/23 11:21:48 ##########

set version "2.1"
set proj_dir "D:/MyDucuments/_Junior_1/ElectricSystemDesign/ISP_lab2"
cd $proj_dir

# Get directory paths
set pver $version
regsub -all {\.} $pver {_} pver
set lscfile "lsc_"
append lscfile $pver ".ini"
set lsvini_dir [lindex [array get env LSC_INI_PATH] 1]
set lsvini_path [file join $lsvini_dir $lscfile]
if {[catch {set fid [open $lsvini_path]} msg]} {
	 puts "File Open Error: $lsvini_path"
	 return false
} else {set data [read $fid]; close $fid }
foreach line [split $data '\n'] { 
	set lline [string tolower $line]
	set lline [string trim $lline]
	if {[string compare $lline "\[paths\]"] == 0} { set path 1; continue}
	if {$path && [regexp {^\[} $lline]} {set path 0; break}
	if {$path && [regexp {^bin} $lline]} {set cpld_bin $line; continue}
	if {$path && [regexp {^fpgapath} $lline]} {set fpga_dir $line; continue}
	if {$path && [regexp {^fpgabinpath} $lline]} {set fpga_bin $line}}

set cpld_bin [string range $cpld_bin [expr [string first "=" $cpld_bin]+1] end]
regsub -all "\"" $cpld_bin "" cpld_bin
set cpld_bin [file join $cpld_bin]
set install_dir [string range $cpld_bin 0 [expr [string first "ispcpld" $cpld_bin]-2]]
regsub -all "\"" $install_dir "" install_dir
set install_dir [file join $install_dir]
set fpga_dir [string range $fpga_dir [expr [string first "=" $fpga_dir]+1] end]
regsub -all "\"" $fpga_dir "" fpga_dir
set fpga_dir [file join $fpga_dir]
set fpga_bin [string range $fpga_bin [expr [string first "=" $fpga_bin]+1] end]
regsub -all "\"" $fpga_bin "" fpga_bin
set fpga_bin [file join $fpga_bin]

if {[string match "*$fpga_bin;*" $env(PATH)] == 0 } {
   set env(PATH) "$fpga_bin;$env(PATH)" }

if {[string match "*$cpld_bin;*" $env(PATH)] == 0 } {
   set env(PATH) "$cpld_bin;$env(PATH)" }

lappend auto_path [file join $install_dir "ispcpld" "tcltk" "lib" "ispwidget" "runproc"]
package require runcmd

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_0_9.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/14/23 11:21:48 ###########


########## Tcl recorder starts at 04/14/23 11:34:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_0_9.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/14/23 11:34:35 ###########


########## Tcl recorder starts at 04/21/23 01:20:09 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_0_9.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 01:20:09 ###########


########## Tcl recorder starts at 04/21/23 01:29:46 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_0_9.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 01:29:46 ###########


########## Tcl recorder starts at 04/21/23 01:29:46 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open Counter_0_9.cmd w} rspFile] {
	puts stderr "Cannot create response file Counter_0_9.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: Counter_0_9
WORKING_PATH: \"$proj_dir\"
MODULE: Counter_0_9
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h counter_0_9.v
OUTPUT_FILE_NAME: Counter_0_9
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e Counter_0_9 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete Counter_0_9.cmd

########## Tcl recorder end at 04/21/23 01:29:46 ###########


########## Tcl recorder starts at 04/21/23 01:40:56 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 01:40:56 ###########


########## Tcl recorder starts at 04/21/23 01:46:58 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" clk_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 01:46:58 ###########


########## Tcl recorder starts at 04/21/23 02:50:57 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" clk_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 02:50:57 ###########


########## Tcl recorder starts at 04/21/23 02:50:57 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open counter_n.cmd w} rspFile] {
	puts stderr "Cannot create response file counter_n.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: counter_n
WORKING_PATH: \"$proj_dir\"
MODULE: counter_n
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h counter_n.v
OUTPUT_FILE_NAME: counter_n
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e counter_n -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete counter_n.cmd

########## Tcl recorder end at 04/21/23 02:50:57 ###########


########## Tcl recorder starts at 04/21/23 02:51:39 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open clk_gen.cmd w} rspFile] {
	puts stderr "Cannot create response file clk_gen.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: clk_gen
WORKING_PATH: \"$proj_dir\"
MODULE: clk_gen
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h clk_gen.v
OUTPUT_FILE_NAME: clk_gen
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e clk_gen -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete clk_gen.cmd

########## Tcl recorder end at 04/21/23 02:51:39 ###########


########## Tcl recorder starts at 04/21/23 02:53:46 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" ledscan_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 02:53:46 ###########


########## Tcl recorder starts at 04/21/23 02:54:38 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ledscan_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 02:54:38 ###########


########## Tcl recorder starts at 04/21/23 02:54:54 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ledscan_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 02:54:54 ###########


########## Tcl recorder starts at 04/21/23 02:55:00 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ledscan_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 02:55:00 ###########


########## Tcl recorder starts at 04/21/23 02:55:00 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open LEDscan.cmd w} rspFile] {
	puts stderr "Cannot create response file LEDscan.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: LEDscan
WORKING_PATH: \"$proj_dir\"
MODULE: LEDscan
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h ledscan_n.v
OUTPUT_FILE_NAME: LEDscan
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LEDscan -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LEDscan.cmd

########## Tcl recorder end at 04/21/23 02:55:00 ###########


########## Tcl recorder starts at 04/21/23 02:55:49 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ledscan_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 02:55:49 ###########


########## Tcl recorder starts at 04/21/23 02:55:50 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open LEDscan.cmd w} rspFile] {
	puts stderr "Cannot create response file LEDscan.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: LEDscan
WORKING_PATH: \"$proj_dir\"
MODULE: LEDscan
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h ledscan_n.v
OUTPUT_FILE_NAME: LEDscan
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LEDscan -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LEDscan.cmd

########## Tcl recorder end at 04/21/23 02:55:50 ###########


########## Tcl recorder starts at 04/21/23 02:57:39 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ledscan_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 02:57:39 ###########


########## Tcl recorder starts at 04/21/23 02:57:39 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open LEDscan.cmd w} rspFile] {
	puts stderr "Cannot create response file LEDscan.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: LEDscan
WORKING_PATH: \"$proj_dir\"
MODULE: LEDscan
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h ledscan_n.v
OUTPUT_FILE_NAME: LEDscan
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LEDscan -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LEDscan.cmd

########## Tcl recorder end at 04/21/23 02:57:39 ###########


########## Tcl recorder starts at 04/21/23 02:59:30 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ledscan_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 02:59:30 ###########


########## Tcl recorder starts at 04/21/23 02:59:30 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open LEDscan.cmd w} rspFile] {
	puts stderr "Cannot create response file LEDscan.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: LEDscan
WORKING_PATH: \"$proj_dir\"
MODULE: LEDscan
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h ledscan_n.v
OUTPUT_FILE_NAME: LEDscan
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LEDscan -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LEDscan.cmd

########## Tcl recorder end at 04/21/23 02:59:30 ###########


########## Tcl recorder starts at 04/21/23 03:00:12 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open counter_n.cmd w} rspFile] {
	puts stderr "Cannot create response file counter_n.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: counter_n
WORKING_PATH: \"$proj_dir\"
MODULE: counter_n
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h counter_n.v
OUTPUT_FILE_NAME: counter_n
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e counter_n -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete counter_n.cmd

########## Tcl recorder end at 04/21/23 03:00:12 ###########


########## Tcl recorder starts at 04/21/23 03:04:02 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" button.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 03:04:02 ###########


########## Tcl recorder starts at 04/21/23 03:26:27 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" button.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncer.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 03:26:27 ###########


########## Tcl recorder starts at 04/21/23 03:26:38 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncer.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 03:26:38 ###########


########## Tcl recorder starts at 04/21/23 03:27:50 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" controller.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 03:27:50 ###########


########## Tcl recorder starts at 04/21/23 03:27:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" controller.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 03:27:59 ###########


########## Tcl recorder starts at 04/21/23 03:28:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" timer.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 03:28:20 ###########


########## Tcl recorder starts at 04/21/23 03:28:30 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" timer.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 03:28:30 ###########


########## Tcl recorder starts at 04/21/23 03:30:56 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" synchronizer.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 03:30:56 ###########


########## Tcl recorder starts at 04/21/23 03:30:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" synchronizer.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 03:30:59 ###########


########## Tcl recorder starts at 04/21/23 03:31:42 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" width_trans.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 03:31:42 ###########


########## Tcl recorder starts at 04/21/23 03:31:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" width_trans.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 03:31:47 ###########


########## Tcl recorder starts at 04/21/23 03:32:22 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 03:32:22 ###########


########## Tcl recorder starts at 04/21/23 03:32:26 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 03:32:26 ###########


########## Tcl recorder starts at 04/21/23 03:35:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" clk_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 03:35:17 ###########


########## Tcl recorder starts at 04/21/23 03:36:49 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ledscan_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" clk_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 03:36:49 ###########


########## Tcl recorder starts at 04/21/23 08:39:13 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ledscan_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncer.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" button.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" clk_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 08:39:13 ###########


########## Tcl recorder starts at 04/21/23 08:39:15 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open button.cmd w} rspFile] {
	puts stderr "Cannot create response file button.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: button
WORKING_PATH: \"$proj_dir\"
MODULE: button
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h dffre.v width_trans.v controller.v timer.v debouncer.v synchronizer.v button.v
OUTPUT_FILE_NAME: button
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e button -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete button.cmd

########## Tcl recorder end at 04/21/23 08:39:15 ###########


########## Tcl recorder starts at 04/21/23 08:40:52 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open controller.cmd w} rspFile] {
	puts stderr "Cannot create response file controller.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: controller
WORKING_PATH: \"$proj_dir\"
MODULE: controller
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h controller.v
OUTPUT_FILE_NAME: controller
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e controller -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete controller.cmd

########## Tcl recorder end at 04/21/23 08:40:52 ###########


########## Tcl recorder starts at 04/21/23 08:41:27 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open timer.cmd w} rspFile] {
	puts stderr "Cannot create response file timer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: timer
WORKING_PATH: \"$proj_dir\"
MODULE: timer
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h timer.v
OUTPUT_FILE_NAME: timer
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e timer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete timer.cmd

########## Tcl recorder end at 04/21/23 08:41:27 ###########


########## Tcl recorder starts at 04/21/23 08:44:33 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncer.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" clk_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 08:44:33 ###########


########## Tcl recorder starts at 04/21/23 08:44:37 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" ledscan_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" width_trans.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" button.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" synchronizer.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" controller.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 08:44:37 ###########


########## Tcl recorder starts at 04/21/23 08:44:39 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open counter_n.cmd w} rspFile] {
	puts stderr "Cannot create response file counter_n.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: counter_n
WORKING_PATH: \"$proj_dir\"
MODULE: counter_n
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h counter_n.v
OUTPUT_FILE_NAME: counter_n
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e counter_n -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete counter_n.cmd

########## Tcl recorder end at 04/21/23 08:44:39 ###########


########## Tcl recorder starts at 04/21/23 08:45:14 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open controller.cmd w} rspFile] {
	puts stderr "Cannot create response file controller.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: controller
WORKING_PATH: \"$proj_dir\"
MODULE: controller
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h controller.v
OUTPUT_FILE_NAME: controller
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e controller -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete controller.cmd

########## Tcl recorder end at 04/21/23 08:45:14 ###########


########## Tcl recorder starts at 04/21/23 08:45:48 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open debouncer.cmd w} rspFile] {
	puts stderr "Cannot create response file debouncer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: debouncer
WORKING_PATH: \"$proj_dir\"
MODULE: debouncer
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h controller.v counter_n.v debouncer.v
OUTPUT_FILE_NAME: debouncer
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e debouncer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete debouncer.cmd

########## Tcl recorder end at 04/21/23 08:45:48 ###########


########## Tcl recorder starts at 04/21/23 08:47:06 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncer.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 08:47:06 ###########


########## Tcl recorder starts at 04/21/23 08:47:07 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open debouncer.cmd w} rspFile] {
	puts stderr "Cannot create response file debouncer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: debouncer
WORKING_PATH: \"$proj_dir\"
MODULE: debouncer
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h controller.v counter_n.v debouncer.v
OUTPUT_FILE_NAME: debouncer
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e debouncer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete debouncer.cmd

########## Tcl recorder end at 04/21/23 08:47:07 ###########


########## Tcl recorder starts at 04/21/23 08:47:45 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open dffre.cmd w} rspFile] {
	puts stderr "Cannot create response file dffre.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: dffre
WORKING_PATH: \"$proj_dir\"
MODULE: dffre
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h dffre.v
OUTPUT_FILE_NAME: dffre
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e dffre -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete dffre.cmd

########## Tcl recorder end at 04/21/23 08:47:45 ###########


########## Tcl recorder starts at 04/21/23 08:48:28 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open synchro.cmd w} rspFile] {
	puts stderr "Cannot create response file synchro.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: synchro
WORKING_PATH: \"$proj_dir\"
MODULE: synchro
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h dffre.v synchronizer.v
OUTPUT_FILE_NAME: synchro
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e synchro -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete synchro.cmd

########## Tcl recorder end at 04/21/23 08:48:28 ###########


########## Tcl recorder starts at 04/21/23 08:49:06 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open width_trans.cmd w} rspFile] {
	puts stderr "Cannot create response file width_trans.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: width_trans
WORKING_PATH: \"$proj_dir\"
MODULE: width_trans
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h dffre.v width_trans.v
OUTPUT_FILE_NAME: width_trans
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e width_trans -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete width_trans.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf width_trans.edi -out width_trans.bl0 -err automake.err -log width_trans.log -prj isp_lab2 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 08:49:06 ###########


########## Tcl recorder starts at 04/21/23 08:49:42 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open clk_gen.cmd w} rspFile] {
	puts stderr "Cannot create response file clk_gen.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: clk_gen
WORKING_PATH: \"$proj_dir\"
MODULE: clk_gen
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h counter_n.v clk_gen.v
OUTPUT_FILE_NAME: clk_gen
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e clk_gen -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete clk_gen.cmd

########## Tcl recorder end at 04/21/23 08:49:42 ###########


########## Tcl recorder starts at 04/21/23 08:50:55 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" clk_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 08:50:55 ###########


########## Tcl recorder starts at 04/21/23 08:50:55 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open clk_gen.cmd w} rspFile] {
	puts stderr "Cannot create response file clk_gen.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: clk_gen
WORKING_PATH: \"$proj_dir\"
MODULE: clk_gen
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h counter_n.v clk_gen.v
OUTPUT_FILE_NAME: clk_gen
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e clk_gen -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete clk_gen.cmd

########## Tcl recorder end at 04/21/23 08:50:55 ###########


########## Tcl recorder starts at 04/21/23 08:52:13 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" clk_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 08:52:13 ###########


########## Tcl recorder starts at 04/21/23 08:52:14 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open clk_gen.cmd w} rspFile] {
	puts stderr "Cannot create response file clk_gen.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: clk_gen
WORKING_PATH: \"$proj_dir\"
MODULE: clk_gen
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h counter_n.v clk_gen.v
OUTPUT_FILE_NAME: clk_gen
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e clk_gen -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete clk_gen.cmd

########## Tcl recorder end at 04/21/23 08:52:14 ###########


########## Tcl recorder starts at 04/21/23 08:53:16 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open LEDscan.cmd w} rspFile] {
	puts stderr "Cannot create response file LEDscan.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: LEDscan
WORKING_PATH: \"$proj_dir\"
MODULE: LEDscan
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h ledscan_n.v
OUTPUT_FILE_NAME: LEDscan
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LEDscan -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LEDscan.cmd

########## Tcl recorder end at 04/21/23 08:53:16 ###########


########## Tcl recorder starts at 04/21/23 08:53:52 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ledscan_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 08:53:52 ###########


########## Tcl recorder starts at 04/21/23 08:53:53 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open LEDscan.cmd w} rspFile] {
	puts stderr "Cannot create response file LEDscan.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: LEDscan
WORKING_PATH: \"$proj_dir\"
MODULE: LEDscan
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h ledscan_n.v
OUTPUT_FILE_NAME: LEDscan
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LEDscan -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LEDscan.cmd

########## Tcl recorder end at 04/21/23 08:53:53 ###########


########## Tcl recorder starts at 04/21/23 08:57:05 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ledscan_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" random_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 08:57:05 ###########


########## Tcl recorder starts at 04/21/23 09:06:02 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" random_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" clk_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 09:06:02 ###########


########## Tcl recorder starts at 04/21/23 09:06:03 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open random_gen.cmd w} rspFile] {
	puts stderr "Cannot create response file random_gen.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: random_gen
WORKING_PATH: \"$proj_dir\"
MODULE: random_gen
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h counter_n.v random_gen.v
OUTPUT_FILE_NAME: random_gen
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e random_gen -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete random_gen.cmd

########## Tcl recorder end at 04/21/23 09:06:03 ###########


########## Tcl recorder starts at 04/21/23 09:07:27 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 09:07:27 ###########


########## Tcl recorder starts at 04/21/23 09:45:42 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" button.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" random_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 09:45:42 ###########


########## Tcl recorder starts at 04/21/23 09:45:43 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open button.cmd w} rspFile] {
	puts stderr "Cannot create response file button.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: button
WORKING_PATH: \"$proj_dir\"
MODULE: button
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h dffre.v width_trans.v controller.v counter_n.v debouncer.v synchronizer.v button.v
OUTPUT_FILE_NAME: button
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e button -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete button.cmd

########## Tcl recorder end at 04/21/23 09:45:43 ###########


########## Tcl recorder starts at 04/21/23 10:15:55 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" random_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" clk_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 10:15:55 ###########


########## Tcl recorder starts at 04/21/23 10:15:56 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h ledscan_n.v counter_n.v random_gen.v clk_gen.v dffre.v width_trans.v controller.v debouncer.v synchronizer.v button.v top_level.v
OUTPUT_FILE_NAME: top_level
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e top_level -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete top_level.cmd

########## Tcl recorder end at 04/21/23 10:15:56 ###########


########## Tcl recorder starts at 04/21/23 10:16:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 10:16:47 ###########


########## Tcl recorder starts at 04/21/23 10:16:47 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h ledscan_n.v counter_n.v random_gen.v clk_gen.v dffre.v width_trans.v controller.v debouncer.v synchronizer.v button.v top_level.v
OUTPUT_FILE_NAME: top_level
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e top_level -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete top_level.cmd

########## Tcl recorder end at 04/21/23 10:16:47 ###########


########## Tcl recorder starts at 04/21/23 10:20:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" random_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 10:20:35 ###########


########## Tcl recorder starts at 04/21/23 10:20:36 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h ledscan_n.v counter_n.v random_gen.v clk_gen.v dffre.v width_trans.v controller.v debouncer.v synchronizer.v button.v top_level.v
OUTPUT_FILE_NAME: top_level
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e top_level -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete top_level.cmd

########## Tcl recorder end at 04/21/23 10:20:36 ###########


########## Tcl recorder starts at 04/21/23 10:22:14 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 10:22:14 ###########


########## Tcl recorder starts at 04/21/23 10:22:14 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h ledscan_n.v counter_n.v random_gen.v clk_gen.v dffre.v width_trans.v controller.v debouncer.v synchronizer.v button.v top_level.v
OUTPUT_FILE_NAME: top_level
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e top_level -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete top_level.cmd

########## Tcl recorder end at 04/21/23 10:22:14 ###########


########## Tcl recorder starts at 04/21/23 10:22:54 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 10:22:54 ###########


########## Tcl recorder starts at 04/21/23 10:22:55 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h ledscan_n.v counter_n.v random_gen.v clk_gen.v dffre.v width_trans.v controller.v debouncer.v synchronizer.v button.v top_level.v
OUTPUT_FILE_NAME: top_level
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e top_level -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete top_level.cmd

########## Tcl recorder end at 04/21/23 10:22:55 ###########


########## Tcl recorder starts at 04/21/23 10:23:40 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" top_level"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 10:23:40 ###########


########## Tcl recorder starts at 04/21/23 10:42:23 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" ledscan_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncer.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" width_trans.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" button.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" synchronizer.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" random_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" controller.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" clk_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 10:42:23 ###########


########## Tcl recorder starts at 04/21/23 10:42:26 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h ledscan_n.v counter_n.v random_gen.v clk_gen.v dffre.v width_trans.v controller.v debouncer.v synchronizer.v button.v top_level.v
OUTPUT_FILE_NAME: top_level
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e top_level -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete top_level.cmd

########## Tcl recorder end at 04/21/23 10:42:26 ###########


########## Tcl recorder starts at 04/21/23 10:42:57 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" top_level"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 10:42:57 ###########


########## Tcl recorder starts at 04/21/23 10:54:47 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/exp\" -lhdl -ext=.ltv -testpt sim1.wdl -network=isp_lab2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/edif2blf\" -edf top_level.edi -out top_level.bl0 -err automake.err -log top_level.log -prj isp_lab2 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" top_level.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"isp_lab2.bl2\" -omod \"isp_lab2\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj isp_lab2 -lci isp_lab2.lct -log isp_lab2.imp -err automake.err -tti isp_lab2.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab2.lct -blifopt isp_lab2.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp_lab2.bl2 -sweep -mergefb -err automake.err -o isp_lab2.bl3 @isp_lab2.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab2.lct -dev lc4k -diofft isp_lab2.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" isp_lab2.bl3 -family AMDMACH -idev van -o isp_lab2.bl4 -oxrf isp_lab2.xrf -err automake.err @isp_lab2.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab2.lct -dev lc4k -prefit isp_lab2.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp isp_lab2.bl4 -out isp_lab2.bl5 -err automake.err -log isp_lab2.log -mod top_level @isp_lab2.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk sim1.ltv -map top_level.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 10:54:47 ###########


########## Tcl recorder starts at 04/21/23 10:56:34 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk sim1.ltv -map top_level.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 10:56:34 ###########


########## Tcl recorder starts at 04/21/23 10:56:44 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk sim1.ltv -map top_level.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 10:56:44 ###########


########## Tcl recorder starts at 04/21/23 10:56:50 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk sim1.ltv -map top_level.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 10:56:50 ###########


########## Tcl recorder starts at 04/21/23 10:57:21 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk sim1.ltv -map top_level.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 10:57:21 ###########


########## Tcl recorder starts at 04/21/23 10:58:06 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk sim1.ltv -map top_level.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 10:58:06 ###########


########## Tcl recorder starts at 04/21/23 11:00:51 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" button"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 11:00:51 ###########


########## Tcl recorder starts at 04/21/23 11:02:11 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk sim1.ltv -map top_level.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 11:02:11 ###########


########## Tcl recorder starts at 04/21/23 11:03:06 ##########

# Commands to make the Process: 
# Verilog Test Fixture Declarations
if [runCmd "\"$cpld_bin/vlog2jhd\" -tfi -proj isp_lab2 -mod top_level -out top_level -predefine isp_lab2.h -tpl \"$install_dir/ispcpld/generic/verilog/tfi.tft\" top_level.v"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 11:03:06 ###########


########## Tcl recorder starts at 04/21/23 11:03:18 ##########

# Commands to make the Process: 
# Timing Simulation
if [catch {open isp_lab2.rs1 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs1: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -nojed -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open isp_lab2.rs2 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs2: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@isp_lab2.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete isp_lab2.rs1
file delete isp_lab2.rs2
if [runCmd "\"$cpld_bin/tda\" -i isp_lab2.bl5 -o isp_lab2.tda -lci isp_lab2.lct -dev m4s_256_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open isp_lab2.rss w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rss: $rspFile"
} else {
	puts $rspFile "-i \"isp_lab2.tt4\" -lib \"$install_dir/ispcpld/dat/lc4k\" -strategy top -sdfmdl \"$install_dir/ispcpld/dat/sdf.mdl\" -simmdl \"$install_dir/ispcpld/dat/sim.mdl\" -pla \"isp_lab2.tt4\" -lci \"isp_lab2.lct\" -prj \"isp_lab2\" -dir \"$proj_dir\" -err automake.err -log \"isp_lab2.nrp\" -exf \"top_level.exf\"  -netlist edif
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/sdf\" \"@isp_lab2.rss\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete isp_lab2.rss
# Application to view the Process: 
# Timing Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.post5 -ini simcpls.ini -all simcp.post5
-cfg machgen.fdk sim1.ltv -map top_level.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 11:03:18 ###########


########## Tcl recorder starts at 04/21/23 11:09:30 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/exp\" -lhdl -ext=.ltv -testpt button_sim.wdl -network=button -module=button"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open button.cmd w} rspFile] {
	puts stderr "Cannot create response file button.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: button
WORKING_PATH: \"$proj_dir\"
MODULE: button
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h dffre.v width_trans.v controller.v counter_n.v debouncer.v synchronizer.v button.v
OUTPUT_FILE_NAME: button
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e button -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete button.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf button.edi -out button.bl0 -err automake.err -log button.log -prj isp_lab2 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" button.bl0 -o button.blo  -keepwires -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open dffre.cmd w} rspFile] {
	puts stderr "Cannot create response file dffre.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: dffre
WORKING_PATH: \"$proj_dir\"
MODULE: dffre
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h dffre.v
OUTPUT_FILE_NAME: dffre
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e dffre -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete dffre.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf dffre.edi -out dffre.bl0 -err automake.err -log dffre.log -prj isp_lab2 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" dffre.bl0 -o dffre.blo  -keepwires -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open width_trans.cmd w} rspFile] {
	puts stderr "Cannot create response file width_trans.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: width_trans
WORKING_PATH: \"$proj_dir\"
MODULE: width_trans
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h dffre.v width_trans.v
OUTPUT_FILE_NAME: width_trans
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e width_trans -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete width_trans.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf width_trans.edi -out width_trans.bl0 -err automake.err -log width_trans.log -prj isp_lab2 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" width_trans.bl0 -o width_trans.blo  -keepwires -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open controller.cmd w} rspFile] {
	puts stderr "Cannot create response file controller.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: controller
WORKING_PATH: \"$proj_dir\"
MODULE: controller
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h controller.v
OUTPUT_FILE_NAME: controller
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e controller -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete controller.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf controller.edi -out controller.bl0 -err automake.err -log controller.log -prj isp_lab2 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" controller.bl0 -o controller.blo  -keepwires -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open counter_n.cmd w} rspFile] {
	puts stderr "Cannot create response file counter_n.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: counter_n
WORKING_PATH: \"$proj_dir\"
MODULE: counter_n
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h counter_n.v
OUTPUT_FILE_NAME: counter_n
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e counter_n -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete counter_n.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf counter_n.edi -out counter_n.bl0 -err automake.err -log counter_n.log -prj isp_lab2 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" counter_n.bl0 -o counter_n.blo  -keepwires -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open debouncer.cmd w} rspFile] {
	puts stderr "Cannot create response file debouncer.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: debouncer
WORKING_PATH: \"$proj_dir\"
MODULE: debouncer
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h controller.v counter_n.v debouncer.v
OUTPUT_FILE_NAME: debouncer
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e debouncer -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete debouncer.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf debouncer.edi -out debouncer.bl0 -err automake.err -log debouncer.log -prj isp_lab2 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" debouncer.bl0 -o debouncer.blo  -keepwires -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open synchro.cmd w} rspFile] {
	puts stderr "Cannot create response file synchro.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: synchro
WORKING_PATH: \"$proj_dir\"
MODULE: synchro
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h dffre.v synchronizer.v
OUTPUT_FILE_NAME: synchro
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e synchro -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete synchro.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf synchro.edi -out synchro.bl0 -err automake.err -log synchro.log -prj isp_lab2 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" synchro.bl0 -o synchro.blo  -keepwires -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"button.blo\" -o \"button.blh\" -omod \"button\" -err \"automake.err\" "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" button.blh -o button.bli -sweep -mergefb -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" -i button.bli -o button.blj -family AMDMACH -idev van -err automake.err -dev lc4k "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg machgen.fdk button_sim.ltv -map button.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 11:09:30 ###########


########## Tcl recorder starts at 04/21/23 11:17:20 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/exp\" -lhdl -ext=.ltv -testpt button_sim.wdl -network=button -module=button"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"button.blo\" -o \"button.blh\" -omod \"button\" -err \"automake.err\" "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" button.blh -o button.bli -sweep -mergefb -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" -i button.bli -o button.blj -family AMDMACH -idev van -err automake.err -dev lc4k "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg machgen.fdk button_sim.ltv -map button.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 11:17:20 ###########


########## Tcl recorder starts at 04/21/23 11:21:27 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/exp\" -lhdl -ext=.ltv -testpt button_sim.wdl -network=button -module=button"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"button.blo\" -o \"button.blh\" -omod \"button\" -err \"automake.err\" "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" button.blh -o button.bli -sweep -mergefb -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" -i button.bli -o button.blj -family AMDMACH -idev van -err automake.err -dev lc4k "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg machgen.fdk button_sim.ltv -map button.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 11:21:27 ###########


########## Tcl recorder starts at 04/21/23 11:52:18 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i isp_lab2.bl5 -o isp_lab2.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src isp_lab2.bl5 -type BLIF -presrc isp_lab2.bl3 -crf isp_lab2.crf -sif isp_lab2.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci isp_lab2.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 11:52:18 ###########


########## Tcl recorder starts at 04/21/23 12:00:15 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open isp_lab2.rs1 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs1: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -nojed -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open isp_lab2.rs2 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs2: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@isp_lab2.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete isp_lab2.rs1
file delete isp_lab2.rs2
if [runCmd "\"$cpld_bin/tda\" -i isp_lab2.bl5 -o isp_lab2.tda -lci isp_lab2.lct -dev m4s_256_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj isp_lab2 -if isp_lab2.jed -j2s -log isp_lab2.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 12:00:15 ###########


########## Tcl recorder starts at 04/21/23 16:07:09 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" controller.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" clk_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 16:07:09 ###########


########## Tcl recorder starts at 04/21/23 16:07:10 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h ledscan_n.v counter_n.v random_gen.v clk_gen.v dffre.v width_trans.v controller.v debouncer.v synchronizer.v button.v top_level.v
OUTPUT_FILE_NAME: top_level
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e top_level -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete top_level.cmd

########## Tcl recorder end at 04/21/23 16:07:10 ###########


########## Tcl recorder starts at 04/21/23 16:07:27 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h ledscan_n.v counter_n.v random_gen.v clk_gen.v dffre.v width_trans.v controller.v debouncer.v synchronizer.v button.v top_level.v
OUTPUT_FILE_NAME: top_level
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e top_level -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete top_level.cmd

########## Tcl recorder end at 04/21/23 16:07:27 ###########


########## Tcl recorder starts at 04/21/23 16:07:59 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/edif2blf\" -edf top_level.edi -out top_level.bl0 -err automake.err -log top_level.log -prj isp_lab2 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" top_level.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"isp_lab2.bl2\" -omod \"isp_lab2\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj isp_lab2 -lci isp_lab2.lct -log isp_lab2.imp -err automake.err -tti isp_lab2.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab2.lct -blifopt isp_lab2.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp_lab2.bl2 -sweep -mergefb -err automake.err -o isp_lab2.bl3 @isp_lab2.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab2.lct -dev lc4k -diofft isp_lab2.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" isp_lab2.bl3 -family AMDMACH -idev van -o isp_lab2.bl4 -oxrf isp_lab2.xrf -err automake.err @isp_lab2.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab2.lct -dev lc4k -prefit isp_lab2.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp isp_lab2.bl4 -out isp_lab2.bl5 -err automake.err -log isp_lab2.log -mod top_level @isp_lab2.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open isp_lab2.rs1 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs1: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -nojed -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open isp_lab2.rs2 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs2: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@isp_lab2.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete isp_lab2.rs1
file delete isp_lab2.rs2
if [runCmd "\"$cpld_bin/tda\" -i isp_lab2.bl5 -o isp_lab2.tda -lci isp_lab2.lct -dev m4s_256_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj isp_lab2 -if isp_lab2.jed -j2s -log isp_lab2.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 16:07:59 ###########


########## Tcl recorder starts at 04/21/23 16:47:52 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" width_trans.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 16:47:52 ###########


########## Tcl recorder starts at 04/21/23 16:47:52 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h ledscan_n.v counter_n.v random_gen.v clk_gen.v width_trans.v controller.v debouncer.v dffre.v synchronizer.v button.v top_level.v
OUTPUT_FILE_NAME: top_level
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e top_level -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete top_level.cmd

########## Tcl recorder end at 04/21/23 16:47:52 ###########


########## Tcl recorder starts at 04/21/23 16:48:53 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/edif2blf\" -edf top_level.edi -out top_level.bl0 -err automake.err -log top_level.log -prj isp_lab2 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" top_level.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"isp_lab2.bl2\" -omod \"isp_lab2\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj isp_lab2 -lci isp_lab2.lct -log isp_lab2.imp -err automake.err -tti isp_lab2.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab2.lct -blifopt isp_lab2.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp_lab2.bl2 -sweep -mergefb -err automake.err -o isp_lab2.bl3 @isp_lab2.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab2.lct -dev lc4k -diofft isp_lab2.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" isp_lab2.bl3 -family AMDMACH -idev van -o isp_lab2.bl4 -oxrf isp_lab2.xrf -err automake.err @isp_lab2.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab2.lct -dev lc4k -prefit isp_lab2.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp isp_lab2.bl4 -out isp_lab2.bl5 -err automake.err -log isp_lab2.log -mod top_level @isp_lab2.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i isp_lab2.bl5 -o isp_lab2.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src isp_lab2.bl5 -type BLIF -presrc isp_lab2.bl3 -crf isp_lab2.crf -sif isp_lab2.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci isp_lab2.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 16:48:53 ###########


########## Tcl recorder starts at 04/21/23 16:50:41 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i isp_lab2.bl5 -o isp_lab2.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src isp_lab2.bl5 -type BLIF -presrc isp_lab2.bl3 -crf isp_lab2.crf -sif isp_lab2.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci isp_lab2.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 16:50:41 ###########


########## Tcl recorder starts at 04/21/23 16:52:02 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open isp_lab2.rs1 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs1: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -nojed -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open isp_lab2.rs2 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs2: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@isp_lab2.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete isp_lab2.rs1
file delete isp_lab2.rs2
if [runCmd "\"$cpld_bin/tda\" -i isp_lab2.bl5 -o isp_lab2.tda -lci isp_lab2.lct -dev m4s_256_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj isp_lab2 -if isp_lab2.jed -j2s -log isp_lab2.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 16:52:02 ###########


########## Tcl recorder starts at 04/21/23 17:00:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" random_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 17:00:37 ###########


########## Tcl recorder starts at 04/21/23 17:00:37 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h ledscan_n.v counter_n.v random_gen.v clk_gen.v width_trans.v controller.v debouncer.v dffre.v synchronizer.v button.v top_level.v
OUTPUT_FILE_NAME: top_level
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e top_level -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete top_level.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf top_level.edi -out top_level.bl0 -err automake.err -log top_level.log -prj isp_lab2 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" top_level.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"isp_lab2.bl2\" -omod \"isp_lab2\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj isp_lab2 -lci isp_lab2.lct -log isp_lab2.imp -err automake.err -tti isp_lab2.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab2.lct -blifopt isp_lab2.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp_lab2.bl2 -sweep -mergefb -err automake.err -o isp_lab2.bl3 @isp_lab2.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab2.lct -dev lc4k -diofft isp_lab2.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" isp_lab2.bl3 -family AMDMACH -idev van -o isp_lab2.bl4 -oxrf isp_lab2.xrf -err automake.err @isp_lab2.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab2.lct -dev lc4k -prefit isp_lab2.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp isp_lab2.bl4 -out isp_lab2.bl5 -err automake.err -log isp_lab2.log -mod top_level @isp_lab2.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open isp_lab2.rs1 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs1: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -nojed -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open isp_lab2.rs2 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs2: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@isp_lab2.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete isp_lab2.rs1
file delete isp_lab2.rs2
if [runCmd "\"$cpld_bin/tda\" -i isp_lab2.bl5 -o isp_lab2.tda -lci isp_lab2.lct -dev m4s_256_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj isp_lab2 -if isp_lab2.jed -j2s -log isp_lab2.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 17:00:37 ###########


########## Tcl recorder starts at 04/21/23 17:21:25 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" width_trans.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" button.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" random_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" clk_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 17:21:25 ###########


########## Tcl recorder starts at 04/21/23 17:21:27 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h ledscan_n.v counter_n.v random_gen.v clk_gen.v width_trans.v controller.v debouncer.v button.v top_level.v
OUTPUT_FILE_NAME: top_level
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e top_level -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete top_level.cmd

########## Tcl recorder end at 04/21/23 17:21:27 ###########


########## Tcl recorder starts at 04/21/23 17:22:02 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/edif2blf\" -edf top_level.edi -out top_level.bl0 -err automake.err -log top_level.log -prj isp_lab2 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" top_level.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"isp_lab2.bl2\" -omod \"isp_lab2\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj isp_lab2 -lci isp_lab2.lct -log isp_lab2.imp -err automake.err -tti isp_lab2.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab2.lct -blifopt isp_lab2.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp_lab2.bl2 -sweep -mergefb -err automake.err -o isp_lab2.bl3 @isp_lab2.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab2.lct -dev lc4k -diofft isp_lab2.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" isp_lab2.bl3 -family AMDMACH -idev van -o isp_lab2.bl4 -oxrf isp_lab2.xrf -err automake.err @isp_lab2.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab2.lct -dev lc4k -prefit isp_lab2.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp isp_lab2.bl4 -out isp_lab2.bl5 -err automake.err -log isp_lab2.log -mod top_level @isp_lab2.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open isp_lab2.rs1 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs1: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -nojed -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open isp_lab2.rs2 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs2: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@isp_lab2.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete isp_lab2.rs1
file delete isp_lab2.rs2
if [runCmd "\"$cpld_bin/tda\" -i isp_lab2.bl5 -o isp_lab2.tda -lci isp_lab2.lct -dev m4s_256_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj isp_lab2 -if isp_lab2.jed -j2s -log isp_lab2.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 17:22:02 ###########


########## Tcl recorder starts at 04/21/23 17:24:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" random_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 17:24:59 ###########


########## Tcl recorder starts at 04/21/23 17:24:59 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open clk_gen.cmd w} rspFile] {
	puts stderr "Cannot create response file clk_gen.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: clk_gen
WORKING_PATH: \"$proj_dir\"
MODULE: clk_gen
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h counter_n.v clk_gen.v
OUTPUT_FILE_NAME: clk_gen
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e clk_gen -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete clk_gen.cmd

########## Tcl recorder end at 04/21/23 17:24:59 ###########


########## Tcl recorder starts at 04/21/23 17:25:33 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h ledscan_n.v counter_n.v random_gen.v clk_gen.v width_trans.v controller.v debouncer.v button.v top_level.v
OUTPUT_FILE_NAME: top_level
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e top_level -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete top_level.cmd

########## Tcl recorder end at 04/21/23 17:25:33 ###########


########## Tcl recorder starts at 04/21/23 17:26:06 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open random_gen.cmd w} rspFile] {
	puts stderr "Cannot create response file random_gen.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: random_gen
WORKING_PATH: \"$proj_dir\"
MODULE: random_gen
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h counter_n.v random_gen.v
OUTPUT_FILE_NAME: random_gen
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e random_gen -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete random_gen.cmd

########## Tcl recorder end at 04/21/23 17:26:06 ###########


########## Tcl recorder starts at 04/21/23 17:27:12 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open LEDscan.cmd w} rspFile] {
	puts stderr "Cannot create response file LEDscan.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: LEDscan
WORKING_PATH: \"$proj_dir\"
MODULE: LEDscan
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h ledscan_n.v
OUTPUT_FILE_NAME: LEDscan
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LEDscan -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LEDscan.cmd

########## Tcl recorder end at 04/21/23 17:27:12 ###########


########## Tcl recorder starts at 04/21/23 17:28:32 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/edif2blf\" -edf top_level.edi -out top_level.bl0 -err automake.err -log top_level.log -prj isp_lab2 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" top_level.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"isp_lab2.bl2\" -omod \"isp_lab2\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj isp_lab2 -lci isp_lab2.lct -log isp_lab2.imp -err automake.err -tti isp_lab2.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab2.lct -blifopt isp_lab2.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp_lab2.bl2 -sweep -mergefb -err automake.err -o isp_lab2.bl3 @isp_lab2.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab2.lct -dev lc4k -diofft isp_lab2.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" isp_lab2.bl3 -family AMDMACH -idev van -o isp_lab2.bl4 -oxrf isp_lab2.xrf -err automake.err @isp_lab2.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab2.lct -dev lc4k -prefit isp_lab2.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp isp_lab2.bl4 -out isp_lab2.bl5 -err automake.err -log isp_lab2.log -mod top_level @isp_lab2.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open isp_lab2.rs1 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs1: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -nojed -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open isp_lab2.rs2 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs2: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@isp_lab2.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete isp_lab2.rs1
file delete isp_lab2.rs2
if [runCmd "\"$cpld_bin/tda\" -i isp_lab2.bl5 -o isp_lab2.tda -lci isp_lab2.lct -dev m4s_256_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj isp_lab2 -if isp_lab2.jed -j2s -log isp_lab2.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 17:28:32 ###########


########## Tcl recorder starts at 04/21/23 17:53:51 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 17:53:51 ###########


########## Tcl recorder starts at 04/21/23 17:54:20 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h ledscan_n.v counter_n.v random_gen.v clk_gen.v width_trans.v controller.v debouncer.v button.v top_level.v
OUTPUT_FILE_NAME: top_level
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e top_level -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete top_level.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf top_level.edi -out top_level.bl0 -err automake.err -log top_level.log -prj isp_lab2 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" top_level.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"isp_lab2.bl2\" -omod \"isp_lab2\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj isp_lab2 -lci isp_lab2.lct -log isp_lab2.imp -err automake.err -tti isp_lab2.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab2.lct -blifopt isp_lab2.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp_lab2.bl2 -sweep -mergefb -err automake.err -o isp_lab2.bl3 @isp_lab2.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab2.lct -dev lc4k -diofft isp_lab2.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" isp_lab2.bl3 -family AMDMACH -idev van -o isp_lab2.bl4 -oxrf isp_lab2.xrf -err automake.err @isp_lab2.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab2.lct -dev lc4k -prefit isp_lab2.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp isp_lab2.bl4 -out isp_lab2.bl5 -err automake.err -log isp_lab2.log -mod top_level @isp_lab2.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open isp_lab2.rs1 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs1: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -nojed -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open isp_lab2.rs2 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs2: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@isp_lab2.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete isp_lab2.rs1
file delete isp_lab2.rs2
if [runCmd "\"$cpld_bin/tda\" -i isp_lab2.bl5 -o isp_lab2.tda -lci isp_lab2.lct -dev m4s_256_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj isp_lab2 -if isp_lab2.jed -j2s -log isp_lab2.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 17:54:20 ###########


########## Tcl recorder starts at 04/21/23 17:56:41 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i isp_lab2.bl5 -o isp_lab2.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src isp_lab2.bl5 -type BLIF -presrc isp_lab2.bl3 -crf isp_lab2.crf -sif isp_lab2.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci isp_lab2.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 17:56:41 ###########


########## Tcl recorder starts at 04/21/23 17:57:43 ##########

# Commands to make the Process: 
# Pre-Fit Equations
if [runCmd "\"$cpld_bin/blif2eqn\" isp_lab2.bl5 -o isp_lab2.eq2 -use_short -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 17:57:43 ###########


########## Tcl recorder starts at 04/21/23 17:57:45 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open isp_lab2.rs1 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs1: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -nojed -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open isp_lab2.rs2 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs2: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@isp_lab2.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete isp_lab2.rs1
file delete isp_lab2.rs2
if [runCmd "\"$cpld_bin/tda\" -i isp_lab2.bl5 -o isp_lab2.tda -lci isp_lab2.lct -dev m4s_256_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj isp_lab2 -if isp_lab2.jed -j2s -log isp_lab2.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 17:57:45 ###########


########## Tcl recorder starts at 04/21/23 18:36:40 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" ledscan_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" clk_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 18:36:40 ###########


########## Tcl recorder starts at 04/21/23 18:36:41 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h ledscan_n.v counter_n.v random_gen.v clk_gen.v width_trans.v controller.v debouncer.v button.v top_level.v
OUTPUT_FILE_NAME: top_level
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e top_level -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete top_level.cmd

########## Tcl recorder end at 04/21/23 18:36:41 ###########


########## Tcl recorder starts at 04/21/23 18:37:25 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/edif2blf\" -edf top_level.edi -out top_level.bl0 -err automake.err -log top_level.log -prj isp_lab2 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" top_level.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"isp_lab2.bl2\" -omod \"isp_lab2\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj isp_lab2 -lci isp_lab2.lct -log isp_lab2.imp -err automake.err -tti isp_lab2.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab2.lct -blifopt isp_lab2.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp_lab2.bl2 -sweep -mergefb -err automake.err -o isp_lab2.bl3 @isp_lab2.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab2.lct -dev lc4k -diofft isp_lab2.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" isp_lab2.bl3 -family AMDMACH -idev van -o isp_lab2.bl4 -oxrf isp_lab2.xrf -err automake.err @isp_lab2.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab2.lct -dev lc4k -prefit isp_lab2.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp isp_lab2.bl4 -out isp_lab2.bl5 -err automake.err -log isp_lab2.log -mod top_level @isp_lab2.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open isp_lab2.rs1 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs1: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -nojed -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open isp_lab2.rs2 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs2: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@isp_lab2.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete isp_lab2.rs1
file delete isp_lab2.rs2
if [runCmd "\"$cpld_bin/tda\" -i isp_lab2.bl5 -o isp_lab2.tda -lci isp_lab2.lct -dev m4s_256_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj isp_lab2 -if isp_lab2.jed -j2s -log isp_lab2.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 18:37:25 ###########


########## Tcl recorder starts at 04/22/23 21:26:00 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h ledscan_n.v counter_n.v random_gen.v clk_gen.v width_trans.v controller.v debouncer.v button.v top_level.v
OUTPUT_FILE_NAME: top_level
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e top_level -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete top_level.cmd

########## Tcl recorder end at 04/22/23 21:26:00 ###########


########## Tcl recorder starts at 04/22/23 21:29:26 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/edif2blf\" -edf top_level.edi -out top_level.bl0 -err automake.err -log top_level.log -prj isp_lab2 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" top_level.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"isp_lab2.bl2\" -omod \"isp_lab2\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj isp_lab2 -lci isp_lab2.lct -log isp_lab2.imp -err automake.err -tti isp_lab2.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab2.lct -blifopt isp_lab2.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp_lab2.bl2 -sweep -mergefb -err automake.err -o isp_lab2.bl3 @isp_lab2.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab2.lct -dev lc4k -diofft isp_lab2.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" isp_lab2.bl3 -family AMDMACH -idev van -o isp_lab2.bl4 -oxrf isp_lab2.xrf -err automake.err @isp_lab2.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab2.lct -dev lc4k -prefit isp_lab2.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp isp_lab2.bl4 -out isp_lab2.bl5 -err automake.err -log isp_lab2.log -mod top_level @isp_lab2.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open isp_lab2.rs1 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs1: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -nojed -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open isp_lab2.rs2 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs2: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@isp_lab2.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete isp_lab2.rs1
file delete isp_lab2.rs2
if [runCmd "\"$cpld_bin/tda\" -i isp_lab2.bl5 -o isp_lab2.tda -lci isp_lab2.lct -dev m4s_256_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj isp_lab2 -if isp_lab2.jed -j2s -log isp_lab2.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/22/23 21:29:26 ###########


########## Tcl recorder starts at 04/22/23 21:32:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/22/23 21:32:35 ###########


########## Tcl recorder starts at 04/22/23 21:32:35 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h ledscan_n.v counter_n.v random_gen.v clk_gen.v width_trans.v controller.v debouncer.v button.v top_level.v
OUTPUT_FILE_NAME: top_level
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e top_level -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete top_level.cmd

########## Tcl recorder end at 04/22/23 21:32:35 ###########


########## Tcl recorder starts at 04/22/23 21:33:10 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/edif2blf\" -edf top_level.edi -out top_level.bl0 -err automake.err -log top_level.log -prj isp_lab2 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" top_level.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"isp_lab2.bl2\" -omod \"isp_lab2\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj isp_lab2 -lci isp_lab2.lct -log isp_lab2.imp -err automake.err -tti isp_lab2.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab2.lct -blifopt isp_lab2.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp_lab2.bl2 -sweep -mergefb -err automake.err -o isp_lab2.bl3 @isp_lab2.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab2.lct -dev lc4k -diofft isp_lab2.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" isp_lab2.bl3 -family AMDMACH -idev van -o isp_lab2.bl4 -oxrf isp_lab2.xrf -err automake.err @isp_lab2.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab2.lct -dev lc4k -prefit isp_lab2.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp isp_lab2.bl4 -out isp_lab2.bl5 -err automake.err -log isp_lab2.log -mod top_level @isp_lab2.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open isp_lab2.rs1 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs1: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -nojed -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open isp_lab2.rs2 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs2: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@isp_lab2.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete isp_lab2.rs1
file delete isp_lab2.rs2
if [runCmd "\"$cpld_bin/tda\" -i isp_lab2.bl5 -o isp_lab2.tda -lci isp_lab2.lct -dev m4s_256_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj isp_lab2 -if isp_lab2.jed -j2s -log isp_lab2.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/22/23 21:33:10 ###########


########## Tcl recorder starts at 04/22/23 21:36:45 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i isp_lab2.bl5 -o isp_lab2.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src isp_lab2.bl5 -type BLIF -presrc isp_lab2.bl3 -crf isp_lab2.crf -sif isp_lab2.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci isp_lab2.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/22/23 21:36:45 ###########


########## Tcl recorder starts at 04/22/23 21:37:52 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open isp_lab2.rs1 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs1: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -nojed -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open isp_lab2.rs2 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs2: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@isp_lab2.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete isp_lab2.rs1
file delete isp_lab2.rs2
if [runCmd "\"$cpld_bin/tda\" -i isp_lab2.bl5 -o isp_lab2.tda -lci isp_lab2.lct -dev m4s_256_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj isp_lab2 -if isp_lab2.jed -j2s -log isp_lab2.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/22/23 21:37:52 ###########


########## Tcl recorder starts at 04/22/23 21:37:57 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i isp_lab2.bl5 -o isp_lab2.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src isp_lab2.bl5 -type BLIF -presrc isp_lab2.bl3 -crf isp_lab2.crf -sif isp_lab2.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci isp_lab2.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/22/23 21:37:57 ###########


########## Tcl recorder starts at 04/22/23 21:38:14 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open isp_lab2.rs1 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs1: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -nojed -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open isp_lab2.rs2 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs2: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@isp_lab2.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete isp_lab2.rs1
file delete isp_lab2.rs2
if [runCmd "\"$cpld_bin/tda\" -i isp_lab2.bl5 -o isp_lab2.tda -lci isp_lab2.lct -dev m4s_256_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj isp_lab2 -if isp_lab2.jed -j2s -log isp_lab2.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/22/23 21:38:14 ###########


########## Tcl recorder starts at 04/22/23 21:38:51 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open LEDscan.cmd w} rspFile] {
	puts stderr "Cannot create response file LEDscan.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: LEDscan
WORKING_PATH: \"$proj_dir\"
MODULE: LEDscan
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h ledscan_n.v
OUTPUT_FILE_NAME: LEDscan
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LEDscan -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LEDscan.cmd

########## Tcl recorder end at 04/22/23 21:38:51 ###########


########## Tcl recorder starts at 04/22/23 21:39:28 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open clk_gen.cmd w} rspFile] {
	puts stderr "Cannot create response file clk_gen.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: clk_gen
WORKING_PATH: \"$proj_dir\"
MODULE: clk_gen
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h counter_n.v clk_gen.v
OUTPUT_FILE_NAME: clk_gen
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e clk_gen -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete clk_gen.cmd

########## Tcl recorder end at 04/22/23 21:39:28 ###########


########## Tcl recorder starts at 04/22/23 21:40:03 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open button.cmd w} rspFile] {
	puts stderr "Cannot create response file button.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: button
WORKING_PATH: \"$proj_dir\"
MODULE: button
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h width_trans.v controller.v counter_n.v debouncer.v button.v
OUTPUT_FILE_NAME: button
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e button -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete button.cmd

########## Tcl recorder end at 04/22/23 21:40:03 ###########


########## Tcl recorder starts at 04/22/23 21:40:40 ##########

# Commands to make the Process: 
# Constraint Editor
# - none -
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src isp_lab2.bl5 -type BLIF -presrc isp_lab2.bl3 -crf isp_lab2.crf -sif isp_lab2.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci isp_lab2.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/22/23 21:40:40 ###########


########## Tcl recorder starts at 04/22/23 21:41:14 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open isp_lab2.rs1 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs1: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -nojed -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open isp_lab2.rs2 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs2: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@isp_lab2.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete isp_lab2.rs1
file delete isp_lab2.rs2
if [runCmd "\"$cpld_bin/tda\" -i isp_lab2.bl5 -o isp_lab2.tda -lci isp_lab2.lct -dev m4s_256_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj isp_lab2 -if isp_lab2.jed -j2s -log isp_lab2.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/22/23 21:41:14 ###########


########## Tcl recorder starts at 04/22/23 21:41:36 ##########

# Commands to make the Process: 
# Constraint Editor
# - none -
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src isp_lab2.bl5 -type BLIF -presrc isp_lab2.bl3 -crf isp_lab2.crf -sif isp_lab2.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci isp_lab2.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/22/23 21:41:36 ###########


########## Tcl recorder starts at 04/22/23 21:42:56 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i isp_lab2.bl5 -o isp_lab2.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src isp_lab2.bl5 -type BLIF -presrc isp_lab2.bl3 -crf isp_lab2.crf -sif isp_lab2.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci isp_lab2.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/22/23 21:42:56 ###########


########## Tcl recorder starts at 04/22/23 21:43:03 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open isp_lab2.rs1 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs1: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -nojed -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open isp_lab2.rs2 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs2: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@isp_lab2.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete isp_lab2.rs1
file delete isp_lab2.rs2
if [runCmd "\"$cpld_bin/tda\" -i isp_lab2.bl5 -o isp_lab2.tda -lci isp_lab2.lct -dev m4s_256_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj isp_lab2 -if isp_lab2.jed -j2s -log isp_lab2.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/22/23 21:43:03 ###########


########## Tcl recorder starts at 04/22/23 21:57:56 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab2.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/22/23 21:57:56 ###########


########## Tcl recorder starts at 04/22/23 21:57:56 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab2.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab2.h ledscan_n.v counter_n.v random_gen.v clk_gen.v controller.v debouncer.v width_trans.v button.v top_level.v
OUTPUT_FILE_NAME: top_level
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e top_level -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete top_level.cmd

########## Tcl recorder end at 04/22/23 21:57:56 ###########


########## Tcl recorder starts at 04/22/23 21:58:33 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/edif2blf\" -edf top_level.edi -out top_level.bl0 -err automake.err -log top_level.log -prj isp_lab2 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" top_level.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"isp_lab2.bl2\" -omod \"isp_lab2\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj isp_lab2 -lci isp_lab2.lct -log isp_lab2.imp -err automake.err -tti isp_lab2.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab2.lct -blifopt isp_lab2.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp_lab2.bl2 -sweep -mergefb -err automake.err -o isp_lab2.bl3 @isp_lab2.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab2.lct -dev lc4k -diofft isp_lab2.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" isp_lab2.bl3 -family AMDMACH -idev van -o isp_lab2.bl4 -oxrf isp_lab2.xrf -err automake.err @isp_lab2.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab2.lct -dev lc4k -prefit isp_lab2.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp isp_lab2.bl4 -out isp_lab2.bl5 -err automake.err -log isp_lab2.log -mod top_level @isp_lab2.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open isp_lab2.rs1 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs1: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -nojed -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open isp_lab2.rs2 w} rspFile] {
	puts stderr "Cannot create response file isp_lab2.rs2: $rspFile"
} else {
	puts $rspFile "-i isp_lab2.bl5 -lci isp_lab2.lct -d m4s_256_64 -lco isp_lab2.lco -html_rpt -fti isp_lab2.fti -fmt PLA -tto isp_lab2.tt4 -eqn isp_lab2.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@isp_lab2.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete isp_lab2.rs1
file delete isp_lab2.rs2
if [runCmd "\"$cpld_bin/tda\" -i isp_lab2.bl5 -o isp_lab2.tda -lci isp_lab2.lct -dev m4s_256_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj isp_lab2 -if isp_lab2.jed -j2s -log isp_lab2.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/22/23 21:58:33 ###########

