
########## Tcl recorder starts at 04/22/23 23:26:31 ##########

set version "2.1"
set proj_dir "D:/MyDucuments/_Junior_1/ElectricSystemDesign/ISP_lab3"
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
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" ledscan_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncer.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" width_trans.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" button.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" random_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" controller.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" clk_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" top_test.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" button_process_unit_tb.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/22/23 23:26:31 ###########


########## Tcl recorder starts at 04/22/23 23:27:14 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" ledscan_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncer.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" width_trans.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" button.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" random_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" controller.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" clk_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/22/23 23:27:14 ###########


########## Tcl recorder starts at 04/23/23 01:10:51 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" ledscan_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncer.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" width_trans.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" button.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" random_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" controller.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" clk_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/23/23 01:10:51 ###########


########## Tcl recorder starts at 04/23/23 01:10:53 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab3.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab3.h counter_n.v ledscan_n.v random_gen.v clk_gen.v controller.v debouncer.v top_level.v
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

########## Tcl recorder end at 04/23/23 01:10:53 ###########


########## Tcl recorder starts at 04/23/23 01:12:32 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" clk_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/23/23 01:12:32 ###########


########## Tcl recorder starts at 04/23/23 01:12:32 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab3.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab3.h counter_n.v ledscan_n.v random_gen.v clk_gen.v controller.v debouncer.v top_level.v
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

########## Tcl recorder end at 04/23/23 01:12:32 ###########


########## Tcl recorder starts at 04/23/23 01:13:33 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/23/23 01:13:33 ###########


########## Tcl recorder starts at 04/23/23 01:13:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ledscan_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncer.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" width_trans.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" random_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" controller.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" clk_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/23/23 01:13:36 ###########


########## Tcl recorder starts at 04/23/23 01:13:38 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab3.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab3.h counter_n.v ledscan_n.v random_gen.v clk_gen.v controller.v debouncer.v top_level.v
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

########## Tcl recorder end at 04/23/23 01:13:38 ###########


########## Tcl recorder starts at 04/23/23 01:14:37 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/23/23 01:14:37 ###########


########## Tcl recorder starts at 04/23/23 01:14:38 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab3.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab3.h counter_n.v ledscan_n.v random_gen.v clk_gen.v controller.v debouncer.v top_level.v
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

########## Tcl recorder end at 04/23/23 01:14:38 ###########


########## Tcl recorder starts at 04/23/23 01:15:45 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/23/23 01:15:45 ###########


########## Tcl recorder starts at 04/23/23 01:15:45 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab3.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab3.h counter_n.v ledscan_n.v random_gen.v clk_gen.v controller.v debouncer.v top_level.v
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

########## Tcl recorder end at 04/23/23 01:15:45 ###########


########## Tcl recorder starts at 04/23/23 01:17:02 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" bit5_full_adder.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/23/23 01:17:02 ###########


########## Tcl recorder starts at 04/23/23 01:17:07 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab3.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab3.h counter_n.v bit5_full_adder.v ledscan_n.v random_gen.v clk_gen.v controller.v debouncer.v top_level.v
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

########## Tcl recorder end at 04/23/23 01:17:07 ###########


########## Tcl recorder starts at 04/23/23 01:20:08 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/23/23 01:20:08 ###########


########## Tcl recorder starts at 04/23/23 01:20:08 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab3.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab3.h counter_n.v bit5_full_adder.v ledscan_n.v random_gen.v clk_gen.v controller.v debouncer.v top_level.v
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

########## Tcl recorder end at 04/23/23 01:20:08 ###########


########## Tcl recorder starts at 04/23/23 01:22:00 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/23/23 01:22:00 ###########


########## Tcl recorder starts at 04/23/23 01:22:00 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab3.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab3.h counter_n.v bit5_full_adder.v ledscan_n.v random_gen.v clk_gen.v controller.v debouncer.v top_level.v
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

########## Tcl recorder end at 04/23/23 01:22:00 ###########


########## Tcl recorder starts at 04/23/23 01:26:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" bit5_full_adder.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/23/23 01:26:34 ###########


########## Tcl recorder starts at 04/23/23 01:26:35 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab3.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab3.h counter_n.v bit5_full_adder.v ledscan_n.v random_gen.v clk_gen.v controller.v debouncer.v top_level.v
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

########## Tcl recorder end at 04/23/23 01:26:35 ###########


########## Tcl recorder starts at 04/23/23 01:27:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" bit5_full_adder.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" ledscan_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncer.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" random_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" controller.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" clk_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/23/23 01:27:20 ###########


########## Tcl recorder starts at 04/23/23 01:27:21 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab3.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab3.h counter_n.v bit5_full_adder.v ledscan_n.v random_gen.v clk_gen.v controller.v debouncer.v top_level.v
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

########## Tcl recorder end at 04/23/23 01:27:21 ###########


########## Tcl recorder starts at 04/23/23 01:28:10 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/edif2blf\" -edf top_level.edi -out top_level.bl0 -err automake.err -log top_level.log -prj isp_lab3 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"isp_lab3.bl2\" -omod \"isp_lab3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj isp_lab3 -lci isp_lab3.lct -log isp_lab3.imp -err automake.err -tti isp_lab3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab3.lct -blifopt isp_lab3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp_lab3.bl2 -sweep -mergefb -err automake.err -o isp_lab3.bl3 @isp_lab3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab3.lct -dev lc4k -diofft isp_lab3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" isp_lab3.bl3 -family AMDMACH -idev van -o isp_lab3.bl4 -oxrf isp_lab3.xrf -err automake.err @isp_lab3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab3.lct -dev lc4k -prefit isp_lab3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp isp_lab3.bl4 -out isp_lab3.bl5 -err automake.err -log isp_lab3.log -mod top_level @isp_lab3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i isp_lab3.bl5 -o isp_lab3.sif"] {
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
	puts $rspFile "-nodal -src isp_lab3.bl5 -type BLIF -presrc isp_lab3.bl3 -crf isp_lab3.crf -sif isp_lab3.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci isp_lab3.lct
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

########## Tcl recorder end at 04/23/23 01:28:10 ###########


########## Tcl recorder starts at 04/23/23 01:35:30 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/23/23 01:35:30 ###########


########## Tcl recorder starts at 04/23/23 01:35:31 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab3.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab3.h counter_n.v bit5_full_adder.v ledscan_n.v random_gen.v clk_gen.v controller.v debouncer.v top_level.v
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

########## Tcl recorder end at 04/23/23 01:35:31 ###########


########## Tcl recorder starts at 04/23/23 01:36:21 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/edif2blf\" -edf top_level.edi -out top_level.bl0 -err automake.err -log top_level.log -prj isp_lab3 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"isp_lab3.bl2\" -omod \"isp_lab3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj isp_lab3 -lci isp_lab3.lct -log isp_lab3.imp -err automake.err -tti isp_lab3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab3.lct -blifopt isp_lab3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp_lab3.bl2 -sweep -mergefb -err automake.err -o isp_lab3.bl3 @isp_lab3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab3.lct -dev lc4k -diofft isp_lab3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" isp_lab3.bl3 -family AMDMACH -idev van -o isp_lab3.bl4 -oxrf isp_lab3.xrf -err automake.err @isp_lab3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab3.lct -dev lc4k -prefit isp_lab3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp isp_lab3.bl4 -out isp_lab3.bl5 -err automake.err -log isp_lab3.log -mod top_level @isp_lab3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i isp_lab3.bl5 -o isp_lab3.sif"] {
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
	puts $rspFile "-nodal -src isp_lab3.bl5 -type BLIF -presrc isp_lab3.bl3 -crf isp_lab3.crf -sif isp_lab3.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci isp_lab3.lct
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

########## Tcl recorder end at 04/23/23 01:36:21 ###########


########## Tcl recorder starts at 04/23/23 01:36:39 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open isp_lab3.rs1 w} rspFile] {
	puts stderr "Cannot create response file isp_lab3.rs1: $rspFile"
} else {
	puts $rspFile "-i isp_lab3.bl5 -lci isp_lab3.lct -d m4s_256_64 -lco isp_lab3.lco -html_rpt -fti isp_lab3.fti -fmt PLA -tto isp_lab3.tt4 -nojed -eqn isp_lab3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open isp_lab3.rs2 w} rspFile] {
	puts stderr "Cannot create response file isp_lab3.rs2: $rspFile"
} else {
	puts $rspFile "-i isp_lab3.bl5 -lci isp_lab3.lct -d m4s_256_64 -lco isp_lab3.lco -html_rpt -fti isp_lab3.fti -fmt PLA -tto isp_lab3.tt4 -eqn isp_lab3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@isp_lab3.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete isp_lab3.rs1
file delete isp_lab3.rs2
if [runCmd "\"$cpld_bin/tda\" -i isp_lab3.bl5 -o isp_lab3.tda -lci isp_lab3.lct -dev m4s_256_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj isp_lab3 -if isp_lab3.jed -j2s -log isp_lab3.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/23/23 01:36:39 ###########


########## Tcl recorder starts at 04/23/23 02:04:03 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" clk_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/23/23 02:04:03 ###########


########## Tcl recorder starts at 04/23/23 02:04:03 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab3.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab3.h counter_n.v bit5_full_adder.v ledscan_n.v random_gen.v clk_gen.v controller.v debouncer.v top_level.v
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

########## Tcl recorder end at 04/23/23 02:04:03 ###########


########## Tcl recorder starts at 04/23/23 02:04:38 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/edif2blf\" -edf top_level.edi -out top_level.bl0 -err automake.err -log top_level.log -prj isp_lab3 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"isp_lab3.bl2\" -omod \"isp_lab3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj isp_lab3 -lci isp_lab3.lct -log isp_lab3.imp -err automake.err -tti isp_lab3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab3.lct -blifopt isp_lab3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp_lab3.bl2 -sweep -mergefb -err automake.err -o isp_lab3.bl3 @isp_lab3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab3.lct -dev lc4k -diofft isp_lab3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" isp_lab3.bl3 -family AMDMACH -idev van -o isp_lab3.bl4 -oxrf isp_lab3.xrf -err automake.err @isp_lab3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab3.lct -dev lc4k -prefit isp_lab3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp isp_lab3.bl4 -out isp_lab3.bl5 -err automake.err -log isp_lab3.log -mod top_level @isp_lab3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open isp_lab3.rs1 w} rspFile] {
	puts stderr "Cannot create response file isp_lab3.rs1: $rspFile"
} else {
	puts $rspFile "-i isp_lab3.bl5 -lci isp_lab3.lct -d m4s_256_64 -lco isp_lab3.lco -html_rpt -fti isp_lab3.fti -fmt PLA -tto isp_lab3.tt4 -nojed -eqn isp_lab3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open isp_lab3.rs2 w} rspFile] {
	puts stderr "Cannot create response file isp_lab3.rs2: $rspFile"
} else {
	puts $rspFile "-i isp_lab3.bl5 -lci isp_lab3.lct -d m4s_256_64 -lco isp_lab3.lco -html_rpt -fti isp_lab3.fti -fmt PLA -tto isp_lab3.tt4 -eqn isp_lab3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@isp_lab3.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete isp_lab3.rs1
file delete isp_lab3.rs2
if [runCmd "\"$cpld_bin/tda\" -i isp_lab3.bl5 -o isp_lab3.tda -lci isp_lab3.lct -dev m4s_256_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj isp_lab3 -if isp_lab3.jed -j2s -log isp_lab3.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/23/23 02:04:38 ###########


########## Tcl recorder starts at 04/23/23 02:10:54 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" ledscan_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/23/23 02:10:54 ###########


########## Tcl recorder starts at 04/23/23 02:10:55 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open bit5_full_adder.cmd w} rspFile] {
	puts stderr "Cannot create response file bit5_full_adder.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab3.sty
PROJECT: bit5_full_adder
WORKING_PATH: \"$proj_dir\"
MODULE: bit5_full_adder
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab3.h bit5_full_adder.v
OUTPUT_FILE_NAME: bit5_full_adder
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e bit5_full_adder -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete bit5_full_adder.cmd

########## Tcl recorder end at 04/23/23 02:10:55 ###########


########## Tcl recorder starts at 04/23/23 02:11:27 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab3.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab3.h counter_n.v bit5_full_adder.v ledscan_n.v random_gen.v clk_gen.v controller.v debouncer.v top_level.v
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

########## Tcl recorder end at 04/23/23 02:11:27 ###########


########## Tcl recorder starts at 04/23/23 02:12:02 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/edif2blf\" -edf top_level.edi -out top_level.bl0 -err automake.err -log top_level.log -prj isp_lab3 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"isp_lab3.bl2\" -omod \"isp_lab3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj isp_lab3 -lci isp_lab3.lct -log isp_lab3.imp -err automake.err -tti isp_lab3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab3.lct -blifopt isp_lab3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp_lab3.bl2 -sweep -mergefb -err automake.err -o isp_lab3.bl3 @isp_lab3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab3.lct -dev lc4k -diofft isp_lab3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" isp_lab3.bl3 -family AMDMACH -idev van -o isp_lab3.bl4 -oxrf isp_lab3.xrf -err automake.err @isp_lab3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab3.lct -dev lc4k -prefit isp_lab3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp isp_lab3.bl4 -out isp_lab3.bl5 -err automake.err -log isp_lab3.log -mod top_level @isp_lab3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open isp_lab3.rs1 w} rspFile] {
	puts stderr "Cannot create response file isp_lab3.rs1: $rspFile"
} else {
	puts $rspFile "-i isp_lab3.bl5 -lci isp_lab3.lct -d m4s_256_64 -lco isp_lab3.lco -html_rpt -fti isp_lab3.fti -fmt PLA -tto isp_lab3.tt4 -nojed -eqn isp_lab3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open isp_lab3.rs2 w} rspFile] {
	puts stderr "Cannot create response file isp_lab3.rs2: $rspFile"
} else {
	puts $rspFile "-i isp_lab3.bl5 -lci isp_lab3.lct -d m4s_256_64 -lco isp_lab3.lco -html_rpt -fti isp_lab3.fti -fmt PLA -tto isp_lab3.tt4 -eqn isp_lab3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@isp_lab3.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete isp_lab3.rs1
file delete isp_lab3.rs2
if [runCmd "\"$cpld_bin/tda\" -i isp_lab3.bl5 -o isp_lab3.tda -lci isp_lab3.lct -dev m4s_256_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj isp_lab3 -if isp_lab3.jed -j2s -log isp_lab3.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/23/23 02:12:02 ###########


########## Tcl recorder starts at 04/23/23 02:17:19 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/23/23 02:17:19 ###########


########## Tcl recorder starts at 04/23/23 02:17:19 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab3.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab3.h counter_n.v bit5_full_adder.v ledscan_n.v random_gen.v clk_gen.v controller.v debouncer.v top_level.v
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

########## Tcl recorder end at 04/23/23 02:17:19 ###########


########## Tcl recorder starts at 04/23/23 02:20:09 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/23/23 02:20:09 ###########


########## Tcl recorder starts at 04/23/23 02:20:09 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab3.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab3.h counter_n.v bit5_full_adder.v ledscan_n.v random_gen.v clk_gen.v controller.v debouncer.v top_level.v
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

########## Tcl recorder end at 04/23/23 02:20:09 ###########


########## Tcl recorder starts at 04/23/23 02:21:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/23/23 02:21:35 ###########


########## Tcl recorder starts at 04/23/23 02:21:36 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab3.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab3.h counter_n.v bit5_full_adder.v ledscan_n.v random_gen.v clk_gen.v controller.v debouncer.v top_level.v
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

########## Tcl recorder end at 04/23/23 02:21:36 ###########


########## Tcl recorder starts at 04/23/23 02:31:33 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/23/23 02:31:33 ###########


########## Tcl recorder starts at 04/23/23 02:31:34 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab3.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab3.h counter_n.v bit5_full_adder.v ledscan_n.v random_gen.v clk_gen.v controller.v debouncer.v top_level.v
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

########## Tcl recorder end at 04/23/23 02:31:34 ###########


########## Tcl recorder starts at 04/23/23 02:33:35 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/edif2blf\" -edf top_level.edi -out top_level.bl0 -err automake.err -log top_level.log -prj isp_lab3 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"isp_lab3.bl2\" -omod \"isp_lab3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj isp_lab3 -lci isp_lab3.lct -log isp_lab3.imp -err automake.err -tti isp_lab3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab3.lct -blifopt isp_lab3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp_lab3.bl2 -sweep -mergefb -err automake.err -o isp_lab3.bl3 @isp_lab3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab3.lct -dev lc4k -diofft isp_lab3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" isp_lab3.bl3 -family AMDMACH -idev van -o isp_lab3.bl4 -oxrf isp_lab3.xrf -err automake.err @isp_lab3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab3.lct -dev lc4k -prefit isp_lab3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp isp_lab3.bl4 -out isp_lab3.bl5 -err automake.err -log isp_lab3.log -mod top_level @isp_lab3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open isp_lab3.rs1 w} rspFile] {
	puts stderr "Cannot create response file isp_lab3.rs1: $rspFile"
} else {
	puts $rspFile "-i isp_lab3.bl5 -lci isp_lab3.lct -d m4s_256_64 -lco isp_lab3.lco -html_rpt -fti isp_lab3.fti -fmt PLA -tto isp_lab3.tt4 -nojed -eqn isp_lab3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open isp_lab3.rs2 w} rspFile] {
	puts stderr "Cannot create response file isp_lab3.rs2: $rspFile"
} else {
	puts $rspFile "-i isp_lab3.bl5 -lci isp_lab3.lct -d m4s_256_64 -lco isp_lab3.lco -html_rpt -fti isp_lab3.fti -fmt PLA -tto isp_lab3.tt4 -eqn isp_lab3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@isp_lab3.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete isp_lab3.rs1
file delete isp_lab3.rs2
if [runCmd "\"$cpld_bin/tda\" -i isp_lab3.bl5 -o isp_lab3.tda -lci isp_lab3.lct -dev m4s_256_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj isp_lab3 -if isp_lab3.jed -j2s -log isp_lab3.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/23/23 02:33:35 ###########


########## Tcl recorder starts at 04/23/23 02:44:08 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/23/23 02:44:08 ###########


########## Tcl recorder starts at 04/23/23 02:44:08 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab3.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab3.h counter_n.v bit5_full_adder.v ledscan_n.v random_gen.v clk_gen.v controller.v debouncer.v top_level.v
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

########## Tcl recorder end at 04/23/23 02:44:08 ###########


########## Tcl recorder starts at 04/23/23 02:44:53 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" width_trans.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/23/23 02:44:53 ###########


########## Tcl recorder starts at 04/23/23 02:44:54 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab3.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab3.h counter_n.v width_trans.v bit5_full_adder.v ledscan_n.v random_gen.v clk_gen.v controller.v debouncer.v top_level.v
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

########## Tcl recorder end at 04/23/23 02:44:54 ###########


########## Tcl recorder starts at 04/23/23 02:45:29 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/edif2blf\" -edf top_level.edi -out top_level.bl0 -err automake.err -log top_level.log -prj isp_lab3 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"isp_lab3.bl2\" -omod \"isp_lab3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj isp_lab3 -lci isp_lab3.lct -log isp_lab3.imp -err automake.err -tti isp_lab3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab3.lct -blifopt isp_lab3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp_lab3.bl2 -sweep -mergefb -err automake.err -o isp_lab3.bl3 @isp_lab3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab3.lct -dev lc4k -diofft isp_lab3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" isp_lab3.bl3 -family AMDMACH -idev van -o isp_lab3.bl4 -oxrf isp_lab3.xrf -err automake.err @isp_lab3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab3.lct -dev lc4k -prefit isp_lab3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp isp_lab3.bl4 -out isp_lab3.bl5 -err automake.err -log isp_lab3.log -mod top_level @isp_lab3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open isp_lab3.rs1 w} rspFile] {
	puts stderr "Cannot create response file isp_lab3.rs1: $rspFile"
} else {
	puts $rspFile "-i isp_lab3.bl5 -lci isp_lab3.lct -d m4s_256_64 -lco isp_lab3.lco -html_rpt -fti isp_lab3.fti -fmt PLA -tto isp_lab3.tt4 -nojed -eqn isp_lab3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open isp_lab3.rs2 w} rspFile] {
	puts stderr "Cannot create response file isp_lab3.rs2: $rspFile"
} else {
	puts $rspFile "-i isp_lab3.bl5 -lci isp_lab3.lct -d m4s_256_64 -lco isp_lab3.lco -html_rpt -fti isp_lab3.fti -fmt PLA -tto isp_lab3.tt4 -eqn isp_lab3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@isp_lab3.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete isp_lab3.rs1
file delete isp_lab3.rs2
if [runCmd "\"$cpld_bin/tda\" -i isp_lab3.bl5 -o isp_lab3.tda -lci isp_lab3.lct -dev m4s_256_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj isp_lab3 -if isp_lab3.jed -j2s -log isp_lab3.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/23/23 02:45:29 ###########


########## Tcl recorder starts at 04/23/23 02:47:01 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/23/23 02:47:01 ###########


########## Tcl recorder starts at 04/23/23 02:47:01 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab3.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab3.h counter_n.v width_trans.v bit5_full_adder.v ledscan_n.v random_gen.v clk_gen.v controller.v debouncer.v top_level.v
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

########## Tcl recorder end at 04/23/23 02:47:01 ###########


########## Tcl recorder starts at 04/23/23 02:47:36 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/edif2blf\" -edf top_level.edi -out top_level.bl0 -err automake.err -log top_level.log -prj isp_lab3 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"isp_lab3.bl2\" -omod \"isp_lab3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj isp_lab3 -lci isp_lab3.lct -log isp_lab3.imp -err automake.err -tti isp_lab3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab3.lct -blifopt isp_lab3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp_lab3.bl2 -sweep -mergefb -err automake.err -o isp_lab3.bl3 @isp_lab3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab3.lct -dev lc4k -diofft isp_lab3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" isp_lab3.bl3 -family AMDMACH -idev van -o isp_lab3.bl4 -oxrf isp_lab3.xrf -err automake.err @isp_lab3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab3.lct -dev lc4k -prefit isp_lab3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp isp_lab3.bl4 -out isp_lab3.bl5 -err automake.err -log isp_lab3.log -mod top_level @isp_lab3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open isp_lab3.rs1 w} rspFile] {
	puts stderr "Cannot create response file isp_lab3.rs1: $rspFile"
} else {
	puts $rspFile "-i isp_lab3.bl5 -lci isp_lab3.lct -d m4s_256_64 -lco isp_lab3.lco -html_rpt -fti isp_lab3.fti -fmt PLA -tto isp_lab3.tt4 -nojed -eqn isp_lab3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open isp_lab3.rs2 w} rspFile] {
	puts stderr "Cannot create response file isp_lab3.rs2: $rspFile"
} else {
	puts $rspFile "-i isp_lab3.bl5 -lci isp_lab3.lct -d m4s_256_64 -lco isp_lab3.lco -html_rpt -fti isp_lab3.fti -fmt PLA -tto isp_lab3.tt4 -eqn isp_lab3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@isp_lab3.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete isp_lab3.rs1
file delete isp_lab3.rs2
if [runCmd "\"$cpld_bin/tda\" -i isp_lab3.bl5 -o isp_lab3.tda -lci isp_lab3.lct -dev m4s_256_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj isp_lab3 -if isp_lab3.jed -j2s -log isp_lab3.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/23/23 02:47:36 ###########


########## Tcl recorder starts at 04/23/23 02:52:23 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/23/23 02:52:23 ###########


########## Tcl recorder starts at 04/23/23 02:52:23 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab3.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab3.h counter_n.v width_trans.v bit5_full_adder.v ledscan_n.v random_gen.v clk_gen.v controller.v debouncer.v top_level.v
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

########## Tcl recorder end at 04/23/23 02:52:23 ###########


########## Tcl recorder starts at 04/23/23 02:52:56 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/edif2blf\" -edf top_level.edi -out top_level.bl0 -err automake.err -log top_level.log -prj isp_lab3 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"isp_lab3.bl2\" -omod \"isp_lab3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj isp_lab3 -lci isp_lab3.lct -log isp_lab3.imp -err automake.err -tti isp_lab3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab3.lct -blifopt isp_lab3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp_lab3.bl2 -sweep -mergefb -err automake.err -o isp_lab3.bl3 @isp_lab3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab3.lct -dev lc4k -diofft isp_lab3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" isp_lab3.bl3 -family AMDMACH -idev van -o isp_lab3.bl4 -oxrf isp_lab3.xrf -err automake.err @isp_lab3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab3.lct -dev lc4k -prefit isp_lab3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp isp_lab3.bl4 -out isp_lab3.bl5 -err automake.err -log isp_lab3.log -mod top_level @isp_lab3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open isp_lab3.rs1 w} rspFile] {
	puts stderr "Cannot create response file isp_lab3.rs1: $rspFile"
} else {
	puts $rspFile "-i isp_lab3.bl5 -lci isp_lab3.lct -d m4s_256_64 -lco isp_lab3.lco -html_rpt -fti isp_lab3.fti -fmt PLA -tto isp_lab3.tt4 -nojed -eqn isp_lab3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open isp_lab3.rs2 w} rspFile] {
	puts stderr "Cannot create response file isp_lab3.rs2: $rspFile"
} else {
	puts $rspFile "-i isp_lab3.bl5 -lci isp_lab3.lct -d m4s_256_64 -lco isp_lab3.lco -html_rpt -fti isp_lab3.fti -fmt PLA -tto isp_lab3.tt4 -eqn isp_lab3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@isp_lab3.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete isp_lab3.rs1
file delete isp_lab3.rs2
if [runCmd "\"$cpld_bin/tda\" -i isp_lab3.bl5 -o isp_lab3.tda -lci isp_lab3.lct -dev m4s_256_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj isp_lab3 -if isp_lab3.jed -j2s -log isp_lab3.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/23/23 02:52:56 ###########


########## Tcl recorder starts at 04/23/23 02:53:07 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i isp_lab3.bl5 -o isp_lab3.sif"] {
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
	puts $rspFile "-nodal -src isp_lab3.bl5 -type BLIF -presrc isp_lab3.bl3 -crf isp_lab3.crf -sif isp_lab3.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci isp_lab3.lct
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

########## Tcl recorder end at 04/23/23 02:53:07 ###########


########## Tcl recorder starts at 04/23/23 02:54:10 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/23/23 02:54:10 ###########


########## Tcl recorder starts at 04/23/23 02:54:10 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab3.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab3.h counter_n.v width_trans.v bit5_full_adder.v ledscan_n.v random_gen.v clk_gen.v controller.v debouncer.v top_level.v
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

########## Tcl recorder end at 04/23/23 02:54:10 ###########


########## Tcl recorder starts at 04/23/23 02:54:43 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/edif2blf\" -edf top_level.edi -out top_level.bl0 -err automake.err -log top_level.log -prj isp_lab3 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"isp_lab3.bl2\" -omod \"isp_lab3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj isp_lab3 -lci isp_lab3.lct -log isp_lab3.imp -err automake.err -tti isp_lab3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab3.lct -blifopt isp_lab3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp_lab3.bl2 -sweep -mergefb -err automake.err -o isp_lab3.bl3 @isp_lab3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab3.lct -dev lc4k -diofft isp_lab3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" isp_lab3.bl3 -family AMDMACH -idev van -o isp_lab3.bl4 -oxrf isp_lab3.xrf -err automake.err @isp_lab3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab3.lct -dev lc4k -prefit isp_lab3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp isp_lab3.bl4 -out isp_lab3.bl5 -err automake.err -log isp_lab3.log -mod top_level @isp_lab3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open isp_lab3.rs1 w} rspFile] {
	puts stderr "Cannot create response file isp_lab3.rs1: $rspFile"
} else {
	puts $rspFile "-i isp_lab3.bl5 -lci isp_lab3.lct -d m4s_256_64 -lco isp_lab3.lco -html_rpt -fti isp_lab3.fti -fmt PLA -tto isp_lab3.tt4 -nojed -eqn isp_lab3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open isp_lab3.rs2 w} rspFile] {
	puts stderr "Cannot create response file isp_lab3.rs2: $rspFile"
} else {
	puts $rspFile "-i isp_lab3.bl5 -lci isp_lab3.lct -d m4s_256_64 -lco isp_lab3.lco -html_rpt -fti isp_lab3.fti -fmt PLA -tto isp_lab3.tt4 -eqn isp_lab3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@isp_lab3.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete isp_lab3.rs1
file delete isp_lab3.rs2
if [runCmd "\"$cpld_bin/tda\" -i isp_lab3.bl5 -o isp_lab3.tda -lci isp_lab3.lct -dev m4s_256_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj isp_lab3 -if isp_lab3.jed -j2s -log isp_lab3.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/23/23 02:54:43 ###########


########## Tcl recorder starts at 04/23/23 02:57:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" top_level.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/23/23 02:57:20 ###########


########## Tcl recorder starts at 04/23/23 02:57:20 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab3.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab3.h counter_n.v width_trans.v bit5_full_adder.v ledscan_n.v random_gen.v clk_gen.v controller.v debouncer.v top_level.v
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

########## Tcl recorder end at 04/23/23 02:57:20 ###########


########## Tcl recorder starts at 04/23/23 02:57:55 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/edif2blf\" -edf top_level.edi -out top_level.bl0 -err automake.err -log top_level.log -prj isp_lab3 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"isp_lab3.bl2\" -omod \"isp_lab3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj isp_lab3 -lci isp_lab3.lct -log isp_lab3.imp -err automake.err -tti isp_lab3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab3.lct -blifopt isp_lab3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp_lab3.bl2 -sweep -mergefb -err automake.err -o isp_lab3.bl3 @isp_lab3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab3.lct -dev lc4k -diofft isp_lab3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" isp_lab3.bl3 -family AMDMACH -idev van -o isp_lab3.bl4 -oxrf isp_lab3.xrf -err automake.err @isp_lab3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab3.lct -dev lc4k -prefit isp_lab3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp isp_lab3.bl4 -out isp_lab3.bl5 -err automake.err -log isp_lab3.log -mod top_level @isp_lab3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open isp_lab3.rs1 w} rspFile] {
	puts stderr "Cannot create response file isp_lab3.rs1: $rspFile"
} else {
	puts $rspFile "-i isp_lab3.bl5 -lci isp_lab3.lct -d m4s_256_64 -lco isp_lab3.lco -html_rpt -fti isp_lab3.fti -fmt PLA -tto isp_lab3.tt4 -nojed -eqn isp_lab3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open isp_lab3.rs2 w} rspFile] {
	puts stderr "Cannot create response file isp_lab3.rs2: $rspFile"
} else {
	puts $rspFile "-i isp_lab3.bl5 -lci isp_lab3.lct -d m4s_256_64 -lco isp_lab3.lco -html_rpt -fti isp_lab3.fti -fmt PLA -tto isp_lab3.tt4 -eqn isp_lab3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@isp_lab3.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete isp_lab3.rs1
file delete isp_lab3.rs2
if [runCmd "\"$cpld_bin/tda\" -i isp_lab3.bl5 -o isp_lab3.tda -lci isp_lab3.lct -dev m4s_256_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj isp_lab3 -if isp_lab3.jed -j2s -log isp_lab3.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/23/23 02:57:55 ###########


########## Tcl recorder starts at 04/28/23 08:25:30 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top_level.cmd w} rspFile] {
	puts stderr "Cannot create response file top_level.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab3.sty
PROJECT: top_level
WORKING_PATH: \"$proj_dir\"
MODULE: top_level
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab3.h counter_n.v width_trans.v bit5_full_adder.v ledscan_n.v random_gen.v clk_gen.v controller.v debouncer.v top_level.v
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

########## Tcl recorder end at 04/28/23 08:25:30 ###########


########## Tcl recorder starts at 04/28/23 08:26:32 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/edif2blf\" -edf top_level.edi -out top_level.bl0 -err automake.err -log top_level.log -prj isp_lab3 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"top_level.bl1\" -o \"isp_lab3.bl2\" -omod \"isp_lab3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj isp_lab3 -lci isp_lab3.lct -log isp_lab3.imp -err automake.err -tti isp_lab3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab3.lct -blifopt isp_lab3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp_lab3.bl2 -sweep -mergefb -err automake.err -o isp_lab3.bl3 @isp_lab3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab3.lct -dev lc4k -diofft isp_lab3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" isp_lab3.bl3 -family AMDMACH -idev van -o isp_lab3.bl4 -oxrf isp_lab3.xrf -err automake.err @isp_lab3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab3.lct -dev lc4k -prefit isp_lab3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp isp_lab3.bl4 -out isp_lab3.bl5 -err automake.err -log isp_lab3.log -mod top_level @isp_lab3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open isp_lab3.rs1 w} rspFile] {
	puts stderr "Cannot create response file isp_lab3.rs1: $rspFile"
} else {
	puts $rspFile "-i isp_lab3.bl5 -lci isp_lab3.lct -d m4s_256_64 -lco isp_lab3.lco -html_rpt -fti isp_lab3.fti -fmt PLA -tto isp_lab3.tt4 -nojed -eqn isp_lab3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open isp_lab3.rs2 w} rspFile] {
	puts stderr "Cannot create response file isp_lab3.rs2: $rspFile"
} else {
	puts $rspFile "-i isp_lab3.bl5 -lci isp_lab3.lct -d m4s_256_64 -lco isp_lab3.lco -html_rpt -fti isp_lab3.fti -fmt PLA -tto isp_lab3.tt4 -eqn isp_lab3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@isp_lab3.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete isp_lab3.rs1
file delete isp_lab3.rs2
if [runCmd "\"$cpld_bin/tda\" -i isp_lab3.bl5 -o isp_lab3.tda -lci isp_lab3.lct -dev m4s_256_64 -family lc4k -mod top_level -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj isp_lab3 -if isp_lab3.jed -j2s -log isp_lab3.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/28/23 08:26:32 ###########


########## Tcl recorder starts at 04/28/23 09:15:54 ##########

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

########## Tcl recorder end at 04/28/23 09:15:54 ###########

