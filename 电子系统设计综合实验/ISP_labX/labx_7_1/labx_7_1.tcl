
########## Tcl recorder starts at 06/02/23 11:57:59 ##########

set version "2.1"
set proj_dir "D:/MyDucuments/_Junior_1/ElectricSystemDesign/ISP_labX/labx_7_1"
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
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncer.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" width_trans.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" play.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" toplevel.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" clk_gen.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" controller.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 11:57:59 ###########


########## Tcl recorder starts at 06/02/23 11:58:05 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx_7_1.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx_7_1.h play.v width_trans.v controller.v counter_n.v debouncer.v clk_gen.v toplevel.v
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

########## Tcl recorder end at 06/02/23 11:58:05 ###########


########## Tcl recorder starts at 06/02/23 11:59:08 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/edif2blf\" -edf toplevel.edi -out toplevel.bl0 -err automake.err -log toplevel.log -prj labx_7_1 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"toplevel.bl1\" -o \"labx_7_1.bl2\" -omod \"labx_7_1\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx_7_1 -lci labx_7_1.lct -log labx_7_1.imp -err automake.err -tti labx_7_1.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -blifopt labx_7_1.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx_7_1.bl2 -sweep -mergefb -err automake.err -o labx_7_1.bl3 @labx_7_1.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -diofft labx_7_1.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx_7_1.bl3 -family AMDMACH -idev van -o labx_7_1.bl4 -oxrf labx_7_1.xrf -err automake.err @labx_7_1.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -prefit labx_7_1.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx_7_1.bl4 -out labx_7_1.bl5 -err automake.err -log labx_7_1.log -mod toplevel @labx_7_1.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i labx_7_1.bl5 -o labx_7_1.sif"] {
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
	puts $rspFile "-nodal -src labx_7_1.bl5 -type BLIF -presrc labx_7_1.bl3 -crf labx_7_1.crf -sif labx_7_1.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci labx_7_1.lct
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

########## Tcl recorder end at 06/02/23 11:59:08 ###########


########## Tcl recorder starts at 06/02/23 12:00:21 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open labx_7_1.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs1: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -nojed -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx_7_1.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs2: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx_7_1.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx_7_1.rs1
file delete labx_7_1.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx_7_1.bl5 -o labx_7_1.tda -lci labx_7_1.lct -dev m4s_256_96 -family lc4k -mod toplevel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx_7_1 -if labx_7_1.jed -j2s -log labx_7_1.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:00:21 ###########


########## Tcl recorder starts at 06/02/23 12:02:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" clk_gen.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:02:36 ###########


########## Tcl recorder starts at 06/02/23 12:02:36 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx_7_1.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx_7_1.h play.v width_trans.v controller.v counter_n.v debouncer.v clk_gen.v toplevel.v
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

########## Tcl recorder end at 06/02/23 12:02:36 ###########


########## Tcl recorder starts at 06/02/23 12:03:21 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/edif2blf\" -edf toplevel.edi -out toplevel.bl0 -err automake.err -log toplevel.log -prj labx_7_1 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"toplevel.bl1\" -o \"labx_7_1.bl2\" -omod \"labx_7_1\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx_7_1 -lci labx_7_1.lct -log labx_7_1.imp -err automake.err -tti labx_7_1.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -blifopt labx_7_1.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx_7_1.bl2 -sweep -mergefb -err automake.err -o labx_7_1.bl3 @labx_7_1.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -diofft labx_7_1.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx_7_1.bl3 -family AMDMACH -idev van -o labx_7_1.bl4 -oxrf labx_7_1.xrf -err automake.err @labx_7_1.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -prefit labx_7_1.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx_7_1.bl4 -out labx_7_1.bl5 -err automake.err -log labx_7_1.log -mod toplevel @labx_7_1.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx_7_1.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs1: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -nojed -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx_7_1.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs2: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx_7_1.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx_7_1.rs1
file delete labx_7_1.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx_7_1.bl5 -o labx_7_1.tda -lci labx_7_1.lct -dev m4s_256_96 -family lc4k -mod toplevel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx_7_1 -if labx_7_1.jed -j2s -log labx_7_1.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:03:21 ###########


########## Tcl recorder starts at 06/02/23 12:05:51 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" play.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" toplevel.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:05:51 ###########


########## Tcl recorder starts at 06/02/23 12:05:52 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx_7_1.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx_7_1.h play.v width_trans.v controller.v counter_n.v debouncer.v clk_gen.v toplevel.v
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

########## Tcl recorder end at 06/02/23 12:05:52 ###########


########## Tcl recorder starts at 06/02/23 12:06:34 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/edif2blf\" -edf toplevel.edi -out toplevel.bl0 -err automake.err -log toplevel.log -prj labx_7_1 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"toplevel.bl1\" -o \"labx_7_1.bl2\" -omod \"labx_7_1\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx_7_1 -lci labx_7_1.lct -log labx_7_1.imp -err automake.err -tti labx_7_1.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -blifopt labx_7_1.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx_7_1.bl2 -sweep -mergefb -err automake.err -o labx_7_1.bl3 @labx_7_1.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -diofft labx_7_1.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx_7_1.bl3 -family AMDMACH -idev van -o labx_7_1.bl4 -oxrf labx_7_1.xrf -err automake.err @labx_7_1.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -prefit labx_7_1.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx_7_1.bl4 -out labx_7_1.bl5 -err automake.err -log labx_7_1.log -mod toplevel @labx_7_1.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx_7_1.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs1: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -nojed -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx_7_1.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs2: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx_7_1.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx_7_1.rs1
file delete labx_7_1.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx_7_1.bl5 -o labx_7_1.tda -lci labx_7_1.lct -dev m4s_256_96 -family lc4k -mod toplevel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx_7_1 -if labx_7_1.jed -j2s -log labx_7_1.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:06:34 ###########


########## Tcl recorder starts at 06/02/23 12:06:53 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i labx_7_1.bl5 -o labx_7_1.sif"] {
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
	puts $rspFile "-nodal -src labx_7_1.bl5 -type BLIF -presrc labx_7_1.bl3 -crf labx_7_1.crf -sif labx_7_1.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci labx_7_1.lct
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

########## Tcl recorder end at 06/02/23 12:06:53 ###########


########## Tcl recorder starts at 06/02/23 12:07:08 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open labx_7_1.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs1: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -nojed -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx_7_1.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs2: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx_7_1.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx_7_1.rs1
file delete labx_7_1.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx_7_1.bl5 -o labx_7_1.tda -lci labx_7_1.lct -dev m4s_256_96 -family lc4k -mod toplevel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx_7_1 -if labx_7_1.jed -j2s -log labx_7_1.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:07:08 ###########


########## Tcl recorder starts at 06/02/23 12:10:13 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" play.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:10:13 ###########


########## Tcl recorder starts at 06/02/23 12:10:13 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx_7_1.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx_7_1.h play.v width_trans.v controller.v counter_n.v debouncer.v clk_gen.v toplevel.v
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

########## Tcl recorder end at 06/02/23 12:10:13 ###########


########## Tcl recorder starts at 06/02/23 12:11:11 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/edif2blf\" -edf toplevel.edi -out toplevel.bl0 -err automake.err -log toplevel.log -prj labx_7_1 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"toplevel.bl1\" -o \"labx_7_1.bl2\" -omod \"labx_7_1\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx_7_1 -lci labx_7_1.lct -log labx_7_1.imp -err automake.err -tti labx_7_1.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -blifopt labx_7_1.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx_7_1.bl2 -sweep -mergefb -err automake.err -o labx_7_1.bl3 @labx_7_1.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -diofft labx_7_1.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx_7_1.bl3 -family AMDMACH -idev van -o labx_7_1.bl4 -oxrf labx_7_1.xrf -err automake.err @labx_7_1.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -prefit labx_7_1.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx_7_1.bl4 -out labx_7_1.bl5 -err automake.err -log labx_7_1.log -mod toplevel @labx_7_1.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx_7_1.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs1: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -nojed -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx_7_1.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs2: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx_7_1.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx_7_1.rs1
file delete labx_7_1.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx_7_1.bl5 -o labx_7_1.tda -lci labx_7_1.lct -dev m4s_256_96 -family lc4k -mod toplevel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx_7_1 -if labx_7_1.jed -j2s -log labx_7_1.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:11:11 ###########


########## Tcl recorder starts at 06/02/23 12:14:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" play.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:14:31 ###########


########## Tcl recorder starts at 06/02/23 12:14:31 ##########

# Commands to make the Process: 
# Fitter Report (HTML)
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx_7_1.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx_7_1.h play.v width_trans.v controller.v counter_n.v debouncer.v clk_gen.v toplevel.v
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf toplevel.edi -out toplevel.bl0 -err automake.err -log toplevel.log -prj labx_7_1 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"toplevel.bl1\" -o \"labx_7_1.bl2\" -omod \"labx_7_1\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx_7_1 -lci labx_7_1.lct -log labx_7_1.imp -err automake.err -tti labx_7_1.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -blifopt labx_7_1.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx_7_1.bl2 -sweep -mergefb -err automake.err -o labx_7_1.bl3 @labx_7_1.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -diofft labx_7_1.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx_7_1.bl3 -family AMDMACH -idev van -o labx_7_1.bl4 -oxrf labx_7_1.xrf -err automake.err @labx_7_1.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -prefit labx_7_1.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx_7_1.bl4 -out labx_7_1.bl5 -err automake.err -log labx_7_1.log -mod toplevel @labx_7_1.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx_7_1.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs1: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -nojed -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx_7_1.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs2: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx_7_1.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx_7_1.rs1
file delete labx_7_1.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx_7_1.bl5 -o labx_7_1.tda -lci labx_7_1.lct -dev m4s_256_96 -family lc4k -mod toplevel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx_7_1 -if labx_7_1.jed -j2s -log labx_7_1.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:14:31 ###########


########## Tcl recorder starts at 06/02/23 12:16:21 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ledscan_n.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:16:21 ###########


########## Tcl recorder starts at 06/02/23 12:21:46 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncer.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" toplevel.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" clk_gen.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:21:46 ###########


########## Tcl recorder starts at 06/02/23 12:21:47 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx_7_1.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx_7_1.h ledscan_n.v play.v controller.v counter_n.v debouncer.v clk_gen.v toplevel.v
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

########## Tcl recorder end at 06/02/23 12:21:47 ###########


########## Tcl recorder starts at 06/02/23 12:22:25 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ledscan_n.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncer.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" play.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" toplevel.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" clk_gen.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" controller.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:22:25 ###########


########## Tcl recorder starts at 06/02/23 12:22:27 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx_7_1.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx_7_1.h ledscan_n.v play.v controller.v counter_n.v debouncer.v clk_gen.v toplevel.v
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

########## Tcl recorder end at 06/02/23 12:22:27 ###########


########## Tcl recorder starts at 06/02/23 12:23:04 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/edif2blf\" -edf toplevel.edi -out toplevel.bl0 -err automake.err -log toplevel.log -prj labx_7_1 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"toplevel.bl1\" -o \"labx_7_1.bl2\" -omod \"labx_7_1\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx_7_1 -lci labx_7_1.lct -log labx_7_1.imp -err automake.err -tti labx_7_1.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -blifopt labx_7_1.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx_7_1.bl2 -sweep -mergefb -err automake.err -o labx_7_1.bl3 @labx_7_1.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -diofft labx_7_1.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx_7_1.bl3 -family AMDMACH -idev van -o labx_7_1.bl4 -oxrf labx_7_1.xrf -err automake.err @labx_7_1.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -prefit labx_7_1.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx_7_1.bl4 -out labx_7_1.bl5 -err automake.err -log labx_7_1.log -mod toplevel @labx_7_1.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i labx_7_1.bl5 -o labx_7_1.sif"] {
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
	puts $rspFile "-nodal -src labx_7_1.bl5 -type BLIF -presrc labx_7_1.bl3 -crf labx_7_1.crf -sif labx_7_1.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci labx_7_1.lct
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

########## Tcl recorder end at 06/02/23 12:23:04 ###########


########## Tcl recorder starts at 06/02/23 12:23:27 ##########

# Commands to make the Process: 
# Fitter Report (HTML)
if [catch {open labx_7_1.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs1: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -nojed -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx_7_1.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs2: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx_7_1.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx_7_1.rs1
file delete labx_7_1.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx_7_1.bl5 -o labx_7_1.tda -lci labx_7_1.lct -dev m4s_256_96 -family lc4k -mod toplevel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx_7_1 -if labx_7_1.jed -j2s -log labx_7_1.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:23:27 ###########


########## Tcl recorder starts at 06/02/23 12:24:33 ##########

# Commands to make the Process: 
# Constraint Editor
# - none -
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src labx_7_1.bl5 -type BLIF -presrc labx_7_1.bl3 -crf labx_7_1.crf -sif labx_7_1.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci labx_7_1.lct
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

########## Tcl recorder end at 06/02/23 12:24:33 ###########


########## Tcl recorder starts at 06/02/23 12:26:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" play.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" toplevel.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:26:41 ###########


########## Tcl recorder starts at 06/02/23 12:26:42 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx_7_1.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx_7_1.h ledscan_n.v play.v controller.v counter_n.v debouncer.v clk_gen.v toplevel.v
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

########## Tcl recorder end at 06/02/23 12:26:42 ###########


########## Tcl recorder starts at 06/02/23 12:27:42 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" debouncer.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:27:42 ###########


########## Tcl recorder starts at 06/02/23 12:27:43 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx_7_1.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx_7_1.h ledscan_n.v play.v controller.v counter_n.v debouncer.v clk_gen.v toplevel.v
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

########## Tcl recorder end at 06/02/23 12:27:43 ###########


########## Tcl recorder starts at 06/02/23 12:29:01 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/edif2blf\" -edf toplevel.edi -out toplevel.bl0 -err automake.err -log toplevel.log -prj labx_7_1 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"toplevel.bl1\" -o \"labx_7_1.bl2\" -omod \"labx_7_1\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx_7_1 -lci labx_7_1.lct -log labx_7_1.imp -err automake.err -tti labx_7_1.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -blifopt labx_7_1.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx_7_1.bl2 -sweep -mergefb -err automake.err -o labx_7_1.bl3 @labx_7_1.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -diofft labx_7_1.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx_7_1.bl3 -family AMDMACH -idev van -o labx_7_1.bl4 -oxrf labx_7_1.xrf -err automake.err @labx_7_1.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -prefit labx_7_1.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx_7_1.bl4 -out labx_7_1.bl5 -err automake.err -log labx_7_1.log -mod toplevel @labx_7_1.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i labx_7_1.bl5 -o labx_7_1.sif"] {
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
	puts $rspFile "-nodal -src labx_7_1.bl5 -type BLIF -presrc labx_7_1.bl3 -crf labx_7_1.crf -sif labx_7_1.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci labx_7_1.lct
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

########## Tcl recorder end at 06/02/23 12:29:01 ###########


########## Tcl recorder starts at 06/02/23 12:31:55 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" toplevel.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:31:55 ###########


########## Tcl recorder starts at 06/02/23 12:31:55 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx_7_1.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx_7_1.h ledscan_n.v play.v controller.v counter_n.v debouncer.v clk_gen.v toplevel.v
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

########## Tcl recorder end at 06/02/23 12:31:55 ###########


########## Tcl recorder starts at 06/02/23 12:34:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" toplevel.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:34:11 ###########


########## Tcl recorder starts at 06/02/23 12:34:12 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx_7_1.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx_7_1.h ledscan_n.v play.v controller.v counter_n.v debouncer.v clk_gen.v toplevel.v
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

########## Tcl recorder end at 06/02/23 12:34:12 ###########


########## Tcl recorder starts at 06/02/23 12:34:45 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/edif2blf\" -edf toplevel.edi -out toplevel.bl0 -err automake.err -log toplevel.log -prj labx_7_1 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"toplevel.bl1\" -o \"labx_7_1.bl2\" -omod \"labx_7_1\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx_7_1 -lci labx_7_1.lct -log labx_7_1.imp -err automake.err -tti labx_7_1.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -blifopt labx_7_1.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx_7_1.bl2 -sweep -mergefb -err automake.err -o labx_7_1.bl3 @labx_7_1.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -diofft labx_7_1.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx_7_1.bl3 -family AMDMACH -idev van -o labx_7_1.bl4 -oxrf labx_7_1.xrf -err automake.err @labx_7_1.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -prefit labx_7_1.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx_7_1.bl4 -out labx_7_1.bl5 -err automake.err -log labx_7_1.log -mod toplevel @labx_7_1.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx_7_1.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs1: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -nojed -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx_7_1.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs2: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx_7_1.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx_7_1.rs1
file delete labx_7_1.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx_7_1.bl5 -o labx_7_1.tda -lci labx_7_1.lct -dev m4s_256_96 -family lc4k -mod toplevel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx_7_1 -if labx_7_1.jed -j2s -log labx_7_1.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:34:45 ###########


########## Tcl recorder starts at 06/02/23 12:36:38 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i labx_7_1.bl5 -o labx_7_1.sif"] {
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
	puts $rspFile "-nodal -src labx_7_1.bl5 -type BLIF -presrc labx_7_1.bl3 -crf labx_7_1.crf -sif labx_7_1.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci labx_7_1.lct
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

########## Tcl recorder end at 06/02/23 12:36:38 ###########


########## Tcl recorder starts at 06/02/23 12:37:58 ##########

# Commands to make the Process: 
# Optimization Constraint
# - none -
# Application to view the Process: 
# Optimization Constraint
if [catch {open opt_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file opt_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-global -lci labx_7_1.lct -touch labx_7_1.imp
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

########## Tcl recorder end at 06/02/23 12:37:58 ###########


########## Tcl recorder starts at 06/02/23 12:38:06 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -blifopt labx_7_1.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx_7_1.bl2 -sweep -mergefb -err automake.err -o labx_7_1.bl3 @labx_7_1.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -diofft labx_7_1.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx_7_1.bl3 -family AMDMACH -idev van -o labx_7_1.bl4 -oxrf labx_7_1.xrf -err automake.err @labx_7_1.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -prefit labx_7_1.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx_7_1.bl4 -out labx_7_1.bl5 -err automake.err -log labx_7_1.log -mod toplevel @labx_7_1.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx_7_1.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs1: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -nojed -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx_7_1.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs2: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx_7_1.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx_7_1.rs1
file delete labx_7_1.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx_7_1.bl5 -o labx_7_1.tda -lci labx_7_1.lct -dev m4s_256_96 -family lc4k -mod toplevel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx_7_1 -if labx_7_1.jed -j2s -log labx_7_1.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:38:06 ###########


########## Tcl recorder starts at 06/02/23 12:38:23 ##########

# Commands to make the Process: 
# Optimization Constraint
# - none -
# Application to view the Process: 
# Optimization Constraint
if [catch {open opt_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file opt_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-global -lci labx_7_1.lct -touch labx_7_1.imp
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

########## Tcl recorder end at 06/02/23 12:38:23 ###########


########## Tcl recorder starts at 06/02/23 12:38:30 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -blifopt labx_7_1.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx_7_1.bl2 -sweep -mergefb -err automake.err -o labx_7_1.bl3 @labx_7_1.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -diofft labx_7_1.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx_7_1.bl3 -family AMDMACH -idev van -o labx_7_1.bl4 -oxrf labx_7_1.xrf -err automake.err @labx_7_1.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -prefit labx_7_1.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx_7_1.bl4 -out labx_7_1.bl5 -err automake.err -log labx_7_1.log -mod toplevel @labx_7_1.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx_7_1.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs1: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -nojed -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx_7_1.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs2: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx_7_1.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx_7_1.rs1
file delete labx_7_1.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx_7_1.bl5 -o labx_7_1.tda -lci labx_7_1.lct -dev m4s_256_96 -family lc4k -mod toplevel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx_7_1 -if labx_7_1.jed -j2s -log labx_7_1.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:38:30 ###########


########## Tcl recorder starts at 06/02/23 12:40:04 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" toplevel.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:40:04 ###########


########## Tcl recorder starts at 06/02/23 12:40:05 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx_7_1.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx_7_1.h ledscan_n.v play.v controller.v counter_n.v debouncer.v clk_gen.v toplevel.v
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

########## Tcl recorder end at 06/02/23 12:40:05 ###########


########## Tcl recorder starts at 06/02/23 12:40:38 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/edif2blf\" -edf toplevel.edi -out toplevel.bl0 -err automake.err -log toplevel.log -prj labx_7_1 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"toplevel.bl1\" -o \"labx_7_1.bl2\" -omod \"labx_7_1\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx_7_1 -lci labx_7_1.lct -log labx_7_1.imp -err automake.err -tti labx_7_1.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -blifopt labx_7_1.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx_7_1.bl2 -sweep -mergefb -err automake.err -o labx_7_1.bl3 @labx_7_1.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -diofft labx_7_1.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx_7_1.bl3 -family AMDMACH -idev van -o labx_7_1.bl4 -oxrf labx_7_1.xrf -err automake.err @labx_7_1.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -prefit labx_7_1.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx_7_1.bl4 -out labx_7_1.bl5 -err automake.err -log labx_7_1.log -mod toplevel @labx_7_1.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx_7_1.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs1: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -nojed -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx_7_1.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs2: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx_7_1.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx_7_1.rs1
file delete labx_7_1.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx_7_1.bl5 -o labx_7_1.tda -lci labx_7_1.lct -dev m4s_256_96 -family lc4k -mod toplevel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx_7_1 -if labx_7_1.jed -j2s -log labx_7_1.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:40:38 ###########


########## Tcl recorder starts at 06/02/23 12:42:14 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" toplevel.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:42:14 ###########


########## Tcl recorder starts at 06/02/23 12:42:14 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx_7_1.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx_7_1.h ledscan_n.v play.v controller.v counter_n.v debouncer.v clk_gen.v toplevel.v
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

########## Tcl recorder end at 06/02/23 12:42:14 ###########


########## Tcl recorder starts at 06/02/23 12:42:49 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/edif2blf\" -edf toplevel.edi -out toplevel.bl0 -err automake.err -log toplevel.log -prj labx_7_1 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"toplevel.bl1\" -o \"labx_7_1.bl2\" -omod \"labx_7_1\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx_7_1 -lci labx_7_1.lct -log labx_7_1.imp -err automake.err -tti labx_7_1.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -blifopt labx_7_1.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx_7_1.bl2 -sweep -mergefb -err automake.err -o labx_7_1.bl3 @labx_7_1.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -diofft labx_7_1.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx_7_1.bl3 -family AMDMACH -idev van -o labx_7_1.bl4 -oxrf labx_7_1.xrf -err automake.err @labx_7_1.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -prefit labx_7_1.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx_7_1.bl4 -out labx_7_1.bl5 -err automake.err -log labx_7_1.log -mod toplevel @labx_7_1.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx_7_1.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs1: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -nojed -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx_7_1.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs2: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx_7_1.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx_7_1.rs1
file delete labx_7_1.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx_7_1.bl5 -o labx_7_1.tda -lci labx_7_1.lct -dev m4s_256_96 -family lc4k -mod toplevel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx_7_1 -if labx_7_1.jed -j2s -log labx_7_1.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:42:49 ###########


########## Tcl recorder starts at 06/02/23 12:44:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" toplevel.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:44:34 ###########


########## Tcl recorder starts at 06/02/23 12:44:34 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx_7_1.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx_7_1.h ledscan_n.v play.v controller.v counter_n.v debouncer.v clk_gen.v toplevel.v
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

########## Tcl recorder end at 06/02/23 12:44:34 ###########


########## Tcl recorder starts at 06/02/23 12:45:39 ##########

# Commands to make the Process: 
# Optimization Constraint
if [runCmd "\"$cpld_bin/edif2blf\" -edf toplevel.edi -out toplevel.bl0 -err automake.err -log toplevel.log -prj labx_7_1 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"toplevel.bl1\" -o \"labx_7_1.bl2\" -omod \"labx_7_1\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx_7_1 -lci labx_7_1.lct -log labx_7_1.imp -err automake.err -tti labx_7_1.bl2 -dir $proj_dir"] {
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
	puts $rspFile "-global -lci labx_7_1.lct -touch labx_7_1.imp
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

########## Tcl recorder end at 06/02/23 12:45:39 ###########


########## Tcl recorder starts at 06/02/23 12:45:48 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -blifopt labx_7_1.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx_7_1.bl2 -sweep -mergefb -err automake.err -o labx_7_1.bl3 @labx_7_1.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -diofft labx_7_1.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx_7_1.bl3 -family AMDMACH -idev van -o labx_7_1.bl4 -oxrf labx_7_1.xrf -err automake.err @labx_7_1.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -prefit labx_7_1.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx_7_1.bl4 -out labx_7_1.bl5 -err automake.err -log labx_7_1.log -mod toplevel @labx_7_1.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx_7_1.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs1: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -nojed -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx_7_1.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs2: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx_7_1.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx_7_1.rs1
file delete labx_7_1.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx_7_1.bl5 -o labx_7_1.tda -lci labx_7_1.lct -dev m4s_256_96 -family lc4k -mod toplevel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx_7_1 -if labx_7_1.jed -j2s -log labx_7_1.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/02/23 12:45:48 ###########


########## Tcl recorder starts at 06/09/23 08:43:47 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx_7_1.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx_7_1.h ledscan_n.v play.v controller.v counter_n.v debouncer.v clk_gen.v toplevel.v
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

########## Tcl recorder end at 06/09/23 08:43:47 ###########


########## Tcl recorder starts at 06/09/23 08:44:46 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/edif2blf\" -edf toplevel.edi -out toplevel.bl0 -err automake.err -log toplevel.log -prj labx_7_1 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"toplevel.bl1\" -o \"labx_7_1.bl2\" -omod \"labx_7_1\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx_7_1 -lci labx_7_1.lct -log labx_7_1.imp -err automake.err -tti labx_7_1.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -blifopt labx_7_1.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx_7_1.bl2 -sweep -mergefb -err automake.err -o labx_7_1.bl3 @labx_7_1.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -diofft labx_7_1.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx_7_1.bl3 -family AMDMACH -idev van -o labx_7_1.bl4 -oxrf labx_7_1.xrf -err automake.err @labx_7_1.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -prefit labx_7_1.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx_7_1.bl4 -out labx_7_1.bl5 -err automake.err -log labx_7_1.log -mod toplevel @labx_7_1.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx_7_1.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs1: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -nojed -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx_7_1.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs2: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx_7_1.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx_7_1.rs1
file delete labx_7_1.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx_7_1.bl5 -o labx_7_1.tda -lci labx_7_1.lct -dev m4s_256_96 -family lc4k -mod toplevel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx_7_1 -if labx_7_1.jed -j2s -log labx_7_1.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 08:44:46 ###########


########## Tcl recorder starts at 06/09/23 11:10:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" play.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 11:10:59 ###########


########## Tcl recorder starts at 06/09/23 11:10:59 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx_7_1.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx_7_1.h ledscan_n.v play.v controller.v counter_n.v debouncer.v clk_gen.v toplevel.v
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

########## Tcl recorder end at 06/09/23 11:10:59 ###########


########## Tcl recorder starts at 06/09/23 11:12:30 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/edif2blf\" -edf toplevel.edi -out toplevel.bl0 -err automake.err -log toplevel.log -prj labx_7_1 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"toplevel.bl1\" -o \"labx_7_1.bl2\" -omod \"labx_7_1\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx_7_1 -lci labx_7_1.lct -log labx_7_1.imp -err automake.err -tti labx_7_1.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -blifopt labx_7_1.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx_7_1.bl2 -sweep -mergefb -err automake.err -o labx_7_1.bl3 @labx_7_1.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -diofft labx_7_1.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx_7_1.bl3 -family AMDMACH -idev van -o labx_7_1.bl4 -oxrf labx_7_1.xrf -err automake.err @labx_7_1.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -prefit labx_7_1.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx_7_1.bl4 -out labx_7_1.bl5 -err automake.err -log labx_7_1.log -mod toplevel @labx_7_1.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx_7_1.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs1: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -nojed -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx_7_1.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs2: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx_7_1.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx_7_1.rs1
file delete labx_7_1.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx_7_1.bl5 -o labx_7_1.tda -lci labx_7_1.lct -dev m4s_256_96 -family lc4k -mod toplevel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx_7_1 -if labx_7_1.jed -j2s -log labx_7_1.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 11:12:30 ###########


########## Tcl recorder starts at 06/09/23 11:18:32 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" play.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 11:18:32 ###########


########## Tcl recorder starts at 06/09/23 11:18:33 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx_7_1.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx_7_1.h ledscan_n.v play.v controller.v counter_n.v debouncer.v clk_gen.v toplevel.v
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf toplevel.edi -out toplevel.bl0 -err automake.err -log toplevel.log -prj labx_7_1 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"toplevel.bl1\" -o \"labx_7_1.bl2\" -omod \"labx_7_1\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx_7_1 -lci labx_7_1.lct -log labx_7_1.imp -err automake.err -tti labx_7_1.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -blifopt labx_7_1.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx_7_1.bl2 -sweep -mergefb -err automake.err -o labx_7_1.bl3 @labx_7_1.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -diofft labx_7_1.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx_7_1.bl3 -family AMDMACH -idev van -o labx_7_1.bl4 -oxrf labx_7_1.xrf -err automake.err @labx_7_1.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -prefit labx_7_1.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx_7_1.bl4 -out labx_7_1.bl5 -err automake.err -log labx_7_1.log -mod toplevel @labx_7_1.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx_7_1.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs1: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -nojed -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx_7_1.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs2: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx_7_1.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx_7_1.rs1
file delete labx_7_1.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx_7_1.bl5 -o labx_7_1.tda -lci labx_7_1.lct -dev m4s_256_96 -family lc4k -mod toplevel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx_7_1 -if labx_7_1.jed -j2s -log labx_7_1.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 11:18:33 ###########


########## Tcl recorder starts at 06/09/23 11:25:14 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" toplevel.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 11:25:14 ###########


########## Tcl recorder starts at 06/09/23 11:25:14 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx_7_1.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx_7_1.h ledscan_n.v play.v controller.v counter_n.v debouncer.v clk_gen.v toplevel.v
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

########## Tcl recorder end at 06/09/23 11:25:14 ###########


########## Tcl recorder starts at 06/09/23 11:26:00 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/edif2blf\" -edf toplevel.edi -out toplevel.bl0 -err automake.err -log toplevel.log -prj labx_7_1 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"toplevel.bl1\" -o \"labx_7_1.bl2\" -omod \"labx_7_1\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx_7_1 -lci labx_7_1.lct -log labx_7_1.imp -err automake.err -tti labx_7_1.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -blifopt labx_7_1.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx_7_1.bl2 -sweep -mergefb -err automake.err -o labx_7_1.bl3 @labx_7_1.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -diofft labx_7_1.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx_7_1.bl3 -family AMDMACH -idev van -o labx_7_1.bl4 -oxrf labx_7_1.xrf -err automake.err @labx_7_1.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -prefit labx_7_1.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx_7_1.bl4 -out labx_7_1.bl5 -err automake.err -log labx_7_1.log -mod toplevel @labx_7_1.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx_7_1.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs1: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -nojed -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx_7_1.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs2: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx_7_1.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx_7_1.rs1
file delete labx_7_1.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx_7_1.bl5 -o labx_7_1.tda -lci labx_7_1.lct -dev m4s_256_96 -family lc4k -mod toplevel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx_7_1 -if labx_7_1.jed -j2s -log labx_7_1.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 11:26:00 ###########


########## Tcl recorder starts at 06/09/23 11:29:51 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" play.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 11:29:51 ###########


########## Tcl recorder starts at 06/09/23 11:29:52 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx_7_1.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx_7_1.h ledscan_n.v play.v controller.v counter_n.v debouncer.v clk_gen.v toplevel.v
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

########## Tcl recorder end at 06/09/23 11:29:52 ###########


########## Tcl recorder starts at 06/09/23 11:30:24 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/edif2blf\" -edf toplevel.edi -out toplevel.bl0 -err automake.err -log toplevel.log -prj labx_7_1 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"toplevel.bl1\" -o \"labx_7_1.bl2\" -omod \"labx_7_1\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx_7_1 -lci labx_7_1.lct -log labx_7_1.imp -err automake.err -tti labx_7_1.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -blifopt labx_7_1.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx_7_1.bl2 -sweep -mergefb -err automake.err -o labx_7_1.bl3 @labx_7_1.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -diofft labx_7_1.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx_7_1.bl3 -family AMDMACH -idev van -o labx_7_1.bl4 -oxrf labx_7_1.xrf -err automake.err @labx_7_1.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -prefit labx_7_1.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx_7_1.bl4 -out labx_7_1.bl5 -err automake.err -log labx_7_1.log -mod toplevel @labx_7_1.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx_7_1.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs1: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -nojed -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx_7_1.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs2: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx_7_1.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx_7_1.rs1
file delete labx_7_1.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx_7_1.bl5 -o labx_7_1.tda -lci labx_7_1.lct -dev m4s_256_96 -family lc4k -mod toplevel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx_7_1 -if labx_7_1.jed -j2s -log labx_7_1.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 11:30:24 ###########


########## Tcl recorder starts at 06/09/23 11:32:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" play.v -p \"$install_dir/ispcpld/generic\" -predefine labx_7_1.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 11:32:36 ###########


########## Tcl recorder starts at 06/09/23 11:32:36 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open toplevel.cmd w} rspFile] {
	puts stderr "Cannot create response file toplevel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: labx_7_1.sty
PROJECT: toplevel
WORKING_PATH: \"$proj_dir\"
MODULE: toplevel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" labx_7_1.h ledscan_n.v play.v controller.v counter_n.v debouncer.v clk_gen.v toplevel.v
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

########## Tcl recorder end at 06/09/23 11:32:36 ###########


########## Tcl recorder starts at 06/09/23 11:33:10 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/edif2blf\" -edf toplevel.edi -out toplevel.bl0 -err automake.err -log toplevel.log -prj labx_7_1 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"toplevel.bl1\" -o \"labx_7_1.bl2\" -omod \"labx_7_1\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx_7_1 -lci labx_7_1.lct -log labx_7_1.imp -err automake.err -tti labx_7_1.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -blifopt labx_7_1.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx_7_1.bl2 -sweep -mergefb -err automake.err -o labx_7_1.bl3 @labx_7_1.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -diofft labx_7_1.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx_7_1.bl3 -family AMDMACH -idev van -o labx_7_1.bl4 -oxrf labx_7_1.xrf -err automake.err @labx_7_1.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -prefit labx_7_1.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx_7_1.bl4 -out labx_7_1.bl5 -err automake.err -log labx_7_1.log -mod toplevel @labx_7_1.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx_7_1.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs1: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -nojed -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx_7_1.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs2: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx_7_1.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx_7_1.rs1
file delete labx_7_1.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx_7_1.bl5 -o labx_7_1.tda -lci labx_7_1.lct -dev m4s_256_96 -family lc4k -mod toplevel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx_7_1 -if labx_7_1.jed -j2s -log labx_7_1.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/09/23 11:33:10 ###########


########## Tcl recorder starts at 06/16/23 04:21:01 ##########

# Commands to make the Process: 
# Fitter Report (HTML)
if [runCmd "\"$cpld_bin/edif2blf\" -edf toplevel.edi -out toplevel.bl0 -err automake.err -log toplevel.log -prj labx_7_1 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"toplevel.bl1\" -o \"labx_7_1.bl2\" -omod \"labx_7_1\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj labx_7_1 -lci labx_7_1.lct -log labx_7_1.imp -err automake.err -tti labx_7_1.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -blifopt labx_7_1.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" labx_7_1.bl2 -sweep -mergefb -err automake.err -o labx_7_1.bl3 @labx_7_1.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -diofft labx_7_1.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" labx_7_1.bl3 -family AMDMACH -idev van -o labx_7_1.bl4 -oxrf labx_7_1.xrf -err automake.err @labx_7_1.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci labx_7_1.lct -dev lc4k -prefit labx_7_1.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp labx_7_1.bl4 -out labx_7_1.bl5 -err automake.err -log labx_7_1.log -mod toplevel @labx_7_1.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open labx_7_1.rs1 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs1: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -nojed -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open labx_7_1.rs2 w} rspFile] {
	puts stderr "Cannot create response file labx_7_1.rs2: $rspFile"
} else {
	puts $rspFile "-i labx_7_1.bl5 -lci labx_7_1.lct -d m4s_256_96 -lco labx_7_1.lco -html_rpt -fti labx_7_1.fti -fmt PLA -tto labx_7_1.tt4 -eqn labx_7_1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@labx_7_1.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete labx_7_1.rs1
file delete labx_7_1.rs2
if [runCmd "\"$cpld_bin/tda\" -i labx_7_1.bl5 -o labx_7_1.tda -lci labx_7_1.lct -dev m4s_256_96 -family lc4k -mod toplevel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj labx_7_1 -if labx_7_1.jed -j2s -log labx_7_1.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/16/23 04:21:01 ###########

