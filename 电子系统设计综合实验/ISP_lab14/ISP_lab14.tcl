
########## Tcl recorder starts at 05/29/23 15:31:29 ##########

set version "2.1"
set proj_dir "D:/MyDucuments/_Junior_1/ElectricSystemDesign/ISP_lab14"
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
if [runCmd "\"$cpld_bin/vlog2jhd\" vga_top.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" VCounter.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" FrameScan.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" HCounter.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" vga_ctrl.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" LineScan.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" vga_data.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 15:31:29 ###########


########## Tcl recorder starts at 05/29/23 15:31:35 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab14.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab14.h vga_data.v FrameScan.v LineScan.v VCounter.v HCounter.v vga_ctrl.v vga_top.v
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

########## Tcl recorder end at 05/29/23 15:31:35 ###########


########## Tcl recorder starts at 05/29/23 15:33:23 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" VCounter.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" HCounter.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" vga_ctrl.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" LineScan.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 15:33:23 ###########


########## Tcl recorder starts at 05/29/23 15:33:24 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab14.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab14.h vga_data.v FrameScan.v LineScan.v VCounter.v HCounter.v vga_ctrl.v vga_top.v
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

########## Tcl recorder end at 05/29/23 15:33:24 ###########


########## Tcl recorder starts at 05/29/23 15:34:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" VCounter.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 15:34:44 ###########


########## Tcl recorder starts at 05/29/23 15:34:44 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab14.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab14.h vga_data.v FrameScan.v LineScan.v VCounter.v HCounter.v vga_ctrl.v vga_top.v
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

########## Tcl recorder end at 05/29/23 15:34:44 ###########


########## Tcl recorder starts at 05/29/23 15:35:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" HCounter.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" LineScan.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 15:35:44 ###########


########## Tcl recorder starts at 05/29/23 15:35:44 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab14.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab14.h vga_data.v FrameScan.v LineScan.v VCounter.v HCounter.v vga_ctrl.v vga_top.v
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

########## Tcl recorder end at 05/29/23 15:35:44 ###########


########## Tcl recorder starts at 05/29/23 15:40:33 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" LineScan.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 15:40:33 ###########


########## Tcl recorder starts at 05/29/23 15:40:33 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab14.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab14.h vga_data.v FrameScan.v LineScan.v VCounter.v HCounter.v vga_ctrl.v vga_top.v
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

########## Tcl recorder end at 05/29/23 15:40:33 ###########


########## Tcl recorder starts at 05/29/23 15:43:45 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" FrameScan.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" LineScan.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 15:43:45 ###########


########## Tcl recorder starts at 05/29/23 15:43:45 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab14.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab14.h vga_data.v FrameScan.v LineScan.v VCounter.v HCounter.v vga_ctrl.v vga_top.v
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

########## Tcl recorder end at 05/29/23 15:43:45 ###########


########## Tcl recorder starts at 05/29/23 15:45:27 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" FrameScan.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 15:45:27 ###########


########## Tcl recorder starts at 05/29/23 15:45:27 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab14.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab14.h vga_data.v FrameScan.v LineScan.v VCounter.v HCounter.v vga_ctrl.v vga_top.v
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

########## Tcl recorder end at 05/29/23 15:45:27 ###########


########## Tcl recorder starts at 05/29/23 15:52:45 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" vga_data.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 15:52:45 ###########


########## Tcl recorder starts at 05/29/23 15:52:45 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab14.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab14.h vga_data.v FrameScan.v LineScan.v VCounter.v HCounter.v vga_ctrl.v vga_top.v
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

########## Tcl recorder end at 05/29/23 15:52:45 ###########


########## Tcl recorder starts at 05/29/23 16:03:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" vga_top.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" vga_data.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 16:03:41 ###########


########## Tcl recorder starts at 05/29/23 16:03:42 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab14.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab14.h vga_data.v FrameScan.v LineScan.v VCounter.v HCounter.v vga_ctrl.v vga_top.v
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

########## Tcl recorder end at 05/29/23 16:03:42 ###########


########## Tcl recorder starts at 05/29/23 16:04:56 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" vga_top.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 16:04:56 ###########


########## Tcl recorder starts at 05/29/23 16:04:56 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab14.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab14.h vga_data.v FrameScan.v LineScan.v VCounter.v HCounter.v vga_ctrl.v vga_top.v
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

########## Tcl recorder end at 05/29/23 16:04:56 ###########


########## Tcl recorder starts at 05/29/23 16:07:54 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" vga_top.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 16:07:54 ###########


########## Tcl recorder starts at 05/29/23 16:07:55 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab14.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab14.h vga_data.v FrameScan.v LineScan.v VCounter.v HCounter.v vga_ctrl.v vga_top.v
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

########## Tcl recorder end at 05/29/23 16:07:55 ###########


########## Tcl recorder starts at 05/29/23 16:09:07 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/edif2blf\" -edf toplevel.edi -out toplevel.bl0 -err automake.err -log toplevel.log -prj isp_lab14 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"toplevel.bl1\" -o \"isp_lab14.bl2\" -omod \"isp_lab14\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj isp_lab14 -lci isp_lab14.lct -log isp_lab14.imp -err automake.err -tti isp_lab14.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab14.lct -blifopt isp_lab14.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp_lab14.bl2 -sweep -mergefb -err automake.err -o isp_lab14.bl3 @isp_lab14.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab14.lct -dev lc4k -diofft isp_lab14.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" isp_lab14.bl3 -family AMDMACH -idev van -o isp_lab14.bl4 -oxrf isp_lab14.xrf -err automake.err @isp_lab14.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab14.lct -dev lc4k -prefit isp_lab14.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp isp_lab14.bl4 -out isp_lab14.bl5 -err automake.err -log isp_lab14.log -mod toplevel @isp_lab14.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i isp_lab14.bl5 -o isp_lab14.sif"] {
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
	puts $rspFile "-nodal -src isp_lab14.bl5 -type BLIF -presrc isp_lab14.bl3 -crf isp_lab14.crf -sif isp_lab14.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci isp_lab14.lct
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

########## Tcl recorder end at 05/29/23 16:09:07 ###########


########## Tcl recorder starts at 05/29/23 16:10:05 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" vga_data.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 16:10:05 ###########


########## Tcl recorder starts at 05/29/23 16:10:05 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab14.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab14.h vga_data.v FrameScan.v LineScan.v VCounter.v HCounter.v vga_ctrl.v vga_top.v
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

########## Tcl recorder end at 05/29/23 16:10:05 ###########


########## Tcl recorder starts at 05/29/23 16:12:25 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" vga_top.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 16:12:25 ###########


########## Tcl recorder starts at 05/29/23 16:12:26 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab14.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab14.h vga_data.v FrameScan.v LineScan.v VCounter.v HCounter.v vga_ctrl.v vga_top.v
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

########## Tcl recorder end at 05/29/23 16:12:26 ###########


########## Tcl recorder starts at 05/29/23 16:13:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" vga_data.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 16:13:44 ###########


########## Tcl recorder starts at 05/29/23 16:13:44 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab14.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab14.h vga_data.v FrameScan.v LineScan.v VCounter.v HCounter.v vga_ctrl.v vga_top.v
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

########## Tcl recorder end at 05/29/23 16:13:44 ###########


########## Tcl recorder starts at 05/29/23 16:16:48 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" FrameScan.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" LineScan.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 16:16:48 ###########


########## Tcl recorder starts at 05/29/23 16:16:49 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab14.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab14.h vga_data.v FrameScan.v LineScan.v VCounter.v HCounter.v vga_ctrl.v vga_top.v
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

########## Tcl recorder end at 05/29/23 16:16:49 ###########


########## Tcl recorder starts at 05/29/23 16:18:44 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/edif2blf\" -edf toplevel.edi -out toplevel.bl0 -err automake.err -log toplevel.log -prj isp_lab14 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"toplevel.bl1\" -o \"isp_lab14.bl2\" -omod \"isp_lab14\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj isp_lab14 -lci isp_lab14.lct -log isp_lab14.imp -err automake.err -tti isp_lab14.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab14.lct -blifopt isp_lab14.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp_lab14.bl2 -sweep -mergefb -err automake.err -o isp_lab14.bl3 @isp_lab14.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab14.lct -dev lc4k -diofft isp_lab14.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" isp_lab14.bl3 -family AMDMACH -idev van -o isp_lab14.bl4 -oxrf isp_lab14.xrf -err automake.err @isp_lab14.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab14.lct -dev lc4k -prefit isp_lab14.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp isp_lab14.bl4 -out isp_lab14.bl5 -err automake.err -log isp_lab14.log -mod toplevel @isp_lab14.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i isp_lab14.bl5 -o isp_lab14.sif"] {
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
	puts $rspFile "-nodal -src isp_lab14.bl5 -type BLIF -presrc isp_lab14.bl3 -crf isp_lab14.crf -sif isp_lab14.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci isp_lab14.lct
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

########## Tcl recorder end at 05/29/23 16:18:44 ###########


########## Tcl recorder starts at 05/29/23 16:22:36 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open isp_lab14.rs1 w} rspFile] {
	puts stderr "Cannot create response file isp_lab14.rs1: $rspFile"
} else {
	puts $rspFile "-i isp_lab14.bl5 -lci isp_lab14.lct -d m4s_256_96 -lco isp_lab14.lco -html_rpt -fti isp_lab14.fti -fmt PLA -tto isp_lab14.tt4 -nojed -eqn isp_lab14.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open isp_lab14.rs2 w} rspFile] {
	puts stderr "Cannot create response file isp_lab14.rs2: $rspFile"
} else {
	puts $rspFile "-i isp_lab14.bl5 -lci isp_lab14.lct -d m4s_256_96 -lco isp_lab14.lco -html_rpt -fti isp_lab14.fti -fmt PLA -tto isp_lab14.tt4 -eqn isp_lab14.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@isp_lab14.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete isp_lab14.rs1
file delete isp_lab14.rs2
if [runCmd "\"$cpld_bin/tda\" -i isp_lab14.bl5 -o isp_lab14.tda -lci isp_lab14.lct -dev m4s_256_96 -family lc4k -mod toplevel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj isp_lab14 -if isp_lab14.jed -j2s -log isp_lab14.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 16:22:36 ###########

