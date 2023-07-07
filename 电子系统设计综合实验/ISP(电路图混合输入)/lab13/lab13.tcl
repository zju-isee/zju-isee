
########## Tcl recorder starts at 05/29/23 12:02:37 ##########

set version "2.1"
set proj_dir "D:/isp/lab13"
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

########## Tcl recorder end at 05/29/23 12:02:37 ###########


########## Tcl recorder starts at 05/29/23 12:06:33 ##########

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

########## Tcl recorder end at 05/29/23 12:06:33 ###########


########## Tcl recorder starts at 05/29/23 17:04:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lcd.v -p \"$install_dir/ispcpld/generic\" -predefine lab13.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 17:04:31 ###########


########## Tcl recorder starts at 05/29/23 17:04:43 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lcd.v -p \"$install_dir/ispcpld/generic\" -predefine lab13.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 17:04:43 ###########


########## Tcl recorder starts at 05/29/23 17:06:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lcd.v -p \"$install_dir/ispcpld/generic\" -predefine lab13.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 17:06:16 ###########


########## Tcl recorder starts at 05/29/23 17:06:17 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open LCD.cmd w} rspFile] {
	puts stderr "Cannot create response file LCD.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab13.sty
PROJECT: LCD
WORKING_PATH: \"$proj_dir\"
MODULE: LCD
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab13.h lcd.v
OUTPUT_FILE_NAME: LCD
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LCD -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LCD.cmd

########## Tcl recorder end at 05/29/23 17:06:17 ###########


########## Tcl recorder starts at 05/29/23 17:07:28 ##########

# Commands to make the Process: 
# Compile EDIF File
if [runCmd "\"$cpld_bin/edif2blf\" -edf LCD.edi -out LCD.bl0 -err automake.err -log LCD.log -prj lab13 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 17:07:28 ###########


########## Tcl recorder starts at 05/29/23 17:07:31 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" LCD"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 17:07:31 ###########


########## Tcl recorder starts at 05/29/23 17:08:53 ##########

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

########## Tcl recorder end at 05/29/23 17:08:53 ###########


########## Tcl recorder starts at 05/29/23 17:08:58 ##########

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
if [runCmd "\"$cpld_bin/mblifopt\" LCD.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"lab13.bl2\" -omod \"lab13\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab13 -lci lab13.lct -log lab13.imp -err automake.err -tti lab13.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -blifopt lab13.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab13.bl2 -sweep -mergefb -err automake.err -o lab13.bl3 @lab13.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -diofft lab13.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab13.bl3 -family AMDMACH -idev van -o lab13.bl4 -oxrf lab13.xrf -err automake.err @lab13.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -prefit lab13.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab13.bl4 -out lab13.bl5 -err automake.err -log lab13.log -mod top @lab13.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i lab13.bl5 -o lab13.sif"] {
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
	puts $rspFile "-nodal -src lab13.bl5 -type BLIF -presrc lab13.bl3 -crf lab13.crf -sif lab13.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci lab13.lct
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

########## Tcl recorder end at 05/29/23 17:08:58 ###########


########## Tcl recorder starts at 05/29/23 17:10:44 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab13.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs1: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4s_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -nojed -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab13.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs2: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4s_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab13.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab13.rs1
file delete lab13.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab13.bl5 -o lab13.tda -lci lab13.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab13 -if lab13.jed -j2s -log lab13.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 17:10:44 ###########


########## Tcl recorder starts at 05/29/23 17:32:33 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lcd.v -p \"$install_dir/ispcpld/generic\" -predefine lab13.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 17:32:33 ###########


########## Tcl recorder starts at 05/29/23 17:32:36 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open LCD.cmd w} rspFile] {
	puts stderr "Cannot create response file LCD.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab13.sty
PROJECT: LCD
WORKING_PATH: \"$proj_dir\"
MODULE: LCD
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab13.h lcd.v
OUTPUT_FILE_NAME: LCD
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e LCD -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete LCD.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf LCD.edi -out LCD.bl0 -err automake.err -log LCD.log -prj lab13 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" LCD.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"lab13.bl2\" -omod \"lab13\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab13 -lci lab13.lct -log lab13.imp -err automake.err -tti lab13.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -blifopt lab13.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab13.bl2 -sweep -mergefb -err automake.err -o lab13.bl3 @lab13.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -diofft lab13.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab13.bl3 -family AMDMACH -idev van -o lab13.bl4 -oxrf lab13.xrf -err automake.err @lab13.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab13.lct -dev lc4k -prefit lab13.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab13.bl4 -out lab13.bl5 -err automake.err -log lab13.log -mod top @lab13.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab13.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs1: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4s_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -nojed -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab13.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab13.rs2: $rspFile"
} else {
	puts $rspFile "-i lab13.bl5 -lci lab13.lct -d m4s_256_96 -lco lab13.lco -html_rpt -fti lab13.fti -fmt PLA -tto lab13.tt4 -eqn lab13.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab13.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab13.rs1
file delete lab13.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab13.bl5 -o lab13.tda -lci lab13.lct -dev m4s_256_96 -family lc4k -mod top -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab13 -if lab13.jed -j2s -log lab13.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/29/23 17:32:36 ###########

