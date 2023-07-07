
########## Tcl recorder starts at 05/25/23 00:07:12 ##########

set version "2.1"
set proj_dir "D:/isp/lab9"
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
if [runCmd "\"$cpld_bin/vlog2jhd\" serial.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/23 00:07:12 ###########


########## Tcl recorder starts at 05/25/23 00:07:14 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" serial.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/23 00:07:14 ###########


########## Tcl recorder starts at 05/25/23 00:07:18 ##########

# Commands to make the Process: 
# Lattice Synthesize Verilog File
if [catch {open SERIAL_lse.env w} rspFile] {
	puts stderr "Cannot create response file SERIAL_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open SERIAL.synproj w} rspFile] {
	puts stderr "Cannot create response file SERIAL.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top SERIAL
-lib \"work\" -ver lab9.h serial.v
-output_edif SERIAL.edi
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
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"SERIAL.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete SERIAL_lse.env
file delete SERIAL.synproj

########## Tcl recorder end at 05/25/23 00:07:18 ###########


########## Tcl recorder starts at 05/25/23 00:08:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" serial.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/23 00:08:34 ###########


########## Tcl recorder starts at 05/25/23 00:10:19 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" serial.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/23 00:10:19 ###########


########## Tcl recorder starts at 05/25/23 00:10:20 ##########

# Commands to make the Process: 
# Lattice Synthesize Verilog File
if [catch {open SERIAL_lse.env w} rspFile] {
	puts stderr "Cannot create response file SERIAL_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open SERIAL.synproj w} rspFile] {
	puts stderr "Cannot create response file SERIAL.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top SERIAL
-lib \"work\" -ver lab9.h serial.v
-output_edif SERIAL.edi
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
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"SERIAL.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete SERIAL_lse.env
file delete SERIAL.synproj

########## Tcl recorder end at 05/25/23 00:10:20 ###########


########## Tcl recorder starts at 05/25/23 00:10:25 ##########

# Commands to make the Process: 
# Compile EDIF File
if [runCmd "\"$cpld_bin/edif2blf\" -edf SERIAL.edi -out SERIAL.bl0 -err automake.err -log SERIAL.log -prj lab9 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/23 00:10:25 ###########


########## Tcl recorder starts at 05/25/23 00:10:29 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" SERIAL"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/23 00:10:29 ###########


########## Tcl recorder starts at 05/25/23 00:11:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" lab.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/23 00:11:12 ###########


########## Tcl recorder starts at 05/25/23 00:13:43 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" deshake.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/23 00:13:43 ###########


########## Tcl recorder starts at 05/25/23 00:13:46 ##########

# Commands to make the Process: 
# Lattice Synthesize Verilog File
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
-lib \"work\" -ver lab9.h deshake.v
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

########## Tcl recorder end at 05/25/23 00:13:46 ###########


########## Tcl recorder starts at 05/25/23 00:13:50 ##########

# Commands to make the Process: 
# Compile EDIF File
if [runCmd "\"$cpld_bin/edif2blf\" -edf DESHAKE.edi -out DESHAKE.bl0 -err automake.err -log DESHAKE.log -prj lab9 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/23 00:13:50 ###########


########## Tcl recorder starts at 05/25/23 00:13:53 ##########

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

########## Tcl recorder end at 05/25/23 00:13:53 ###########


########## Tcl recorder starts at 05/25/23 00:16:03 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" lab.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/23 00:16:03 ###########


########## Tcl recorder starts at 05/25/23 00:16:53 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" display.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/23 00:16:53 ###########


########## Tcl recorder starts at 05/25/23 00:17:32 ##########

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
-lib \"work\" -ver lab9.h display.v
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

########## Tcl recorder end at 05/25/23 00:17:32 ###########


########## Tcl recorder starts at 05/25/23 00:17:36 ##########

# Commands to make the Process: 
# Compile EDIF File
if [runCmd "\"$cpld_bin/edif2blf\" -edf DISPLAY.edi -out DISPLAY.bl0 -err automake.err -log DISPLAY.log -prj lab9 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/23 00:17:36 ###########


########## Tcl recorder starts at 05/25/23 00:17:40 ##########

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

########## Tcl recorder end at 05/25/23 00:17:40 ###########


########## Tcl recorder starts at 05/25/23 00:20:06 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" serial.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/23 00:20:06 ###########


########## Tcl recorder starts at 05/25/23 00:20:08 ##########

# Commands to make the Process: 
# Lattice Synthesize Verilog File
if [catch {open SERIAL_lse.env w} rspFile] {
	puts stderr "Cannot create response file SERIAL_lse.env: $rspFile"
} else {
	puts $rspFile "FOUNDRY=$install_dir/lse
PATH=$install_dir/lse/bin/nt;%PATH%
"
	close $rspFile
}
if [catch {open SERIAL.synproj w} rspFile] {
	puts stderr "Cannot create response file SERIAL.synproj: $rspFile"
} else {
	puts $rspFile "-a ispMACH400ZE
-d LC4256V
-top SERIAL
-lib \"work\" -ver lab9.h serial.v
-output_edif SERIAL.edi
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
if [runCmd "\"$install_dir/lse/bin/nt/synthesis\" -f \"SERIAL.synproj\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete SERIAL_lse.env
file delete SERIAL.synproj

########## Tcl recorder end at 05/25/23 00:20:08 ###########


########## Tcl recorder starts at 05/25/23 00:20:12 ##########

# Commands to make the Process: 
# Compile EDIF File
if [runCmd "\"$cpld_bin/edif2blf\" -edf SERIAL.edi -out SERIAL.bl0 -err automake.err -log SERIAL.log -prj lab9 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/23 00:20:12 ###########


########## Tcl recorder starts at 05/25/23 00:20:14 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" SERIAL"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/23 00:20:14 ###########


########## Tcl recorder starts at 05/25/23 00:20:51 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" lab.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/23 00:20:51 ###########


########## Tcl recorder starts at 05/25/23 00:23:51 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" lab.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/23 00:23:51 ###########


########## Tcl recorder starts at 05/25/23 00:26:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" lab.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/23 00:26:12 ###########


########## Tcl recorder starts at 05/25/23 00:27:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" display.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/23 00:27:29 ###########


########## Tcl recorder starts at 05/25/23 00:28:34 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup lab.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab.bls\" -o \"lab.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i lab.bl0 -o lab.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
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
-lib \"work\" -ver lab9.h display.v
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf DISPLAY.edi -out DISPLAY.bl0 -err automake.err -log DISPLAY.log -prj lab9 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
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
if [runCmd "\"$cpld_bin/mblifopt\" DESHAKE.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" SERIAL.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod lab @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i lab9.bl5 -o lab9.sif"] {
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
	puts $rspFile "-nodal -src lab9.bl5 -type BLIF -presrc lab9.bl3 -crf lab9.crf -sif lab9.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci lab9.lct
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

########## Tcl recorder end at 05/25/23 00:28:34 ###########


########## Tcl recorder starts at 05/25/23 00:33:20 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4s_256_64 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4s_256_64 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4s_256_64 -family lc4k -mod lab -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/25/23 00:33:20 ###########

