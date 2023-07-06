
########## Tcl recorder starts at 05/26/23 11:24:11 ##########

set version "2.1"
set proj_dir "D:/MyDucuments/_Junior_1/ElectricSystemDesign/ISP_lab11"
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
if [runCmd "\"$cpld_bin/vlog2jhd\" lab11.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 11:24:11 ###########


########## Tcl recorder starts at 05/26/23 17:13:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ledscan_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncer.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" width_trans.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" scanButtons.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" lab11.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncer_key.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" toplevel.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" controller.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" clk_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 17:13:47 ###########


########## Tcl recorder starts at 05/26/23 17:14:08 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ledscan_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncer.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" width_trans.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" scanButtons.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" lab11.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" toplevel.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" controller.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" clk_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 17:14:08 ###########


########## Tcl recorder starts at 05/26/23 17:14:10 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab11.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab11.h ledscan_n.v scanButtons.v lab11.v width_trans.v controller.v counter_n.v debouncer.v clk_gen.v toplevel.v
OUTPUT_FILE_NAME: toplevel
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e toplevel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete toplevel.cmd

########## Tcl recorder end at 05/26/23 17:14:10 ###########


########## Tcl recorder starts at 05/26/23 17:15:26 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lab11.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 17:15:26 ###########


########## Tcl recorder starts at 05/26/23 17:15:27 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab11.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab11.h ledscan_n.v scanButtons.v lab11.v width_trans.v controller.v counter_n.v debouncer.v clk_gen.v toplevel.v
OUTPUT_FILE_NAME: toplevel
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e toplevel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete toplevel.cmd

########## Tcl recorder end at 05/26/23 17:15:27 ###########


########## Tcl recorder starts at 05/26/23 17:17:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lab11.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 17:17:34 ###########


########## Tcl recorder starts at 05/26/23 17:17:35 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab11.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab11.h ledscan_n.v scanButtons.v lab11.v width_trans.v controller.v counter_n.v debouncer.v clk_gen.v toplevel.v
OUTPUT_FILE_NAME: toplevel
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e toplevel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete toplevel.cmd

########## Tcl recorder end at 05/26/23 17:17:35 ###########


########## Tcl recorder starts at 05/26/23 17:18:22 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" scanButtons.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 17:18:22 ###########


########## Tcl recorder starts at 05/26/23 17:18:23 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab11.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab11.h ledscan_n.v scanButtons.v lab11.v width_trans.v controller.v counter_n.v debouncer.v clk_gen.v toplevel.v
OUTPUT_FILE_NAME: toplevel
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e toplevel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete toplevel.cmd

########## Tcl recorder end at 05/26/23 17:18:23 ###########


########## Tcl recorder starts at 05/26/23 17:19:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lab11.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 17:19:31 ###########


########## Tcl recorder starts at 05/26/23 17:19:31 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab11.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab11.h ledscan_n.v scanButtons.v lab11.v width_trans.v controller.v counter_n.v debouncer.v clk_gen.v toplevel.v
OUTPUT_FILE_NAME: toplevel
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e toplevel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete toplevel.cmd

########## Tcl recorder end at 05/26/23 17:19:31 ###########


########## Tcl recorder starts at 05/26/23 17:20:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lab11.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" clk_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 17:20:44 ###########


########## Tcl recorder starts at 05/26/23 17:20:44 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab11.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab11.h ledscan_n.v scanButtons.v lab11.v width_trans.v controller.v counter_n.v debouncer.v clk_gen.v toplevel.v
OUTPUT_FILE_NAME: toplevel
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e toplevel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete toplevel.cmd

########## Tcl recorder end at 05/26/23 17:20:44 ###########


########## Tcl recorder starts at 05/26/23 17:23:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" toplevel.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 17:23:17 ###########


########## Tcl recorder starts at 05/26/23 17:23:18 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab11.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab11.h ledscan_n.v scanButtons.v lab11.v width_trans.v controller.v counter_n.v debouncer.v clk_gen.v toplevel.v
OUTPUT_FILE_NAME: toplevel
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e toplevel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete toplevel.cmd

########## Tcl recorder end at 05/26/23 17:23:18 ###########


########## Tcl recorder starts at 05/26/23 17:23:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" toplevel.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 17:23:47 ###########


########## Tcl recorder starts at 05/26/23 17:23:48 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab11.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab11.h ledscan_n.v scanButtons.v lab11.v width_trans.v controller.v counter_n.v debouncer.v clk_gen.v toplevel.v
OUTPUT_FILE_NAME: toplevel
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e toplevel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete toplevel.cmd

########## Tcl recorder end at 05/26/23 17:23:48 ###########


########## Tcl recorder starts at 05/26/23 17:25:01 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" toplevel.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 17:25:01 ###########


########## Tcl recorder starts at 05/26/23 17:25:02 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab11.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab11.h ledscan_n.v scanButtons.v lab11.v width_trans.v controller.v counter_n.v debouncer.v clk_gen.v toplevel.v
OUTPUT_FILE_NAME: toplevel
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e toplevel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete toplevel.cmd

########## Tcl recorder end at 05/26/23 17:25:02 ###########


########## Tcl recorder starts at 05/26/23 17:26:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" toplevel.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 17:26:36 ###########


########## Tcl recorder starts at 05/26/23 17:26:36 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab11.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab11.h ledscan_n.v scanButtons.v lab11.v width_trans.v controller.v counter_n.v debouncer.v clk_gen.v toplevel.v
OUTPUT_FILE_NAME: toplevel
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e toplevel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete toplevel.cmd

########## Tcl recorder end at 05/26/23 17:26:36 ###########


########## Tcl recorder starts at 05/26/23 17:28:03 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" toplevel.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 17:28:03 ###########


########## Tcl recorder starts at 05/26/23 17:28:03 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/edif2blf\" -edf toplevel.edi -out toplevel.bl0 -err automake.err -log toplevel.log -prj isp_lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" toplevel.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"toplevel.bl1\" -o \"isp_lab11.bl2\" -omod \"isp_lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj isp_lab11 -lci isp_lab11.lct -log isp_lab11.imp -err automake.err -tti isp_lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab11.lct -blifopt isp_lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp_lab11.bl2 -sweep -mergefb -err automake.err -o isp_lab11.bl3 @isp_lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab11.lct -dev lc4k -diofft isp_lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" isp_lab11.bl3 -family AMDMACH -idev van -o isp_lab11.bl4 -oxrf isp_lab11.xrf -err automake.err @isp_lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab11.lct -dev lc4k -prefit isp_lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp isp_lab11.bl4 -out isp_lab11.bl5 -err automake.err -log isp_lab11.log -mod toplevel @isp_lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i isp_lab11.bl5 -o isp_lab11.sif"] {
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
	puts $rspFile "-nodal -src isp_lab11.bl5 -type BLIF -presrc isp_lab11.bl3 -crf isp_lab11.crf -sif isp_lab11.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci isp_lab11.lct
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

########## Tcl recorder end at 05/26/23 17:28:03 ###########


########## Tcl recorder starts at 05/26/23 17:34:06 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open isp_lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file isp_lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i isp_lab11.bl5 -lci isp_lab11.lct -d m4s_256_64 -lco isp_lab11.lco -html_rpt -fti isp_lab11.fti -fmt PLA -tto isp_lab11.tt4 -nojed -eqn isp_lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open isp_lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file isp_lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i isp_lab11.bl5 -lci isp_lab11.lct -d m4s_256_64 -lco isp_lab11.lco -html_rpt -fti isp_lab11.fti -fmt PLA -tto isp_lab11.tt4 -eqn isp_lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@isp_lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete isp_lab11.rs1
file delete isp_lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i isp_lab11.bl5 -o isp_lab11.tda -lci isp_lab11.lct -dev m4s_256_64 -family lc4k -mod toplevel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj isp_lab11 -if isp_lab11.jed -j2s -log isp_lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 17:34:06 ###########


########## Tcl recorder starts at 05/26/23 17:37:02 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" toplevel.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 17:37:02 ###########


########## Tcl recorder starts at 05/26/23 17:37:02 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab11.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab11.h ledscan_n.v scanButtons.v lab11.v counter_n.v clk_gen.v toplevel.v
OUTPUT_FILE_NAME: toplevel
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e toplevel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete toplevel.cmd

########## Tcl recorder end at 05/26/23 17:37:03 ###########


########## Tcl recorder starts at 05/26/23 17:37:56 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ledscan_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" width_trans.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" scanButtons.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" lab11.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" toplevel.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" clk_gen.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 17:37:56 ###########


########## Tcl recorder starts at 05/26/23 17:38:00 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab11.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab11.h ledscan_n.v scanButtons.v lab11.v counter_n.v clk_gen.v toplevel.v
OUTPUT_FILE_NAME: toplevel
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e toplevel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete toplevel.cmd

########## Tcl recorder end at 05/26/23 17:38:00 ###########


########## Tcl recorder starts at 05/26/23 17:39:37 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/edif2blf\" -edf toplevel.edi -out toplevel.bl0 -err automake.err -log toplevel.log -prj isp_lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" toplevel.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"toplevel.bl1\" -o \"isp_lab11.bl2\" -omod \"isp_lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj isp_lab11 -lci isp_lab11.lct -log isp_lab11.imp -err automake.err -tti isp_lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab11.lct -blifopt isp_lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp_lab11.bl2 -sweep -mergefb -err automake.err -o isp_lab11.bl3 @isp_lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab11.lct -dev lc4k -diofft isp_lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" isp_lab11.bl3 -family AMDMACH -idev van -o isp_lab11.bl4 -oxrf isp_lab11.xrf -err automake.err @isp_lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab11.lct -dev lc4k -prefit isp_lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp isp_lab11.bl4 -out isp_lab11.bl5 -err automake.err -log isp_lab11.log -mod toplevel @isp_lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open isp_lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file isp_lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i isp_lab11.bl5 -lci isp_lab11.lct -d m4s_256_64 -lco isp_lab11.lco -html_rpt -fti isp_lab11.fti -fmt PLA -tto isp_lab11.tt4 -nojed -eqn isp_lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open isp_lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file isp_lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i isp_lab11.bl5 -lci isp_lab11.lct -d m4s_256_64 -lco isp_lab11.lco -html_rpt -fti isp_lab11.fti -fmt PLA -tto isp_lab11.tt4 -eqn isp_lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@isp_lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete isp_lab11.rs1
file delete isp_lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i isp_lab11.bl5 -o isp_lab11.tda -lci isp_lab11.lct -dev m4s_256_64 -family lc4k -mod toplevel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj isp_lab11 -if isp_lab11.jed -j2s -log isp_lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 17:39:37 ###########


########## Tcl recorder starts at 06/02/23 08:21:38 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i isp_lab11.bl5 -o isp_lab11.sif"] {
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
	puts $rspFile "-nodal -src isp_lab11.bl5 -type BLIF -presrc isp_lab11.bl3 -crf isp_lab11.crf -sif isp_lab11.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci isp_lab11.lct
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

########## Tcl recorder end at 06/02/23 08:21:38 ###########


########## Tcl recorder starts at 06/02/23 08:30:36 ##########

# Commands to make the Process: 
# Constraint Editor
# - none -
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src isp_lab11.bl5 -type BLIF -presrc isp_lab11.bl3 -crf isp_lab11.crf -sif isp_lab11.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci isp_lab11.lct
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

########## Tcl recorder end at 06/02/23 08:30:36 ###########


########## Tcl recorder starts at 06/02/23 08:33:18 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open isp_lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file isp_lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i isp_lab11.bl5 -lci isp_lab11.lct -d m4s_256_64 -lco isp_lab11.lco -html_rpt -fti isp_lab11.fti -fmt PLA -tto isp_lab11.tt4 -nojed -eqn isp_lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open isp_lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file isp_lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i isp_lab11.bl5 -lci isp_lab11.lct -d m4s_256_64 -lco isp_lab11.lco -html_rpt -fti isp_lab11.fti -fmt PLA -tto isp_lab11.tt4 -eqn isp_lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@isp_lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete isp_lab11.rs1
file delete isp_lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i isp_lab11.bl5 -o isp_lab11.tda -lci isp_lab11.lct -dev m4s_256_64 -family lc4k -mod toplevel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj isp_lab11 -if isp_lab11.jed -j2s -log isp_lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 08:33:18 ###########

