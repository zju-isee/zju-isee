
########## Tcl recorder starts at 05/25/23 10:41:04 ##########

set version "2.1"
set proj_dir "D:/isp/lab10"
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
if [runCmd "\"$cpld_bin/sch2jhd\" lab10.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/23 10:41:04 ###########


########## Tcl recorder starts at 05/25/23 10:41:15 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" lab10.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/23 10:41:15 ###########


########## Tcl recorder starts at 05/25/23 10:41:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/23 10:41:36 ###########


########## Tcl recorder starts at 05/25/23 10:41:42 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/23 10:41:42 ###########


########## Tcl recorder starts at 05/25/23 10:41:49 ##########

# Commands to make the Process: 
# Lattice Synthesize Verilog File
if [catch {open KEYBOARD_lse.env w} rspFile] {
	puts stderr "Cannot create response file KEYBOARD_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open KEYBOARD.synproj w} rspFile] {
	puts stderr "Cannot create response file KEYBOARD.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top KEYBOARD
-lib \"work\" -ver lab10.h keyboard.v
-output_edif KEYBOARD.edi
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
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"KEYBOARD.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KEYBOARD_lse.env
file delete KEYBOARD.synproj

########## Tcl recorder end at 05/25/23 10:41:49 ###########


########## Tcl recorder starts at 05/25/23 10:41:57 ##########

# Commands to make the Process: 
# Compile EDIF File
if [runCmd "\"$cpld_bin/edif2blf\" -edf KEYBOARD.edi -out KEYBOARD.bl0 -err automake.err -log KEYBOARD.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/23 10:41:57 ###########


########## Tcl recorder starts at 05/25/23 10:42:00 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" KEYBOARD"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/23 10:42:00 ###########


########## Tcl recorder starts at 05/25/23 10:42:49 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" lab10.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/23 10:42:49 ###########


########## Tcl recorder starts at 05/25/23 10:43:46 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" lab10.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/23 10:43:46 ###########


########## Tcl recorder starts at 05/25/23 10:44:26 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" display.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/23 10:44:26 ###########


########## Tcl recorder starts at 05/25/23 10:44:30 ##########

# Commands to make the Process: 
# Lattice Synthesize Verilog File
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
-lib \"work\" -ver lab10.h display.v
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

########## Tcl recorder end at 05/25/23 10:44:30 ###########


########## Tcl recorder starts at 05/25/23 10:46:38 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" display.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/23 10:46:38 ###########


########## Tcl recorder starts at 05/25/23 10:46:42 ##########

# Commands to make the Process: 
# Lattice Synthesize Verilog File
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
-lib \"work\" -ver lab10.h display.v
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

########## Tcl recorder end at 05/25/23 10:46:42 ###########


########## Tcl recorder starts at 05/25/23 10:46:46 ##########

# Commands to make the Process: 
# Compile EDIF File
if [runCmd "\"$cpld_bin/edif2blf\" -edf DISPLAY.edi -out DISPLAY.bl0 -err automake.err -log DISPLAY.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/23 10:46:46 ###########


########## Tcl recorder starts at 05/25/23 10:46:48 ##########

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

########## Tcl recorder end at 05/25/23 10:46:48 ###########


########## Tcl recorder starts at 05/25/23 10:50:27 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" lab10.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/23 10:50:27 ###########


########## Tcl recorder starts at 05/25/23 11:18:27 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup lab10.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bls\" -o \"lab10.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i lab10.bl0 -o lab10.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
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
if [runCmd "\"$cpld_bin/mblifopt\" KEYBOARD.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod lab10 @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i lab10.bl5 -o lab10.sif"] {
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
	puts $rspFile "-nodal -src lab10.bl5 -type BLIF -presrc lab10.bl3 -crf lab10.crf -sif lab10.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci lab10.lct
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

########## Tcl recorder end at 05/25/23 11:18:27 ###########


########## Tcl recorder starts at 05/25/23 11:21:19 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4s_256_64 -family lc4k -mod lab10 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/23 11:21:19 ###########


########## Tcl recorder starts at 05/26/23 08:55:56 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 08:55:56 ###########


########## Tcl recorder starts at 05/26/23 08:56:02 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KEYBOARD_lse.env w} rspFile] {
	puts stderr "Cannot create response file KEYBOARD_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open KEYBOARD.synproj w} rspFile] {
	puts stderr "Cannot create response file KEYBOARD.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top KEYBOARD
-lib \"work\" -ver lab10.h keyboard.v
-output_edif KEYBOARD.edi
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
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"KEYBOARD.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KEYBOARD_lse.env
file delete KEYBOARD.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf KEYBOARD.edi -out KEYBOARD.bl0 -err automake.err -log KEYBOARD.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KEYBOARD.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod lab10 @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4s_256_64 -family lc4k -mod lab10 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 08:56:02 ###########


########## Tcl recorder starts at 05/26/23 08:58:33 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 08:58:33 ###########


########## Tcl recorder starts at 05/26/23 08:58:48 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KEYBOARD_lse.env w} rspFile] {
	puts stderr "Cannot create response file KEYBOARD_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open KEYBOARD.synproj w} rspFile] {
	puts stderr "Cannot create response file KEYBOARD.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top KEYBOARD
-lib \"work\" -ver lab10.h keyboard.v
-output_edif KEYBOARD.edi
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
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"KEYBOARD.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KEYBOARD_lse.env
file delete KEYBOARD.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf KEYBOARD.edi -out KEYBOARD.bl0 -err automake.err -log KEYBOARD.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KEYBOARD.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod lab10 @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4s_256_64 -family lc4k -mod lab10 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 08:58:48 ###########


########## Tcl recorder starts at 05/26/23 10:25:58 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup lab10.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bls\" -o \"lab10.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i lab10.bl0 -o lab10.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
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
-lib \"work\" -ver lab10.h display.v
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf DISPLAY.edi -out DISPLAY.bl0 -err automake.err -log DISPLAY.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [catch {open KEYBOARD_lse.env w} rspFile] {
	puts stderr "Cannot create response file KEYBOARD_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open KEYBOARD.synproj w} rspFile] {
	puts stderr "Cannot create response file KEYBOARD.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top KEYBOARD
-lib \"work\" -ver lab10.h keyboard.v
-output_edif KEYBOARD.edi
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
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"KEYBOARD.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KEYBOARD_lse.env
file delete KEYBOARD.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf KEYBOARD.edi -out KEYBOARD.bl0 -err automake.err -log KEYBOARD.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KEYBOARD.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod lab10 @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4s_256_64 -family lc4k -mod lab10 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 10:25:58 ###########


########## Tcl recorder starts at 05/26/23 10:32:27 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup lab10.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bls\" -o \"lab10.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i lab10.bl0 -o lab10.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
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
-lib \"work\" -ver lab10.h display.v
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf DISPLAY.edi -out DISPLAY.bl0 -err automake.err -log DISPLAY.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [catch {open KEYBOARD_lse.env w} rspFile] {
	puts stderr "Cannot create response file KEYBOARD_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open KEYBOARD.synproj w} rspFile] {
	puts stderr "Cannot create response file KEYBOARD.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top KEYBOARD
-lib \"work\" -ver lab10.h keyboard.v
-output_edif KEYBOARD.edi
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
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"KEYBOARD.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KEYBOARD_lse.env
file delete KEYBOARD.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf KEYBOARD.edi -out KEYBOARD.bl0 -err automake.err -log KEYBOARD.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KEYBOARD.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod lab10 @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4s_256_64 -family lc4k -mod lab10 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 10:32:27 ###########


########## Tcl recorder starts at 05/26/23 10:45:57 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 10:45:57 ###########


########## Tcl recorder starts at 05/26/23 10:46:02 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KEYBOARD_lse.env w} rspFile] {
	puts stderr "Cannot create response file KEYBOARD_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open KEYBOARD.synproj w} rspFile] {
	puts stderr "Cannot create response file KEYBOARD.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top KEYBOARD
-lib \"work\" -ver lab10.h keyboard.v
-output_edif KEYBOARD.edi
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
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"KEYBOARD.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KEYBOARD_lse.env
file delete KEYBOARD.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf KEYBOARD.edi -out KEYBOARD.bl0 -err automake.err -log KEYBOARD.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KEYBOARD.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod lab10 @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4s_256_64 -family lc4k -mod lab10 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 10:46:02 ###########


########## Tcl recorder starts at 05/26/23 10:46:57 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4s_256_64 -family lc4k -mod lab10 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 10:46:57 ###########


########## Tcl recorder starts at 05/26/23 10:47:21 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup lab10.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bls\" -o \"lab10.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i lab10.bl0 -o lab10.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
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
-lib \"work\" -ver lab10.h display.v
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf DISPLAY.edi -out DISPLAY.bl0 -err automake.err -log DISPLAY.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [catch {open KEYBOARD_lse.env w} rspFile] {
	puts stderr "Cannot create response file KEYBOARD_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open KEYBOARD.synproj w} rspFile] {
	puts stderr "Cannot create response file KEYBOARD.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top KEYBOARD
-lib \"work\" -ver lab10.h keyboard.v
-output_edif KEYBOARD.edi
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
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"KEYBOARD.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KEYBOARD_lse.env
file delete KEYBOARD.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf KEYBOARD.edi -out KEYBOARD.bl0 -err automake.err -log KEYBOARD.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KEYBOARD.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod lab10 @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4s_256_64 -family lc4k -mod lab10 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 10:47:21 ###########


########## Tcl recorder starts at 05/26/23 10:48:53 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4s_256_64 -family lc4k -mod lab10 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 10:48:53 ###########


########## Tcl recorder starts at 05/26/23 10:49:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 10:49:17 ###########


########## Tcl recorder starts at 05/26/23 10:49:22 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup lab10.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bls\" -o \"lab10.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i lab10.bl0 -o lab10.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
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
-lib \"work\" -ver lab10.h display.v
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf DISPLAY.edi -out DISPLAY.bl0 -err automake.err -log DISPLAY.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [catch {open KEYBOARD_lse.env w} rspFile] {
	puts stderr "Cannot create response file KEYBOARD_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open KEYBOARD.synproj w} rspFile] {
	puts stderr "Cannot create response file KEYBOARD.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top KEYBOARD
-lib \"work\" -ver lab10.h keyboard.v
-output_edif KEYBOARD.edi
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
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"KEYBOARD.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KEYBOARD_lse.env
file delete KEYBOARD.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf KEYBOARD.edi -out KEYBOARD.bl0 -err automake.err -log KEYBOARD.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KEYBOARD.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod lab10 @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4s_256_64 -family lc4k -mod lab10 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 10:49:22 ###########


########## Tcl recorder starts at 05/26/23 10:50:21 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 10:50:21 ###########


########## Tcl recorder starts at 05/26/23 10:50:25 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KEYBOARD_lse.env w} rspFile] {
	puts stderr "Cannot create response file KEYBOARD_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open KEYBOARD.synproj w} rspFile] {
	puts stderr "Cannot create response file KEYBOARD.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top KEYBOARD
-lib \"work\" -ver lab10.h keyboard.v
-output_edif KEYBOARD.edi
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
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"KEYBOARD.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KEYBOARD_lse.env
file delete KEYBOARD.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf KEYBOARD.edi -out KEYBOARD.bl0 -err automake.err -log KEYBOARD.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KEYBOARD.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod lab10 @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4s_256_64 -family lc4k -mod lab10 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 10:50:25 ###########


########## Tcl recorder starts at 05/26/23 10:57:22 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 10:57:22 ###########


########## Tcl recorder starts at 05/26/23 10:57:35 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KEYBOARD_lse.env w} rspFile] {
	puts stderr "Cannot create response file KEYBOARD_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open KEYBOARD.synproj w} rspFile] {
	puts stderr "Cannot create response file KEYBOARD.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top KEYBOARD
-lib \"work\" -ver lab10.h keyboard.v
-output_edif KEYBOARD.edi
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
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"KEYBOARD.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KEYBOARD_lse.env
file delete KEYBOARD.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf KEYBOARD.edi -out KEYBOARD.bl0 -err automake.err -log KEYBOARD.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KEYBOARD.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod lab10 @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4s_256_64 -family lc4k -mod lab10 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 10:57:35 ###########


########## Tcl recorder starts at 05/26/23 10:57:58 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 10:57:58 ###########


########## Tcl recorder starts at 05/26/23 10:58:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 10:58:07 ###########


########## Tcl recorder starts at 05/26/23 10:59:55 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 10:59:55 ###########


########## Tcl recorder starts at 05/26/23 10:59:58 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KEYBOARD_lse.env w} rspFile] {
	puts stderr "Cannot create response file KEYBOARD_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open KEYBOARD.synproj w} rspFile] {
	puts stderr "Cannot create response file KEYBOARD.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top KEYBOARD
-lib \"work\" -ver lab10.h keyboard.v
-output_edif KEYBOARD.edi
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
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"KEYBOARD.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KEYBOARD_lse.env
file delete KEYBOARD.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf KEYBOARD.edi -out KEYBOARD.bl0 -err automake.err -log KEYBOARD.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KEYBOARD.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod lab10 @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4s_256_64 -family lc4k -mod lab10 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 10:59:58 ###########


########## Tcl recorder starts at 05/26/23 11:12:09 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 11:12:09 ###########


########## Tcl recorder starts at 05/26/23 11:12:14 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open KEYBOARD_lse.env w} rspFile] {
	puts stderr "Cannot create response file KEYBOARD_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open KEYBOARD.synproj w} rspFile] {
	puts stderr "Cannot create response file KEYBOARD.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top KEYBOARD
-lib \"work\" -ver lab10.h keyboard.v
-output_edif KEYBOARD.edi
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
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"KEYBOARD.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KEYBOARD_lse.env
file delete KEYBOARD.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf KEYBOARD.edi -out KEYBOARD.bl0 -err automake.err -log KEYBOARD.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KEYBOARD.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod lab10 @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4s_256_64 -family lc4k -mod lab10 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 11:12:14 ###########


########## Tcl recorder starts at 05/26/23 11:19:21 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" display.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 11:19:21 ###########


########## Tcl recorder starts at 05/26/23 11:19:26 ##########

# Commands to make the Process: 
# Lattice Synthesize Verilog File
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
-lib \"work\" -ver lab10.h display.v
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

########## Tcl recorder end at 05/26/23 11:19:26 ###########


########## Tcl recorder starts at 05/26/23 11:19:31 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/edif2blf\" -edf DISPLAY.edi -out DISPLAY.bl0 -err automake.err -log DISPLAY.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod lab10 @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4s_256_64 -family lc4k -mod lab10 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 11:19:31 ###########


########## Tcl recorder starts at 05/26/23 11:26:24 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" lab10.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 11:26:24 ###########


########## Tcl recorder starts at 05/26/23 11:26:27 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup lab10.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bls\" -o \"lab10.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i lab10.bl0 -o lab10.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod lab10 @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4s_256_64 -family lc4k -mod lab10 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 11:26:27 ###########


########## Tcl recorder starts at 05/26/23 11:30:42 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" display.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 11:30:42 ###########


########## Tcl recorder starts at 05/26/23 11:30:46 ##########

# Commands to make the Process: 
# Fit Design
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
-lib \"work\" -ver lab10.h display.v
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf DISPLAY.edi -out DISPLAY.bl0 -err automake.err -log DISPLAY.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod lab10 @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4s_256_64 -family lc4k -mod lab10 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 11:30:46 ###########


########## Tcl recorder starts at 05/26/23 11:33:33 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" display.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 11:33:33 ###########


########## Tcl recorder starts at 05/26/23 11:33:43 ##########

# Commands to make the Process: 
# Fit Design
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
-lib \"work\" -ver lab10.h display.v
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf DISPLAY.edi -out DISPLAY.bl0 -err automake.err -log DISPLAY.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod lab10 @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4s_256_64 -family lc4k -mod lab10 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 11:33:43 ###########


########## Tcl recorder starts at 05/26/23 11:53:30 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 11:53:30 ###########


########## Tcl recorder starts at 05/26/23 11:53:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 11:53:41 ###########


########## Tcl recorder starts at 05/26/23 11:53:50 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" KEYBOARD"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 11:53:50 ###########


########## Tcl recorder starts at 05/26/23 11:53:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" lab10.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 11:53:59 ###########


########## Tcl recorder starts at 05/26/23 11:54:00 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" lab10.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 11:54:00 ###########


########## Tcl recorder starts at 05/26/23 11:54:55 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" lab10.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 11:54:55 ###########


########## Tcl recorder starts at 05/26/23 11:55:01 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup lab10.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bls\" -o \"lab10.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i lab10.bl0 -o lab10.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open KEYBOARD_lse.env w} rspFile] {
	puts stderr "Cannot create response file KEYBOARD_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open KEYBOARD.synproj w} rspFile] {
	puts stderr "Cannot create response file KEYBOARD.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top KEYBOARD
-lib \"work\" -ver lab10.h keyboard.v
-output_edif KEYBOARD.edi
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
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"KEYBOARD.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KEYBOARD_lse.env
file delete KEYBOARD.synproj
if [runCmd "\"$cpld_bin/edif2blf\" -edf KEYBOARD.edi -out KEYBOARD.bl0 -err automake.err -log KEYBOARD.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KEYBOARD.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod lab10 @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i lab10.bl5 -o lab10.sif"] {
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
	puts $rspFile "-nodal -src lab10.bl5 -type BLIF -presrc lab10.bl3 -crf lab10.crf -sif lab10.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci lab10.lct
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

########## Tcl recorder end at 05/26/23 11:55:01 ###########


########## Tcl recorder starts at 05/26/23 11:56:34 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4s_256_64 -family lc4k -mod lab10 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 11:56:34 ###########


########## Tcl recorder starts at 05/26/23 12:01:50 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" display.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/sch2jhd\" lab10.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 12:01:50 ###########


########## Tcl recorder starts at 05/26/23 12:01:51 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup lab10.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bls\" -o \"lab10.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i lab10.bl0 -o lab10.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
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
	puts $rspFile "STYFILENAME: lab10.sty
PROJECT: DISPLAY
WORKING_PATH: \"$proj_dir\"
MODULE: DISPLAY
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab10.h display.v
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf DISPLAY.edi -out DISPLAY.bl0 -err automake.err -log DISPLAY.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [catch {open KEYBOARD.cmd w} rspFile] {
	puts stderr "Cannot create response file KEYBOARD.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab10.sty
PROJECT: KEYBOARD
WORKING_PATH: \"$proj_dir\"
MODULE: KEYBOARD
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab10.h keyboard.v
OUTPUT_FILE_NAME: KEYBOARD
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e KEYBOARD -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete KEYBOARD.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf KEYBOARD.edi -out KEYBOARD.bl0 -err automake.err -log KEYBOARD.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" KEYBOARD.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod lab10 @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i lab10.bl5 -o lab10.sif"] {
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
	puts $rspFile "-nodal -src lab10.bl5 -type BLIF -presrc lab10.bl3 -crf lab10.crf -sif lab10.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci lab10.lct
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

########## Tcl recorder end at 05/26/23 12:01:51 ###########


########## Tcl recorder starts at 05/26/23 12:04:56 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4s_256_64 -family lc4k -mod lab10 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 12:04:56 ###########

