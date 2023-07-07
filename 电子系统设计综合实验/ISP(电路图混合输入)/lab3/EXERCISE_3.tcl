
########## Tcl recorder starts at 04/21/23 11:28:27 ##########

set version "2.1"
set proj_dir "F:/EXERCISE_3"
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
if [runCmd "\"$cpld_bin/ahdl2blf\" counter_1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 11:28:27 ###########


########## Tcl recorder starts at 04/21/23 11:29:09 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" counter_1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 11:29:09 ###########


########## Tcl recorder starts at 04/21/23 11:29:54 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" counter_2.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 11:29:54 ###########


########## Tcl recorder starts at 04/21/23 11:30:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" counter_2.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 11:30:34 ###########


########## Tcl recorder starts at 04/21/23 11:31:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" counter_3.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 11:31:16 ###########


########## Tcl recorder starts at 04/21/23 11:31:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" counter_3.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 11:31:35 ###########


########## Tcl recorder starts at 04/21/23 11:31:39 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" counter_3.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 11:31:39 ###########


########## Tcl recorder starts at 04/21/23 11:32:19 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" counter_4.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 11:32:19 ###########


########## Tcl recorder starts at 04/21/23 11:32:37 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" counter_4.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 11:32:37 ###########


########## Tcl recorder starts at 04/21/23 11:32:55 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" counter_1.abl -mod counter_1 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 11:32:55 ###########


########## Tcl recorder starts at 04/21/23 11:32:57 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" counter_1"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 11:32:57 ###########


########## Tcl recorder starts at 04/21/23 11:33:00 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" counter_2.abl -mod counter_2 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 11:33:00 ###########


########## Tcl recorder starts at 04/21/23 11:33:03 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" counter_2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 11:33:03 ###########


########## Tcl recorder starts at 04/21/23 11:33:08 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" counter_3.abl -mod counter_3 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 11:33:08 ###########


########## Tcl recorder starts at 04/21/23 11:33:09 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" counter_3"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 11:33:09 ###########


########## Tcl recorder starts at 04/21/23 11:33:13 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" counter_4.abl -mod counter_4 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 11:33:13 ###########


########## Tcl recorder starts at 04/21/23 11:33:14 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" counter_4"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 11:33:14 ###########


########## Tcl recorder starts at 04/21/23 11:33:46 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" exercise_3.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 11:33:46 ###########


########## Tcl recorder starts at 04/21/23 12:33:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" exercise_3.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 12:33:59 ###########


########## Tcl recorder starts at 04/21/23 12:42:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" exercise_3.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 12:42:35 ###########


########## Tcl recorder starts at 04/21/23 13:15:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" exercise_3.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 13:15:31 ###########


########## Tcl recorder starts at 04/21/23 13:36:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" exercise_3.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 13:36:11 ###########


########## Tcl recorder starts at 04/21/23 13:37:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" exercise_3.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 13:37:47 ###########


########## Tcl recorder starts at 04/21/23 13:58:43 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" exercise_3.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 13:58:43 ###########


########## Tcl recorder starts at 04/21/23 14:11:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" exercise_3.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 14:11:31 ###########


########## Tcl recorder starts at 04/21/23 14:22:38 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" exercise_3.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 14:22:38 ###########


########## Tcl recorder starts at 04/21/23 14:28:38 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" exercise_3.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 14:28:38 ###########


########## Tcl recorder starts at 04/21/23 14:29:02 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" exercise_3.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 14:29:02 ###########


########## Tcl recorder starts at 04/21/23 14:29:43 ##########

# Commands to make the Process: 
# Compile Schematic
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup exercise_3.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"exercise_3.bls\" -o \"exercise_3.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 14:29:43 ###########


########## Tcl recorder starts at 04/21/23 14:29:46 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" exercise_3"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 14:29:46 ###########


########## Tcl recorder starts at 04/21/23 14:45:54 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" exercise_3.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 14:45:54 ###########


########## Tcl recorder starts at 04/21/23 14:46:03 ##########

# Commands to make the Process: 
# Compile Schematic
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup exercise_3.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"exercise_3.bls\" -o \"exercise_3.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 14:46:03 ###########


########## Tcl recorder starts at 04/21/23 14:46:06 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" exercise_3"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 14:46:06 ###########


########## Tcl recorder starts at 04/21/23 14:48:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" exercise_3.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 14:48:12 ###########


########## Tcl recorder starts at 04/21/23 14:48:14 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" exercise_3.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 14:48:14 ###########


########## Tcl recorder starts at 04/21/23 14:48:30 ##########

# Commands to make the Process: 
# Compile Schematic
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup exercise_3.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"exercise_3.bls\" -o \"exercise_3.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 14:48:30 ###########


########## Tcl recorder starts at 04/21/23 14:48:32 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" exercise_3"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 14:48:32 ###########


########## Tcl recorder starts at 04/21/23 14:55:49 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" exercise_3.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 14:55:49 ###########


########## Tcl recorder starts at 04/21/23 15:04:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" exercise_3.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 15:04:41 ###########


########## Tcl recorder starts at 04/21/23 15:04:42 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" exercise_3.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 15:04:42 ###########


########## Tcl recorder starts at 04/21/23 15:04:45 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" exercise_3.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 15:04:45 ###########


########## Tcl recorder starts at 04/21/23 15:04:53 ##########

# Commands to make the Process: 
# Compile Schematic
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup exercise_3.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"exercise_3.bls\" -o \"exercise_3.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 15:04:53 ###########


########## Tcl recorder starts at 04/21/23 15:04:56 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" exercise_3"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 15:04:56 ###########


########## Tcl recorder starts at 04/21/23 15:08:28 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/exp\" -lhdl -ext=.ltv -testpt exercise.wdl -network=exercise_3"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i exercise_3.bl0 -o exercise_3.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" counter_4.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" counter_3.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" counter_2.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" counter_1.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"exercise_3.bl1\" -o \"exercise_3.bl2\" -omod \"exercise_3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj exercise_3 -lci exercise_3.lct -log exercise_3.imp -err automake.err -tti exercise_3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -blifopt exercise_3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" exercise_3.bl2 -sweep -mergefb -err automake.err -o exercise_3.bl3 @exercise_3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -diofft exercise_3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" exercise_3.bl3 -family AMDMACH -idev van -o exercise_3.bl4 -oxrf exercise_3.xrf -err automake.err @exercise_3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -prefit exercise_3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp exercise_3.bl4 -out exercise_3.bl5 -err automake.err -log exercise_3.log -mod exercise_3 @exercise_3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk exercise.ltv -map exercise_3.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 15:08:28 ###########


########## Tcl recorder starts at 04/21/23 15:09:15 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" exercise_3.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 15:09:15 ###########


########## Tcl recorder starts at 04/21/23 15:16:58 ##########

# Commands to make the Process: 
# Compile Schematic
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup exercise_3.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"exercise_3.bls\" -o \"exercise_3.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 15:16:58 ###########


########## Tcl recorder starts at 04/21/23 15:16:59 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" exercise_3"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 15:16:59 ###########


########## Tcl recorder starts at 04/21/23 15:17:18 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/mblifopt\" -i exercise_3.bl0 -o exercise_3.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"exercise_3.bl1\" -o \"exercise_3.bl2\" -omod \"exercise_3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj exercise_3 -lci exercise_3.lct -log exercise_3.imp -err automake.err -tti exercise_3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -blifopt exercise_3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" exercise_3.bl2 -sweep -mergefb -err automake.err -o exercise_3.bl3 @exercise_3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -diofft exercise_3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" exercise_3.bl3 -family AMDMACH -idev van -o exercise_3.bl4 -oxrf exercise_3.xrf -err automake.err @exercise_3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -prefit exercise_3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp exercise_3.bl4 -out exercise_3.bl5 -err automake.err -log exercise_3.log -mod exercise_3 @exercise_3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open exercise_3.rs1 w} rspFile] {
	puts stderr "Cannot create response file exercise_3.rs1: $rspFile"
} else {
	puts $rspFile "-i exercise_3.bl5 -lci exercise_3.lct -d m4s_256_64 -lco exercise_3.lco -html_rpt -fti exercise_3.fti -fmt PLA -tto exercise_3.tt4 -nojed -eqn exercise_3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open exercise_3.rs2 w} rspFile] {
	puts stderr "Cannot create response file exercise_3.rs2: $rspFile"
} else {
	puts $rspFile "-i exercise_3.bl5 -lci exercise_3.lct -d m4s_256_64 -lco exercise_3.lco -html_rpt -fti exercise_3.fti -fmt PLA -tto exercise_3.tt4 -eqn exercise_3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@exercise_3.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete exercise_3.rs1
file delete exercise_3.rs2
if [runCmd "\"$cpld_bin/tda\" -i exercise_3.bl5 -o exercise_3.tda -lci exercise_3.lct -dev m4s_256_64 -family lc4k -mod exercise_3 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj exercise_3 -if exercise_3.jed -j2s -log exercise_3.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 15:17:18 ###########


########## Tcl recorder starts at 04/21/23 15:17:34 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i exercise_3.bl5 -o exercise_3.sif"] {
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
	puts $rspFile "-nodal -src exercise_3.bl5 -type BLIF -presrc exercise_3.bl3 -crf exercise_3.crf -sif exercise_3.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci exercise_3.lct
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

########## Tcl recorder end at 04/21/23 15:17:34 ###########


########## Tcl recorder starts at 04/21/23 15:23:56 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open exercise_3.rs1 w} rspFile] {
	puts stderr "Cannot create response file exercise_3.rs1: $rspFile"
} else {
	puts $rspFile "-i exercise_3.bl5 -lci exercise_3.lct -d m4s_256_64 -lco exercise_3.lco -html_rpt -fti exercise_3.fti -fmt PLA -tto exercise_3.tt4 -nojed -eqn exercise_3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open exercise_3.rs2 w} rspFile] {
	puts stderr "Cannot create response file exercise_3.rs2: $rspFile"
} else {
	puts $rspFile "-i exercise_3.bl5 -lci exercise_3.lct -d m4s_256_64 -lco exercise_3.lco -html_rpt -fti exercise_3.fti -fmt PLA -tto exercise_3.tt4 -eqn exercise_3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@exercise_3.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete exercise_3.rs1
file delete exercise_3.rs2
if [runCmd "\"$cpld_bin/tda\" -i exercise_3.bl5 -o exercise_3.tda -lci exercise_3.lct -dev m4s_256_64 -family lc4k -mod exercise_3 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj exercise_3 -if exercise_3.jed -j2s -log exercise_3.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 15:23:56 ###########


########## Tcl recorder starts at 04/21/23 17:14:06 ##########

set version "2.1"
set proj_dir "D:/isp/exersize"
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
if [runCmd "\"$cpld_bin/sch2jhd\" exercise_3.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 17:14:06 ###########


########## Tcl recorder starts at 04/21/23 17:15:01 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 17:15:01 ###########


########## Tcl recorder starts at 04/21/23 17:15:08 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 17:15:08 ###########


########## Tcl recorder starts at 04/21/23 17:15:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider2.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 17:15:34 ###########


########## Tcl recorder starts at 04/21/23 17:17:10 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 17:17:10 ###########


########## Tcl recorder starts at 04/21/23 17:25:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 17:25:35 ###########


########## Tcl recorder starts at 04/21/23 17:26:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 17:26:16 ###########


########## Tcl recorder starts at 04/21/23 17:26:45 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 17:26:45 ###########


########## Tcl recorder starts at 04/21/23 17:30:08 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 17:30:08 ###########


########## Tcl recorder starts at 04/21/23 17:30:39 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 17:30:39 ###########


########## Tcl recorder starts at 04/21/23 17:30:54 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 17:30:54 ###########


########## Tcl recorder starts at 04/21/23 17:38:57 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -mod DIVIDER1 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 17:38:57 ###########


########## Tcl recorder starts at 04/21/23 17:39:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 17:39:29 ###########


########## Tcl recorder starts at 04/21/23 17:49:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 17:49:34 ###########


########## Tcl recorder starts at 04/21/23 17:50:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 17:50:20 ###########


########## Tcl recorder starts at 04/21/23 17:51:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 17:51:07 ###########


########## Tcl recorder starts at 04/21/23 17:51:10 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 17:51:10 ###########


########## Tcl recorder starts at 04/21/23 17:51:17 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -mod DIVIDER1 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 17:51:17 ###########


########## Tcl recorder starts at 04/21/23 17:55:48 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 17:55:48 ###########


########## Tcl recorder starts at 04/21/23 18:00:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 18:00:17 ###########


########## Tcl recorder starts at 04/21/23 18:01:13 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 18:01:14 ###########


########## Tcl recorder starts at 04/21/23 18:01:15 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 18:01:15 ###########


########## Tcl recorder starts at 04/21/23 18:01:19 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 18:01:19 ###########


########## Tcl recorder starts at 04/21/23 18:13:14 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 18:13:14 ###########


########## Tcl recorder starts at 04/21/23 18:13:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 18:13:41 ###########


########## Tcl recorder starts at 04/21/23 18:14:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 18:14:11 ###########


########## Tcl recorder starts at 04/21/23 18:14:15 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -mod DIVIDER1 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 18:14:15 ###########


########## Tcl recorder starts at 04/21/23 18:15:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 18:15:07 ###########


########## Tcl recorder starts at 04/21/23 18:15:13 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 18:15:13 ###########


########## Tcl recorder starts at 04/21/23 18:15:21 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -mod DIVIDER1 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 18:15:21 ###########


########## Tcl recorder starts at 04/21/23 18:23:46 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 18:23:46 ###########


########## Tcl recorder starts at 04/21/23 18:28:48 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 18:28:48 ###########


########## Tcl recorder starts at 04/21/23 18:28:49 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 18:28:49 ###########


########## Tcl recorder starts at 04/21/23 18:28:56 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -mod DIVIDER1 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 18:28:56 ###########


########## Tcl recorder starts at 04/21/23 18:29:25 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 18:29:25 ###########


########## Tcl recorder starts at 04/21/23 18:29:31 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -mod DIVIDER1 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 18:29:31 ###########


########## Tcl recorder starts at 04/21/23 18:30:21 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 18:30:21 ###########


########## Tcl recorder starts at 04/21/23 18:30:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 18:30:29 ###########


########## Tcl recorder starts at 04/21/23 18:30:39 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 18:30:39 ###########


########## Tcl recorder starts at 04/21/23 18:30:42 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -mod DIVIDER1 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/21/23 18:30:42 ###########


########## Tcl recorder starts at 04/27/23 00:46:22 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -mod DIVIDER1 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 00:46:22 ###########


########## Tcl recorder starts at 04/27/23 00:47:15 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 00:47:15 ###########


########## Tcl recorder starts at 04/27/23 00:47:24 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -mod DIVIDER1 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 00:47:24 ###########


########## Tcl recorder starts at 04/27/23 00:48:13 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 00:48:13 ###########


########## Tcl recorder starts at 04/27/23 00:48:26 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 00:48:26 ###########


########## Tcl recorder starts at 04/27/23 00:48:34 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -mod DIVIDER1 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 00:48:34 ###########


########## Tcl recorder starts at 04/27/23 00:50:37 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 00:50:37 ###########


########## Tcl recorder starts at 04/27/23 00:50:58 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 00:50:58 ###########


########## Tcl recorder starts at 04/27/23 00:51:48 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 00:51:48 ###########


########## Tcl recorder starts at 04/27/23 00:51:56 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -mod DIVIDER1 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 00:51:56 ###########


########## Tcl recorder starts at 04/27/23 00:52:22 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 00:52:22 ###########


########## Tcl recorder starts at 04/27/23 00:52:26 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 00:52:26 ###########


########## Tcl recorder starts at 04/27/23 00:52:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 00:52:29 ###########


########## Tcl recorder starts at 04/27/23 00:52:32 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -mod DIVIDER1 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 00:52:32 ###########


########## Tcl recorder starts at 04/27/23 00:53:21 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 00:53:21 ###########


########## Tcl recorder starts at 04/27/23 00:53:28 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 00:53:28 ###########


########## Tcl recorder starts at 04/27/23 00:53:32 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -mod DIVIDER1 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 00:53:32 ###########


########## Tcl recorder starts at 04/27/23 00:54:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 00:54:47 ###########


########## Tcl recorder starts at 04/27/23 00:55:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 00:55:36 ###########


########## Tcl recorder starts at 04/27/23 00:55:40 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -mod DIVIDER1 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 00:55:40 ###########


########## Tcl recorder starts at 04/27/23 00:56:51 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 00:56:51 ###########


########## Tcl recorder starts at 04/27/23 00:57:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 00:57:34 ###########


########## Tcl recorder starts at 04/27/23 00:57:38 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" divider1.abl -mod DIVIDER1 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 00:57:38 ###########


########## Tcl recorder starts at 04/27/23 00:57:40 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" DIVIDER1"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 00:57:40 ###########


########## Tcl recorder starts at 04/27/23 00:58:01 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" exercise_3.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 00:58:01 ###########


########## Tcl recorder starts at 04/27/23 00:58:13 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" exercise_3.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 00:58:13 ###########


########## Tcl recorder starts at 04/27/23 00:58:56 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" exercise_3.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 00:58:56 ###########


########## Tcl recorder starts at 04/27/23 00:59:30 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" test.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 00:59:30 ###########


########## Tcl recorder starts at 04/27/23 01:14:08 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" test.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:14:08 ###########


########## Tcl recorder starts at 04/27/23 01:15:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:15:31 ###########


########## Tcl recorder starts at 04/27/23 01:15:53 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:15:53 ###########


########## Tcl recorder starts at 04/27/23 01:15:58 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_10.abl -mod DIVIDER_10 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:15:58 ###########


########## Tcl recorder starts at 04/27/23 01:21:03 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/exp\" -lhdl -ext=.ltv -testpt test.wdl -network=exercise_3"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup test.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"test.bls\" -o \"test.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i test.bl0 -o test.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DIVIDER_10.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"test.bl1\" -o \"exercise_3.bl2\" -omod \"exercise_3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj exercise_3 -lci exercise_3.lct -log exercise_3.imp -err automake.err -tti exercise_3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -blifopt exercise_3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" exercise_3.bl2 -sweep -mergefb -err automake.err -o exercise_3.bl3 @exercise_3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -diofft exercise_3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" exercise_3.bl3 -family AMDMACH -idev van -o exercise_3.bl4 -oxrf exercise_3.xrf -err automake.err @exercise_3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -prefit exercise_3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp exercise_3.bl4 -out exercise_3.bl5 -err automake.err -log exercise_3.log -mod test @exercise_3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map test.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:21:03 ###########


########## Tcl recorder starts at 04/27/23 01:21:58 ##########

# Commands to make the Process: 
# Timing Simulation
if [runCmd "\"$cpld_bin/sch2tf\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -prj exercise_3 -ext .lsi test.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"test.bl1\" -o \"exercise_3.bl2\" -omod \"exercise_3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj exercise_3 -lci exercise_3.lct -log exercise_3.imp -err automake.err -tti exercise_3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -blifopt exercise_3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" exercise_3.bl2 -sweep -mergefb -err automake.err -o exercise_3.bl3 @exercise_3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -diofft exercise_3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" exercise_3.bl3 -family AMDMACH -idev van -o exercise_3.bl4 -oxrf exercise_3.xrf -err automake.err @exercise_3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -prefit exercise_3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp exercise_3.bl4 -out exercise_3.bl5 -err automake.err -log exercise_3.log -mod test @exercise_3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open exercise_3.rs1 w} rspFile] {
	puts stderr "Cannot create response file exercise_3.rs1: $rspFile"
} else {
	puts $rspFile "-i exercise_3.bl5 -lci exercise_3.lct -d m4s_256_64 -lco exercise_3.lco -html_rpt -fti exercise_3.fti -fmt PLA -tto exercise_3.tt4 -nojed -eqn exercise_3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open exercise_3.rs2 w} rspFile] {
	puts stderr "Cannot create response file exercise_3.rs2: $rspFile"
} else {
	puts $rspFile "-i exercise_3.bl5 -lci exercise_3.lct -d m4s_256_64 -lco exercise_3.lco -html_rpt -fti exercise_3.fti -fmt PLA -tto exercise_3.tt4 -eqn exercise_3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@exercise_3.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete exercise_3.rs1
file delete exercise_3.rs2
if [runCmd "\"$cpld_bin/tda\" -i exercise_3.bl5 -o exercise_3.tda -lci exercise_3.lct -dev m4s_256_64 -family lc4k -mod test -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open exercise_3.rss w} rspFile] {
	puts stderr "Cannot create response file exercise_3.rss: $rspFile"
} else {
	puts $rspFile "-i \"exercise_3.tt4\" -lib \"$install_dir/ispcpld/dat/lc4k\" -strategy top -sdfmdl \"$install_dir/ispcpld/dat/sdf.mdl\" -simmdl \"$install_dir/ispcpld/dat/sim.mdl\" -pla \"exercise_3.tt4\" -lci \"exercise_3.lct\" -prj \"exercise_3\" -dir \"$proj_dir\" -err automake.err -log \"exercise_3.nrp\" -exf \"test.exf\"  -netlist edif
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/sdf\" \"@exercise_3.rss\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete exercise_3.rss
# Application to view the Process: 
# Timing Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.post5 -ini simcpls.ini -all simcp.post5
-cfg machgen.fdk test.ltv -map test.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:21:59 ###########


########## Tcl recorder starts at 04/27/23 01:22:39 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:22:39 ###########


########## Tcl recorder starts at 04/27/23 01:22:45 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:22:45 ###########


########## Tcl recorder starts at 04/27/23 01:22:58 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:22:58 ###########


########## Tcl recorder starts at 04/27/23 01:23:03 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_10.abl -mod DIVIDER_10 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:23:03 ###########


########## Tcl recorder starts at 04/27/23 01:23:10 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/mblifopt\" DIVIDER_10.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"test.bl1\" -o \"exercise_3.bl2\" -omod \"exercise_3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj exercise_3 -lci exercise_3.lct -log exercise_3.imp -err automake.err -tti exercise_3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -blifopt exercise_3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" exercise_3.bl2 -sweep -mergefb -err automake.err -o exercise_3.bl3 @exercise_3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -diofft exercise_3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" exercise_3.bl3 -family AMDMACH -idev van -o exercise_3.bl4 -oxrf exercise_3.xrf -err automake.err @exercise_3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -prefit exercise_3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp exercise_3.bl4 -out exercise_3.bl5 -err automake.err -log exercise_3.log -mod test @exercise_3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map test.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:23:10 ###########


########## Tcl recorder starts at 04/27/23 01:25:45 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:25:45 ###########


########## Tcl recorder starts at 04/27/23 01:25:48 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:25:48 ###########


########## Tcl recorder starts at 04/27/23 01:25:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:25:59 ###########


########## Tcl recorder starts at 04/27/23 01:26:07 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_10.abl -mod DIVIDER_10 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:26:07 ###########


########## Tcl recorder starts at 04/27/23 01:26:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:26:31 ###########


########## Tcl recorder starts at 04/27/23 01:26:35 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_10.abl -mod DIVIDER_10 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:26:35 ###########


########## Tcl recorder starts at 04/27/23 01:26:42 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/mblifopt\" DIVIDER_10.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"test.bl1\" -o \"exercise_3.bl2\" -omod \"exercise_3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj exercise_3 -lci exercise_3.lct -log exercise_3.imp -err automake.err -tti exercise_3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -blifopt exercise_3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" exercise_3.bl2 -sweep -mergefb -err automake.err -o exercise_3.bl3 @exercise_3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -diofft exercise_3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" exercise_3.bl3 -family AMDMACH -idev van -o exercise_3.bl4 -oxrf exercise_3.xrf -err automake.err @exercise_3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -prefit exercise_3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp exercise_3.bl4 -out exercise_3.bl5 -err automake.err -log exercise_3.log -mod test @exercise_3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map test.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:26:42 ###########


########## Tcl recorder starts at 04/27/23 01:27:07 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map test.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:27:07 ###########


########## Tcl recorder starts at 04/27/23 01:27:15 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map test.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:27:15 ###########


########## Tcl recorder starts at 04/27/23 01:27:33 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map test.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:27:33 ###########


########## Tcl recorder starts at 04/27/23 01:27:51 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map test.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:27:51 ###########


########## Tcl recorder starts at 04/27/23 01:27:59 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map test.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:27:59 ###########


########## Tcl recorder starts at 04/27/23 01:28:10 ##########

# Commands to make the Process: 
# Timing Simulation
if [catch {open exercise_3.rs1 w} rspFile] {
	puts stderr "Cannot create response file exercise_3.rs1: $rspFile"
} else {
	puts $rspFile "-i exercise_3.bl5 -lci exercise_3.lct -d m4s_256_64 -lco exercise_3.lco -html_rpt -fti exercise_3.fti -fmt PLA -tto exercise_3.tt4 -nojed -eqn exercise_3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open exercise_3.rs2 w} rspFile] {
	puts stderr "Cannot create response file exercise_3.rs2: $rspFile"
} else {
	puts $rspFile "-i exercise_3.bl5 -lci exercise_3.lct -d m4s_256_64 -lco exercise_3.lco -html_rpt -fti exercise_3.fti -fmt PLA -tto exercise_3.tt4 -eqn exercise_3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@exercise_3.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete exercise_3.rs1
file delete exercise_3.rs2
if [runCmd "\"$cpld_bin/tda\" -i exercise_3.bl5 -o exercise_3.tda -lci exercise_3.lct -dev m4s_256_64 -family lc4k -mod test -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open exercise_3.rss w} rspFile] {
	puts stderr "Cannot create response file exercise_3.rss: $rspFile"
} else {
	puts $rspFile "-i \"exercise_3.tt4\" -lib \"$install_dir/ispcpld/dat/lc4k\" -strategy top -sdfmdl \"$install_dir/ispcpld/dat/sdf.mdl\" -simmdl \"$install_dir/ispcpld/dat/sim.mdl\" -pla \"exercise_3.tt4\" -lci \"exercise_3.lct\" -prj \"exercise_3\" -dir \"$proj_dir\" -err automake.err -log \"exercise_3.nrp\" -exf \"test.exf\"  -netlist edif
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/sdf\" \"@exercise_3.rss\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete exercise_3.rss
# Application to view the Process: 
# Timing Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.post5 -ini simcpls.ini -all simcp.post5
-cfg machgen.fdk test.ltv -map test.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:28:10 ###########


########## Tcl recorder starts at 04/27/23 01:28:18 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map test.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:28:18 ###########


########## Tcl recorder starts at 04/27/23 01:28:21 ##########

# Commands to make the Process: 
# Timing Simulation
# - none -
# Application to view the Process: 
# Timing Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.post5 -ini simcpls.ini -all simcp.post5
-cfg machgen.fdk test.ltv -map test.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:28:21 ###########


########## Tcl recorder starts at 04/27/23 01:29:04 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:29:04 ###########


########## Tcl recorder starts at 04/27/23 01:29:06 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_10.abl -mod DIVIDER_10 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:29:06 ###########


########## Tcl recorder starts at 04/27/23 01:29:10 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/mblifopt\" DIVIDER_10.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"test.bl1\" -o \"exercise_3.bl2\" -omod \"exercise_3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj exercise_3 -lci exercise_3.lct -log exercise_3.imp -err automake.err -tti exercise_3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -blifopt exercise_3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" exercise_3.bl2 -sweep -mergefb -err automake.err -o exercise_3.bl3 @exercise_3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -diofft exercise_3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" exercise_3.bl3 -family AMDMACH -idev van -o exercise_3.bl4 -oxrf exercise_3.xrf -err automake.err @exercise_3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -prefit exercise_3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp exercise_3.bl4 -out exercise_3.bl5 -err automake.err -log exercise_3.log -mod test @exercise_3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map test.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:29:10 ###########


########## Tcl recorder starts at 04/27/23 01:30:09 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map test.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:30:09 ###########


########## Tcl recorder starts at 04/27/23 01:30:19 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup exercise_3.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"exercise_3.bls\" -o \"exercise_3.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i exercise_3.bl0 -o exercise_3.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"exercise_3.bl1\" -o \"exercise_3.bl2\" -omod \"exercise_3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj exercise_3 -lci exercise_3.lct -log exercise_3.imp -err automake.err -tti exercise_3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -blifopt exercise_3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" exercise_3.bl2 -sweep -mergefb -err automake.err -o exercise_3.bl3 @exercise_3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -diofft exercise_3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" exercise_3.bl3 -family AMDMACH -idev van -o exercise_3.bl4 -oxrf exercise_3.xrf -err automake.err @exercise_3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -prefit exercise_3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp exercise_3.bl4 -out exercise_3.bl5 -err automake.err -log exercise_3.log -mod exercise_3 @exercise_3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk exercise.ltv -map exercise_3.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:30:19 ###########


########## Tcl recorder starts at 04/27/23 01:31:11 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" DIVIDER_10"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:31:11 ###########


########## Tcl recorder starts at 04/27/23 01:31:19 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/mblflink\" \"test.bl1\" -o \"exercise_3.bl2\" -omod \"exercise_3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj exercise_3 -lci exercise_3.lct -log exercise_3.imp -err automake.err -tti exercise_3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -blifopt exercise_3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" exercise_3.bl2 -sweep -mergefb -err automake.err -o exercise_3.bl3 @exercise_3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -diofft exercise_3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" exercise_3.bl3 -family AMDMACH -idev van -o exercise_3.bl4 -oxrf exercise_3.xrf -err automake.err @exercise_3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -prefit exercise_3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp exercise_3.bl4 -out exercise_3.bl5 -err automake.err -log exercise_3.log -mod test @exercise_3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map test.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:31:19 ###########


########## Tcl recorder starts at 04/27/23 01:31:38 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map test.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:31:38 ###########


########## Tcl recorder starts at 04/27/23 01:31:58 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map test.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:31:58 ###########


########## Tcl recorder starts at 04/27/23 01:33:39 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map test.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:33:39 ###########


########## Tcl recorder starts at 04/27/23 01:34:04 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:34:04 ###########


########## Tcl recorder starts at 04/27/23 01:34:07 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_10.abl -mod DIVIDER_10 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:34:07 ###########


########## Tcl recorder starts at 04/27/23 01:34:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:34:17 ###########


########## Tcl recorder starts at 04/27/23 01:34:19 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_10.abl -mod DIVIDER_10 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:34:19 ###########


########## Tcl recorder starts at 04/27/23 01:34:25 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/mblifopt\" DIVIDER_10.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"test.bl1\" -o \"exercise_3.bl2\" -omod \"exercise_3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj exercise_3 -lci exercise_3.lct -log exercise_3.imp -err automake.err -tti exercise_3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -blifopt exercise_3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" exercise_3.bl2 -sweep -mergefb -err automake.err -o exercise_3.bl3 @exercise_3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -diofft exercise_3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" exercise_3.bl3 -family AMDMACH -idev van -o exercise_3.bl4 -oxrf exercise_3.xrf -err automake.err @exercise_3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -prefit exercise_3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp exercise_3.bl4 -out exercise_3.bl5 -err automake.err -log exercise_3.log -mod test @exercise_3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map test.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:34:25 ###########


########## Tcl recorder starts at 04/27/23 01:43:52 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map test.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:43:52 ###########


########## Tcl recorder starts at 04/27/23 01:44:18 ##########

# Commands to make the Process: 
# Check Syntax
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_10.abl -mod DIVIDER_10 -syn  -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:44:18 ###########


########## Tcl recorder starts at 04/27/23 01:44:21 ##########

# Commands to make the Process: 
# Compiler Listing
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_10.abl -mod DIVIDER_10 -syn -list  -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:44:21 ###########


########## Tcl recorder starts at 04/27/23 01:44:24 ##########

# Commands to make the Process: 
# Compiled Equations
if [runCmd "\"$cpld_bin/blif2eqn\" DIVIDER_10.bl0 -o DIVIDER_10.eq0  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:44:24 ###########


########## Tcl recorder starts at 04/27/23 01:46:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:46:11 ###########


########## Tcl recorder starts at 04/27/23 01:46:42 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:46:42 ###########


########## Tcl recorder starts at 04/27/23 01:46:49 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_10.abl -mod DIVIDER_10 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:46:49 ###########


########## Tcl recorder starts at 04/27/23 01:47:23 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/mblifopt\" DIVIDER_10.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"test.bl1\" -o \"exercise_3.bl2\" -omod \"exercise_3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj exercise_3 -lci exercise_3.lct -log exercise_3.imp -err automake.err -tti exercise_3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -blifopt exercise_3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" exercise_3.bl2 -sweep -mergefb -err automake.err -o exercise_3.bl3 @exercise_3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -diofft exercise_3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" exercise_3.bl3 -family AMDMACH -idev van -o exercise_3.bl4 -oxrf exercise_3.xrf -err automake.err @exercise_3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -prefit exercise_3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp exercise_3.bl4 -out exercise_3.bl5 -err automake.err -log exercise_3.log -mod test @exercise_3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map test.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:47:23 ###########


########## Tcl recorder starts at 04/27/23 01:47:38 ##########

# Commands to make the Process: 
# Compiled Equations
if [runCmd "\"$cpld_bin/blif2eqn\" DIVIDER_10.bl0 -o DIVIDER_10.eq0  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:47:38 ###########


########## Tcl recorder starts at 04/27/23 01:48:34 ##########

# Commands to make the Process: 
# Compiled Equations
if [runCmd "\"$cpld_bin/blif2eqn\" counter_4.bl0 -o counter_4.eq0  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:48:34 ###########


########## Tcl recorder starts at 04/27/23 01:48:40 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" DIVIDER_10"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:48:40 ###########


########## Tcl recorder starts at 04/27/23 01:48:51 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map test.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:48:51 ###########


########## Tcl recorder starts at 04/27/23 01:48:56 ##########

# Commands to make the Process: 
# Timing Simulation
if [catch {open exercise_3.rs1 w} rspFile] {
	puts stderr "Cannot create response file exercise_3.rs1: $rspFile"
} else {
	puts $rspFile "-i exercise_3.bl5 -lci exercise_3.lct -d m4s_256_64 -lco exercise_3.lco -html_rpt -fti exercise_3.fti -fmt PLA -tto exercise_3.tt4 -nojed -eqn exercise_3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open exercise_3.rs2 w} rspFile] {
	puts stderr "Cannot create response file exercise_3.rs2: $rspFile"
} else {
	puts $rspFile "-i exercise_3.bl5 -lci exercise_3.lct -d m4s_256_64 -lco exercise_3.lco -html_rpt -fti exercise_3.fti -fmt PLA -tto exercise_3.tt4 -eqn exercise_3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@exercise_3.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete exercise_3.rs1
file delete exercise_3.rs2
if [runCmd "\"$cpld_bin/tda\" -i exercise_3.bl5 -o exercise_3.tda -lci exercise_3.lct -dev m4s_256_64 -family lc4k -mod test -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open exercise_3.rss w} rspFile] {
	puts stderr "Cannot create response file exercise_3.rss: $rspFile"
} else {
	puts $rspFile "-i \"exercise_3.tt4\" -lib \"$install_dir/ispcpld/dat/lc4k\" -strategy top -sdfmdl \"$install_dir/ispcpld/dat/sdf.mdl\" -simmdl \"$install_dir/ispcpld/dat/sim.mdl\" -pla \"exercise_3.tt4\" -lci \"exercise_3.lct\" -prj \"exercise_3\" -dir \"$proj_dir\" -err automake.err -log \"exercise_3.nrp\" -exf \"test.exf\"  -netlist edif
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/sdf\" \"@exercise_3.rss\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete exercise_3.rss
# Application to view the Process: 
# Timing Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.post5 -ini simcpls.ini -all simcp.post5
-cfg machgen.fdk test.ltv -map test.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:48:56 ###########


########## Tcl recorder starts at 04/27/23 01:54:33 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" test.abv -vec -ovec test.tmv -sim EXERCISE_3 -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:54:33 ###########


########## Tcl recorder starts at 04/27/23 01:55:11 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" test.abv -vec -ovec test.tmv -sim EXERCISE_3 -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:55:11 ###########


########## Tcl recorder starts at 04/27/23 01:55:30 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" test.abv -vec -ovec test.tmv -sim EXERCISE_3 -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:55:30 ###########


########## Tcl recorder starts at 04/27/23 01:55:33 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup test.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"test.bls\" -o \"test.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i test.bl0 -o test.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_10.abl -mod DIVIDER_10 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DIVIDER_10.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"test.bl1\" -o \"exercise_3.bl2\" -omod \"exercise_3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj exercise_3 -lci exercise_3.lct -log exercise_3.imp -err automake.err -tti exercise_3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -blifopt exercise_3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" exercise_3.bl2 -sweep -mergefb -err automake.err -o exercise_3.bl3 @exercise_3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -diofft exercise_3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" exercise_3.bl3 -family AMDMACH -idev van -o exercise_3.bl4 -oxrf exercise_3.xrf -err automake.err @exercise_3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -prefit exercise_3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp exercise_3.bl4 -out exercise_3.bl5 -err automake.err -log exercise_3.log -mod test @exercise_3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.lts -map test.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:55:33 ###########


########## Tcl recorder starts at 04/27/23 01:56:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:56:12 ###########


########## Tcl recorder starts at 04/27/23 01:56:17 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_10.abl -mod DIVIDER_10 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DIVIDER_10.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"test.bl1\" -o \"exercise_3.bl2\" -omod \"exercise_3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj exercise_3 -lci exercise_3.lct -log exercise_3.imp -err automake.err -tti exercise_3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -blifopt exercise_3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" exercise_3.bl2 -sweep -mergefb -err automake.err -o exercise_3.bl3 @exercise_3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -diofft exercise_3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" exercise_3.bl3 -family AMDMACH -idev van -o exercise_3.bl4 -oxrf exercise_3.xrf -err automake.err @exercise_3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -prefit exercise_3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp exercise_3.bl4 -out exercise_3.bl5 -err automake.err -log exercise_3.log -mod test @exercise_3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.lts -map test.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:56:17 ###########


########## Tcl recorder starts at 04/27/23 01:59:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" test.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:59:31 ###########


########## Tcl recorder starts at 04/27/23 01:59:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_5.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 01:59:59 ###########


########## Tcl recorder starts at 04/27/23 02:00:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_5.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 02:00:17 ###########


########## Tcl recorder starts at 04/27/23 02:01:31 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" test.abv -vec -ovec test.tmv -sim EXERCISE_3 -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 02:01:31 ###########


########## Tcl recorder starts at 04/27/23 02:01:32 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup test.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"test.bls\" -o \"test.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i test.bl0 -o test.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_5.abl -mod DIVIDER_5 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DIVIDER_5.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"test.bl1\" -o \"exercise_3.bl2\" -omod \"exercise_3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj exercise_3 -lci exercise_3.lct -log exercise_3.imp -err automake.err -tti exercise_3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -blifopt exercise_3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" exercise_3.bl2 -sweep -mergefb -err automake.err -o exercise_3.bl3 @exercise_3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -diofft exercise_3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" exercise_3.bl3 -family AMDMACH -idev van -o exercise_3.bl4 -oxrf exercise_3.xrf -err automake.err @exercise_3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -prefit exercise_3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp exercise_3.bl4 -out exercise_3.bl5 -err automake.err -log exercise_3.log -mod test @exercise_3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.lts -map test.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 02:01:33 ###########


########## Tcl recorder starts at 04/27/23 02:01:46 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_5.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 02:01:46 ###########


########## Tcl recorder starts at 04/27/23 02:01:51 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_5.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 02:01:51 ###########


########## Tcl recorder starts at 04/27/23 02:01:55 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_5.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 02:01:55 ###########


########## Tcl recorder starts at 04/27/23 02:02:00 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_5.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 02:02:00 ###########


########## Tcl recorder starts at 04/27/23 02:02:07 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_5.abl -mod DIVIDER_5 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 02:02:07 ###########


########## Tcl recorder starts at 04/27/23 02:02:13 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/mblifopt\" DIVIDER_5.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"test.bl1\" -o \"exercise_3.bl2\" -omod \"exercise_3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj exercise_3 -lci exercise_3.lct -log exercise_3.imp -err automake.err -tti exercise_3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -blifopt exercise_3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" exercise_3.bl2 -sweep -mergefb -err automake.err -o exercise_3.bl3 @exercise_3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -diofft exercise_3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" exercise_3.bl3 -family AMDMACH -idev van -o exercise_3.bl4 -oxrf exercise_3.xrf -err automake.err @exercise_3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -prefit exercise_3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp exercise_3.bl4 -out exercise_3.bl5 -err automake.err -log exercise_3.log -mod test @exercise_3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.lts -map test.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 02:02:13 ###########


########## Tcl recorder starts at 04/27/23 02:02:37 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_5.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 02:02:37 ###########


########## Tcl recorder starts at 04/27/23 02:02:41 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_5.abl -mod DIVIDER_5 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 02:02:41 ###########


########## Tcl recorder starts at 04/27/23 02:02:50 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/mblifopt\" DIVIDER_5.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"test.bl1\" -o \"exercise_3.bl2\" -omod \"exercise_3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj exercise_3 -lci exercise_3.lct -log exercise_3.imp -err automake.err -tti exercise_3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -blifopt exercise_3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" exercise_3.bl2 -sweep -mergefb -err automake.err -o exercise_3.bl3 @exercise_3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -diofft exercise_3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" exercise_3.bl3 -family AMDMACH -idev van -o exercise_3.bl4 -oxrf exercise_3.xrf -err automake.err @exercise_3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -prefit exercise_3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp exercise_3.bl4 -out exercise_3.bl5 -err automake.err -log exercise_3.log -mod test @exercise_3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.lts -map test.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 02:02:50 ###########


########## Tcl recorder starts at 04/27/23 02:07:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" exercise_3.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 02:07:16 ###########


########## Tcl recorder starts at 04/27/23 02:11:45 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/exp\" -lhdl -ext=.ltv -testpt test.wdl -network=exercise_3"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup exercise_3.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"exercise_3.bls\" -o \"exercise_3.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i exercise_3.bl0 -o exercise_3.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/ahdl2blf\" counter_4.abl -mod counter_4 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" counter_4.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/ahdl2blf\" counter_3.abl -mod counter_3 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" counter_3.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/ahdl2blf\" counter_2.abl -mod counter_2 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" counter_2.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/ahdl2blf\" counter_1.abl -mod counter_1 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" counter_1.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"exercise_3.bl1\" -o \"exercise_3.bl2\" -omod \"exercise_3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj exercise_3 -lci exercise_3.lct -log exercise_3.imp -err automake.err -tti exercise_3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -blifopt exercise_3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" exercise_3.bl2 -sweep -mergefb -err automake.err -o exercise_3.bl3 @exercise_3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -diofft exercise_3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" exercise_3.bl3 -family AMDMACH -idev van -o exercise_3.bl4 -oxrf exercise_3.xrf -err automake.err @exercise_3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -prefit exercise_3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp exercise_3.bl4 -out exercise_3.bl5 -err automake.err -log exercise_3.log -mod exercise_3 @exercise_3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map exercise_3.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 02:11:45 ###########


########## Tcl recorder starts at 04/27/23 02:21:22 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" exercise_3.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 02:21:22 ###########


########## Tcl recorder starts at 04/27/23 02:22:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" exercise_3.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 02:22:07 ###########


########## Tcl recorder starts at 04/27/23 02:22:09 ##########

# Commands to make the Process: 
# Compile Schematic
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup exercise_3.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"exercise_3.bls\" -o \"exercise_3.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 02:22:09 ###########


########## Tcl recorder starts at 04/27/23 02:24:28 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/mblifopt\" -i exercise_3.bl0 -o exercise_3.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"exercise_3.bl1\" -o \"exercise_3.bl2\" -omod \"exercise_3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj exercise_3 -lci exercise_3.lct -log exercise_3.imp -err automake.err -tti exercise_3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -blifopt exercise_3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" exercise_3.bl2 -sweep -mergefb -err automake.err -o exercise_3.bl3 @exercise_3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -diofft exercise_3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" exercise_3.bl3 -family AMDMACH -idev van -o exercise_3.bl4 -oxrf exercise_3.xrf -err automake.err @exercise_3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -prefit exercise_3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp exercise_3.bl4 -out exercise_3.bl5 -err automake.err -log exercise_3.log -mod exercise_3 @exercise_3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i exercise_3.bl5 -o exercise_3.sif"] {
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
	puts $rspFile "-nodal -src exercise_3.bl5 -type BLIF -presrc exercise_3.bl3 -crf exercise_3.crf -sif exercise_3.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci exercise_3.lct
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

########## Tcl recorder end at 04/27/23 02:24:28 ###########


########## Tcl recorder starts at 04/27/23 02:25:05 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open exercise_3.rs1 w} rspFile] {
	puts stderr "Cannot create response file exercise_3.rs1: $rspFile"
} else {
	puts $rspFile "-i exercise_3.bl5 -lci exercise_3.lct -d m4s_256_64 -lco exercise_3.lco -html_rpt -fti exercise_3.fti -fmt PLA -tto exercise_3.tt4 -nojed -eqn exercise_3.eq3 -tmv test.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open exercise_3.rs2 w} rspFile] {
	puts stderr "Cannot create response file exercise_3.rs2: $rspFile"
} else {
	puts $rspFile "-i exercise_3.bl5 -lci exercise_3.lct -d m4s_256_64 -lco exercise_3.lco -html_rpt -fti exercise_3.fti -fmt PLA -tto exercise_3.tt4 -eqn exercise_3.eq3 -tmv test.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@exercise_3.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete exercise_3.rs1
file delete exercise_3.rs2
if [runCmd "\"$cpld_bin/tda\" -i exercise_3.bl5 -o exercise_3.tda -lci exercise_3.lct -dev m4s_256_64 -family lc4k -mod exercise_3 -ovec test.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj exercise_3 -if exercise_3.jed -j2s -log exercise_3.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 02:25:05 ###########


########## Tcl recorder starts at 04/27/23 02:37:04 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_5.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 02:37:04 ###########


########## Tcl recorder starts at 04/27/23 02:37:14 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_5.abl -mod DIVIDER_5 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 02:37:14 ###########


########## Tcl recorder starts at 04/27/23 02:37:22 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/mblifopt\" DIVIDER_5.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"exercise_3.bl1\" -o \"exercise_3.bl2\" -omod \"exercise_3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj exercise_3 -lci exercise_3.lct -log exercise_3.imp -err automake.err -tti exercise_3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -blifopt exercise_3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" exercise_3.bl2 -sweep -mergefb -err automake.err -o exercise_3.bl3 @exercise_3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -diofft exercise_3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" exercise_3.bl3 -family AMDMACH -idev van -o exercise_3.bl4 -oxrf exercise_3.xrf -err automake.err @exercise_3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -prefit exercise_3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp exercise_3.bl4 -out exercise_3.bl5 -err automake.err -log exercise_3.log -mod exercise_3 @exercise_3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open exercise_3.rs1 w} rspFile] {
	puts stderr "Cannot create response file exercise_3.rs1: $rspFile"
} else {
	puts $rspFile "-i exercise_3.bl5 -lci exercise_3.lct -d m4s_256_64 -lco exercise_3.lco -html_rpt -fti exercise_3.fti -fmt PLA -tto exercise_3.tt4 -nojed -eqn exercise_3.eq3 -tmv test.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open exercise_3.rs2 w} rspFile] {
	puts stderr "Cannot create response file exercise_3.rs2: $rspFile"
} else {
	puts $rspFile "-i exercise_3.bl5 -lci exercise_3.lct -d m4s_256_64 -lco exercise_3.lco -html_rpt -fti exercise_3.fti -fmt PLA -tto exercise_3.tt4 -eqn exercise_3.eq3 -tmv test.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@exercise_3.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete exercise_3.rs1
file delete exercise_3.rs2
if [runCmd "\"$cpld_bin/tda\" -i exercise_3.bl5 -o exercise_3.tda -lci exercise_3.lct -dev m4s_256_64 -family lc4k -mod exercise_3 -ovec test.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj exercise_3 -if exercise_3.jed -j2s -log exercise_3.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 02:37:22 ###########


########## Tcl recorder starts at 04/27/23 02:38:39 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_5.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 02:38:39 ###########


########## Tcl recorder starts at 04/27/23 02:38:42 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_5.abl -mod DIVIDER_5 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 02:38:42 ###########


########## Tcl recorder starts at 04/27/23 02:38:46 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/mblifopt\" DIVIDER_5.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"exercise_3.bl1\" -o \"exercise_3.bl2\" -omod \"exercise_3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj exercise_3 -lci exercise_3.lct -log exercise_3.imp -err automake.err -tti exercise_3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -blifopt exercise_3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" exercise_3.bl2 -sweep -mergefb -err automake.err -o exercise_3.bl3 @exercise_3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -diofft exercise_3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" exercise_3.bl3 -family AMDMACH -idev van -o exercise_3.bl4 -oxrf exercise_3.xrf -err automake.err @exercise_3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -prefit exercise_3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp exercise_3.bl4 -out exercise_3.bl5 -err automake.err -log exercise_3.log -mod exercise_3 @exercise_3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open exercise_3.rs1 w} rspFile] {
	puts stderr "Cannot create response file exercise_3.rs1: $rspFile"
} else {
	puts $rspFile "-i exercise_3.bl5 -lci exercise_3.lct -d m4s_256_64 -lco exercise_3.lco -html_rpt -fti exercise_3.fti -fmt PLA -tto exercise_3.tt4 -nojed -eqn exercise_3.eq3 -tmv test.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open exercise_3.rs2 w} rspFile] {
	puts stderr "Cannot create response file exercise_3.rs2: $rspFile"
} else {
	puts $rspFile "-i exercise_3.bl5 -lci exercise_3.lct -d m4s_256_64 -lco exercise_3.lco -html_rpt -fti exercise_3.fti -fmt PLA -tto exercise_3.tt4 -eqn exercise_3.eq3 -tmv test.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@exercise_3.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete exercise_3.rs1
file delete exercise_3.rs2
if [runCmd "\"$cpld_bin/tda\" -i exercise_3.bl5 -o exercise_3.tda -lci exercise_3.lct -dev m4s_256_64 -family lc4k -mod exercise_3 -ovec test.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj exercise_3 -if exercise_3.jed -j2s -log exercise_3.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 02:38:46 ###########


########## Tcl recorder starts at 04/27/23 02:40:01 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" counter_1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 02:40:01 ###########


########## Tcl recorder starts at 04/27/23 02:40:09 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" counter_1.abl -mod counter_1 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 02:40:09 ###########


########## Tcl recorder starts at 04/27/23 02:40:16 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/mblifopt\" counter_1.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"exercise_3.bl1\" -o \"exercise_3.bl2\" -omod \"exercise_3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj exercise_3 -lci exercise_3.lct -log exercise_3.imp -err automake.err -tti exercise_3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -blifopt exercise_3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" exercise_3.bl2 -sweep -mergefb -err automake.err -o exercise_3.bl3 @exercise_3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -diofft exercise_3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" exercise_3.bl3 -family AMDMACH -idev van -o exercise_3.bl4 -oxrf exercise_3.xrf -err automake.err @exercise_3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -prefit exercise_3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp exercise_3.bl4 -out exercise_3.bl5 -err automake.err -log exercise_3.log -mod exercise_3 @exercise_3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open exercise_3.rs1 w} rspFile] {
	puts stderr "Cannot create response file exercise_3.rs1: $rspFile"
} else {
	puts $rspFile "-i exercise_3.bl5 -lci exercise_3.lct -d m4s_256_64 -lco exercise_3.lco -html_rpt -fti exercise_3.fti -fmt PLA -tto exercise_3.tt4 -nojed -eqn exercise_3.eq3 -tmv test.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open exercise_3.rs2 w} rspFile] {
	puts stderr "Cannot create response file exercise_3.rs2: $rspFile"
} else {
	puts $rspFile "-i exercise_3.bl5 -lci exercise_3.lct -d m4s_256_64 -lco exercise_3.lco -html_rpt -fti exercise_3.fti -fmt PLA -tto exercise_3.tt4 -eqn exercise_3.eq3 -tmv test.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@exercise_3.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete exercise_3.rs1
file delete exercise_3.rs2
if [runCmd "\"$cpld_bin/tda\" -i exercise_3.bl5 -o exercise_3.tda -lci exercise_3.lct -dev m4s_256_64 -family lc4k -mod exercise_3 -ovec test.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj exercise_3 -if exercise_3.jed -j2s -log exercise_3.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 02:40:16 ###########


########## Tcl recorder starts at 04/27/23 03:02:23 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map exercise_3.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/27/23 03:02:23 ###########


########## Tcl recorder starts at 04/28/23 08:15:53 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map exercise_3.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/28/23 08:15:53 ###########


########## Tcl recorder starts at 04/28/23 08:31:45 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/exp\" -lhdl -ext=.ltv -testpt test.wdl -network=exercise_3"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map exercise_3.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/28/23 08:31:45 ###########


########## Tcl recorder starts at 04/28/23 08:46:17 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/exp\" -lhdl -ext=.ltv -testpt test.wdl -network=exercise_3"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map exercise_3.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/28/23 08:46:17 ###########


########## Tcl recorder starts at 04/28/23 08:53:56 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" exercise_3.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/28/23 08:53:56 ###########


########## Tcl recorder starts at 04/28/23 08:54:01 ##########

# Commands to make the Process: 
# Compile Schematic
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup exercise_3.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"exercise_3.bls\" -o \"exercise_3.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/28/23 08:54:01 ###########


########## Tcl recorder starts at 04/28/23 08:54:09 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/mblifopt\" -i exercise_3.bl0 -o exercise_3.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"exercise_3.bl1\" -o \"exercise_3.bl2\" -omod \"exercise_3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj exercise_3 -lci exercise_3.lct -log exercise_3.imp -err automake.err -tti exercise_3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -blifopt exercise_3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" exercise_3.bl2 -sweep -mergefb -err automake.err -o exercise_3.bl3 @exercise_3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -diofft exercise_3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" exercise_3.bl3 -family AMDMACH -idev van -o exercise_3.bl4 -oxrf exercise_3.xrf -err automake.err @exercise_3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -prefit exercise_3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp exercise_3.bl4 -out exercise_3.bl5 -err automake.err -log exercise_3.log -mod exercise_3 @exercise_3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map exercise_3.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/28/23 08:54:09 ###########


########## Tcl recorder starts at 04/28/23 09:01:54 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/exp\" -lhdl -ext=.ltv -testpt test.wdl -network=exercise_3"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map exercise_3.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/28/23 09:01:54 ###########


########## Tcl recorder starts at 04/28/23 09:04:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" exercise_3.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/28/23 09:04:12 ###########


########## Tcl recorder starts at 04/28/23 09:19:08 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup exercise_3.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"exercise_3.bls\" -o \"exercise_3.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i exercise_3.bl0 -o exercise_3.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"exercise_3.bl1\" -o \"exercise_3.bl2\" -omod \"exercise_3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj exercise_3 -lci exercise_3.lct -log exercise_3.imp -err automake.err -tti exercise_3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -blifopt exercise_3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" exercise_3.bl2 -sweep -mergefb -err automake.err -o exercise_3.bl3 @exercise_3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -diofft exercise_3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" exercise_3.bl3 -family AMDMACH -idev van -o exercise_3.bl4 -oxrf exercise_3.xrf -err automake.err @exercise_3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -prefit exercise_3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp exercise_3.bl4 -out exercise_3.bl5 -err automake.err -log exercise_3.log -mod exercise_3 @exercise_3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map exercise_3.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/28/23 09:19:08 ###########


########## Tcl recorder starts at 04/28/23 09:23:57 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i exercise_3.bl5 -o exercise_3.sif"] {
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
	puts $rspFile "-nodal -src exercise_3.bl5 -type BLIF -presrc exercise_3.bl3 -crf exercise_3.crf -sif exercise_3.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci exercise_3.lct
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

########## Tcl recorder end at 04/28/23 09:23:57 ###########


########## Tcl recorder starts at 04/28/23 10:04:09 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" exercise_3.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/28/23 10:04:09 ###########


########## Tcl recorder starts at 04/28/23 10:04:15 ##########

# Commands to make the Process: 
# Compile Schematic
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup exercise_3.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"exercise_3.bls\" -o \"exercise_3.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/28/23 10:04:15 ###########


########## Tcl recorder starts at 04/28/23 10:04:27 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/mblifopt\" -i exercise_3.bl0 -o exercise_3.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"exercise_3.bl1\" -o \"exercise_3.bl2\" -omod \"exercise_3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj exercise_3 -lci exercise_3.lct -log exercise_3.imp -err automake.err -tti exercise_3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -blifopt exercise_3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" exercise_3.bl2 -sweep -mergefb -err automake.err -o exercise_3.bl3 @exercise_3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -diofft exercise_3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" exercise_3.bl3 -family AMDMACH -idev van -o exercise_3.bl4 -oxrf exercise_3.xrf -err automake.err @exercise_3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -prefit exercise_3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp exercise_3.bl4 -out exercise_3.bl5 -err automake.err -log exercise_3.log -mod exercise_3 @exercise_3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map exercise_3.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/28/23 10:04:27 ###########


########## Tcl recorder starts at 04/28/23 10:08:50 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/exp\" -lhdl -ext=.ltv -testpt test.wdl -network=exercise_3"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map exercise_3.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/28/23 10:08:50 ###########


########## Tcl recorder starts at 04/28/23 10:10:32 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" exercise_3.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/28/23 10:10:32 ###########


########## Tcl recorder starts at 04/28/23 10:10:35 ##########

# Commands to make the Process: 
# Compile Schematic
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup exercise_3.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"exercise_3.bls\" -o \"exercise_3.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/28/23 10:10:35 ###########


########## Tcl recorder starts at 04/28/23 10:10:39 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/mblifopt\" -i exercise_3.bl0 -o exercise_3.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"exercise_3.bl1\" -o \"exercise_3.bl2\" -omod \"exercise_3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj exercise_3 -lci exercise_3.lct -log exercise_3.imp -err automake.err -tti exercise_3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -blifopt exercise_3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" exercise_3.bl2 -sweep -mergefb -err automake.err -o exercise_3.bl3 @exercise_3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -diofft exercise_3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" exercise_3.bl3 -family AMDMACH -idev van -o exercise_3.bl4 -oxrf exercise_3.xrf -err automake.err @exercise_3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -prefit exercise_3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp exercise_3.bl4 -out exercise_3.bl5 -err automake.err -log exercise_3.log -mod exercise_3 @exercise_3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map exercise_3.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/28/23 10:10:39 ###########


########## Tcl recorder starts at 04/28/23 10:11:26 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map exercise_3.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/28/23 10:11:26 ###########


########## Tcl recorder starts at 04/28/23 10:19:12 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map exercise_3.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/28/23 10:19:13 ###########


########## Tcl recorder starts at 04/28/23 10:28:23 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" exercise_3.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/28/23 10:28:23 ###########


########## Tcl recorder starts at 04/28/23 10:28:32 ##########

# Commands to make the Process: 
# Compile Schematic
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup exercise_3.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"exercise_3.bls\" -o \"exercise_3.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/28/23 10:28:32 ###########


########## Tcl recorder starts at 04/28/23 10:28:35 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/mblifopt\" -i exercise_3.bl0 -o exercise_3.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"exercise_3.bl1\" -o \"exercise_3.bl2\" -omod \"exercise_3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj exercise_3 -lci exercise_3.lct -log exercise_3.imp -err automake.err -tti exercise_3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -blifopt exercise_3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" exercise_3.bl2 -sweep -mergefb -err automake.err -o exercise_3.bl3 @exercise_3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -diofft exercise_3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" exercise_3.bl3 -family AMDMACH -idev van -o exercise_3.bl4 -oxrf exercise_3.xrf -err automake.err @exercise_3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -prefit exercise_3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp exercise_3.bl4 -out exercise_3.bl5 -err automake.err -log exercise_3.log -mod exercise_3 @exercise_3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map exercise_3.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/28/23 10:28:35 ###########


########## Tcl recorder starts at 04/28/23 10:30:01 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map exercise_3.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/28/23 10:30:01 ###########


########## Tcl recorder starts at 04/28/23 10:41:21 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map exercise_3.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/28/23 10:41:21 ###########


########## Tcl recorder starts at 04/28/23 10:42:33 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map exercise_3.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/28/23 10:42:33 ###########


########## Tcl recorder starts at 04/28/23 10:43:14 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map exercise_3.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/28/23 10:43:14 ###########


########## Tcl recorder starts at 04/28/23 10:44:36 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk test.ltv -map exercise_3.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/28/23 10:44:36 ###########


########## Tcl recorder starts at 05/04/23 17:19:06 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i exercise_3.bl5 -o exercise_3.sif"] {
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
	puts $rspFile "-nodal -src exercise_3.bl5 -type BLIF -presrc exercise_3.bl3 -crf exercise_3.crf -sif exercise_3.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci exercise_3.lct
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

########## Tcl recorder end at 05/04/23 17:19:06 ###########


########## Tcl recorder starts at 05/26/23 10:48:15 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup exercise_3.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"exercise_3.bls\" -o \"exercise_3.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i exercise_3.bl0 -o exercise_3.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_5.abl -mod DIVIDER_5 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DIVIDER_5.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_10.abl -mod DIVIDER_10 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" DIVIDER_10.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/ahdl2blf\" counter_4.abl -mod counter_4 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" counter_4.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/ahdl2blf\" counter_3.abl -mod counter_3 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" counter_3.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/ahdl2blf\" counter_2.abl -mod counter_2 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" counter_2.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/ahdl2blf\" counter_1.abl -mod counter_1 -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" counter_1.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"exercise_3.bl1\" -o \"exercise_3.bl2\" -omod \"exercise_3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj exercise_3 -lci exercise_3.lct -log exercise_3.imp -err automake.err -tti exercise_3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -blifopt exercise_3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" exercise_3.bl2 -sweep -mergefb -err automake.err -o exercise_3.bl3 @exercise_3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -diofft exercise_3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" exercise_3.bl3 -family AMDMACH -idev van -o exercise_3.bl4 -oxrf exercise_3.xrf -err automake.err @exercise_3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci exercise_3.lct -dev lc4k -prefit exercise_3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp exercise_3.bl4 -out exercise_3.bl5 -err automake.err -log exercise_3.log -mod exercise_3 @exercise_3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open exercise_3.rs1 w} rspFile] {
	puts stderr "Cannot create response file exercise_3.rs1: $rspFile"
} else {
	puts $rspFile "-i exercise_3.bl5 -lci exercise_3.lct -d m4s_256_64 -lco exercise_3.lco -html_rpt -fti exercise_3.fti -fmt PLA -tto exercise_3.tt4 -nojed -eqn exercise_3.eq3 -tmv test.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open exercise_3.rs2 w} rspFile] {
	puts stderr "Cannot create response file exercise_3.rs2: $rspFile"
} else {
	puts $rspFile "-i exercise_3.bl5 -lci exercise_3.lct -d m4s_256_64 -lco exercise_3.lco -html_rpt -fti exercise_3.fti -fmt PLA -tto exercise_3.tt4 -eqn exercise_3.eq3 -tmv test.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@exercise_3.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete exercise_3.rs1
file delete exercise_3.rs2
if [runCmd "\"$cpld_bin/tda\" -i exercise_3.bl5 -o exercise_3.tda -lci exercise_3.lct -dev m4s_256_64 -family lc4k -mod exercise_3 -ovec test.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj exercise_3 -if exercise_3.jed -j2s -log exercise_3.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/26/23 10:48:15 ###########


########## Tcl recorder starts at 06/14/23 17:59:49 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" counter_1.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/ahdl2blf\" counter_2.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/ahdl2blf\" counter_3.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/ahdl2blf\" counter_4.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_10.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/ahdl2blf\" divider_5.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/ahdl2blf\" divider2.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/sch2jhd\" exercise_3.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/14/23 17:59:49 ###########

