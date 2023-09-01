
########## Tcl recorder starts at 05/24/23 21:46:17 ##########

set version "2.1"
set proj_dir "D:/MyDucuments/_Junior_1/ElectricSystemDesign/ISP_lab10"
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
if [runCmd "\"$cpld_bin/vlog2jhd\" ledscan_n.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" toplevel.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" PS2_Receiver.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/24/23 21:46:17 ###########


########## Tcl recorder starts at 05/24/23 21:46:20 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab10.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab10.h ledscan_n.v PS2_Receiver.v toplevel.v
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

########## Tcl recorder end at 05/24/23 21:46:20 ###########


########## Tcl recorder starts at 05/24/23 21:47:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" PS2_Receiver.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/24/23 21:47:16 ###########


########## Tcl recorder starts at 05/24/23 21:47:16 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab10.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab10.h ledscan_n.v PS2_Receiver.v toplevel.v
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

########## Tcl recorder end at 05/24/23 21:47:16 ###########


########## Tcl recorder starts at 05/24/23 21:48:27 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" PS2_Receiver.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/24/23 21:48:27 ###########


########## Tcl recorder starts at 05/24/23 21:48:27 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab10.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab10.h ledscan_n.v PS2_Receiver.v toplevel.v
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

########## Tcl recorder end at 05/24/23 21:48:27 ###########


########## Tcl recorder starts at 05/24/23 21:52:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" PS2_Receiver.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/24/23 21:52:11 ###########


########## Tcl recorder starts at 05/24/23 21:52:12 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab10.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab10.h ledscan_n.v PS2_Receiver.v toplevel.v
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

########## Tcl recorder end at 05/24/23 21:52:12 ###########


########## Tcl recorder starts at 05/24/23 21:53:04 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" PS2_Receiver.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/24/23 21:53:04 ###########


########## Tcl recorder starts at 05/24/23 21:53:05 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab10.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab10.h ledscan_n.v PS2_Receiver.v toplevel.v
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

########## Tcl recorder end at 05/24/23 21:53:05 ###########


########## Tcl recorder starts at 05/24/23 21:53:58 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" PS2_Receiver.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/24/23 21:53:58 ###########


########## Tcl recorder starts at 05/24/23 21:53:58 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab10.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab10.h ledscan_n.v PS2_Receiver.v toplevel.v
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

########## Tcl recorder end at 05/24/23 21:53:58 ###########


########## Tcl recorder starts at 05/24/23 21:55:03 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" PS2_Receiver.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/24/23 21:55:03 ###########


########## Tcl recorder starts at 05/24/23 21:55:03 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab10.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab10.h ledscan_n.v PS2_Receiver.v toplevel.v
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

########## Tcl recorder end at 05/24/23 21:55:03 ###########


########## Tcl recorder starts at 05/24/23 21:56:04 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" PS2_Receiver.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/24/23 21:56:04 ###########


########## Tcl recorder starts at 05/24/23 21:56:04 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab10.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab10.h ledscan_n.v PS2_Receiver.v toplevel.v
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

########## Tcl recorder end at 05/24/23 21:56:04 ###########


########## Tcl recorder starts at 05/24/23 21:56:40 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" PS2_Receiver.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/24/23 21:56:40 ###########


########## Tcl recorder starts at 05/24/23 21:56:40 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab10.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab10.h ledscan_n.v PS2_Receiver.v toplevel.v
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

########## Tcl recorder end at 05/24/23 21:56:40 ###########


########## Tcl recorder starts at 05/24/23 21:57:33 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" PS2_Receiver.v -p \"$install_dir/ispcpld/generic\" -predefine isp_lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/24/23 21:57:33 ###########


########## Tcl recorder starts at 05/24/23 21:57:33 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: isp_lab10.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" isp_lab10.h ledscan_n.v PS2_Receiver.v toplevel.v
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

########## Tcl recorder end at 05/24/23 21:57:33 ###########


########## Tcl recorder starts at 05/24/23 21:58:07 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/edif2blf\" -edf toplevel.edi -out toplevel.bl0 -err automake.err -log toplevel.log -prj isp_lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"toplevel.bl1\" -o \"isp_lab10.bl2\" -omod \"isp_lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj isp_lab10 -lci isp_lab10.lct -log isp_lab10.imp -err automake.err -tti isp_lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab10.lct -blifopt isp_lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" isp_lab10.bl2 -sweep -mergefb -err automake.err -o isp_lab10.bl3 @isp_lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab10.lct -dev lc4k -diofft isp_lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" isp_lab10.bl3 -family AMDMACH -idev van -o isp_lab10.bl4 -oxrf isp_lab10.xrf -err automake.err @isp_lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci isp_lab10.lct -dev lc4k -prefit isp_lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp isp_lab10.bl4 -out isp_lab10.bl5 -err automake.err -log isp_lab10.log -mod toplevel @isp_lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i isp_lab10.bl5 -o isp_lab10.sif"] {
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
	puts $rspFile "-nodal -src isp_lab10.bl5 -type BLIF -presrc isp_lab10.bl3 -crf isp_lab10.crf -sif isp_lab10.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci isp_lab10.lct
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

########## Tcl recorder end at 05/24/23 21:58:07 ###########


########## Tcl recorder starts at 05/24/23 22:05:33 ##########

# Commands to make the Process: 
# Pre-Fit Equations
if [runCmd "\"$cpld_bin/blif2eqn\" isp_lab10.bl5 -o isp_lab10.eq2 -use_short -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/24/23 22:05:33 ###########


########## Tcl recorder starts at 05/24/23 22:05:36 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open isp_lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file isp_lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i isp_lab10.bl5 -lci isp_lab10.lct -d m4s_256_64 -lco isp_lab10.lco -html_rpt -fti isp_lab10.fti -fmt PLA -tto isp_lab10.tt4 -nojed -eqn isp_lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open isp_lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file isp_lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i isp_lab10.bl5 -lci isp_lab10.lct -d m4s_256_64 -lco isp_lab10.lco -html_rpt -fti isp_lab10.fti -fmt PLA -tto isp_lab10.tt4 -eqn isp_lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@isp_lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete isp_lab10.rs1
file delete isp_lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i isp_lab10.bl5 -o isp_lab10.tda -lci isp_lab10.lct -dev m4s_256_64 -family lc4k -mod toplevel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj isp_lab10 -if isp_lab10.jed -j2s -log isp_lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/24/23 22:05:36 ###########

