
########## Tcl recorder starts at 06/02/23 10:44:00 ##########

set version "2.1"
set proj_dir "D:/isp/labX"
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
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 10:44:00 ###########


########## Tcl recorder starts at 06/02/23 10:44:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 10:44:11 ###########


########## Tcl recorder starts at 06/02/23 10:45:58 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open CALCULATE.cmd w} rspFile] {
	puts stderr "Cannot create response file CALCULATE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: CALCULATE
WORKING_PATH: \"$proj_dir\"
MODULE: CALCULATE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h calculate.v
OUTPUT_FILE_NAME: CALCULATE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e CALCULATE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete CALCULATE.cmd

########## Tcl recorder end at 06/02/23 10:45:58 ###########


########## Tcl recorder starts at 06/02/23 10:47:27 ##########

# Commands to make the Process: 
# Compile EDIF File
if [runCmd "\"$cpld_bin/edif2blf\" -edf CALCULATE.edi -out CALCULATE.bl0 -err automake.err -log CALCULATE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 10:47:27 ###########


########## Tcl recorder starts at 06/02/23 10:47:29 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" CALCULATE"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 10:47:29 ###########


########## Tcl recorder starts at 06/02/23 10:47:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 10:47:35 ###########


########## Tcl recorder starts at 06/02/23 10:48:05 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 10:48:05 ###########


########## Tcl recorder starts at 06/02/23 10:48:34 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open CALCULATE.cmd w} rspFile] {
	puts stderr "Cannot create response file CALCULATE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: CALCULATE
WORKING_PATH: \"$proj_dir\"
MODULE: CALCULATE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h calculate.v
OUTPUT_FILE_NAME: CALCULATE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e CALCULATE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete CALCULATE.cmd

########## Tcl recorder end at 06/02/23 10:48:34 ###########


########## Tcl recorder starts at 06/02/23 10:49:05 ##########

# Commands to make the Process: 
# Compile EDIF File
if [runCmd "\"$cpld_bin/edif2blf\" -edf CALCULATE.edi -out CALCULATE.bl0 -err automake.err -log CALCULATE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 10:49:05 ###########


########## Tcl recorder starts at 06/02/23 10:49:07 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" CALCULATE"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 10:49:07 ###########


########## Tcl recorder starts at 06/02/23 10:49:15 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 10:49:15 ###########


########## Tcl recorder starts at 06/02/23 10:51:55 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 10:51:55 ###########


########## Tcl recorder starts at 06/02/23 10:52:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 10:52:12 ###########


########## Tcl recorder starts at 06/02/23 10:52:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" display.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 10:52:29 ###########


########## Tcl recorder starts at 06/02/23 10:52:39 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" display.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 10:52:39 ###########


########## Tcl recorder starts at 06/02/23 10:53:01 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open DISPLAY.cmd w} rspFile] {
	puts stderr "Cannot create response file DISPLAY.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: DISPLAY
WORKING_PATH: \"$proj_dir\"
MODULE: DISPLAY
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h display.v
OUTPUT_FILE_NAME: DISPLAY
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DISPLAY -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DISPLAY.cmd

########## Tcl recorder end at 06/02/23 10:53:01 ###########


########## Tcl recorder starts at 06/02/23 10:54:30 ##########

# Commands to make the Process: 
# Compile EDIF File
if [runCmd "\"$cpld_bin/edif2blf\" -edf DISPLAY.edi -out DISPLAY.bl0 -err automake.err -log DISPLAY.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 10:54:30 ###########


########## Tcl recorder starts at 06/02/23 10:54:32 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" DISPLAY"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 10:54:32 ###########


########## Tcl recorder starts at 06/02/23 10:55:46 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 10:55:46 ###########


########## Tcl recorder starts at 06/02/23 10:56:05 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 10:56:05 ###########


########## Tcl recorder starts at 06/02/23 11:00:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 11:00:20 ###########


########## Tcl recorder starts at 06/02/23 11:13:45 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 11:13:45 ###########


########## Tcl recorder starts at 06/02/23 11:13:50 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open CALCULATE.cmd w} rspFile] {
	puts stderr "Cannot create response file CALCULATE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: CALCULATE
WORKING_PATH: \"$proj_dir\"
MODULE: CALCULATE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h calculate.v
OUTPUT_FILE_NAME: CALCULATE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e CALCULATE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete CALCULATE.cmd

########## Tcl recorder end at 06/02/23 11:13:50 ###########


########## Tcl recorder starts at 06/02/23 11:16:45 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" CALCULATE"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 11:16:45 ###########


########## Tcl recorder starts at 06/02/23 11:17:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 11:17:17 ###########


########## Tcl recorder starts at 06/02/23 11:18:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 11:18:07 ###########


########## Tcl recorder starts at 06/02/23 11:18:13 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 11:18:13 ###########


########## Tcl recorder starts at 06/02/23 11:18:17 ##########

# Commands to make the Process: 
# Compile Schematic
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup top.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bls\" -o \"top.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 11:18:17 ###########


########## Tcl recorder starts at 06/02/23 11:18:20 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/mblifopt\" -i top.bl0 -o top.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DISPLAY.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/edif2blf\" -edf CALCULATE.edi -out CALCULATE.bl0 -err automake.err -log CALCULATE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" CALCULATE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i labx.bl5 -o labx.sif"] {
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
	puts $rspFile "-nodal -src labx.bl5 -type BLIF -presrc labx.bl3 -crf labx.crf -sif labx.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci labx.lct
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

########## Tcl recorder end at 06/02/23 11:18:20 ###########


########## Tcl recorder starts at 06/02/23 11:25:03 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 11:25:03 ###########


########## Tcl recorder starts at 06/02/23 11:25:05 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 11:25:05 ###########


########## Tcl recorder starts at 06/02/23 11:27:28 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 11:27:28 ###########


########## Tcl recorder starts at 06/02/23 11:27:57 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 11:27:57 ###########


########## Tcl recorder starts at 06/02/23 11:29:04 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 11:29:04 ###########


########## Tcl recorder starts at 06/02/23 11:30:49 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" display.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 11:30:49 ###########


########## Tcl recorder starts at 06/02/23 11:30:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" display.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 11:30:59 ###########


########## Tcl recorder starts at 06/02/23 11:31:01 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" display.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 11:31:01 ###########


########## Tcl recorder starts at 06/02/23 11:31:26 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" display.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 11:31:26 ###########


########## Tcl recorder starts at 06/02/23 11:31:30 ##########

# Commands to make the Process: 
# Compile Schematic
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup top.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bls\" -o \"top.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 11:31:30 ###########


########## Tcl recorder starts at 06/02/23 11:31:34 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/mblifopt\" -i top.bl0 -o top.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open DISPLAY.cmd w} rspFile] {
	puts stderr "Cannot create response file DISPLAY.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: DISPLAY
WORKING_PATH: \"$proj_dir\"
MODULE: DISPLAY
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h display.v
OUTPUT_FILE_NAME: DISPLAY
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DISPLAY -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DISPLAY.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DISPLAY.edi -out DISPLAY.bl0 -err automake.err -log DISPLAY.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DISPLAY.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open CALCULATE.cmd w} rspFile] {
	puts stderr "Cannot create response file CALCULATE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: CALCULATE
WORKING_PATH: \"$proj_dir\"
MODULE: CALCULATE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h calculate.v
OUTPUT_FILE_NAME: CALCULATE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e CALCULATE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete CALCULATE.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf CALCULATE.edi -out CALCULATE.bl0 -err automake.err -log CALCULATE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" CALCULATE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i labx.bl5 -o labx.sif"] {
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
	puts $rspFile "-nodal -src labx.bl5 -type BLIF -presrc labx.bl3 -crf labx.crf -sif labx.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci labx.lct
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

########## Tcl recorder end at 06/02/23 11:31:34 ###########


########## Tcl recorder starts at 06/02/23 11:35:36 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 11:35:36 ###########


########## Tcl recorder starts at 06/02/23 11:39:15 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i labx.bl5 -o labx.sif"] {
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
	puts $rspFile "-nodal -src labx.bl5 -type BLIF -presrc labx.bl3 -crf labx.crf -sif labx.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci labx.lct
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

########## Tcl recorder end at 06/02/23 11:39:15 ###########


########## Tcl recorder starts at 06/02/23 11:42:59 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 11:42:59 ###########


########## Tcl recorder starts at 06/02/23 11:45:17 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i labx.bl5 -o labx.sif"] {
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
	puts $rspFile "-nodal -src labx.bl5 -type BLIF -presrc labx.bl3 -crf labx.crf -sif labx.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci labx.lct
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

########## Tcl recorder end at 06/02/23 11:45:17 ###########


########## Tcl recorder starts at 06/02/23 11:46:11 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 11:46:11 ###########


########## Tcl recorder starts at 06/02/23 11:48:37 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 11:48:37 ###########


########## Tcl recorder starts at 06/02/23 11:48:42 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup top.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bls\" -o \"top.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i top.bl0 -o top.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 11:48:42 ###########


########## Tcl recorder starts at 06/02/23 11:57:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 11:57:44 ###########


########## Tcl recorder starts at 06/02/23 11:58:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 11:58:12 ###########


########## Tcl recorder starts at 06/02/23 11:58:24 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup top.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bls\" -o \"top.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i top.bl0 -o top.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i labx.bl5 -o labx.sif"] {
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
	puts $rspFile "-nodal -src labx.bl5 -type BLIF -presrc labx.bl3 -crf labx.crf -sif labx.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci labx.lct
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

########## Tcl recorder end at 06/02/23 11:58:24 ###########


########## Tcl recorder starts at 06/02/23 11:59:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 11:59:16 ###########


########## Tcl recorder starts at 06/02/23 12:00:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:00:16 ###########


########## Tcl recorder starts at 06/02/23 12:00:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:00:59 ###########


########## Tcl recorder starts at 06/02/23 12:02:00 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:02:00 ###########


########## Tcl recorder starts at 06/02/23 12:02:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:02:12 ###########


########## Tcl recorder starts at 06/02/23 12:02:18 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup top.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bls\" -o \"top.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i top.bl0 -o top.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open CALCULATE.cmd w} rspFile] {
	puts stderr "Cannot create response file CALCULATE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: CALCULATE
WORKING_PATH: \"$proj_dir\"
MODULE: CALCULATE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h calculate.v
OUTPUT_FILE_NAME: CALCULATE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e CALCULATE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete CALCULATE.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf CALCULATE.edi -out CALCULATE.bl0 -err automake.err -log CALCULATE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" CALCULATE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:02:18 ###########


########## Tcl recorder starts at 06/02/23 12:04:40 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:04:40 ###########


########## Tcl recorder starts at 06/02/23 12:05:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:05:07 ###########


########## Tcl recorder starts at 06/02/23 12:05:37 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open CALCULATE.cmd w} rspFile] {
	puts stderr "Cannot create response file CALCULATE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: CALCULATE
WORKING_PATH: \"$proj_dir\"
MODULE: CALCULATE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h calculate.v
OUTPUT_FILE_NAME: CALCULATE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e CALCULATE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete CALCULATE.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf CALCULATE.edi -out CALCULATE.bl0 -err automake.err -log CALCULATE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" CALCULATE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:05:37 ###########


########## Tcl recorder starts at 06/05/23 21:27:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/05/23 21:27:41 ###########


########## Tcl recorder starts at 06/05/23 21:30:09 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/05/23 21:30:09 ###########


########## Tcl recorder starts at 06/05/23 21:30:17 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open CALCULATE.cmd w} rspFile] {
	puts stderr "Cannot create response file CALCULATE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: CALCULATE
WORKING_PATH: \"$proj_dir\"
MODULE: CALCULATE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h calculate.v
OUTPUT_FILE_NAME: CALCULATE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e CALCULATE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete CALCULATE.cmd

########## Tcl recorder end at 06/05/23 21:30:17 ###########


########## Tcl recorder starts at 06/05/23 21:34:05 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/05/23 21:34:05 ###########


########## Tcl recorder starts at 06/05/23 21:34:05 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open CALCULATE.cmd w} rspFile] {
	puts stderr "Cannot create response file CALCULATE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: CALCULATE
WORKING_PATH: \"$proj_dir\"
MODULE: CALCULATE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h calculate.v
OUTPUT_FILE_NAME: CALCULATE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e CALCULATE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete CALCULATE.cmd

########## Tcl recorder end at 06/05/23 21:34:05 ###########


########## Tcl recorder starts at 06/05/23 21:34:39 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" CALCULATE"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/05/23 21:34:39 ###########


########## Tcl recorder starts at 06/05/23 21:34:46 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/05/23 21:34:46 ###########


########## Tcl recorder starts at 06/05/23 21:35:13 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/05/23 21:35:13 ###########


########## Tcl recorder starts at 06/05/23 21:35:24 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup top.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bls\" -o \"top.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i top.bl0 -o top.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/edif2blf\" -edf CALCULATE.edi -out CALCULATE.bl0 -err automake.err -log CALCULATE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" CALCULATE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i labx.bl5 -o labx.sif"] {
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
	puts $rspFile "-nodal -src labx.bl5 -type BLIF -presrc labx.bl3 -crf labx.crf -sif labx.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci labx.lct
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

########## Tcl recorder end at 06/05/23 21:35:24 ###########


########## Tcl recorder starts at 06/05/23 21:37:17 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/05/23 21:37:17 ###########


########## Tcl recorder starts at 06/05/23 22:39:50 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/05/23 22:39:50 ###########


########## Tcl recorder starts at 06/05/23 22:39:55 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open CALCULATE.cmd w} rspFile] {
	puts stderr "Cannot create response file CALCULATE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: CALCULATE
WORKING_PATH: \"$proj_dir\"
MODULE: CALCULATE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h calculate.v
OUTPUT_FILE_NAME: CALCULATE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e CALCULATE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete CALCULATE.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf CALCULATE.edi -out CALCULATE.bl0 -err automake.err -log CALCULATE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" CALCULATE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/05/23 22:39:55 ###########


########## Tcl recorder starts at 06/05/23 22:41:26 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/05/23 22:41:26 ###########


########## Tcl recorder starts at 06/05/23 22:41:30 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open CALCULATE.cmd w} rspFile] {
	puts stderr "Cannot create response file CALCULATE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: CALCULATE
WORKING_PATH: \"$proj_dir\"
MODULE: CALCULATE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h calculate.v
OUTPUT_FILE_NAME: CALCULATE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e CALCULATE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete CALCULATE.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf CALCULATE.edi -out CALCULATE.bl0 -err automake.err -log CALCULATE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" CALCULATE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/05/23 22:41:30 ###########


########## Tcl recorder starts at 06/05/23 22:42:40 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/05/23 22:42:40 ###########


########## Tcl recorder starts at 06/05/23 22:42:51 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open CALCULATE.cmd w} rspFile] {
	puts stderr "Cannot create response file CALCULATE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: CALCULATE
WORKING_PATH: \"$proj_dir\"
MODULE: CALCULATE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h calculate.v
OUTPUT_FILE_NAME: CALCULATE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e CALCULATE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete CALCULATE.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf CALCULATE.edi -out CALCULATE.bl0 -err automake.err -log CALCULATE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" CALCULATE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/05/23 22:42:51 ###########


########## Tcl recorder starts at 06/05/23 22:44:23 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/05/23 22:44:23 ###########


########## Tcl recorder starts at 06/05/23 22:44:27 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open CALCULATE.cmd w} rspFile] {
	puts stderr "Cannot create response file CALCULATE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: CALCULATE
WORKING_PATH: \"$proj_dir\"
MODULE: CALCULATE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h calculate.v
OUTPUT_FILE_NAME: CALCULATE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e CALCULATE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete CALCULATE.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf CALCULATE.edi -out CALCULATE.bl0 -err automake.err -log CALCULATE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" CALCULATE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/05/23 22:44:27 ###########


########## Tcl recorder starts at 06/05/23 22:45:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/05/23 22:45:47 ###########


########## Tcl recorder starts at 06/05/23 22:45:51 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open CALCULATE.cmd w} rspFile] {
	puts stderr "Cannot create response file CALCULATE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: CALCULATE
WORKING_PATH: \"$proj_dir\"
MODULE: CALCULATE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h calculate.v
OUTPUT_FILE_NAME: CALCULATE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e CALCULATE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete CALCULATE.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf CALCULATE.edi -out CALCULATE.bl0 -err automake.err -log CALCULATE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" CALCULATE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/05/23 22:45:51 ###########


########## Tcl recorder starts at 06/05/23 22:47:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/05/23 22:47:16 ###########


########## Tcl recorder starts at 06/05/23 22:47:29 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open CALCULATE.cmd w} rspFile] {
	puts stderr "Cannot create response file CALCULATE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: CALCULATE
WORKING_PATH: \"$proj_dir\"
MODULE: CALCULATE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h calculate.v
OUTPUT_FILE_NAME: CALCULATE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e CALCULATE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete CALCULATE.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf CALCULATE.edi -out CALCULATE.bl0 -err automake.err -log CALCULATE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" CALCULATE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/05/23 22:47:29 ###########


########## Tcl recorder starts at 06/05/23 22:48:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/05/23 22:48:34 ###########


########## Tcl recorder starts at 06/05/23 22:48:39 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open CALCULATE.cmd w} rspFile] {
	puts stderr "Cannot create response file CALCULATE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: CALCULATE
WORKING_PATH: \"$proj_dir\"
MODULE: CALCULATE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h calculate.v
OUTPUT_FILE_NAME: CALCULATE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e CALCULATE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete CALCULATE.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf CALCULATE.edi -out CALCULATE.bl0 -err automake.err -log CALCULATE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" CALCULATE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/05/23 22:48:39 ###########


########## Tcl recorder starts at 06/05/23 22:50:02 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i labx.bl5 -o labx.sif"] {
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
	puts $rspFile "-nodal -src labx.bl5 -type BLIF -presrc labx.bl3 -crf labx.crf -sif labx.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci labx.lct
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

########## Tcl recorder end at 06/05/23 22:50:02 ###########


########## Tcl recorder starts at 06/05/23 22:51:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/05/23 22:51:16 ###########


########## Tcl recorder starts at 06/05/23 22:51:20 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open CALCULATE.cmd w} rspFile] {
	puts stderr "Cannot create response file CALCULATE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: CALCULATE
WORKING_PATH: \"$proj_dir\"
MODULE: CALCULATE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h calculate.v
OUTPUT_FILE_NAME: CALCULATE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e CALCULATE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete CALCULATE.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf CALCULATE.edi -out CALCULATE.bl0 -err automake.err -log CALCULATE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" CALCULATE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/05/23 22:51:20 ###########


########## Tcl recorder starts at 06/05/23 23:01:37 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/05/23 23:01:37 ###########


########## Tcl recorder starts at 06/05/23 23:01:40 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open CALCULATE.cmd w} rspFile] {
	puts stderr "Cannot create response file CALCULATE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: CALCULATE
WORKING_PATH: \"$proj_dir\"
MODULE: CALCULATE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h calculate.v
OUTPUT_FILE_NAME: CALCULATE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e CALCULATE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete CALCULATE.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf CALCULATE.edi -out CALCULATE.bl0 -err automake.err -log CALCULATE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" CALCULATE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/05/23 23:01:40 ###########


########## Tcl recorder starts at 06/05/23 23:02:50 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/05/23 23:02:50 ###########


########## Tcl recorder starts at 06/05/23 23:02:54 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open CALCULATE.cmd w} rspFile] {
	puts stderr "Cannot create response file CALCULATE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: CALCULATE
WORKING_PATH: \"$proj_dir\"
MODULE: CALCULATE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h calculate.v
OUTPUT_FILE_NAME: CALCULATE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e CALCULATE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete CALCULATE.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf CALCULATE.edi -out CALCULATE.bl0 -err automake.err -log CALCULATE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" CALCULATE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/05/23 23:02:54 ###########


########## Tcl recorder starts at 06/05/23 23:04:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/05/23 23:04:17 ###########


########## Tcl recorder starts at 06/05/23 23:04:20 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open CALCULATE.cmd w} rspFile] {
	puts stderr "Cannot create response file CALCULATE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: CALCULATE
WORKING_PATH: \"$proj_dir\"
MODULE: CALCULATE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h calculate.v
OUTPUT_FILE_NAME: CALCULATE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e CALCULATE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete CALCULATE.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf CALCULATE.edi -out CALCULATE.bl0 -err automake.err -log CALCULATE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" CALCULATE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/05/23 23:04:20 ###########


########## Tcl recorder starts at 06/05/23 23:05:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/05/23 23:05:41 ###########


########## Tcl recorder starts at 06/05/23 23:05:44 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open CALCULATE.cmd w} rspFile] {
	puts stderr "Cannot create response file CALCULATE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: CALCULATE
WORKING_PATH: \"$proj_dir\"
MODULE: CALCULATE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h calculate.v
OUTPUT_FILE_NAME: CALCULATE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e CALCULATE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete CALCULATE.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf CALCULATE.edi -out CALCULATE.bl0 -err automake.err -log CALCULATE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" CALCULATE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/05/23 23:05:44 ###########


########## Tcl recorder starts at 06/05/23 23:16:28 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/05/23 23:16:28 ###########


########## Tcl recorder starts at 06/05/23 23:16:41 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open CALCULATE.cmd w} rspFile] {
	puts stderr "Cannot create response file CALCULATE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: CALCULATE
WORKING_PATH: \"$proj_dir\"
MODULE: CALCULATE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h calculate.v
OUTPUT_FILE_NAME: CALCULATE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e CALCULATE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete CALCULATE.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf CALCULATE.edi -out CALCULATE.bl0 -err automake.err -log CALCULATE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" CALCULATE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/05/23 23:16:41 ###########


########## Tcl recorder starts at 06/07/23 18:56:39 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/07/23 18:56:39 ###########


########## Tcl recorder starts at 06/07/23 18:57:20 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" LED"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/07/23 18:57:20 ###########


########## Tcl recorder starts at 06/07/23 18:57:24 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open LED.cmd w} rspFile] {
	puts stderr "Cannot create response file LED.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: LED
WORKING_PATH: \"$proj_dir\"
MODULE: LED
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h led.v
OUTPUT_FILE_NAME: LED
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LED -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED.cmd

########## Tcl recorder end at 06/07/23 18:57:24 ###########


########## Tcl recorder starts at 06/07/23 22:18:03 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/07/23 22:18:03 ###########


########## Tcl recorder starts at 06/07/23 22:18:18 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup top.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bls\" -o \"top.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i top.bl0 -o top.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/edif2blf\" -edf LED.edi -out LED.bl0 -err automake.err -log LED.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" LED.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i labx.bl5 -o labx.sif"] {
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
	puts $rspFile "-nodal -src labx.bl5 -type BLIF -presrc labx.bl3 -crf labx.crf -sif labx.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci labx.lct
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

########## Tcl recorder end at 06/07/23 22:18:18 ###########


########## Tcl recorder starts at 06/07/23 22:19:50 ##########

# Commands to make the Process: 
# Constraint Editor
# - none -
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src labx.bl5 -type BLIF -presrc labx.bl3 -crf labx.crf -sif labx.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci labx.lct
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

########## Tcl recorder end at 06/07/23 22:19:50 ###########


########## Tcl recorder starts at 06/07/23 22:21:13 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/07/23 22:21:13 ###########


########## Tcl recorder starts at 06/07/23 23:14:23 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/07/23 23:14:23 ###########


########## Tcl recorder starts at 06/07/23 23:14:28 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open LED.cmd w} rspFile] {
	puts stderr "Cannot create response file LED.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: LED
WORKING_PATH: \"$proj_dir\"
MODULE: LED
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h led.v
OUTPUT_FILE_NAME: LED
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LED -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf LED.edi -out LED.bl0 -err automake.err -log LED.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" LED.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/07/23 23:14:28 ###########


########## Tcl recorder starts at 06/07/23 23:18:43 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/07/23 23:18:43 ###########


########## Tcl recorder starts at 06/07/23 23:18:48 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open LED.cmd w} rspFile] {
	puts stderr "Cannot create response file LED.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: LED
WORKING_PATH: \"$proj_dir\"
MODULE: LED
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h led.v
OUTPUT_FILE_NAME: LED
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LED -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf LED.edi -out LED.bl0 -err automake.err -log LED.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" LED.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/07/23 23:18:48 ###########


########## Tcl recorder starts at 06/07/23 23:22:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/07/23 23:22:20 ###########


########## Tcl recorder starts at 06/07/23 23:22:43 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/07/23 23:22:43 ###########


########## Tcl recorder starts at 06/07/23 23:22:46 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open LED.cmd w} rspFile] {
	puts stderr "Cannot create response file LED.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: LED
WORKING_PATH: \"$proj_dir\"
MODULE: LED
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h led.v
OUTPUT_FILE_NAME: LED
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LED -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf LED.edi -out LED.bl0 -err automake.err -log LED.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" LED.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/07/23 23:22:46 ###########


########## Tcl recorder starts at 06/07/23 23:24:16 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i labx.bl5 -o labx.sif"] {
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
	puts $rspFile "-nodal -src labx.bl5 -type BLIF -presrc labx.bl3 -crf labx.crf -sif labx.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci labx.lct
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

########## Tcl recorder end at 06/07/23 23:24:16 ###########


########## Tcl recorder starts at 06/07/23 23:26:06 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/07/23 23:26:06 ###########


########## Tcl recorder starts at 06/07/23 23:26:40 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/07/23 23:26:40 ###########


########## Tcl recorder starts at 06/07/23 23:26:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/07/23 23:26:47 ###########


########## Tcl recorder starts at 06/07/23 23:26:51 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open LED.cmd w} rspFile] {
	puts stderr "Cannot create response file LED.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: LED
WORKING_PATH: \"$proj_dir\"
MODULE: LED
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h led.v
OUTPUT_FILE_NAME: LED
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LED -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf LED.edi -out LED.bl0 -err automake.err -log LED.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" LED.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/07/23 23:26:51 ###########


########## Tcl recorder starts at 06/07/23 23:27:39 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/07/23 23:27:39 ###########


########## Tcl recorder starts at 06/07/23 23:27:53 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup top.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bls\" -o \"top.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i top.bl0 -o top.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open LED.cmd w} rspFile] {
	puts stderr "Cannot create response file LED.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: LED
WORKING_PATH: \"$proj_dir\"
MODULE: LED
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h led.v
OUTPUT_FILE_NAME: LED
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LED -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf LED.edi -out LED.bl0 -err automake.err -log LED.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" LED.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open DISPLAY.cmd w} rspFile] {
	puts stderr "Cannot create response file DISPLAY.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: DISPLAY
WORKING_PATH: \"$proj_dir\"
MODULE: DISPLAY
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h display.v
OUTPUT_FILE_NAME: DISPLAY
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DISPLAY -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DISPLAY.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DISPLAY.edi -out DISPLAY.bl0 -err automake.err -log DISPLAY.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DISPLAY.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open CALCULATE.cmd w} rspFile] {
	puts stderr "Cannot create response file CALCULATE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: CALCULATE
WORKING_PATH: \"$proj_dir\"
MODULE: CALCULATE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h calculate.v
OUTPUT_FILE_NAME: CALCULATE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e CALCULATE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete CALCULATE.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf CALCULATE.edi -out CALCULATE.bl0 -err automake.err -log CALCULATE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" CALCULATE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/07/23 23:27:53 ###########


########## Tcl recorder starts at 06/07/23 23:30:49 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i labx.bl5 -o labx.sif"] {
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
	puts $rspFile "-nodal -src labx.bl5 -type BLIF -presrc labx.bl3 -crf labx.crf -sif labx.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci labx.lct
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

########## Tcl recorder end at 06/07/23 23:30:49 ###########


########## Tcl recorder starts at 06/08/23 21:17:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" compare.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/08/23 21:17:12 ###########


########## Tcl recorder starts at 06/08/23 21:17:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" compare.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/08/23 21:17:17 ###########


########## Tcl recorder starts at 06/08/23 21:18:13 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open COMPARE.cmd w} rspFile] {
	puts stderr "Cannot create response file COMPARE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: COMPARE
WORKING_PATH: \"$proj_dir\"
MODULE: COMPARE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h compare.v
OUTPUT_FILE_NAME: COMPARE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e COMPARE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete COMPARE.cmd

########## Tcl recorder end at 06/08/23 21:18:13 ###########


########## Tcl recorder starts at 06/08/23 21:18:45 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" COMPARE"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/08/23 21:18:45 ###########


########## Tcl recorder starts at 06/08/23 21:20:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/08/23 21:20:20 ###########


########## Tcl recorder starts at 06/08/23 21:20:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" compare.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/08/23 21:20:41 ###########


########## Tcl recorder starts at 06/08/23 21:20:45 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" COMPARE"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/08/23 21:20:45 ###########


########## Tcl recorder starts at 06/08/23 21:24:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" deshake.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/08/23 21:24:12 ###########


########## Tcl recorder starts at 06/08/23 21:30:30 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" deshake.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/08/23 21:30:30 ###########


########## Tcl recorder starts at 06/08/23 21:30:39 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open DESHAKE.cmd w} rspFile] {
	puts stderr "Cannot create response file DESHAKE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: DESHAKE
WORKING_PATH: \"$proj_dir\"
MODULE: DESHAKE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h deshake.v
OUTPUT_FILE_NAME: DESHAKE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DESHAKE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DESHAKE.cmd

########## Tcl recorder end at 06/08/23 21:30:39 ###########


########## Tcl recorder starts at 06/08/23 21:31:10 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" DESHAKE"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/08/23 21:31:10 ###########


########## Tcl recorder starts at 06/08/23 21:33:50 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/08/23 21:33:50 ###########


########## Tcl recorder starts at 06/08/23 21:35:03 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/08/23 21:35:03 ###########


########## Tcl recorder starts at 06/08/23 21:35:12 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup top.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bls\" -o \"top.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i top.bl0 -o top.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/edif2blf\" -edf DESHAKE.edi -out DESHAKE.bl0 -err automake.err -log DESHAKE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DESHAKE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open COMPARE.cmd w} rspFile] {
	puts stderr "Cannot create response file COMPARE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: COMPARE
WORKING_PATH: \"$proj_dir\"
MODULE: COMPARE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h compare.v
OUTPUT_FILE_NAME: COMPARE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e COMPARE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete COMPARE.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf COMPARE.edi -out COMPARE.bl0 -err automake.err -log COMPARE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" COMPARE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i labx.bl5 -o labx.sif"] {
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
	puts $rspFile "-nodal -src labx.bl5 -type BLIF -presrc labx.bl3 -crf labx.crf -sif labx.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci labx.lct
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

########## Tcl recorder end at 06/08/23 21:35:12 ###########


########## Tcl recorder starts at 06/08/23 21:37:03 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/08/23 21:37:03 ###########


########## Tcl recorder starts at 06/08/23 21:40:15 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i labx.bl5 -o labx.sif"] {
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
	puts $rspFile "-nodal -src labx.bl5 -type BLIF -presrc labx.bl3 -crf labx.crf -sif labx.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci labx.lct
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

########## Tcl recorder end at 06/08/23 21:40:15 ###########


########## Tcl recorder starts at 06/08/23 21:44:28 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" compare.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/08/23 21:44:28 ###########


########## Tcl recorder starts at 06/08/23 21:44:31 ##########

# Commands to make the Process: 
# Constraint Editor
if [catch {open COMPARE.cmd w} rspFile] {
	puts stderr "Cannot create response file COMPARE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: COMPARE
WORKING_PATH: \"$proj_dir\"
MODULE: COMPARE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h compare.v
OUTPUT_FILE_NAME: COMPARE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e COMPARE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete COMPARE.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf COMPARE.edi -out COMPARE.bl0 -err automake.err -log COMPARE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" COMPARE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i labx.bl5 -o labx.sif"] {
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
	puts $rspFile "-nodal -src labx.bl5 -type BLIF -presrc labx.bl3 -crf labx.crf -sif labx.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci labx.lct
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

########## Tcl recorder end at 06/08/23 21:44:31 ###########


########## Tcl recorder starts at 06/08/23 21:45:15 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/08/23 21:45:15 ###########


########## Tcl recorder starts at 06/08/23 22:10:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" compare.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/08/23 22:10:16 ###########


########## Tcl recorder starts at 06/08/23 22:24:56 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/08/23 22:24:56 ###########


########## Tcl recorder starts at 06/08/23 22:25:04 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open LED.cmd w} rspFile] {
	puts stderr "Cannot create response file LED.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: LED
WORKING_PATH: \"$proj_dir\"
MODULE: LED
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h led.v
OUTPUT_FILE_NAME: LED
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LED -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED.cmd

########## Tcl recorder end at 06/08/23 22:25:04 ###########


########## Tcl recorder starts at 06/08/23 22:26:24 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/08/23 22:26:24 ###########


########## Tcl recorder starts at 06/08/23 22:26:24 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open LED.cmd w} rspFile] {
	puts stderr "Cannot create response file LED.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: LED
WORKING_PATH: \"$proj_dir\"
MODULE: LED
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h led.v
OUTPUT_FILE_NAME: LED
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LED -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED.cmd

########## Tcl recorder end at 06/08/23 22:26:24 ###########


########## Tcl recorder starts at 06/08/23 22:28:56 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" LED"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/08/23 22:28:56 ###########


########## Tcl recorder starts at 06/08/23 22:29:01 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open LED.cmd w} rspFile] {
	puts stderr "Cannot create response file LED.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: LED
WORKING_PATH: \"$proj_dir\"
MODULE: LED
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h led.v
OUTPUT_FILE_NAME: LED
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LED -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED.cmd

########## Tcl recorder end at 06/08/23 22:29:01 ###########


########## Tcl recorder starts at 06/08/23 22:33:56 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/08/23 22:33:56 ###########


########## Tcl recorder starts at 06/08/23 22:34:10 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open LED.cmd w} rspFile] {
	puts stderr "Cannot create response file LED.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: LED
WORKING_PATH: \"$proj_dir\"
MODULE: LED
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h led.v
OUTPUT_FILE_NAME: LED
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LED -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED.cmd

########## Tcl recorder end at 06/08/23 22:34:10 ###########


########## Tcl recorder starts at 06/08/23 23:24:39 ##########

# Commands to make the Process: 
# Compile Schematic
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup top.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bls\" -o \"top.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/08/23 23:24:39 ###########


########## Tcl recorder starts at 06/08/23 23:25:14 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/08/23 23:25:14 ###########


########## Tcl recorder starts at 06/08/23 23:25:35 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup top.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bls\" -o \"top.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i top.bl0 -o top.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open DESHAKE.cmd w} rspFile] {
	puts stderr "Cannot create response file DESHAKE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: DESHAKE
WORKING_PATH: \"$proj_dir\"
MODULE: DESHAKE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h deshake.v
OUTPUT_FILE_NAME: DESHAKE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DESHAKE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DESHAKE.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DESHAKE.edi -out DESHAKE.bl0 -err automake.err -log DESHAKE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DESHAKE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open COMPARE.cmd w} rspFile] {
	puts stderr "Cannot create response file COMPARE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: COMPARE
WORKING_PATH: \"$proj_dir\"
MODULE: COMPARE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h compare.v
OUTPUT_FILE_NAME: COMPARE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e COMPARE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete COMPARE.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf COMPARE.edi -out COMPARE.bl0 -err automake.err -log COMPARE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" COMPARE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open LED.cmd w} rspFile] {
	puts stderr "Cannot create response file LED.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: LED
WORKING_PATH: \"$proj_dir\"
MODULE: LED
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h led.v
OUTPUT_FILE_NAME: LED
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LED -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf LED.edi -out LED.bl0 -err automake.err -log LED.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" LED.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open DISPLAY.cmd w} rspFile] {
	puts stderr "Cannot create response file DISPLAY.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: DISPLAY
WORKING_PATH: \"$proj_dir\"
MODULE: DISPLAY
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h display.v
OUTPUT_FILE_NAME: DISPLAY
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DISPLAY -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DISPLAY.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DISPLAY.edi -out DISPLAY.bl0 -err automake.err -log DISPLAY.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DISPLAY.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open CALCULATE.cmd w} rspFile] {
	puts stderr "Cannot create response file CALCULATE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: CALCULATE
WORKING_PATH: \"$proj_dir\"
MODULE: CALCULATE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h calculate.v
OUTPUT_FILE_NAME: CALCULATE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e CALCULATE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete CALCULATE.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf CALCULATE.edi -out CALCULATE.bl0 -err automake.err -log CALCULATE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" CALCULATE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/08/23 23:25:35 ###########


########## Tcl recorder starts at 06/08/23 23:42:09 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/08/23 23:42:09 ###########


########## Tcl recorder starts at 06/08/23 23:42:12 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open LED.cmd w} rspFile] {
	puts stderr "Cannot create response file LED.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: LED
WORKING_PATH: \"$proj_dir\"
MODULE: LED
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h led.v
OUTPUT_FILE_NAME: LED
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LED -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED.cmd

########## Tcl recorder end at 06/08/23 23:42:12 ###########


########## Tcl recorder starts at 06/08/23 23:44:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/08/23 23:44:41 ###########


########## Tcl recorder starts at 06/08/23 23:44:42 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open LED.cmd w} rspFile] {
	puts stderr "Cannot create response file LED.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: LED
WORKING_PATH: \"$proj_dir\"
MODULE: LED
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h led.v
OUTPUT_FILE_NAME: LED
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LED -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED.cmd

########## Tcl recorder end at 06/08/23 23:44:42 ###########


########## Tcl recorder starts at 06/08/23 23:56:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/08/23 23:56:29 ###########


########## Tcl recorder starts at 06/08/23 23:56:33 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open LED.cmd w} rspFile] {
	puts stderr "Cannot create response file LED.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: LED
WORKING_PATH: \"$proj_dir\"
MODULE: LED
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h led.v
OUTPUT_FILE_NAME: LED
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LED -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED.cmd

########## Tcl recorder end at 06/08/23 23:56:33 ###########


########## Tcl recorder starts at 06/08/23 23:58:10 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/08/23 23:58:10 ###########


########## Tcl recorder starts at 06/08/23 23:58:15 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open LED.cmd w} rspFile] {
	puts stderr "Cannot create response file LED.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: LED
WORKING_PATH: \"$proj_dir\"
MODULE: LED
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h led.v
OUTPUT_FILE_NAME: LED
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LED -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED.cmd

########## Tcl recorder end at 06/08/23 23:58:15 ###########


########## Tcl recorder starts at 06/08/23 23:58:50 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" LED"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/08/23 23:58:50 ###########


########## Tcl recorder starts at 06/08/23 23:59:03 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/edif2blf\" -edf LED.edi -out LED.bl0 -err automake.err -log LED.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" LED.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open DISPLAY.cmd w} rspFile] {
	puts stderr "Cannot create response file DISPLAY.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: DISPLAY
WORKING_PATH: \"$proj_dir\"
MODULE: DISPLAY
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h display.v
OUTPUT_FILE_NAME: DISPLAY
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DISPLAY -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DISPLAY.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DISPLAY.edi -out DISPLAY.bl0 -err automake.err -log DISPLAY.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DISPLAY.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open CALCULATE.cmd w} rspFile] {
	puts stderr "Cannot create response file CALCULATE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: CALCULATE
WORKING_PATH: \"$proj_dir\"
MODULE: CALCULATE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h calculate.v
OUTPUT_FILE_NAME: CALCULATE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e CALCULATE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete CALCULATE.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf CALCULATE.edi -out CALCULATE.bl0 -err automake.err -log CALCULATE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" CALCULATE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/08/23 23:59:03 ###########


########## Tcl recorder starts at 06/09/23 00:03:01 ##########

# Commands to make the Process: 
# Optimization Constraint
# - none -
# Application to view the Process: 
# Optimization Constraint
if [catch {open opt_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file opt_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-global -lci labx.lct -touch labx.imp
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/optedit\" @opt_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 00:03:01 ###########


########## Tcl recorder starts at 06/09/23 00:03:36 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 00:03:36 ###########


########## Tcl recorder starts at 06/09/23 00:04:52 ##########

# Commands to make the Process: 
# Optimization Constraint
# - none -
# Application to view the Process: 
# Optimization Constraint
if [catch {open opt_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file opt_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-global -lci labx.lct -touch labx.imp
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/optedit\" @opt_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 00:04:52 ###########


########## Tcl recorder starts at 06/09/23 00:05:02 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 00:05:03 ###########


########## Tcl recorder starts at 06/09/23 08:13:20 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 08:13:20 ###########


########## Tcl recorder starts at 06/09/23 08:18:42 ##########

# Commands to make the Process: 
# Fitter Report (HTML)
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 08:18:42 ###########


########## Tcl recorder starts at 06/09/23 08:21:59 ##########

# Commands to make the Process: 
# Optimization Constraint
# - none -
# Application to view the Process: 
# Optimization Constraint
if [catch {open opt_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file opt_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-global -lci labx.lct -touch labx.imp
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/optedit\" @opt_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 08:21:59 ###########


########## Tcl recorder starts at 06/09/23 08:22:30 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 08:22:30 ###########


########## Tcl recorder starts at 06/09/23 08:23:03 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i labx.bl5 -o labx.sif"] {
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
	puts $rspFile "-nodal -src labx.bl5 -type BLIF -presrc labx.bl3 -crf labx.crf -sif labx.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci labx.lct
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

########## Tcl recorder end at 06/09/23 08:23:03 ###########


########## Tcl recorder starts at 06/09/23 08:23:08 ##########

# Commands to make the Process: 
# Optimization Constraint
# - none -
# Application to view the Process: 
# Optimization Constraint
if [catch {open opt_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file opt_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-global -lci labx.lct -touch labx.imp
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/optedit\" @opt_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 08:23:08 ###########


########## Tcl recorder starts at 06/09/23 08:23:47 ##########

# Commands to make the Process: 
# Pre-Fit Equations
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blif2eqn\" labx.bl5 -o labx.eq2 -use_short -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 08:23:47 ###########


########## Tcl recorder starts at 06/09/23 08:24:05 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 08:24:05 ###########


########## Tcl recorder starts at 06/09/23 08:27:41 ##########

# Commands to make the Process: 
# Optimization Constraint
# - none -
# Application to view the Process: 
# Optimization Constraint
if [catch {open opt_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file opt_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-global -lci labx.lct -touch labx.imp
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/optedit\" @opt_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 08:27:41 ###########


########## Tcl recorder starts at 06/09/23 08:28:49 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup top.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bls\" -o \"top.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i top.bl0 -o top.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open DESHAKE.cmd w} rspFile] {
	puts stderr "Cannot create response file DESHAKE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: DESHAKE
WORKING_PATH: \"$proj_dir\"
MODULE: DESHAKE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h deshake.v
OUTPUT_FILE_NAME: DESHAKE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DESHAKE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DESHAKE.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DESHAKE.edi -out DESHAKE.bl0 -err automake.err -log DESHAKE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DESHAKE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open COMPARE.cmd w} rspFile] {
	puts stderr "Cannot create response file COMPARE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: COMPARE
WORKING_PATH: \"$proj_dir\"
MODULE: COMPARE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h compare.v
OUTPUT_FILE_NAME: COMPARE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e COMPARE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete COMPARE.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf COMPARE.edi -out COMPARE.bl0 -err automake.err -log COMPARE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" COMPARE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open LED.cmd w} rspFile] {
	puts stderr "Cannot create response file LED.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: LED
WORKING_PATH: \"$proj_dir\"
MODULE: LED
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h led.v
OUTPUT_FILE_NAME: LED
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LED -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf LED.edi -out LED.bl0 -err automake.err -log LED.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" LED.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open DISPLAY.cmd w} rspFile] {
	puts stderr "Cannot create response file DISPLAY.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: DISPLAY
WORKING_PATH: \"$proj_dir\"
MODULE: DISPLAY
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h display.v
OUTPUT_FILE_NAME: DISPLAY
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DISPLAY -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DISPLAY.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DISPLAY.edi -out DISPLAY.bl0 -err automake.err -log DISPLAY.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DISPLAY.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open CALCULATE.cmd w} rspFile] {
	puts stderr "Cannot create response file CALCULATE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: CALCULATE
WORKING_PATH: \"$proj_dir\"
MODULE: CALCULATE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h calculate.v
OUTPUT_FILE_NAME: CALCULATE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e CALCULATE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete CALCULATE.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf CALCULATE.edi -out CALCULATE.bl0 -err automake.err -log CALCULATE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" CALCULATE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 08:28:49 ###########


########## Tcl recorder starts at 06/09/23 08:32:02 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" display.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" compare.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" deshake.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 08:32:02 ###########


########## Tcl recorder starts at 06/09/23 08:32:06 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup top.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bls\" -o \"top.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i top.bl0 -o top.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open DESHAKE_lse.env w} rspFile] {
	puts stderr "Cannot create response file DESHAKE_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open DESHAKE.synproj w} rspFile] {
	puts stderr "Cannot create response file DESHAKE.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top DESHAKE
-lib \"work\" -ver labx.h deshake.v
-output_edif DESHAKE.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"DESHAKE.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DESHAKE_lse.env
file delete DESHAKE.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf DESHAKE.edi -out DESHAKE.bl0 -err automake.err -log DESHAKE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DESHAKE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open COMPARE_lse.env w} rspFile] {
	puts stderr "Cannot create response file COMPARE_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open COMPARE.synproj w} rspFile] {
	puts stderr "Cannot create response file COMPARE.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top COMPARE
-lib \"work\" -ver labx.h compare.v
-output_edif COMPARE.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"COMPARE.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete COMPARE_lse.env
file delete COMPARE.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf COMPARE.edi -out COMPARE.bl0 -err automake.err -log COMPARE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" COMPARE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open LED_lse.env w} rspFile] {
	puts stderr "Cannot create response file LED_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open LED.synproj w} rspFile] {
	puts stderr "Cannot create response file LED.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top LED
-lib \"work\" -ver labx.h led.v
-output_edif LED.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"LED.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED_lse.env
file delete LED.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf LED.edi -out LED.bl0 -err automake.err -log LED.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" LED.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open DISPLAY_lse.env w} rspFile] {
	puts stderr "Cannot create response file DISPLAY_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open DISPLAY.synproj w} rspFile] {
	puts stderr "Cannot create response file DISPLAY.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top DISPLAY
-lib \"work\" -ver labx.h display.v
-output_edif DISPLAY.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"DISPLAY.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DISPLAY_lse.env
file delete DISPLAY.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf DISPLAY.edi -out DISPLAY.bl0 -err automake.err -log DISPLAY.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DISPLAY.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open CALCULATE_lse.env w} rspFile] {
	puts stderr "Cannot create response file CALCULATE_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open CALCULATE.synproj w} rspFile] {
	puts stderr "Cannot create response file CALCULATE.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top CALCULATE
-lib \"work\" -ver labx.h calculate.v
-output_edif CALCULATE.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"CALCULATE.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete CALCULATE_lse.env
file delete CALCULATE.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf CALCULATE.edi -out CALCULATE.bl0 -err automake.err -log CALCULATE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" CALCULATE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 08:32:06 ###########


########## Tcl recorder starts at 06/09/23 08:33:02 ##########

# Commands to make the Process: 
# Optimization Constraint
# - none -
# Application to view the Process: 
# Optimization Constraint
if [catch {open opt_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file opt_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-global -lci labx.lct -touch labx.imp
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/optedit\" @opt_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 08:33:02 ###########


########## Tcl recorder starts at 06/09/23 08:33:36 ##########

# Commands to make the Process: 
# Optimization Constraint
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup top.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bls\" -o \"top.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i top.bl0 -o top.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open DESHAKE_lse.env w} rspFile] {
	puts stderr "Cannot create response file DESHAKE_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open DESHAKE.synproj w} rspFile] {
	puts stderr "Cannot create response file DESHAKE.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top DESHAKE
-lib \"work\" -ver labx.h deshake.v
-output_edif DESHAKE.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"DESHAKE.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DESHAKE_lse.env
file delete DESHAKE.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf DESHAKE.edi -out DESHAKE.bl0 -err automake.err -log DESHAKE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DESHAKE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open COMPARE_lse.env w} rspFile] {
	puts stderr "Cannot create response file COMPARE_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open COMPARE.synproj w} rspFile] {
	puts stderr "Cannot create response file COMPARE.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top COMPARE
-lib \"work\" -ver labx.h compare.v
-output_edif COMPARE.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"COMPARE.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete COMPARE_lse.env
file delete COMPARE.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf COMPARE.edi -out COMPARE.bl0 -err automake.err -log COMPARE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" COMPARE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open LED_lse.env w} rspFile] {
	puts stderr "Cannot create response file LED_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open LED.synproj w} rspFile] {
	puts stderr "Cannot create response file LED.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top LED
-lib \"work\" -ver labx.h led.v
-output_edif LED.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"LED.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED_lse.env
file delete LED.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf LED.edi -out LED.bl0 -err automake.err -log LED.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" LED.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open DISPLAY_lse.env w} rspFile] {
	puts stderr "Cannot create response file DISPLAY_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open DISPLAY.synproj w} rspFile] {
	puts stderr "Cannot create response file DISPLAY.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top DISPLAY
-lib \"work\" -ver labx.h display.v
-output_edif DISPLAY.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"DISPLAY.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DISPLAY_lse.env
file delete DISPLAY.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf DISPLAY.edi -out DISPLAY.bl0 -err automake.err -log DISPLAY.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DISPLAY.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open CALCULATE_lse.env w} rspFile] {
	puts stderr "Cannot create response file CALCULATE_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open CALCULATE.synproj w} rspFile] {
	puts stderr "Cannot create response file CALCULATE.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top CALCULATE
-lib \"work\" -ver labx.h calculate.v
-output_edif CALCULATE.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"CALCULATE.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete CALCULATE_lse.env
file delete CALCULATE.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf CALCULATE.edi -out CALCULATE.bl0 -err automake.err -log CALCULATE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" CALCULATE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Optimization Constraint
if [catch {open opt_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file opt_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-global -lci labx.lct -touch labx.imp
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/optedit\" @opt_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 08:33:36 ###########


########## Tcl recorder starts at 06/09/23 08:34:02 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 08:34:02 ###########


########## Tcl recorder starts at 06/09/23 08:41:27 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 08:41:27 ###########


########## Tcl recorder starts at 06/09/23 08:43:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 08:43:07 ###########


########## Tcl recorder starts at 06/09/23 08:43:15 ##########

# Commands to make the Process: 
# Lattice Synthesize Verilog File
if [catch {open LED_lse.env w} rspFile] {
	puts stderr "Cannot create response file LED_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open LED.synproj w} rspFile] {
	puts stderr "Cannot create response file LED.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top LED
-lib \"work\" -ver labx.h led.v
-output_edif LED.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"LED.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED_lse.env
file delete LED.synproj

########## Tcl recorder end at 06/09/23 08:43:15 ###########


########## Tcl recorder starts at 06/09/23 08:43:29 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" LED"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 08:43:29 ###########


########## Tcl recorder starts at 06/09/23 08:44:10 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 08:44:11 ###########


########## Tcl recorder starts at 06/09/23 08:44:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 08:44:20 ###########


########## Tcl recorder starts at 06/09/23 08:44:25 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup top.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bls\" -o \"top.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i top.bl0 -o top.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/edif2blf\" -edf LED.edi -out LED.bl0 -err automake.err -log LED.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" LED.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 08:44:25 ###########


########## Tcl recorder starts at 06/09/23 08:46:09 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 08:46:09 ###########


########## Tcl recorder starts at 06/09/23 08:46:12 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open LED_lse.env w} rspFile] {
	puts stderr "Cannot create response file LED_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open LED.synproj w} rspFile] {
	puts stderr "Cannot create response file LED.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top LED
-lib \"work\" -ver labx.h led.v
-output_edif LED.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"LED.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED_lse.env
file delete LED.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf LED.edi -out LED.bl0 -err automake.err -log LED.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" LED.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 08:46:12 ###########


########## Tcl recorder starts at 06/09/23 08:53:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" compare.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 08:53:29 ###########


########## Tcl recorder starts at 06/09/23 08:53:36 ##########

# Commands to make the Process: 
# Lattice Synthesize Verilog File
if [catch {open COMPARE_lse.env w} rspFile] {
	puts stderr "Cannot create response file COMPARE_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open COMPARE.synproj w} rspFile] {
	puts stderr "Cannot create response file COMPARE.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top COMPARE
-lib \"work\" -ver labx.h compare.v
-output_edif COMPARE.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"COMPARE.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete COMPARE_lse.env
file delete COMPARE.synproj

########## Tcl recorder end at 06/09/23 08:53:36 ###########


########## Tcl recorder starts at 06/09/23 08:54:25 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" compare.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 08:54:25 ###########


########## Tcl recorder starts at 06/09/23 08:54:33 ##########

# Commands to make the Process: 
# Lattice Synthesize Verilog File
if [catch {open COMPARE_lse.env w} rspFile] {
	puts stderr "Cannot create response file COMPARE_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open COMPARE.synproj w} rspFile] {
	puts stderr "Cannot create response file COMPARE.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top COMPARE
-lib \"work\" -ver labx.h compare.v
-output_edif COMPARE.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"COMPARE.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete COMPARE_lse.env
file delete COMPARE.synproj

########## Tcl recorder end at 06/09/23 08:54:33 ###########


########## Tcl recorder starts at 06/09/23 08:54:37 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" COMPARE"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 08:54:37 ###########


########## Tcl recorder starts at 06/09/23 08:54:45 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 08:54:45 ###########


########## Tcl recorder starts at 06/09/23 08:55:39 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 08:55:39 ###########


########## Tcl recorder starts at 06/09/23 09:01:54 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:01:54 ###########


########## Tcl recorder starts at 06/09/23 09:02:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:02:35 ###########


########## Tcl recorder starts at 06/09/23 09:02:40 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:02:40 ###########


########## Tcl recorder starts at 06/09/23 09:02:56 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" compare.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:02:56 ###########


########## Tcl recorder starts at 06/09/23 09:03:04 ##########

# Commands to make the Process: 
# Lattice Synthesize Verilog File
if [catch {open LED_lse.env w} rspFile] {
	puts stderr "Cannot create response file LED_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open LED.synproj w} rspFile] {
	puts stderr "Cannot create response file LED.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top LED
-lib \"work\" -ver labx.h led.v
-output_edif LED.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"LED.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED_lse.env
file delete LED.synproj

########## Tcl recorder end at 06/09/23 09:03:04 ###########


########## Tcl recorder starts at 06/09/23 09:03:09 ##########

# Commands to make the Process: 
# Lattice Synthesize Verilog File
if [catch {open COMPARE_lse.env w} rspFile] {
	puts stderr "Cannot create response file COMPARE_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open COMPARE.synproj w} rspFile] {
	puts stderr "Cannot create response file COMPARE.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top COMPARE
-lib \"work\" -ver labx.h compare.v
-output_edif COMPARE.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"COMPARE.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete COMPARE_lse.env
file delete COMPARE.synproj

########## Tcl recorder end at 06/09/23 09:03:09 ###########


########## Tcl recorder starts at 06/09/23 09:03:14 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup top.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bls\" -o \"top.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i top.bl0 -o top.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/edif2blf\" -edf COMPARE.edi -out COMPARE.bl0 -err automake.err -log COMPARE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" COMPARE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/edif2blf\" -edf LED.edi -out LED.bl0 -err automake.err -log LED.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" LED.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:03:14 ###########


########## Tcl recorder starts at 06/09/23 09:03:46 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" compare.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:03:46 ###########


########## Tcl recorder starts at 06/09/23 09:04:00 ##########

# Commands to make the Process: 
# Lattice Synthesize Verilog File
if [catch {open COMPARE_lse.env w} rspFile] {
	puts stderr "Cannot create response file COMPARE_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open COMPARE.synproj w} rspFile] {
	puts stderr "Cannot create response file COMPARE.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top COMPARE
-lib \"work\" -ver labx.h compare.v
-output_edif COMPARE.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"COMPARE.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete COMPARE_lse.env
file delete COMPARE.synproj

########## Tcl recorder end at 06/09/23 09:04:00 ###########


########## Tcl recorder starts at 06/09/23 09:04:08 ##########

# Commands to make the Process: 
# Lattice Synthesize Verilog File
if [catch {open COMPARE_lse.env w} rspFile] {
	puts stderr "Cannot create response file COMPARE_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open COMPARE.synproj w} rspFile] {
	puts stderr "Cannot create response file COMPARE.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top COMPARE
-lib \"work\" -ver labx.h compare.v
-output_edif COMPARE.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"COMPARE.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete COMPARE_lse.env
file delete COMPARE.synproj

########## Tcl recorder end at 06/09/23 09:04:08 ###########


########## Tcl recorder starts at 06/09/23 09:04:12 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/vlog2jhd\" compare.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/naf2sym\" COMPARE"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:04:12 ###########


########## Tcl recorder starts at 06/09/23 09:04:17 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/naf2sym\" LED"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:04:17 ###########


########## Tcl recorder starts at 06/09/23 09:04:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:04:20 ###########


########## Tcl recorder starts at 06/09/23 09:04:55 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:04:55 ###########


########## Tcl recorder starts at 06/09/23 09:05:08 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:05:08 ###########


########## Tcl recorder starts at 06/09/23 09:05:14 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup top.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bls\" -o \"top.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i top.bl0 -o top.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open DESHAKE_lse.env w} rspFile] {
	puts stderr "Cannot create response file DESHAKE_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open DESHAKE.synproj w} rspFile] {
	puts stderr "Cannot create response file DESHAKE.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top DESHAKE
-lib \"work\" -ver labx.h deshake.v
-output_edif DESHAKE.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"DESHAKE.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DESHAKE_lse.env
file delete DESHAKE.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf DESHAKE.edi -out DESHAKE.bl0 -err automake.err -log DESHAKE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DESHAKE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/edif2blf\" -edf COMPARE.edi -out COMPARE.bl0 -err automake.err -log COMPARE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" COMPARE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open LED_lse.env w} rspFile] {
	puts stderr "Cannot create response file LED_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open LED.synproj w} rspFile] {
	puts stderr "Cannot create response file LED.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top LED
-lib \"work\" -ver labx.h led.v
-output_edif LED.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"LED.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED_lse.env
file delete LED.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf LED.edi -out LED.bl0 -err automake.err -log LED.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" LED.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open DISPLAY_lse.env w} rspFile] {
	puts stderr "Cannot create response file DISPLAY_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open DISPLAY.synproj w} rspFile] {
	puts stderr "Cannot create response file DISPLAY.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top DISPLAY
-lib \"work\" -ver labx.h display.v
-output_edif DISPLAY.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"DISPLAY.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DISPLAY_lse.env
file delete DISPLAY.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf DISPLAY.edi -out DISPLAY.bl0 -err automake.err -log DISPLAY.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DISPLAY.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open CALCULATE_lse.env w} rspFile] {
	puts stderr "Cannot create response file CALCULATE_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open CALCULATE.synproj w} rspFile] {
	puts stderr "Cannot create response file CALCULATE.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top CALCULATE
-lib \"work\" -ver labx.h calculate.v
-output_edif CALCULATE.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"CALCULATE.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete CALCULATE_lse.env
file delete CALCULATE.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf CALCULATE.edi -out CALCULATE.bl0 -err automake.err -log CALCULATE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" CALCULATE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:05:14 ###########


########## Tcl recorder starts at 06/09/23 09:05:51 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i labx.bl5 -o labx.sif"] {
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
	puts $rspFile "-nodal -src labx.bl5 -type BLIF -presrc labx.bl3 -crf labx.crf -sif labx.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci labx.lct
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

########## Tcl recorder end at 06/09/23 09:05:51 ###########


########## Tcl recorder starts at 06/09/23 09:08:49 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:08:50 ###########


########## Tcl recorder starts at 06/09/23 09:10:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:10:35 ###########


########## Tcl recorder starts at 06/09/23 09:11:26 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:11:26 ###########


########## Tcl recorder starts at 06/09/23 09:11:30 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" CALCULATE"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:11:30 ###########


########## Tcl recorder starts at 06/09/23 09:11:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:11:36 ###########


########## Tcl recorder starts at 06/09/23 09:11:52 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:11:52 ###########


########## Tcl recorder starts at 06/09/23 09:11:58 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup top.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bls\" -o \"top.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i top.bl0 -o top.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open CALCULATE_lse.env w} rspFile] {
	puts stderr "Cannot create response file CALCULATE_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open CALCULATE.synproj w} rspFile] {
	puts stderr "Cannot create response file CALCULATE.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top CALCULATE
-lib \"work\" -ver labx.h calculate.v
-output_edif CALCULATE.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"CALCULATE.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete CALCULATE_lse.env
file delete CALCULATE.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf CALCULATE.edi -out CALCULATE.bl0 -err automake.err -log CALCULATE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" CALCULATE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:11:58 ###########


########## Tcl recorder starts at 06/09/23 09:14:39 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:14:39 ###########


########## Tcl recorder starts at 06/09/23 09:15:02 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" compare.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:15:02 ###########


########## Tcl recorder starts at 06/09/23 09:15:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" compare.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:15:11 ###########


########## Tcl recorder starts at 06/09/23 09:15:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" compare.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:15:16 ###########


########## Tcl recorder starts at 06/09/23 09:15:19 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" compare.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:15:19 ###########


########## Tcl recorder starts at 06/09/23 09:15:37 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" compare.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:15:37 ###########


########## Tcl recorder starts at 06/09/23 09:15:53 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" compare.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:15:53 ###########


########## Tcl recorder starts at 06/09/23 09:16:56 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup top.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bls\" -o \"top.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i top.bl0 -o top.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open COMPARE_lse.env w} rspFile] {
	puts stderr "Cannot create response file COMPARE_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open COMPARE.synproj w} rspFile] {
	puts stderr "Cannot create response file COMPARE.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top COMPARE
-lib \"work\" -ver labx.h compare.v
-output_edif COMPARE.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"COMPARE.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete COMPARE_lse.env
file delete COMPARE.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf COMPARE.edi -out COMPARE.bl0 -err automake.err -log COMPARE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" COMPARE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:16:56 ###########


########## Tcl recorder starts at 06/09/23 09:17:22 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" compare.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:17:22 ###########


########## Tcl recorder starts at 06/09/23 09:17:27 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open COMPARE_lse.env w} rspFile] {
	puts stderr "Cannot create response file COMPARE_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open COMPARE.synproj w} rspFile] {
	puts stderr "Cannot create response file COMPARE.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top COMPARE
-lib \"work\" -ver labx.h compare.v
-output_edif COMPARE.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"COMPARE.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete COMPARE_lse.env
file delete COMPARE.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf COMPARE.edi -out COMPARE.bl0 -err automake.err -log COMPARE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" COMPARE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:17:27 ###########


########## Tcl recorder starts at 06/09/23 09:53:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:53:47 ###########


########## Tcl recorder starts at 06/09/23 09:53:50 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open LED_lse.env w} rspFile] {
	puts stderr "Cannot create response file LED_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open LED.synproj w} rspFile] {
	puts stderr "Cannot create response file LED.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top LED
-lib \"work\" -ver labx.h led.v
-output_edif LED.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"LED.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED_lse.env
file delete LED.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf LED.edi -out LED.bl0 -err automake.err -log LED.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" LED.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:53:50 ###########


########## Tcl recorder starts at 06/09/23 09:55:27 ##########

# Commands to make the Process: 
# Optimization Constraint
# - none -
# Application to view the Process: 
# Optimization Constraint
if [catch {open opt_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file opt_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-global -lci labx.lct -touch labx.imp
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/optedit\" @opt_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:55:27 ###########


########## Tcl recorder starts at 06/09/23 09:55:34 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:55:34 ###########


########## Tcl recorder starts at 06/09/23 09:57:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:57:41 ###########


########## Tcl recorder starts at 06/09/23 09:57:45 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open LED_lse.env w} rspFile] {
	puts stderr "Cannot create response file LED_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open LED.synproj w} rspFile] {
	puts stderr "Cannot create response file LED.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top LED
-lib \"work\" -ver labx.h led.v
-output_edif LED.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"LED.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED_lse.env
file delete LED.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf LED.edi -out LED.bl0 -err automake.err -log LED.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" LED.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:57:45 ###########


########## Tcl recorder starts at 06/09/23 09:59:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:59:20 ###########


########## Tcl recorder starts at 06/09/23 09:59:26 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open LED_lse.env w} rspFile] {
	puts stderr "Cannot create response file LED_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open LED.synproj w} rspFile] {
	puts stderr "Cannot create response file LED.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top LED
-lib \"work\" -ver labx.h led.v
-output_edif LED.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"LED.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED_lse.env
file delete LED.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf LED.edi -out LED.bl0 -err automake.err -log LED.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" LED.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:59:26 ###########


########## Tcl recorder starts at 06/09/23 09:59:59 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup top.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bls\" -o \"top.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i top.bl0 -o top.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open DESHAKE_lse.env w} rspFile] {
	puts stderr "Cannot create response file DESHAKE_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open DESHAKE.synproj w} rspFile] {
	puts stderr "Cannot create response file DESHAKE.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top DESHAKE
-lib \"work\" -ver labx.h deshake.v
-output_edif DESHAKE.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"DESHAKE.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DESHAKE_lse.env
file delete DESHAKE.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf DESHAKE.edi -out DESHAKE.bl0 -err automake.err -log DESHAKE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DESHAKE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open COMPARE_lse.env w} rspFile] {
	puts stderr "Cannot create response file COMPARE_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open COMPARE.synproj w} rspFile] {
	puts stderr "Cannot create response file COMPARE.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top COMPARE
-lib \"work\" -ver labx.h compare.v
-output_edif COMPARE.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"COMPARE.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete COMPARE_lse.env
file delete COMPARE.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf COMPARE.edi -out COMPARE.bl0 -err automake.err -log COMPARE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" COMPARE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open LED_lse.env w} rspFile] {
	puts stderr "Cannot create response file LED_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open LED.synproj w} rspFile] {
	puts stderr "Cannot create response file LED.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top LED
-lib \"work\" -ver labx.h led.v
-output_edif LED.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"LED.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED_lse.env
file delete LED.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf LED.edi -out LED.bl0 -err automake.err -log LED.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" LED.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open DISPLAY_lse.env w} rspFile] {
	puts stderr "Cannot create response file DISPLAY_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open DISPLAY.synproj w} rspFile] {
	puts stderr "Cannot create response file DISPLAY.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top DISPLAY
-lib \"work\" -ver labx.h display.v
-output_edif DISPLAY.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"DISPLAY.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DISPLAY_lse.env
file delete DISPLAY.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf DISPLAY.edi -out DISPLAY.bl0 -err automake.err -log DISPLAY.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DISPLAY.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open CALCULATE_lse.env w} rspFile] {
	puts stderr "Cannot create response file CALCULATE_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open CALCULATE.synproj w} rspFile] {
	puts stderr "Cannot create response file CALCULATE.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top CALCULATE
-lib \"work\" -ver labx.h calculate.v
-output_edif CALCULATE.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"CALCULATE.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete CALCULATE_lse.env
file delete CALCULATE.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf CALCULATE.edi -out CALCULATE.bl0 -err automake.err -log CALCULATE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" CALCULATE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 09:59:59 ###########


########## Tcl recorder starts at 06/09/23 10:03:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:03:41 ###########


########## Tcl recorder starts at 06/09/23 10:03:46 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open LED_lse.env w} rspFile] {
	puts stderr "Cannot create response file LED_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open LED.synproj w} rspFile] {
	puts stderr "Cannot create response file LED.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top LED
-lib \"work\" -ver labx.h led.v
-output_edif LED.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"LED.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED_lse.env
file delete LED.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf LED.edi -out LED.bl0 -err automake.err -log LED.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" LED.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:03:46 ###########


########## Tcl recorder starts at 06/09/23 10:06:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:06:07 ###########


########## Tcl recorder starts at 06/09/23 10:06:11 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open LED_lse.env w} rspFile] {
	puts stderr "Cannot create response file LED_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open LED.synproj w} rspFile] {
	puts stderr "Cannot create response file LED.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top LED
-lib \"work\" -ver labx.h led.v
-output_edif LED.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"LED.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED_lse.env
file delete LED.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf LED.edi -out LED.bl0 -err automake.err -log LED.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" LED.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:06:11 ###########


########## Tcl recorder starts at 06/09/23 10:08:05 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:08:05 ###########


########## Tcl recorder starts at 06/09/23 10:09:32 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" compare.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:09:32 ###########


########## Tcl recorder starts at 06/09/23 10:09:38 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup top.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bls\" -o \"top.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i top.bl0 -o top.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open COMPARE_lse.env w} rspFile] {
	puts stderr "Cannot create response file COMPARE_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open COMPARE.synproj w} rspFile] {
	puts stderr "Cannot create response file COMPARE.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top COMPARE
-lib \"work\" -ver labx.h compare.v
-output_edif COMPARE.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"COMPARE.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete COMPARE_lse.env
file delete COMPARE.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf COMPARE.edi -out COMPARE.bl0 -err automake.err -log COMPARE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" COMPARE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:09:38 ###########


########## Tcl recorder starts at 06/09/23 10:09:43 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup top.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bls\" -o \"top.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i top.bl0 -o top.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open COMPARE_lse.env w} rspFile] {
	puts stderr "Cannot create response file COMPARE_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open COMPARE.synproj w} rspFile] {
	puts stderr "Cannot create response file COMPARE.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top COMPARE
-lib \"work\" -ver labx.h compare.v
-output_edif COMPARE.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"COMPARE.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete COMPARE_lse.env
file delete COMPARE.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf COMPARE.edi -out COMPARE.bl0 -err automake.err -log COMPARE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" COMPARE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i labx.bl5 -o labx.sif"] {
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
	puts $rspFile "-nodal -src labx.bl5 -type BLIF -presrc labx.bl3 -crf labx.crf -sif labx.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci labx.lct
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

########## Tcl recorder end at 06/09/23 10:09:43 ###########


########## Tcl recorder starts at 06/09/23 10:09:57 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" COMPARE"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:09:57 ###########


########## Tcl recorder starts at 06/09/23 10:10:15 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:10:15 ###########


########## Tcl recorder starts at 06/09/23 10:10:19 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup top.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bls\" -o \"top.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i top.bl0 -o top.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open COMPARE_lse.env w} rspFile] {
	puts stderr "Cannot create response file COMPARE_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open COMPARE.synproj w} rspFile] {
	puts stderr "Cannot create response file COMPARE.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top COMPARE
-lib \"work\" -ver labx.h compare.v
-output_edif COMPARE.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"COMPARE.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete COMPARE_lse.env
file delete COMPARE.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf COMPARE.edi -out COMPARE.bl0 -err automake.err -log COMPARE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" COMPARE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:10:19 ###########


########## Tcl recorder starts at 06/09/23 10:10:48 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" compare.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:10:48 ###########


########## Tcl recorder starts at 06/09/23 10:10:54 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open COMPARE_lse.env w} rspFile] {
	puts stderr "Cannot create response file COMPARE_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open COMPARE.synproj w} rspFile] {
	puts stderr "Cannot create response file COMPARE.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top COMPARE
-lib \"work\" -ver labx.h compare.v
-output_edif COMPARE.edi
-optimization_goal Area
-frequency  200
-fsm_encoding_style Auto
-use_io_insertion 1
-resource_sharing 1
-propagate_constants 1
-remove_duplicate_regs 1
-twr_paths  3
-resolve_mixed_drivers 0
"
	close $rspFile
}
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"COMPARE.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete COMPARE_lse.env
file delete COMPARE.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf COMPARE.edi -out COMPARE.bl0 -err automake.err -log COMPARE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" COMPARE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:10:54 ###########


########## Tcl recorder starts at 06/09/23 10:11:44 ##########

# Commands to make the Process: 
# Fitter Report (HTML)
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:11:44 ###########


########## Tcl recorder starts at 06/09/23 10:12:03 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" display.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" compare.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" deshake.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:12:03 ###########


########## Tcl recorder starts at 06/09/23 10:12:06 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup top.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bls\" -o \"top.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i top.bl0 -o top.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open COMPARE.cmd w} rspFile] {
	puts stderr "Cannot create response file COMPARE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: COMPARE
WORKING_PATH: \"$proj_dir\"
MODULE: COMPARE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h compare.v
OUTPUT_FILE_NAME: COMPARE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e COMPARE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete COMPARE.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf COMPARE.edi -out COMPARE.bl0 -err automake.err -log COMPARE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" COMPARE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open LED.cmd w} rspFile] {
	puts stderr "Cannot create response file LED.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: LED
WORKING_PATH: \"$proj_dir\"
MODULE: LED
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h led.v
OUTPUT_FILE_NAME: LED
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LED -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf LED.edi -out LED.bl0 -err automake.err -log LED.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" LED.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open DISPLAY.cmd w} rspFile] {
	puts stderr "Cannot create response file DISPLAY.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: DISPLAY
WORKING_PATH: \"$proj_dir\"
MODULE: DISPLAY
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h display.v
OUTPUT_FILE_NAME: DISPLAY
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DISPLAY -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DISPLAY.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DISPLAY.edi -out DISPLAY.bl0 -err automake.err -log DISPLAY.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DISPLAY.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open CALCULATE.cmd w} rspFile] {
	puts stderr "Cannot create response file CALCULATE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: CALCULATE
WORKING_PATH: \"$proj_dir\"
MODULE: CALCULATE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h calculate.v
OUTPUT_FILE_NAME: CALCULATE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e CALCULATE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete CALCULATE.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf CALCULATE.edi -out CALCULATE.bl0 -err automake.err -log CALCULATE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" CALCULATE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:12:06 ###########


########## Tcl recorder starts at 06/09/23 10:15:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:15:47 ###########


########## Tcl recorder starts at 06/09/23 10:15:51 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open LED.cmd w} rspFile] {
	puts stderr "Cannot create response file LED.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: LED
WORKING_PATH: \"$proj_dir\"
MODULE: LED
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h led.v
OUTPUT_FILE_NAME: LED
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LED -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf LED.edi -out LED.bl0 -err automake.err -log LED.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" LED.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:15:51 ###########


########## Tcl recorder starts at 06/09/23 10:24:52 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:24:52 ###########


########## Tcl recorder starts at 06/09/23 10:24:56 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open LED.cmd w} rspFile] {
	puts stderr "Cannot create response file LED.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: LED
WORKING_PATH: \"$proj_dir\"
MODULE: LED
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h led.v
OUTPUT_FILE_NAME: LED
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LED -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf LED.edi -out LED.bl0 -err automake.err -log LED.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" LED.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:24:56 ###########


########## Tcl recorder starts at 06/09/23 10:29:03 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" compare.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:29:03 ###########


########## Tcl recorder starts at 06/09/23 10:29:06 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" COMPARE"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:29:06 ###########


########## Tcl recorder starts at 06/09/23 10:29:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:29:12 ###########


########## Tcl recorder starts at 06/09/23 10:30:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:30:07 ###########


########## Tcl recorder starts at 06/09/23 10:30:13 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup top.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bls\" -o \"top.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i top.bl0 -o top.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open DESHAKE.cmd w} rspFile] {
	puts stderr "Cannot create response file DESHAKE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: DESHAKE
WORKING_PATH: \"$proj_dir\"
MODULE: DESHAKE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h deshake.v
OUTPUT_FILE_NAME: DESHAKE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e DESHAKE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete DESHAKE.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf DESHAKE.edi -out DESHAKE.bl0 -err automake.err -log DESHAKE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DESHAKE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open COMPARE.cmd w} rspFile] {
	puts stderr "Cannot create response file COMPARE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: COMPARE
WORKING_PATH: \"$proj_dir\"
MODULE: COMPARE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h compare.v
OUTPUT_FILE_NAME: COMPARE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e COMPARE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete COMPARE.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf COMPARE.edi -out COMPARE.bl0 -err automake.err -log COMPARE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" COMPARE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i labx.bl5 -o labx.sif"] {
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
	puts $rspFile "-nodal -src labx.bl5 -type BLIF -presrc labx.bl3 -crf labx.crf -sif labx.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci labx.lct
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

########## Tcl recorder end at 06/09/23 10:30:13 ###########


########## Tcl recorder starts at 06/09/23 10:32:12 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:32:12 ###########


########## Tcl recorder starts at 06/09/23 10:39:51 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:39:51 ###########


########## Tcl recorder starts at 06/09/23 10:39:58 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" LED"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:39:58 ###########


########## Tcl recorder starts at 06/09/23 10:40:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:40:20 ###########


########## Tcl recorder starts at 06/09/23 10:40:28 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup top.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bls\" -o \"top.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i top.bl0 -o top.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open LED.cmd w} rspFile] {
	puts stderr "Cannot create response file LED.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: LED
WORKING_PATH: \"$proj_dir\"
MODULE: LED
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h led.v
OUTPUT_FILE_NAME: LED
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LED -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf LED.edi -out LED.bl0 -err automake.err -log LED.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" LED.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:40:28 ###########


########## Tcl recorder starts at 06/09/23 10:41:24 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:41:24 ###########


########## Tcl recorder starts at 06/09/23 10:41:27 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open LED.cmd w} rspFile] {
	puts stderr "Cannot create response file LED.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: LED
WORKING_PATH: \"$proj_dir\"
MODULE: LED
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h led.v
OUTPUT_FILE_NAME: LED
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LED -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED.cmd

########## Tcl recorder end at 06/09/23 10:41:27 ###########


########## Tcl recorder starts at 06/09/23 10:41:59 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/edif2blf\" -edf LED.edi -out LED.bl0 -err automake.err -log LED.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" LED.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:42:00 ###########


########## Tcl recorder starts at 06/09/23 10:44:31 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i labx.bl5 -o labx.sif"] {
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
	puts $rspFile "-nodal -src labx.bl5 -type BLIF -presrc labx.bl3 -crf labx.crf -sif labx.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci labx.lct
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

########## Tcl recorder end at 06/09/23 10:44:31 ###########


########## Tcl recorder starts at 06/09/23 10:45:00 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:45:00 ###########


########## Tcl recorder starts at 06/09/23 10:45:06 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open LED.cmd w} rspFile] {
	puts stderr "Cannot create response file LED.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: LED
WORKING_PATH: \"$proj_dir\"
MODULE: LED
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h led.v
OUTPUT_FILE_NAME: LED
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LED -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf LED.edi -out LED.bl0 -err automake.err -log LED.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" LED.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:45:06 ###########


########## Tcl recorder starts at 06/09/23 10:48:06 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:48:06 ###########


########## Tcl recorder starts at 06/09/23 10:48:09 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open LED.cmd w} rspFile] {
	puts stderr "Cannot create response file LED.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: LED
WORKING_PATH: \"$proj_dir\"
MODULE: LED
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h led.v
OUTPUT_FILE_NAME: LED
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LED -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf LED.edi -out LED.bl0 -err automake.err -log LED.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" LED.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:48:09 ###########


########## Tcl recorder starts at 06/09/23 10:49:46 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:49:46 ###########


########## Tcl recorder starts at 06/09/23 10:49:51 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open LED.cmd w} rspFile] {
	puts stderr "Cannot create response file LED.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: LED
WORKING_PATH: \"$proj_dir\"
MODULE: LED
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h led.v
OUTPUT_FILE_NAME: LED
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LED -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf LED.edi -out LED.bl0 -err automake.err -log LED.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" LED.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:49:51 ###########


########## Tcl recorder starts at 06/09/23 10:52:15 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" compare.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:52:15 ###########


########## Tcl recorder starts at 06/09/23 10:52:24 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" compare.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:52:24 ###########


########## Tcl recorder starts at 06/09/23 10:52:40 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open COMPARE.cmd w} rspFile] {
	puts stderr "Cannot create response file COMPARE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: COMPARE
WORKING_PATH: \"$proj_dir\"
MODULE: COMPARE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h compare.v
OUTPUT_FILE_NAME: COMPARE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e COMPARE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete COMPARE.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf COMPARE.edi -out COMPARE.bl0 -err automake.err -log COMPARE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" COMPARE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx.rs1: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -nojed -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx.rs2: $rspFile"
} else {
	puts $rspFile "-i labx.bl5 -lci labx.lct -d m4s_256_96 -lco labx.lco -html_rpt -fti labx.fti -fmt PLA -tto labx.tt4 -eqn labx.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx.rs1
file delete labx.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx.bl5 -o labx.tda -lci labx.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx -if labx.jed -j2s -log labx.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 10:52:40 ###########


########## Tcl recorder starts at 06/09/23 11:01:02 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" compare.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 11:01:02 ###########


########## Tcl recorder starts at 06/09/23 11:03:08 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" led.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 11:03:08 ###########


########## Tcl recorder starts at 06/14/23 14:49:18 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine labx.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/14/23 14:49:18 ###########


########## Tcl recorder starts at 06/14/23 14:49:19 ##########

# Commands to make the Process: 
# Constraint Editor
if [catch {open COMPARE.cmd w} rspFile] {
	puts stderr "Cannot create response file COMPARE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: COMPARE
WORKING_PATH: \"$proj_dir\"
MODULE: COMPARE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h compare.v
OUTPUT_FILE_NAME: COMPARE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e COMPARE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete COMPARE.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf COMPARE.edi -out COMPARE.bl0 -err automake.err -log COMPARE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" COMPARE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open LED.cmd w} rspFile] {
	puts stderr "Cannot create response file LED.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: LED
WORKING_PATH: \"$proj_dir\"
MODULE: LED
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h led.v
OUTPUT_FILE_NAME: LED
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LED -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LED.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf LED.edi -out LED.bl0 -err automake.err -log LED.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" LED.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open CALCULATE.cmd w} rspFile] {
	puts stderr "Cannot create response file CALCULATE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx.sty
PROJECT: CALCULATE
WORKING_PATH: \"$proj_dir\"
MODULE: CALCULATE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx.h calculate.v
OUTPUT_FILE_NAME: CALCULATE
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e CALCULATE -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete CALCULATE.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf CALCULATE.edi -out CALCULATE.bl0 -err automake.err -log CALCULATE.log -prj labx -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" CALCULATE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"labx.bl2\" -omod \"labx\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx -lci labx.lct -log labx.imp -err automake.err -tti labx.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -blifopt labx.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx.bl2 -sweep -mergefb -err automake.err -o labx.bl3 @labx.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -diofft labx.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx.bl3 -family AMDMACH -idev van -o labx.bl4 -oxrf labx.xrf -err automake.err @labx.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx.lct -dev lc4k -prefit labx.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx.bl4 -out labx.bl5 -err automake.err -log labx.log -mod top @labx.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i labx.bl5 -o labx.sif"] {
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
	puts $rspFile "-nodal -src labx.bl5 -type BLIF -presrc labx.bl3 -crf labx.crf -sif labx.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci labx.lct
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

########## Tcl recorder end at 06/14/23 14:49:19 ###########

