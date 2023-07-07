
########## Tcl recorder starts at 05/28/23 23:23:54 ##########

set version "2.1"
set proj_dir "D:/isp/new_lab11"
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
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/28/23 23:23:54 ###########


########## Tcl recorder starts at 05/28/23 23:24:11 ##########

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

########## Tcl recorder end at 05/28/23 23:24:11 ###########


########## Tcl recorder starts at 05/28/23 23:24:32 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/28/23 23:24:32 ###########


########## Tcl recorder starts at 05/28/23 23:24:40 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/28/23 23:24:40 ###########


########## Tcl recorder starts at 05/28/23 23:49:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/28/23 23:49:11 ###########


########## Tcl recorder starts at 05/28/23 23:51:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/28/23 23:51:16 ###########


########## Tcl recorder starts at 05/28/23 23:51:17 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open I2C.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: I2C
WORKING_PATH: \"$proj_dir\"
MODULE: I2C
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h i2c.v
OUTPUT_FILE_NAME: I2C
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e I2C -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete I2C.cmd

########## Tcl recorder end at 05/28/23 23:51:17 ###########


########## Tcl recorder starts at 05/28/23 23:51:49 ##########

# Commands to make the Process: 
# Compile EDIF File
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C.edi -out I2C.bl0 -err automake.err -log I2C.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/28/23 23:51:49 ###########


########## Tcl recorder starts at 05/28/23 23:51:51 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" I2C"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/28/23 23:51:51 ###########


########## Tcl recorder starts at 05/28/23 23:52:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/28/23 23:52:44 ###########


########## Tcl recorder starts at 05/28/23 23:52:47 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" I2C"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/28/23 23:52:47 ###########


########## Tcl recorder starts at 05/28/23 23:55:30 ##########

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

########## Tcl recorder end at 05/28/23 23:55:30 ###########


########## Tcl recorder starts at 05/29/23 00:04:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" display.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 00:04:17 ###########


########## Tcl recorder starts at 05/29/23 00:04:22 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open DISPLAY.cmd w} rspFile] {
	puts stderr "Cannot create response file DISPLAY.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: DISPLAY
WORKING_PATH: \"$proj_dir\"
MODULE: DISPLAY
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h display.v
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

########## Tcl recorder end at 05/29/23 00:04:22 ###########


########## Tcl recorder starts at 05/29/23 00:05:54 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 00:05:54 ###########


########## Tcl recorder starts at 05/29/23 00:14:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 00:14:07 ###########


########## Tcl recorder starts at 05/29/23 00:14:07 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open CALCULATE.cmd w} rspFile] {
	puts stderr "Cannot create response file CALCULATE.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: CALCULATE
WORKING_PATH: \"$proj_dir\"
MODULE: CALCULATE
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h calculate.v
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

########## Tcl recorder end at 05/29/23 00:14:07 ###########


########## Tcl recorder starts at 05/29/23 00:14:42 ##########

# Commands to make the Process: 
# Compile EDIF File
if [runCmd "\"$cpld_bin/edif2blf\" -edf CALCULATE.edi -out CALCULATE.bl0 -err automake.err -log CALCULATE.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 00:14:42 ###########


########## Tcl recorder starts at 05/29/23 00:14:45 ##########

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

########## Tcl recorder end at 05/29/23 00:14:45 ###########


########## Tcl recorder starts at 05/29/23 00:14:48 ##########

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

########## Tcl recorder end at 05/29/23 00:14:48 ###########


########## Tcl recorder starts at 05/29/23 00:16:41 ##########

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

########## Tcl recorder end at 05/29/23 00:16:41 ###########


########## Tcl recorder starts at 05/29/23 00:23:27 ##########

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

########## Tcl recorder end at 05/29/23 00:23:27 ###########


########## Tcl recorder starts at 05/29/23 00:23:31 ##########

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

########## Tcl recorder end at 05/29/23 00:23:31 ###########


########## Tcl recorder starts at 05/29/23 00:23:35 ##########

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
if [runCmd "\"$cpld_bin/edif2blf\" -edf DISPLAY.edi -out DISPLAY.bl0 -err automake.err -log DISPLAY.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblifopt\" CALCULATE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open I2C.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: I2C
WORKING_PATH: \"$proj_dir\"
MODULE: I2C
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h i2c.v
OUTPUT_FILE_NAME: I2C
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e I2C -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete I2C.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C.edi -out I2C.bl0 -err automake.err -log I2C.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" I2C.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod top @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i lab11.bl5 -o lab11.sif"] {
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
	puts $rspFile "-nodal -src lab11.bl5 -type BLIF -presrc lab11.bl3 -crf lab11.crf -sif lab11.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci lab11.lct
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

########## Tcl recorder end at 05/29/23 00:23:35 ###########


########## Tcl recorder starts at 05/29/23 00:29:54 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 00:29:54 ###########


########## Tcl recorder starts at 05/29/23 00:33:21 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 00:33:21 ###########


########## Tcl recorder starts at 05/29/23 00:33:27 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open I2C.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: I2C
WORKING_PATH: \"$proj_dir\"
MODULE: I2C
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h i2c.v
OUTPUT_FILE_NAME: I2C
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e I2C -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete I2C.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C.edi -out I2C.bl0 -err automake.err -log I2C.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" I2C.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod top @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 00:33:27 ###########


########## Tcl recorder starts at 05/29/23 00:35:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 00:35:59 ###########


########## Tcl recorder starts at 05/29/23 00:37:12 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open I2C.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: I2C
WORKING_PATH: \"$proj_dir\"
MODULE: I2C
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h i2c.v
OUTPUT_FILE_NAME: I2C
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e I2C -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete I2C.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C.edi -out I2C.bl0 -err automake.err -log I2C.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" I2C.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod top @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 00:37:12 ###########


########## Tcl recorder starts at 05/29/23 00:50:55 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 00:50:55 ###########


########## Tcl recorder starts at 05/29/23 00:51:05 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open I2C.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: I2C
WORKING_PATH: \"$proj_dir\"
MODULE: I2C
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h i2c.v
OUTPUT_FILE_NAME: I2C
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e I2C -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete I2C.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C.edi -out I2C.bl0 -err automake.err -log I2C.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" I2C.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod top @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 00:51:05 ###########


########## Tcl recorder starts at 05/29/23 00:57:51 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i lab11.bl5 -o lab11.sif"] {
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
	puts $rspFile "-nodal -src lab11.bl5 -type BLIF -presrc lab11.bl3 -crf lab11.crf -sif lab11.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci lab11.lct
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

########## Tcl recorder end at 05/29/23 00:57:51 ###########


########## Tcl recorder starts at 05/29/23 01:01:01 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 01:01:01 ###########


########## Tcl recorder starts at 05/29/23 01:01:06 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open I2C.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: I2C
WORKING_PATH: \"$proj_dir\"
MODULE: I2C
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h i2c.v
OUTPUT_FILE_NAME: I2C
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e I2C -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete I2C.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C.edi -out I2C.bl0 -err automake.err -log I2C.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" I2C.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod top @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 01:01:06 ###########


########## Tcl recorder starts at 05/29/23 01:03:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 01:03:35 ###########


########## Tcl recorder starts at 05/29/23 01:03:39 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open I2C.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: I2C
WORKING_PATH: \"$proj_dir\"
MODULE: I2C
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h i2c.v
OUTPUT_FILE_NAME: I2C
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e I2C -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete I2C.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C.edi -out I2C.bl0 -err automake.err -log I2C.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" I2C.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod top @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 01:03:39 ###########


########## Tcl recorder starts at 05/29/23 01:39:42 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 01:39:42 ###########


########## Tcl recorder starts at 05/29/23 01:39:46 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open I2C.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: I2C
WORKING_PATH: \"$proj_dir\"
MODULE: I2C
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h i2c.v
OUTPUT_FILE_NAME: I2C
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e I2C -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete I2C.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C.edi -out I2C.bl0 -err automake.err -log I2C.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" I2C.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod top @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 01:39:46 ###########


########## Tcl recorder starts at 05/29/23 01:44:15 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 01:44:15 ###########


########## Tcl recorder starts at 05/29/23 01:46:24 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open I2C.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: I2C
WORKING_PATH: \"$proj_dir\"
MODULE: I2C
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h i2c.v
OUTPUT_FILE_NAME: I2C
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e I2C -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete I2C.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C.edi -out I2C.bl0 -err automake.err -log I2C.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" I2C.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod top @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 01:46:24 ###########


########## Tcl recorder starts at 05/29/23 09:36:51 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 09:36:51 ###########


########## Tcl recorder starts at 05/29/23 09:36:54 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 09:36:54 ###########


########## Tcl recorder starts at 05/29/23 09:38:37 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" display.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 09:38:37 ###########


########## Tcl recorder starts at 05/29/23 09:41:07 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open DISPLAY.cmd w} rspFile] {
	puts stderr "Cannot create response file DISPLAY.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: DISPLAY
WORKING_PATH: \"$proj_dir\"
MODULE: DISPLAY
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h display.v
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf DISPLAY.edi -out DISPLAY.bl0 -err automake.err -log DISPLAY.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [catch {open I2C.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: I2C
WORKING_PATH: \"$proj_dir\"
MODULE: I2C
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h i2c.v
OUTPUT_FILE_NAME: I2C
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e I2C -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete I2C.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C.edi -out I2C.bl0 -err automake.err -log I2C.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" I2C.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod top @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 09:41:07 ###########


########## Tcl recorder starts at 06/02/23 08:36:54 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 08:36:54 ###########


########## Tcl recorder starts at 06/02/23 08:37:37 ##########

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

########## Tcl recorder end at 06/02/23 08:37:37 ###########


########## Tcl recorder starts at 06/02/23 08:38:19 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" display.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 08:38:19 ###########


########## Tcl recorder starts at 06/02/23 08:38:25 ##########

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
if [catch {open DISPLAY.cmd w} rspFile] {
	puts stderr "Cannot create response file DISPLAY.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: DISPLAY
WORKING_PATH: \"$proj_dir\"
MODULE: DISPLAY
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h display.v
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf DISPLAY.edi -out DISPLAY.bl0 -err automake.err -log DISPLAY.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [catch {open I2C.cmd w} rspFile] {
	puts stderr "Cannot create response file I2C.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: I2C
WORKING_PATH: \"$proj_dir\"
MODULE: I2C
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h i2c.v
OUTPUT_FILE_NAME: I2C
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e I2C -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete I2C.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf I2C.edi -out I2C.bl0 -err automake.err -log I2C.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" I2C.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod top @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 08:38:25 ###########

