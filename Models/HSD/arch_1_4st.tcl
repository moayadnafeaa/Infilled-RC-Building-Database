# --------------------------------------------------
# 3D Model of Archetype Plan #1
# --------------------------------------------------
# Copyright by Al Mouayed Bellah Nafeh
# IUSS Pavia, Italy
# April 2020
# Description: 4-storey infilled RC building
# --------------------------------------------------
puts "Welcome..."

file mkdir $outsdir
file mkdir $outsdir/info/props
file mkdir $outsdir/info/models
file mkdir $outsdir/info/modal
file mkdir $outsdir/info/recorders

global procdir
global modeldir
global MPa
global mm
global AType

# --------------------------------------
# Define the model
# --------------------------------------
#  3D Model (3-dimensional, 6 degrees-of-freedom)
model basic -ndm 3 -ndf 6

# --------------------------------------
# Load some procedures
# --------------------------------------
# These following two files are in another repository

source $procdir/Units.tcl
source $procdir/rcBC_Duct.tcl
source $procdir/jointModel.tcl
source $procdir/modalAnalysis.tcl
source $procdir/infill.tcl
source $procdir/infill_prop.tcl
source $procdir/arch_1_inputParam_HSD.tcl

# --------------------------------------
# Define some basic model parameters
# --------------------------------------
# Dimensions and General Para.

set nst 4; #Number of Stories
set mtype "Infill"; #Typology
set STb 0; #Shear Hinge for Beam (0: No, 1: Yes)
set STc 0; #Shear Hinge for Column (0: No, 1: Yes)
set stairsOPT 0; #Add Stairs (0: No, 1: Yes)
set infillsOPT 1; #Add Infills (0: No, 1: Yes)

# --------------------------------------
# Define the base nodes
# --------------------------------------
# node 	tag 	X		Y		Z
# Base Nodes
# Y=1;
node	1110		0.0		  0.0		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1210		$BX1		0.0		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1310		$BX2		0.0		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1410		$BX3		0.0		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1510		$BX4		0.0		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1610		$BX5		0.0		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1710		$BX6		0.0		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1810		$BX7		0.0		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0

# Y=2;
node	1120		0.0		  $BY1		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1220		$BX1		$BY1		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1320		$BX2		$BY1		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1420		$BX3		$BY1		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1520		$BX4		$BY1		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1620		$BX5		$BY1		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1720		$BX6		$BY1		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1820		$BX7		$BY1		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0

# Y=3;
node	1130		0.0		  $BY2		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1230		$BX1		$BY2		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1330		$BX2		$BY2		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1430		$BX3		$BY2		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1530		$BX4		$BY2		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1630		$BX5		$BY2		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1730		$BX6		$BY2		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1830		$BX7		$BY2		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0

# Y=4;
node	1140		0.0		  $BY3		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1240		$BX1		$BY3		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1340		$BX2		$BY3		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1440		$BX3		$BY3		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1540		$BX4		$BY3		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1640		$BX5		$BY3		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1740		$BX6		$BY3		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1840		$BX7		$BY3		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0

if {$stairsOPT == 1} {
#Define the staircase Nodes

#nodes on landing [on intersection of axis 3(in x) and between axes 1 and 2(in y) every 0.5 floor]
node 10 $BX3 $BY01 [expr 0.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 11 $BX3 $BY01 [expr 1.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 12 $BX3 $BY01 [expr 2.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

#nodes on landing [on intersection of axis 4(in x) and between axes 1 and 2(in y) every 0.5 floor]
node 20 $BX4 $BY01 [expr 0.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 21 $BX4 $BY01 [expr 1.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 22 $BX4 $BY01 [expr 2.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

#nodes on landing [on intersection of between axes 3-4 (in x) and 1-2 (in y) every 0.5 floor]
node 30 $BX34 $BY01 [expr 0.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 31 $BX34 $BY01 [expr 1.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 32 $BX34 $BY01 [expr 2.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

#mid-stair node which starts at level 0 to level 5
node 40 $BX34 $BY1 [expr 0*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 41 $BX34 $BY1 [expr 1*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 42 $BX34 $BY1 [expr 2*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 43 $BX34 $BY1 [expr 3*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

#split the columns nodes
node 14101 $BX3 0 [expr 0.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 14112 $BX3 0 [expr 1.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 14123 $BX3 0 [expr 2.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

node 14201 $BX3 $BY1 [expr 0.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 14212 $BX3 $BY1 [expr 1.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 14223 $BX3 $BY1 [expr 2.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

node 15101 $BX4 0 [expr 0.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 15112 $BX4 0 [expr 1.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 15123 $BX4 0 [expr 2.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

node 15201 $BX4 $BY1 [expr 0.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 15212 $BX4 $BY1 [expr 1.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 15223 $BX4 $BY1 [expr 2.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

}

# --------------------------------------
# Define Transformations
# --------------------------------------
# Use P-Delta geometric transformations. Include rigid-end offsets to account for the rigid zones of the beam-column joints.
# These are incorporated here as opposed to inserting rigid members at each joint for computational efficiency.
geomTransf PDelta 	1  0 1 0 -jntOffset 0.0 0.0 [expr $hc1/2] 0.0 0.0 [expr -$hc1/2] ; # z is in Y
geomTransf PDelta 	2  0 1 0 -jntOffset 0.0 0.0 [expr $hc2/2] 0.0 0.0 [expr -$hc2/2] ; # z is in Y

geomTransf PDelta 	5  0 1 0 -jntOffset [expr $hb1/2] 0.0 0.0  [expr -$hb1/2]  0.0 0.0 ; # z is in Y
geomTransf PDelta 	6  -1 0 0 -jntOffset 0.0 [expr $hb1/2] 0.0  0.0 [expr -$hb1/2]  0.0 ; # z is in Y
geomTransf PDelta 	7  0 1 0 -jntOffset [expr $hb2/2] 0.0 0.0  [expr -$hb2/2]  0.0 0.0 ; # z is in Y
geomTransf PDelta 	8  -1 0 0 -jntOffset 0.0 [expr $hb2/2] 0.0  0.0 [expr -$hb2/2]  0.0 ; # z is in Y

set GTc1 1;
set GTc2 2;

set GTbX1	5;
set GTbY1 6;
set GTbX2	7;
set GTbY2 8;
# --------------------------------------
# Define Elements
# --------------------------------------
# Open a set of files so that the properties of the beams, columns and joint elements creted using the provided procedures can be examined later.
set pfile_jnts [open $outsdir/Properties_joints.txt w];
set pfile_bms  [open $outsdir/Properties_beams.txt w];
set pfile_cols [open $outsdir/Properties_column.txt w];

# Build the model without stairs
if {$stairsOPT == 0} {
puts " # -------------------------------------------------- "
puts " # Building Model without Stairs			                "
puts " # -------------------------------------------------- "
# -------------------
# Joints
# -------------------
# Y=1; 1st Floor
jointModel 	 "Exterior"	111 	[list 0.00 0.0 [expr 1*$H]] $mass11  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	211 	[list $BX1 0.0 [expr 1*$H]] $mass21  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	311 	[list $BX2 0.0 [expr 1*$H]] $mass31  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	411 	[list $BX3 0.0 [expr 1*$H]] $mass41  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	511 	[list $BX4 0.0 [expr 1*$H]] $mass51  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass51+$mass51r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	611 	[list $BX5 0.0 [expr 1*$H]] $mass61  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass61+$mass61r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	711 	[list $BX6 0.0 [expr 1*$H]] $mass71  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass71+$mass71r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Exterior"	811 	[list $BX7 0.0 [expr 1*$H]] $mass81  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass81+$mass81r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts

# Y=1; 2nd Floor
jointModel 	 "Exterior"	112 	[list 0.00 0.0 [expr 2*$H]] $mass11  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	212 	[list $BX1 0.0 [expr 2*$H]] $mass21  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	312 	[list $BX2 0.0 [expr 2*$H]] $mass31  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	412 	[list $BX3 0.0 [expr 2*$H]] $mass41  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	512 	[list $BX4 0.0 [expr 2*$H]] $mass51  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass51+$mass51r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	612 	[list $BX5 0.0 [expr 2*$H]] $mass61  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass61+$mass61r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	712 	[list $BX6 0.0 [expr 2*$H]] $mass71  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass71+$mass71r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Exterior"	812 	[list $BX7 0.0 [expr 2*$H]] $mass81  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass81+$mass81r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts

# Y=1; 3rd Floor
jointModel 	 "Exterior"	113 	[list 0.00 0.0 [expr 3*$H]] $mass11  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	213 	[list $BX1 0.0 [expr 3*$H]] $mass21  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	313 	[list $BX2 0.0 [expr 3*$H]] $mass31  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	413 	[list $BX3 0.0 [expr 3*$H]] $mass41  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	513 	[list $BX4 0.0 [expr 3*$H]] $mass51  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass51+$mass51r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	613 	[list $BX5 0.0 [expr 3*$H]] $mass61  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass61+$mass61r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	713 	[list $BX6 0.0 [expr 3*$H]] $mass71  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass71+$mass71r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Exterior"	813 	[list $BX7 0.0 [expr 3*$H]] $mass81  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass81+$mass81r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts

# Y=1; 4th Floor
jointModel 	 "Exterior"	114 	[list 0.00 0.0 [expr 4*$H]] $mass11  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	214 	[list $BX1 0.0 [expr 4*$H]] $mass21  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	314 	[list $BX2 0.0 [expr 4*$H]] $mass31  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	414 	[list $BX3 0.0 [expr 4*$H]] $mass41  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	514 	[list $BX4 0.0 [expr 4*$H]] $mass51  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass51+$mass51r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	614 	[list $BX5 0.0 [expr 4*$H]] $mass61  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass61+$mass61r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	714 	[list $BX6 0.0 [expr 4*$H]] $mass71  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass71+$mass71r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Exterior"	814 	[list $BX7 0.0 [expr 4*$H]] $mass81  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass81+$mass81r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts

# Y=2; 1st Floor
jointModel 	 "Exterior"	121 	[list 0.00 $BY1 [expr 1*$H]] $mass12  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	221 	[list $BX1 $BY1 [expr 1*$H]] $mass22  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	321 	[list $BX2 $BY1 [expr 1*$H]] $mass32  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	421 	[list $BX3 $BY1 [expr 1*$H]] $mass42  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	521 	[list $BX4 $BY1 [expr 1*$H]] $mass52  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass52+$mass52r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	621 	[list $BX5 $BY1 [expr 1*$H]] $mass62  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass62+$mass62r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	721 	[list $BX6 $BY1 [expr 1*$H]] $mass72  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass72+$mass72r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Exterior"	821 	[list $BX7 $BY1 [expr 1*$H]] $mass82  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass82+$mass82r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts

# Y=2; 2nd Floor
jointModel 	 "Exterior"	122 	[list 0.00 $BY1 [expr 2*$H]] $mass12  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	222 	[list $BX1 $BY1 [expr 2*$H]] $mass22  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	322 	[list $BX2 $BY1 [expr 2*$H]] $mass32  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	422 	[list $BX3 $BY1 [expr 2*$H]] $mass42  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	522 	[list $BX4 $BY1 [expr 2*$H]] $mass52  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass52+$mass52r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	622 	[list $BX5 $BY1 [expr 2*$H]] $mass62  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass62+$mass62r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	722 	[list $BX6 $BY1 [expr 2*$H]] $mass72  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass72+$mass72r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Exterior"	822 	[list $BX7 $BY1 [expr 2*$H]] $mass82  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass82+$mass82r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts

# Y=2; 3rd Floor
jointModel 	 "Exterior"	123 	[list 0.00 $BY1 [expr 3*$H]] $mass12  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	223 	[list $BX1 $BY1 [expr 3*$H]] $mass22  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	323 	[list $BX2 $BY1 [expr 3*$H]] $mass32  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	423 	[list $BX3 $BY1 [expr 3*$H]] $mass42  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	523 	[list $BX4 $BY1 [expr 3*$H]] $mass52  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass52+$mass52r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	623 	[list $BX5 $BY1 [expr 3*$H]] $mass62  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass62+$mass62r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	723 	[list $BX6 $BY1 [expr 3*$H]] $mass72  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass72+$mass72r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Exterior"	823 	[list $BX7 $BY1 [expr 3*$H]] $mass82  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass82+$mass82r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts

# Y=2; 4th Floor
jointModel 	 "Exterior"	124 	[list 0.00 $BY1 [expr 4*$H]] $mass12  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	224 	[list $BX1 $BY1 [expr 4*$H]] $mass22  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	324 	[list $BX2 $BY1 [expr 4*$H]] $mass32  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	424 	[list $BX3 $BY1 [expr 4*$H]] $mass42  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	524 	[list $BX4 $BY1 [expr 4*$H]] $mass52  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass52+$mass52r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	624 	[list $BX5 $BY1 [expr 4*$H]] $mass62  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass62+$mass62r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	724 	[list $BX6 $BY1 [expr 4*$H]] $mass72  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass72+$mass72r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Exterior"	824 	[list $BX7 $BY1 [expr 4*$H]] $mass82  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass82+$mass82r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts

# Y=3; 1st Floor
jointModel 	 "Exterior"	131 	[list 0.00 $BY2 [expr 1*$H]] $mass13  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	231 	[list $BX1 $BY2 [expr 1*$H]] $mass23  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	331 	[list $BX2 $BY2 [expr 1*$H]] $mass33  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	431 	[list $BX3 $BY2 [expr 1*$H]] $mass43  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	531 	[list $BX4 $BY2 [expr 1*$H]] $mass53  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass53+$mass53r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	631 	[list $BX5 $BY2 [expr 1*$H]] $mass63  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass63+$mass63r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	731 	[list $BX6 $BY2 [expr 1*$H]] $mass73  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass73+$mass73r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Exterior"	831 	[list $BX7 $BY2 [expr 1*$H]] $mass73  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass83+$mass83r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts

# Y=3; 2nd Floor
jointModel 	 "Exterior"	132 	[list 0.00 $BY2 [expr 2*$H]] $mass13  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	232 	[list $BX1 $BY2 [expr 2*$H]] $mass23  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	332 	[list $BX2 $BY2 [expr 2*$H]] $mass33  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	432 	[list $BX3 $BY2 [expr 2*$H]] $mass43  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	532 	[list $BX4 $BY2 [expr 2*$H]] $mass53  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass53+$mass53r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	632 	[list $BX5 $BY2 [expr 2*$H]] $mass63  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass63+$mass63r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	732 	[list $BX6 $BY2 [expr 2*$H]] $mass73  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass73+$mass73r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Exterior"	832 	[list $BX7 $BY2 [expr 2*$H]] $mass73  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass83+$mass83r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts

# Y=3; 3rd Floor
jointModel 	 "Exterior"	133 	[list 0.00 $BY2 [expr 3*$H]] $mass13  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	233 	[list $BX1 $BY2 [expr 3*$H]] $mass23  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	333 	[list $BX2 $BY2 [expr 3*$H]] $mass33  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	433 	[list $BX3 $BY2 [expr 3*$H]] $mass43  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	533 	[list $BX4 $BY2 [expr 3*$H]] $mass53  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass53+$mass53r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	633 	[list $BX5 $BY2 [expr 3*$H]] $mass63  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass63+$mass63r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	733 	[list $BX6 $BY2 [expr 3*$H]] $mass73  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass73+$mass73r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Exterior"	833 	[list $BX7 $BY2 [expr 3*$H]] $mass73  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass83+$mass83r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts

# Y=3; 4th Floor
jointModel 	 "Exterior"	134 	[list 0.00 $BY2 [expr 4*$H]] $mass13  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	234 	[list $BX1 $BY2 [expr 4*$H]] $mass23  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	334 	[list $BX2 $BY2 [expr 4*$H]] $mass33  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	434 	[list $BX3 $BY2 [expr 4*$H]] $mass43  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	534 	[list $BX4 $BY2 [expr 4*$H]] $mass53  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass53+$mass53r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	634 	[list $BX5 $BY2 [expr 4*$H]] $mass63  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass63+$mass63r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	734 	[list $BX6 $BY2 [expr 4*$H]] $mass73  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass73+$mass73r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Exterior"	834 	[list $BX7 $BY2 [expr 4*$H]] $mass73  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass83+$mass83r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts

# Y=4; 1st Floor
jointModel 	 "Exterior"	141 	[list 0.00 $BY3 [expr 1*$H]] $mass14  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass14+$mass14r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	241 	[list $BX1 $BY3 [expr 1*$H]] $mass24  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass24+$mass24r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	341 	[list $BX2 $BY3 [expr 1*$H]] $mass34  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass34+$mass34r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	441 	[list $BX3 $BY3 [expr 1*$H]] $mass44  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass44+$mass44r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	541 	[list $BX4 $BY3 [expr 1*$H]] $mass54  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass54+$mass54r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	641 	[list $BX5 $BY3 [expr 1*$H]] $mass64  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass64+$mass64r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	741 	[list $BX6 $BY3 [expr 1*$H]] $mass74  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass74+$mass74r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Exterior"	841 	[list $BX7 $BY3 [expr 1*$H]] $mass84  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass84+$mass84r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts

# Y=4; 2nd Floor
jointModel 	 "Exterior"	142 	[list 0.00 $BY3 [expr 2*$H]] $mass14  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass14+$mass14r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	242 	[list $BX1 $BY3 [expr 2*$H]] $mass24  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass24+$mass24r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	342 	[list $BX2 $BY3 [expr 2*$H]] $mass34  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass34+$mass34r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	442 	[list $BX3 $BY3 [expr 2*$H]] $mass44  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass44+$mass44r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	542 	[list $BX4 $BY3 [expr 2*$H]] $mass54  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass54+$mass54r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	642 	[list $BX5 $BY3 [expr 2*$H]] $mass64  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass64+$mass64r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	742 	[list $BX6 $BY3 [expr 2*$H]] $mass74  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass74+$mass74r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Exterior"	842 	[list $BX7 $BY3 [expr 2*$H]] $mass84  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass84+$mass84r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts

# Y=4; 3rd Floor
jointModel 	 "Exterior"	143 	[list 0.00 $BY3 [expr 3*$H]] $mass14  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass14+$mass14r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	243 	[list $BX1 $BY3 [expr 3*$H]] $mass24  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass24+$mass24r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	343 	[list $BX2 $BY3 [expr 3*$H]] $mass34  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass34+$mass34r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	443 	[list $BX3 $BY3 [expr 3*$H]] $mass44  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass44+$mass44r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	543 	[list $BX4 $BY3 [expr 3*$H]] $mass54  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass54+$mass54r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	643 	[list $BX5 $BY3 [expr 3*$H]] $mass64  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass64+$mass64r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	743 	[list $BX6 $BY3 [expr 3*$H]] $mass74  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass74+$mass74r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Exterior"	843 	[list $BX7 $BY3 [expr 3*$H]] $mass84  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass84+$mass84r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts

# Y=4; 4th Floor
jointModel 	 "Exterior"	144 	[list 0.00 $BY3 [expr 4*$H]] $mass14  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass14+$mass14r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	244 	[list $BX1 $BY3 [expr 4*$H]] $mass24  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass24+$mass24r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	344 	[list $BX2 $BY3 [expr 4*$H]] $mass34  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass34+$mass34r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	444 	[list $BX3 $BY3 [expr 4*$H]] $mass44  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass44+$mass44r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	544 	[list $BX4 $BY3 [expr 4*$H]] $mass54  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass54+$mass54r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	644 	[list $BX5 $BY3 [expr 4*$H]] $mass64  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass64+$mass64r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	744 	[list $BX6 $BY3 [expr 4*$H]] $mass74  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass74+$mass74r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Exterior"	844 	[list $BX7 $BY3 [expr 4*$H]] $mass84  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass84+$mass84r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts

puts "Joints created..."

# -------------------
# Beams
# -------------------
# X-Direction
# -------------------

#1st Floor

# Y=1;
rcBC_Duct 	5111 $GTbX1  6111 6211 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5211 $GTbX1  6211 6311 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5311 $GTbX1  6311 6411 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5411 $GTbX1  6411 6511 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5511 $GTbX1  6511 6611 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5611 $GTbX1  6611 6711 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5711 $GTbX1  6711 6811 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# Y=2;
rcBC_Duct 	5121 $GTbX1  6121 6221 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5221 $GTbX1  6221 6321 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5321 $GTbX1  6321 6421 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5421 $GTbX1  6421 6521 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5521 $GTbX1  6521 6621 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5621 $GTbX1  6621 6721 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5721 $GTbX1  6721 6821 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=3;
rcBC_Duct 	5131 $GTbX1  6131 6231 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5231 $GTbX1  6231 6331 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5331 $GTbX1  6331 6431 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5431 $GTbX1  6431 6531 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5531 $GTbX1  6531 6631 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5631 $GTbX1  6631 6731 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5731 $GTbX1  6731 6831 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=4;
rcBC_Duct 	5141 $GTbX1  6141 6241 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5241 $GTbX1  6241 6341 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5341 $GTbX1  6341 6441 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5441 $GTbX1  6441 6541 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5541 $GTbX1  6541 6641 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5641 $GTbX1  6641 6741 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5741 $GTbX1  6741 6841 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#2nd Floor

# Y=1;
rcBC_Duct 	5112 $GTbX1  6112 6212 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5212 $GTbX1  6212 6312 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5312 $GTbX1  6312 6412 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5412 $GTbX1  6412 6512 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5512 $GTbX1  6512 6612 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5612 $GTbX1  6612 6712 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5712 $GTbX1  6712 6812 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# Y=2;
rcBC_Duct 	5122 $GTbX1  6122 6222 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5222 $GTbX1  6222 6322 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5322 $GTbX1  6322 6422 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5422 $GTbX1  6422 6522 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5522 $GTbX1  6522 6622 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5622 $GTbX1  6622 6722 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5722 $GTbX1  6722 6822 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=3;
rcBC_Duct 	5132 $GTbX1  6132 6232 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5232 $GTbX1  6232 6332 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5332 $GTbX1  6332 6432 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5432 $GTbX1  6432 6532 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5532 $GTbX1  6532 6632 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5632 $GTbX1  6632 6732 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5732 $GTbX1  6732 6832 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=4;
rcBC_Duct 	5142 $GTbX1  6142 6242 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5242 $GTbX1  6242 6342 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5342 $GTbX1  6342 6442 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5442 $GTbX1  6442 6542 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5542 $GTbX1  6542 6642 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5642 $GTbX1  6642 6742 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5742 $GTbX1  6742 6842 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#3rd Floor

# Y=1;
rcBC_Duct 	5113 $GTbX1  6113 6213 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5213 $GTbX1  6213 6313 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5313 $GTbX1  6313 6413 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5413 $GTbX1  6413 6513 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5513 $GTbX1  6513 6613 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5613 $GTbX1  6613 6713 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5713 $GTbX1  6713 6813 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# Y=2;
rcBC_Duct 	5123 $GTbX1  6123 6223 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5223 $GTbX1  6223 6323 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5323 $GTbX1  6323 6423 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5423 $GTbX1  6423 6523 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5523 $GTbX1  6523 6623 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5623 $GTbX1  6623 6723 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5723 $GTbX1  6723 6823 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=3;
rcBC_Duct 	5133 $GTbX1  6133 6233 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5233 $GTbX1  6233 6333 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5333 $GTbX1  6333 6433 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5433 $GTbX1  6433 6533 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5533 $GTbX1  6533 6633 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5633 $GTbX1  6633 6733 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5733 $GTbX1  6733 6833 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=4;
rcBC_Duct 	5143 $GTbX1  6143 6243 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5243 $GTbX1  6243 6343 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5343 $GTbX1  6343 6443 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5443 $GTbX1  6443 6543 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5543 $GTbX1  6543 6643 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5643 $GTbX1  6643 6743 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5743 $GTbX1  6743 6843 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#4th Floor

# Y=1;
rcBC_Duct 	5114 $GTbX1  6114 6214 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5214 $GTbX1  6214 6314 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5314 $GTbX1  6314 6414 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5414 $GTbX1  6414 6514 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5514 $GTbX1  6514 6614 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5614 $GTbX1  6614 6714 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5714 $GTbX1  6714 6814 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# Y=2;
rcBC_Duct 	5124 $GTbX1  6124 6224 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5224 $GTbX1  6224 6324 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5324 $GTbX1  6324 6424 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5424 $GTbX1  6424 6524 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5524 $GTbX1  6524 6624 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5624 $GTbX1  6624 6724 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5724 $GTbX1  6724 6824 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=3;
rcBC_Duct 	5134 $GTbX1  6134 6234 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5234 $GTbX1  6234 6334 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5334 $GTbX1  6334 6434 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5434 $GTbX1  6434 6534 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5534 $GTbX1  6534 6634 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5634 $GTbX1  6634 6734 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5734 $GTbX1  6734 6834 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=4;
rcBC_Duct 	5144 $GTbX1  6144 6244 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5244 $GTbX1  6244 6344 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5344 $GTbX1  6344 6444 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5444 $GTbX1  6444 6544 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5544 $GTbX1  6544 6644 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5644 $GTbX1  6644 6744 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5744 $GTbX1  6744 6844 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# -------------------
# Y-Direction
# -------------------

#1st Floor

# X=1;
rcBC_Duct 	6111 $GTbY1  6111 6121 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6121 $GTbY1  6121 6131 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6131 $GTbY1  6131 6141 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# X=2;
rcBC_Duct 	6211 $GTbY2  6211 6221 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6221 $GTbY2  6221 6231 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6231 $GTbY2  6231 6241 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=3;
rcBC_Duct 	6311 $GTbY2  6311 6321 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6321 $GTbY2  6321 6331 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6331 $GTbY2  6331 6341 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=4;
rcBC_Duct 	6411 $GTbY2  6411 6421 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6421 $GTbY2  6421 6431 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6431 $GTbY2  6431 6441 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=5;
rcBC_Duct 	6511 $GTbY2  6511 6521 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6521 $GTbY2  6521 6531 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct	  6531 $GTbY2  6531 6541 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=6;
rcBC_Duct 	6611 $GTbY2  6611 6621 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6621 $GTbY2  6621 6631 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6631 $GTbY2  6631 6641 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=7;
rcBC_Duct 	6711 $GTbY2  6711 6721 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6721 $GTbY2  6721 6731 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6731 $GTbY2  6731 6741 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=8;
rcBC_Duct 	6811 $GTbY1  6811 6821 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6821 $GTbY1  6821 6831 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6831 $GTbY1  6831 6841 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#2nd Floor

# X=1;
rcBC_Duct 	6112 $GTbY1  6112 6122 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6122 $GTbY1  6122 6132 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6132 $GTbY1  6132 6142 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# X=2;
rcBC_Duct 	6212 $GTbY2  6212 6222 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6222 $GTbY2  6222 6232 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6232 $GTbY2  6232 6242 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=3;
rcBC_Duct 	6312 $GTbY2  6312 6322 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6322 $GTbY2  6322 6332 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6332 $GTbY2  6332 6342 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=4;
rcBC_Duct 	6412 $GTbY2  6412 6422 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6422 $GTbY2  6422 6432 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6432 $GTbY2  6432 6442 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=5;
rcBC_Duct 	6512 $GTbY2  6512 6522 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6522 $GTbY2  6522 6532 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct	  6532 $GTbY2  6532 6542 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=6;
rcBC_Duct 	6612 $GTbY2  6612 6622 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6622 $GTbY2  6622 6632 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6632 $GTbY2  6632 6642 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=7;
rcBC_Duct 	6712 $GTbY2  6712 6722 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6722 $GTbY2  6722 6732 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6732 $GTbY2  6732 6742 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=8;
rcBC_Duct 	6812 $GTbY1  6812 6822 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6822 $GTbY1  6822 6832 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6832 $GTbY1  6832 6842 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#3rd Floor

# X=1;
rcBC_Duct 	6113 $GTbY1  6113 6123 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6123 $GTbY1  6123 6133 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6133 $GTbY1  6133 6143 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# X=2;
rcBC_Duct 	6213 $GTbY2  6213 6223 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6223 $GTbY2  6223 6233 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6233 $GTbY2  6233 6243 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=3;
rcBC_Duct 	6313 $GTbY2  6313 6323 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6323 $GTbY2  6323 6333 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6333 $GTbY2  6333 6343 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=4;
rcBC_Duct 	6413 $GTbY2  6413 6423 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6423 $GTbY2  6423 6433 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6433 $GTbY2  6433 6443 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=5;
rcBC_Duct 	6513 $GTbY2  6513 6523 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6523 $GTbY2  6523 6533 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct	  6533 $GTbY2  6533 6543 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=6;
rcBC_Duct 	6613 $GTbY2  6613 6623 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6623 $GTbY2  6623 6633 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6633 $GTbY2  6633 6643 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=7;
rcBC_Duct 	6713 $GTbY2  6713 6723 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6723 $GTbY2  6723 6733 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6733 $GTbY2  6733 6743 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=8;
rcBC_Duct 	6813 $GTbY1  6813 6823 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6823 $GTbY1  6823 6833 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6833 $GTbY1  6833 6843 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#4th Floor

# X=1;
rcBC_Duct 	6114 $GTbY1  6114 6124 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6124 $GTbY1  6124 6134 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6134 $GTbY1  6134 6144 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# X=2;
rcBC_Duct 	6214 $GTbY2  6214 6224 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6224 $GTbY2  6224 6234 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6234 $GTbY2  6234 6244 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=3;
rcBC_Duct 	6314 $GTbY2  6314 6324 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6324 $GTbY2  6324 6334 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6334 $GTbY2  6334 6344 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=4;
rcBC_Duct 	6414 $GTbY2  6414 6424 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6424 $GTbY2  6424 6434 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6434 $GTbY2  6434 6444 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=5;
rcBC_Duct 	6514 $GTbY2  6514 6524 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6524 $GTbY2  6524 6534 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct	  6534 $GTbY2  6534 6544 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=6;
rcBC_Duct 	6614 $GTbY2  6614 6624 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6624 $GTbY2  6624 6634 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6634 $GTbY2  6634 6644 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=7;
rcBC_Duct 	6714 $GTbY2  6714 6724 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6724 $GTbY2  6724 6734 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6734 $GTbY2  6734 6744 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=8;
rcBC_Duct 	6814 $GTbY1  6814 6824 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6824 $GTbY1  6824 6834 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6834 $GTbY1  6834 6844 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

puts "Beams created..."

# -------------------
# Columns
# -------------------

#1st Floor

# Y=1;
rcBC_Duct 	7111 $GTc1 1110 	1111 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass11+$mass11r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_Duct 	7211 $GTc1 1210 	1211 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass21+$mass21r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_Duct 	7311 $GTc1 1310 	1311 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass31+$mass31r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_Duct 	7411 $GTc1 1410 	1411 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass41+$mass41r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_Duct 	7511 $GTc1 1510 	1511 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass51+$mass51r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_Duct 	7611 $GTc1 1610 	1611 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass61+$mass61r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_Duct 	7711 $GTc1 1710 	1711 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass71+$mass71r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_Duct 	7811 $GTc1 1810 	1811 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass81+$mass81r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols

# Y=2;
rcBC_Duct 	7121 $GTc1 1120 	1121 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass12+$mass12r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_Duct 	7221 $GTc1 1220 	1221 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass22+$mass22r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_Duct 	7321 $GTc1 1320 	1321 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass32+$mass32r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_Duct 	7421 $GTc1 1420 	1421 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass42+$mass42r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_Duct 	7521 $GTc1 1520 	1521 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass52+$mass52r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_Duct 	7621 $GTc1 1620 	1621 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass62+$mass62r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_Duct 	7721 $GTc1 1720 	1721 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass72+$mass72r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_Duct 	7821 $GTc1 1820 	1821 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass82+$mass82r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols

# Y=3;
rcBC_Duct 	7131 $GTc1 1130 	1131 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass13+$mass13r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_Duct 	7231 $GTc1 1230 	1231 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass23+$mass23r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_Duct 	7331 $GTc1 1330 	1331 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass33+$mass33r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_Duct 	7431 $GTc1 1430 	1431 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass43+$mass43r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_Duct 	7531 $GTc1 1530 	1531 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass53+$mass53r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_Duct 	7631 $GTc1 1630 	1631 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass63+$mass63r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_Duct 	7731 $GTc1 1730 	1731 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass73+$mass73r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_Duct 	7831 $GTc1 1830 	1831 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass83+$mass83r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols

# Y=4;
rcBC_Duct 	7141 $GTc1 1140 	1141 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass14+$mass14r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_Duct 	7241 $GTc1 1240 	1241 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass24+$mass24r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_Duct 	7341 $GTc1 1340 	1341 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass34+$mass34r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_Duct 	7441 $GTc1 1440 	1441 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass44+$mass44r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_Duct 	7541 $GTc1 1540 	1541 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass54+$mass54r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_Duct 	7641 $GTc1 1640 	1641 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass64+$mass64r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_Duct 	7741 $GTc1 1740 	1741 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass74+$mass74r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_Duct 	7841 $GTc1 1840 	1841 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass84+$mass84r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols

#2nd Floor

# Y=1;
rcBC_Duct 	7112 $GTc2 1111 	1112 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass11+$mass11r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7212 $GTc2 1211 	1212 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass21+$mass21r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7312 $GTc2 1311 	1312 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass31+$mass31r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7412 $GTc2 1411 	1412 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass41+$mass41r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7512 $GTc2 1511 	1512 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass51+$mass51r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7612 $GTc2 1611 	1612 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass61+$mass61r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7712 $GTc2 1711 	1712 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass71+$mass71r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7812 $GTc2 1811 	1812 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass81+$mass81r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

# Y=2;
rcBC_Duct 	7122 $GTc2 1121 	1122 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass12+$mass12r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7222 $GTc2 1221 	1222 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass22+$mass22r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7322 $GTc2 1321 	1322 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass32+$mass32r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7422 $GTc2 1421 	1422 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass42+$mass42r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7522 $GTc2 1521 	1522 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass52+$mass52r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7622 $GTc2 1621 	1622 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass62+$mass62r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7722 $GTc2 1721 	1722 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass72+$mass72r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7822 $GTc2 1821 	1822 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass82+$mass82r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

# Y=3;
rcBC_Duct 	7132 $GTc2 1131 	1132 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass13+$mass13r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7232 $GTc2 1231 	1232 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass23+$mass23r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7332 $GTc2 1331 	1332 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass33+$mass33r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7432 $GTc2 1431 	1432 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass43+$mass43r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7532 $GTc2 1531 	1532 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass53+$mass53r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7632 $GTc2 1631 	1632 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass63+$mass63r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7732 $GTc2 1731 	1732 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass73+$mass73r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7832 $GTc2 1831 	1832 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass83+$mass83r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

# Y=4;
rcBC_Duct 	7142 $GTc2 1141 	1142 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass14+$mass14r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7242 $GTc2 1241 	1242 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass24+$mass24r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7342 $GTc2 1341 	1342 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass34+$mass34r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7442 $GTc2 1441 	1442 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass44+$mass44r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7542 $GTc2 1541 	1542 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass54+$mass54r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7642 $GTc2 1641 	1642 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass64+$mass64r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7742 $GTc2 1741 	1742 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass74+$mass74r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7842 $GTc2 1841 	1842 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass84+$mass84r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

#3rd Floor

# Y=1;
rcBC_Duct 	7113 $GTc2 1112 	1113 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass11+$mass11r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7213 $GTc2 1212 	1213 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass21+$mass21r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7313 $GTc2 1312 	1313 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass31+$mass31r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7413 $GTc2 1412 	1413 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass41+$mass41r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7513 $GTc2 1512 	1513 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass51+$mass51r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7613 $GTc2 1612 	1613 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass61+$mass61r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7713 $GTc2 1712 	1713 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass71+$mass71r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7813 $GTc2 1812 	1813 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass81+$mass81r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

# Y=2;
rcBC_Duct 	7123 $GTc2 1122 	1123 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass12+$mass12r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7223 $GTc2 1222 	1223 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass22+$mass22r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7323 $GTc2 1322 	1323 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass32+$mass32r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7423 $GTc2 1422 	1423 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass42+$mass42r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7523 $GTc2 1522 	1523 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass52+$mass52r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7623 $GTc2 1622 	1623 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass62+$mass62r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7723 $GTc2 1722 	1723 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass72+$mass72r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7823 $GTc2 1822 	1823 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass82+$mass82r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

# Y=3;
rcBC_Duct 	7133 $GTc2 1132 	1133 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass13+$mass13r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7233 $GTc2 1232 	1233 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass23+$mass23r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7333 $GTc2 1332 	1333 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass33+$mass33r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7433 $GTc2 1432 	1433 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass43+$mass43r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7533 $GTc2 1532 	1533 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass53+$mass53r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7633 $GTc2 1632 	1633 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass63+$mass63r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7733 $GTc2 1732 	1733 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass73+$mass73r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7833 $GTc2 1832 	1833 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass83+$mass83r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

# Y=4;
rcBC_Duct 	7143 $GTc2 1142 	1143 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass14+$mass14r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7243 $GTc2 1242 	1243 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass24+$mass24r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7343 $GTc2 1342 	1343 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass34+$mass34r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7443 $GTc2 1442 	1443 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass44+$mass44r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7543 $GTc2 1542 	1543 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass54+$mass54r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7643 $GTc2 1642 	1643 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass64+$mass64r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7743 $GTc2 1742 	1743 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass74+$mass74r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7843 $GTc2 1842 	1843 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass84+$mass84r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

#4th Floor

# Y=1;
rcBC_Duct 	7114 $GTc2 1113 	1114 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass11+$mass11r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7214 $GTc2 1213 	1214 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass21+$mass21r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7314 $GTc2 1313 	1314 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass31+$mass31r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7414 $GTc2 1413 	1414 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass41+$mass41r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7514 $GTc2 1513 	1514 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass51+$mass51r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7614 $GTc2 1613 	1614 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass61+$mass61r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7714 $GTc2 1713 	1714 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass71+$mass71r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7814 $GTc2 1813 	1814 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass81+$mass81r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

# Y=2;
rcBC_Duct 	7124 $GTc2 1123 	1124 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass12+$mass12r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7224 $GTc2 1223 	1224 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass22+$mass22r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7324 $GTc2 1323 	1324 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass32+$mass32r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7424 $GTc2 1423 	1424 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass42+$mass42r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7524 $GTc2 1523 	1524 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass52+$mass52r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7624 $GTc2 1623 	1624 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass62+$mass62r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7724 $GTc2 1723 	1724 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass72+$mass72r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7824 $GTc2 1823 	1824 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass82+$mass82r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

# Y=3;
rcBC_Duct 	7134 $GTc2 1133 	1134 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass13+$mass13r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7234 $GTc2 1233 	1234 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass23+$mass23r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7334 $GTc2 1333 	1334 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass33+$mass33r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7434 $GTc2 1433 	1434 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass43+$mass43r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7534 $GTc2 1533 	1534 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass53+$mass53r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7634 $GTc2 1633 	1634 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass63+$mass63r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7734 $GTc2 1733 	1734 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass73+$mass73r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7834 $GTc2 1833 	1834 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass83+$mass83r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

# Y=4;
rcBC_Duct 	7144 $GTc2 1143 	1144 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass14+$mass14r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7244 $GTc2 1243 	1244 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass24+$mass24r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7344 $GTc2 1343 	1344 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass34+$mass34r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7444 $GTc2 1443 	1444 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass44+$mass44r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7544 $GTc2 1543 	1544 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass54+$mass54r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7644 $GTc2 1643 	1644 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass64+$mass64r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7744 $GTc2 1743 	1744 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass74+$mass74r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7844 $GTc2 1843 	1844 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass84+$mass84r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

puts "Columns created..."
}

# Build the model with stairs
if {$stairsOPT == 1} {
puts " # -------------------------------------------------- "
puts " # Building Model with Stairs			                    "
puts " # -------------------------------------------------- "
# -------------------
# Joints
# -------------------
# Y=1; 1st Floor
jointModel 	 "Exterior"	111 	[list 0.00 0.0 [expr 1*$H]] $mass11  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	211 	[list $BX1 0.0 [expr 1*$H]] $mass21  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	311 	[list $BX2 0.0 [expr 1*$H]] $mass31  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	411 	[list $BX3 0.0 [expr 1*$H]] $mass41  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	511 	[list $BX4 0.0 [expr 1*$H]] $mass51  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass51+$mass51r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	611 	[list $BX5 0.0 [expr 1*$H]] $mass61  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass61+$mass61r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	711 	[list $BX6 0.0 [expr 1*$H]] $mass71  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass71+$mass71r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Exterior"	811 	[list $BX7 0.0 [expr 1*$H]] $mass81  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass81+$mass81r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts

# Y=1; 2nd Floor
jointModel 	 "Exterior"	112 	[list 0.00 0.0 [expr 2*$H]] $mass11  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	212 	[list $BX1 0.0 [expr 2*$H]] $mass21  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	312 	[list $BX2 0.0 [expr 2*$H]] $mass31  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	412 	[list $BX3 0.0 [expr 2*$H]] $mass41  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	512 	[list $BX4 0.0 [expr 2*$H]] $mass51  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass51+$mass51r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	612 	[list $BX5 0.0 [expr 2*$H]] $mass61  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass61+$mass61r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	712 	[list $BX6 0.0 [expr 2*$H]] $mass71  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass71+$mass71r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Exterior"	812 	[list $BX7 0.0 [expr 2*$H]] $mass81  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass81+$mass81r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts

# Y=1; 3rd Floor
jointModel 	 "Exterior"	113 	[list 0.00 0.0 [expr 3*$H]] $mass11  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	213 	[list $BX1 0.0 [expr 3*$H]] $mass21  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	313 	[list $BX2 0.0 [expr 3*$H]] $mass31  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	413 	[list $BX3 0.0 [expr 3*$H]] $mass41  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	513 	[list $BX4 0.0 [expr 3*$H]] $mass51  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass51+$mass51r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	613 	[list $BX5 0.0 [expr 3*$H]] $mass61  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass61+$mass61r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	713 	[list $BX6 0.0 [expr 3*$H]] $mass71  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass71+$mass71r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Exterior"	813 	[list $BX7 0.0 [expr 3*$H]] $mass81  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass81+$mass81r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts

# Y=1; 4th Floor
jointModel 	 "Exterior"	114 	[list 0.00 0.0 [expr 4*$H]] $mass11  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	214 	[list $BX1 0.0 [expr 4*$H]] $mass21  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	314 	[list $BX2 0.0 [expr 4*$H]] $mass31  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	414 	[list $BX3 0.0 [expr 4*$H]] $mass41  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	514 	[list $BX4 0.0 [expr 4*$H]] $mass51  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass51+$mass51r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	614 	[list $BX5 0.0 [expr 4*$H]] $mass61  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass61+$mass61r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	714 	[list $BX6 0.0 [expr 4*$H]] $mass71  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass71+$mass71r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Exterior"	814 	[list $BX7 0.0 [expr 4*$H]] $mass81  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass81+$mass81r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts

# Y=2; 1st Floor
jointModel 	 "Exterior"	121 	[list 0.00 $BY1 [expr 1*$H]] $mass12  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	221 	[list $BX1 $BY1 [expr 1*$H]] $mass22  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	321 	[list $BX2 $BY1 [expr 1*$H]] $mass32  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	421 	[list $BX3 $BY1 [expr 1*$H]] $mass42  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	521 	[list $BX4 $BY1 [expr 1*$H]] $mass52  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass52+$mass52r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	621 	[list $BX5 $BY1 [expr 1*$H]] $mass62  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass62+$mass62r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	721 	[list $BX6 $BY1 [expr 1*$H]] $mass72  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass72+$mass72r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Exterior"	821 	[list $BX7 $BY1 [expr 1*$H]] $mass82  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass82+$mass82r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts

# Y=2; 2nd Floor
jointModel 	 "Exterior"	122 	[list 0.00 $BY1 [expr 2*$H]] $mass12  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	222 	[list $BX1 $BY1 [expr 2*$H]] $mass22  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	322 	[list $BX2 $BY1 [expr 2*$H]] $mass32  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	422 	[list $BX3 $BY1 [expr 2*$H]] $mass42  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	522 	[list $BX4 $BY1 [expr 2*$H]] $mass52  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass52+$mass52r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	622 	[list $BX5 $BY1 [expr 2*$H]] $mass62  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass62+$mass62r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	722 	[list $BX6 $BY1 [expr 2*$H]] $mass72  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass72+$mass72r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Exterior"	822 	[list $BX7 $BY1 [expr 2*$H]] $mass82  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass82+$mass82r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts

# Y=2; 3rd Floor
jointModel 	 "Exterior"	123 	[list 0.00 $BY1 [expr 3*$H]] $mass12  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	223 	[list $BX1 $BY1 [expr 3*$H]] $mass22  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	323 	[list $BX2 $BY1 [expr 3*$H]] $mass32  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	423 	[list $BX3 $BY1 [expr 3*$H]] $mass42  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	523 	[list $BX4 $BY1 [expr 3*$H]] $mass52  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass52+$mass52r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	623 	[list $BX5 $BY1 [expr 3*$H]] $mass62  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass62+$mass62r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	723 	[list $BX6 $BY1 [expr 3*$H]] $mass72  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass72+$mass72r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Exterior"	823 	[list $BX7 $BY1 [expr 3*$H]] $mass82  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass82+$mass82r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts

# Y=2; 4th Floor
jointModel 	 "Exterior"	124 	[list 0.00 $BY1 [expr 4*$H]] $mass12  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	224 	[list $BX1 $BY1 [expr 4*$H]] $mass22  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	324 	[list $BX2 $BY1 [expr 4*$H]] $mass32  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	424 	[list $BX3 $BY1 [expr 4*$H]] $mass42  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	524 	[list $BX4 $BY1 [expr 4*$H]] $mass52  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass52+$mass52r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	624 	[list $BX5 $BY1 [expr 4*$H]] $mass62  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass62+$mass62r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	724 	[list $BX6 $BY1 [expr 4*$H]] $mass72  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass72+$mass72r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Exterior"	824 	[list $BX7 $BY1 [expr 4*$H]] $mass82  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass82+$mass82r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts

# Y=3; 1st Floor
jointModel 	 "Exterior"	131 	[list 0.00 $BY2 [expr 1*$H]] $mass13  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	231 	[list $BX1 $BY2 [expr 1*$H]] $mass23  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	331 	[list $BX2 $BY2 [expr 1*$H]] $mass33  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	431 	[list $BX3 $BY2 [expr 1*$H]] $mass43  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	531 	[list $BX4 $BY2 [expr 1*$H]] $mass53  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass53+$mass53r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	631 	[list $BX5 $BY2 [expr 1*$H]] $mass63  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass63+$mass63r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	731 	[list $BX6 $BY2 [expr 1*$H]] $mass73  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass73+$mass73r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Exterior"	831 	[list $BX7 $BY2 [expr 1*$H]] $mass73  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass83+$mass83r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts

# Y=3; 2nd Floor
jointModel 	 "Exterior"	132 	[list 0.00 $BY2 [expr 2*$H]] $mass13  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	232 	[list $BX1 $BY2 [expr 2*$H]] $mass23  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	332 	[list $BX2 $BY2 [expr 2*$H]] $mass33  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	432 	[list $BX3 $BY2 [expr 2*$H]] $mass43  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	532 	[list $BX4 $BY2 [expr 2*$H]] $mass53  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass53+$mass53r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	632 	[list $BX5 $BY2 [expr 2*$H]] $mass63  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass63+$mass63r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	732 	[list $BX6 $BY2 [expr 2*$H]] $mass73  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass73+$mass73r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Exterior"	832 	[list $BX7 $BY2 [expr 2*$H]] $mass73  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass83+$mass83r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts

# Y=3; 3rd Floor
jointModel 	 "Exterior"	133 	[list 0.00 $BY2 [expr 3*$H]] $mass13  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	233 	[list $BX1 $BY2 [expr 3*$H]] $mass23  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	333 	[list $BX2 $BY2 [expr 3*$H]] $mass33  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	433 	[list $BX3 $BY2 [expr 3*$H]] $mass43  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	533 	[list $BX4 $BY2 [expr 3*$H]] $mass53  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass53+$mass53r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	633 	[list $BX5 $BY2 [expr 3*$H]] $mass63  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass63+$mass63r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	733 	[list $BX6 $BY2 [expr 3*$H]] $mass73  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass73+$mass73r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Exterior"	833 	[list $BX7 $BY2 [expr 3*$H]] $mass73  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass83+$mass83r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts

# Y=3; 4th Floor
jointModel 	 "Exterior"	134 	[list 0.00 $BY2 [expr 4*$H]] $mass13  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	234 	[list $BX1 $BY2 [expr 4*$H]] $mass23  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	334 	[list $BX2 $BY2 [expr 4*$H]] $mass33  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	434 	[list $BX3 $BY2 [expr 4*$H]] $mass43  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	534 	[list $BX4 $BY2 [expr 4*$H]] $mass53  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass53+$mass53r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	634 	[list $BX5 $BY2 [expr 4*$H]] $mass63  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass63+$mass63r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	734 	[list $BX6 $BY2 [expr 4*$H]] $mass73  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass73+$mass73r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Exterior"	834 	[list $BX7 $BY2 [expr 4*$H]] $mass73  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass83+$mass83r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts

# Y=4; 1st Floor
jointModel 	 "Exterior"	141 	[list 0.00 $BY3 [expr 1*$H]] $mass14  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass14+$mass14r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	241 	[list $BX1 $BY3 [expr 1*$H]] $mass24  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass24+$mass24r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	341 	[list $BX2 $BY3 [expr 1*$H]] $mass34  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass34+$mass34r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	441 	[list $BX3 $BY3 [expr 1*$H]] $mass44  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass44+$mass44r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	541 	[list $BX4 $BY3 [expr 1*$H]] $mass54  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass54+$mass54r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	641 	[list $BX5 $BY3 [expr 1*$H]] $mass64  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass64+$mass64r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	741 	[list $BX6 $BY3 [expr 1*$H]] $mass74  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass74+$mass74r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Exterior"	841 	[list $BX7 $BY3 [expr 1*$H]] $mass84  $col1 $bm1 $c_c1 $brs3  [expr (3*$mass84+$mass84r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts

# Y=4; 2nd Floor
jointModel 	 "Exterior"	142 	[list 0.00 $BY3 [expr 2*$H]] $mass14  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass14+$mass14r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	242 	[list $BX1 $BY3 [expr 2*$H]] $mass24  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass24+$mass24r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	342 	[list $BX2 $BY3 [expr 2*$H]] $mass34  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass34+$mass34r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	442 	[list $BX3 $BY3 [expr 2*$H]] $mass44  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass44+$mass44r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	542 	[list $BX4 $BY3 [expr 2*$H]] $mass54  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass54+$mass54r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	642 	[list $BX5 $BY3 [expr 2*$H]] $mass64  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass64+$mass64r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	742 	[list $BX6 $BY3 [expr 2*$H]] $mass74  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass74+$mass74r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Exterior"	842 	[list $BX7 $BY3 [expr 2*$H]] $mass84  $col2 $bm1 $c_c1 $brs2  [expr (2*$mass84+$mass84r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts

# Y=4; 3rd Floor
jointModel 	 "Exterior"	143 	[list 0.00 $BY3 [expr 3*$H]] $mass14  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass14+$mass14r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	243 	[list $BX1 $BY3 [expr 3*$H]] $mass24  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass24+$mass24r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	343 	[list $BX2 $BY3 [expr 3*$H]] $mass34  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass34+$mass34r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	443 	[list $BX3 $BY3 [expr 3*$H]] $mass44  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass44+$mass44r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	543 	[list $BX4 $BY3 [expr 3*$H]] $mass54  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass54+$mass54r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	643 	[list $BX5 $BY3 [expr 3*$H]] $mass64  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass64+$mass64r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	743 	[list $BX6 $BY3 [expr 3*$H]] $mass74  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass74+$mass74r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Exterior"	843 	[list $BX7 $BY3 [expr 3*$H]] $mass84  $col2 $bm1 $c_c1 $brs2  [expr (1*$mass84+$mass84r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts

# Y=4; 4th Floor
jointModel 	 "Exterior"	144 	[list 0.00 $BY3 [expr 4*$H]] $mass14  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass14+$mass14r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	244 	[list $BX1 $BY3 [expr 4*$H]] $mass24  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass24+$mass24r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	344 	[list $BX2 $BY3 [expr 4*$H]] $mass34  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass34+$mass34r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	444 	[list $BX3 $BY3 [expr 4*$H]] $mass44  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass44+$mass44r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	544 	[list $BX4 $BY3 [expr 4*$H]] $mass54  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass54+$mass54r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	644 	[list $BX5 $BY3 [expr 4*$H]] $mass64  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass64+$mass64r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	744 	[list $BX6 $BY3 [expr 4*$H]] $mass74  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass74+$mass74r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Exterior"	844 	[list $BX7 $BY3 [expr 4*$H]] $mass84  $col2 $bm1 $c_c1 $brs2  [expr (0*$mass84+$mass84r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts

puts "Joints created..."

# -------------------
# Beams
# -------------------
# X-Direction
# -------------------

#1st Floor

# Y=1;
rcBC_Duct 	5111 $GTbX1  6111 6211 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5211 $GTbX1  6211 6311 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5311 $GTbX1  6311 6411 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5411 $GTbX1  6411 6511 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5511 $GTbX1  6511 6611 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5611 $GTbX1  6611 6711 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5711 $GTbX1  6711 6811 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# Y=2;
rcBC_Duct 	5121 $GTbX1  6121 6221 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5221 $GTbX1  6221 6321 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5321 $GTbX1  6321 6421 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
#rcBC_Duct 	5421 $GTbX1  6421 6521 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5521 $GTbX1  6521 6621 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5621 $GTbX1  6621 6721 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5721 $GTbX1  6721 6821 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=3;
rcBC_Duct 	5131 $GTbX1  6131 6231 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5231 $GTbX1  6231 6331 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5331 $GTbX1  6331 6431 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5431 $GTbX1  6431 6531 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5531 $GTbX1  6531 6631 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5631 $GTbX1  6631 6731 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5731 $GTbX1  6731 6831 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=4;
rcBC_Duct 	5141 $GTbX1  6141 6241 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5241 $GTbX1  6241 6341 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5341 $GTbX1  6341 6441 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5441 $GTbX1  6441 6541 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5541 $GTbX1  6541 6641 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5641 $GTbX1  6641 6741 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5741 $GTbX1  6741 6841 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#2nd Floor

# Y=1;
rcBC_Duct 	5112 $GTbX1  6112 6212 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5212 $GTbX1  6212 6312 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5312 $GTbX1  6312 6412 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5412 $GTbX1  6412 6512 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5512 $GTbX1  6512 6612 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5612 $GTbX1  6612 6712 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5712 $GTbX1  6712 6812 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# Y=2;
rcBC_Duct 	5122 $GTbX1  6122 6222 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5222 $GTbX1  6222 6322 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5322 $GTbX1  6322 6422 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
#rcBC_Duct 	5422 $GTbX1  6422 6522 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5522 $GTbX1  6522 6622 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5622 $GTbX1  6622 6722 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5722 $GTbX1  6722 6822 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=3;
rcBC_Duct 	5132 $GTbX1  6132 6232 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5232 $GTbX1  6232 6332 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5332 $GTbX1  6332 6432 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5432 $GTbX1  6432 6532 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5532 $GTbX1  6532 6632 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5632 $GTbX1  6632 6732 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5732 $GTbX1  6732 6832 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=4;
rcBC_Duct 	5142 $GTbX1  6142 6242 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5242 $GTbX1  6242 6342 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5342 $GTbX1  6342 6442 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5442 $GTbX1  6442 6542 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5542 $GTbX1  6542 6642 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5642 $GTbX1  6642 6742 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5742 $GTbX1  6742 6842 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#3rd Floor

# Y=1;
rcBC_Duct 	5113 $GTbX1  6113 6213 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5213 $GTbX1  6213 6313 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5313 $GTbX1  6313 6413 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5413 $GTbX1  6413 6513 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5513 $GTbX1  6513 6613 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5613 $GTbX1  6613 6713 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5713 $GTbX1  6713 6813 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# Y=2;
rcBC_Duct 	5123 $GTbX1  6123 6223 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5223 $GTbX1  6223 6323 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5323 $GTbX1  6323 6423 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
#rcBC_Duct 	5423 $GTbX1  6423 6523 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5523 $GTbX1  6523 6623 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5623 $GTbX1  6623 6723 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5723 $GTbX1  6723 6823 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=3;
rcBC_Duct 	5133 $GTbX1  6133 6233 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5233 $GTbX1  6233 6333 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5333 $GTbX1  6333 6433 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5433 $GTbX1  6433 6533 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5533 $GTbX1  6533 6633 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5633 $GTbX1  6633 6733 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5733 $GTbX1  6733 6833 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=4;
rcBC_Duct 	5143 $GTbX1  6143 6243 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5243 $GTbX1  6243 6343 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5343 $GTbX1  6343 6443 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5443 $GTbX1  6443 6543 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5543 $GTbX1  6543 6643 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5643 $GTbX1  6643 6743 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5743 $GTbX1  6743 6843 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#4th Floor

# Y=1;
rcBC_Duct 	5114 $GTbX1  6114 6214 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5214 $GTbX1  6214 6314 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5314 $GTbX1  6314 6414 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5414 $GTbX1  6414 6514 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5514 $GTbX1  6514 6614 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5614 $GTbX1  6614 6714 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5714 $GTbX1  6714 6814 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# Y=2;
rcBC_Duct 	5124 $GTbX1  6124 6224 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5224 $GTbX1  6224 6324 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5324 $GTbX1  6324 6424 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
#rcBC_Duct 	5424 $GTbX1  6424 6524 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5524 $GTbX1  6524 6624 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5624 $GTbX1  6624 6724 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5724 $GTbX1  6724 6824 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=3;
rcBC_Duct 	5134 $GTbX1  6134 6234 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5234 $GTbX1  6234 6334 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5334 $GTbX1  6334 6434 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5434 $GTbX1  6434 6534 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5534 $GTbX1  6534 6634 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5634 $GTbX1  6634 6734 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5734 $GTbX1  6734 6834 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=4;
rcBC_Duct 	5144 $GTbX1  6144 6244 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5244 $GTbX1  6244 6344 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5344 $GTbX1  6344 6444 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5444 $GTbX1  6444 6544 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5544 $GTbX1  6544 6644 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.575  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5644 $GTbX1  6644 6744 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5744 $GTbX1  6744 6844 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.750  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# -------------------
# Y-Direction
# -------------------

#1st Floor

# X=1;
rcBC_Duct 	6111 $GTbY1  6111 6121 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6121 $GTbY1  6121 6131 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6131 $GTbY1  6131 6141 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# X=2;
rcBC_Duct 	6211 $GTbY2  6211 6221 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6221 $GTbY2  6221 6231 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6231 $GTbY2  6231 6241 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=3;
rcBC_Duct 	6311 $GTbY2  6311 6321 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6321 $GTbY2  6321 6331 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6331 $GTbY2  6331 6341 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=4;
rcBC_Duct 	6411 $GTbY2  6411 6421 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6421 $GTbY2  6421 6431 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6431 $GTbY2  6431 6441 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=5;
rcBC_Duct 	6511 $GTbY2  6511 6521 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6521 $GTbY2  6521 6531 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct	  6531 $GTbY2  6531 6541 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=6;
rcBC_Duct 	6611 $GTbY2  6611 6621 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6621 $GTbY2  6621 6631 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6631 $GTbY2  6631 6641 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=7;
rcBC_Duct 	6711 $GTbY2  6711 6721 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6721 $GTbY2  6721 6731 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6731 $GTbY2  6731 6741 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=8;
rcBC_Duct 	6811 $GTbY1  6811 6821 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6821 $GTbY1  6821 6831 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6831 $GTbY1  6831 6841 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#2nd Floor

# X=1;
rcBC_Duct 	6112 $GTbY1  6112 6122 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6122 $GTbY1  6122 6132 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6132 $GTbY1  6132 6142 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# X=2;
rcBC_Duct 	6212 $GTbY2  6212 6222 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6222 $GTbY2  6222 6232 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6232 $GTbY2  6232 6242 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=3;
rcBC_Duct 	6312 $GTbY2  6312 6322 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6322 $GTbY2  6322 6332 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6332 $GTbY2  6332 6342 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=4;
rcBC_Duct 	6412 $GTbY2  6412 6422 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6422 $GTbY2  6422 6432 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6432 $GTbY2  6432 6442 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=5;
rcBC_Duct 	6512 $GTbY2  6512 6522 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6522 $GTbY2  6522 6532 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct	  6532 $GTbY2  6532 6542 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=6;
rcBC_Duct 	6612 $GTbY2  6612 6622 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6622 $GTbY2  6622 6632 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6632 $GTbY2  6632 6642 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=7;
rcBC_Duct 	6712 $GTbY2  6712 6722 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6722 $GTbY2  6722 6732 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6732 $GTbY2  6732 6742 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=8;
rcBC_Duct 	6812 $GTbY1  6812 6822 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6822 $GTbY1  6822 6832 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6832 $GTbY1  6832 6842 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#3rd Floor

# X=1;
rcBC_Duct 	6113 $GTbY1  6113 6123 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6123 $GTbY1  6123 6133 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6133 $GTbY1  6133 6143 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# X=2;
rcBC_Duct 	6213 $GTbY2  6213 6223 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6223 $GTbY2  6223 6233 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6233 $GTbY2  6233 6243 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=3;
rcBC_Duct 	6313 $GTbY2  6313 6323 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6323 $GTbY2  6323 6333 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6333 $GTbY2  6333 6343 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=4;
rcBC_Duct 	6413 $GTbY2  6413 6423 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6423 $GTbY2  6423 6433 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6433 $GTbY2  6433 6443 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=5;
rcBC_Duct 	6513 $GTbY2  6513 6523 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6523 $GTbY2  6523 6533 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct	  6533 $GTbY2  6533 6543 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=6;
rcBC_Duct 	6613 $GTbY2  6613 6623 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6623 $GTbY2  6623 6633 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6633 $GTbY2  6633 6643 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=7;
rcBC_Duct 	6713 $GTbY2  6713 6723 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6723 $GTbY2  6723 6733 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6733 $GTbY2  6733 6743 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=8;
rcBC_Duct 	6813 $GTbY1  6813 6823 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6823 $GTbY1  6823 6833 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6833 $GTbY1  6833 6843 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#4th Floor

# X=1;
rcBC_Duct 	6114 $GTbY1  6114 6124 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6124 $GTbY1  6124 6134 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6134 $GTbY1  6134 6144 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# X=2;
rcBC_Duct 	6214 $GTbY2  6214 6224 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6224 $GTbY2  6224 6234 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6234 $GTbY2  6234 6244 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=3;
rcBC_Duct 	6314 $GTbY2  6314 6324 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6324 $GTbY2  6324 6334 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6334 $GTbY2  6334 6344 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=4;
rcBC_Duct 	6414 $GTbY2  6414 6424 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6424 $GTbY2  6424 6434 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6434 $GTbY2  6434 6444 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=5;
rcBC_Duct 	6514 $GTbY2  6514 6524 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6524 $GTbY2  6524 6534 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct	  6534 $GTbY2  6534 6544 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=6;
rcBC_Duct 	6614 $GTbY2  6614 6624 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6624 $GTbY2  6624 6634 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 1.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6634 $GTbY2  6634 6644 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=7;
rcBC_Duct 	6714 $GTbY2  6714 6724 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6724 $GTbY2  6724 6734 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6734 $GTbY2  6734 6744 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.000  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=8;
rcBC_Duct 	6814 $GTbY1  6814 6824 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6824 $GTbY1  6824 6834 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6834 $GTbY1  6834 6844 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 2.000  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

puts "Beams created..."

# -------------------
# Columns
# -------------------

#1st Floor

# Y=1;
rcBC_Duct 	7111 $GTc1 1110 	1111 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass11+$mass11r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_Duct 	7211 $GTc1 1210 	1211 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass21+$mass21r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_Duct 	7311 $GTc1 1310 	1311 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass31+$mass31r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols

#split these columns
#--------------------
rcBC_Duct 	74101 $GTc1 1410 	14101 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass41+$mass41r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_Duct 	7411  $GTc1 14101  1411 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass41+$mass41r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols

rcBC_Duct 	75101 $GTc1 1510 	15101 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass51+$mass51r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_Duct 	7511  $GTc1 15101  1511 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass51+$mass51r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
#--------------------

rcBC_Duct 	7611 $GTc1 1610 	1611 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass61+$mass61r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_Duct 	7711 $GTc1 1710 	1711 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass71+$mass71r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_Duct 	7811 $GTc1 1810 	1811 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass81+$mass81r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols

# Y=2;
rcBC_Duct 	7121 $GTc1 1120 	1121 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass12+$mass12r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_Duct 	7221 $GTc1 1220 	1221 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass22+$mass22r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_Duct 	7321 $GTc1 1320 	1321 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass32+$mass32r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols

#split these columns
#--------------------
rcBC_Duct 	74201 $GTc1 1420 	14201 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass42+$mass42r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_Duct 	7421  $GTc1 14201  1421 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass42+$mass42r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols

rcBC_Duct 	75201 $GTc1 1520 	15201 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass52+$mass52r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_Duct 	7521  $GTc1 15201  1521 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass52+$mass52r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
#--------------------

rcBC_Duct 	7621 $GTc1 1620 	1621 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass62+$mass62r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_Duct 	7721 $GTc1 1720 	1721 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass72+$mass72r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_Duct 	7821 $GTc1 1820 	1821 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass82+$mass82r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols

# Y=3;
rcBC_Duct 	7131 $GTc1 1130 	1131 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass13+$mass13r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_Duct 	7231 $GTc1 1230 	1231 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass23+$mass23r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_Duct 	7331 $GTc1 1330 	1331 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass33+$mass33r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_Duct 	7431 $GTc1 1430 	1431 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass43+$mass43r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_Duct 	7531 $GTc1 1530 	1531 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass53+$mass53r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_Duct 	7631 $GTc1 1630 	1631 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass63+$mass63r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_Duct 	7731 $GTc1 1730 	1731 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass73+$mass73r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_Duct 	7831 $GTc1 1830 	1831 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass83+$mass83r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols

# Y=4;
rcBC_Duct 	7141 $GTc1 1140 	1141 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass14+$mass14r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_Duct 	7241 $GTc1 1240 	1241 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass24+$mass24r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_Duct 	7341 $GTc1 1340 	1341 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass34+$mass34r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_Duct 	7441 $GTc1 1440 	1441 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass44+$mass44r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_Duct 	7541 $GTc1 1540 	1541 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass54+$mass54r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$pfile_cols
rcBC_Duct 	7641 $GTc1 1640 	1641 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass64+$mass64r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_Duct 	7741 $GTc1 1740 	1741 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass74+$mass74r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols
rcBC_Duct 	7841 $GTc1 1840 	1841 	$fyL $fyV $Es $fcc1 $Ecc1 $bc1 $hc1 $sc $cv $dbL3 $dbV [expr (3*$mass84+$mass84r)*$g] [expr $H/2] 	$rC1_shr 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot 	$rC1_top 	0.0 		$rC1_bot	$pfile_cols

#2nd Floor

# Y=1;
rcBC_Duct 	7112 $GTc2 1111 	1112 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass11+$mass11r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7212 $GTc2 1211 	1212 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass21+$mass21r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7312 $GTc2 1311 	1312 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass31+$mass31r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols

#split these columns
#--------------------
rcBC_Duct 	74112 $GTc2 1411 	14112 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass41+$mass41r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7412  $GTc2 14112  1412 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass41+$mass41r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

rcBC_Duct 	75112 $GTc2 1511 	15112 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass51+$mass51r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7512  $GTc2 15112  1512 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass51+$mass51r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
#--------------------

rcBC_Duct 	7612 $GTc2 1611 	1612 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass61+$mass61r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7712 $GTc2 1711 	1712 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass71+$mass71r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7812 $GTc2 1811 	1812 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass81+$mass81r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

# Y=2;
rcBC_Duct 	7122 $GTc2 1121 	1122 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass12+$mass12r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7222 $GTc2 1221 	1222 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass22+$mass22r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7322 $GTc2 1321 	1322 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass32+$mass32r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols

#split these columns
#--------------------
rcBC_Duct 	74212 $GTc2 1421 	14212 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass42+$mass42r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7422 $GTc2 14212 	1422 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass42+$mass42r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

rcBC_Duct 	75212 $GTc2 1521 	15212 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass52+$mass52r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7522 $GTc2 15212 	1522 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass52+$mass52r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
#--------------------

rcBC_Duct 	7622 $GTc2 1621 	1622 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass62+$mass62r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7722 $GTc2 1721 	1722 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass72+$mass72r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7822 $GTc2 1821 	1822 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass82+$mass82r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

# Y=3;
rcBC_Duct 	7132 $GTc2 1131 	1132 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass13+$mass13r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7232 $GTc2 1231 	1232 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass23+$mass23r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7332 $GTc2 1331 	1332 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass33+$mass33r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7432 $GTc2 1431 	1432 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass43+$mass43r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7532 $GTc2 1531 	1532 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass53+$mass53r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7632 $GTc2 1631 	1632 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass63+$mass63r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7732 $GTc2 1731 	1732 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass73+$mass73r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7832 $GTc2 1831 	1832 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass83+$mass83r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

# Y=4;
rcBC_Duct 	7142 $GTc2 1141 	1142 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass14+$mass14r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7242 $GTc2 1241 	1242 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass24+$mass24r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7342 $GTc2 1341 	1342 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass34+$mass34r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7442 $GTc2 1441 	1442 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass44+$mass44r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7542 $GTc2 1541 	1542 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass54+$mass54r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7642 $GTc2 1641 	1642 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass64+$mass64r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7742 $GTc2 1741 	1742 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass74+$mass74r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7842 $GTc2 1841 	1842 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (2*$mass84+$mass84r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

#3rd Floor

# Y=1;
rcBC_Duct 	7113 $GTc2 1112 	1113 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass11+$mass11r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7213 $GTc2 1212 	1213 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass21+$mass21r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7313 $GTc2 1312 	1313 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass31+$mass31r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols

#split these columns
#--------------------
rcBC_Duct 	74123 $GTc2 1412 	14123 $fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass41+$mass41r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7413  $GTc2 14123 1413 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass41+$mass41r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

rcBC_Duct 	75123 $GTc2 1512  15123  $fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass51+$mass51r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7513  $GTc2 15123  1513  $fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass51+$mass51r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
#--------------------

rcBC_Duct 	7613 $GTc2 1612 	1613 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass61+$mass61r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7713 $GTc2 1712 	1713 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass71+$mass71r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7813 $GTc2 1812 	1813 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass81+$mass81r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

# Y=2;
rcBC_Duct 	7123 $GTc2 1122 	1123 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass12+$mass12r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7223 $GTc2 1222 	1223 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass22+$mass22r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7323 $GTc2 1322 	1323 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass32+$mass32r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols

#split these columns
#--------------------
rcBC_Duct 	74223 $GTc2 1422 	14223 $fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass42+$mass42r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7423 $GTc2 14223 	1423 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass42+$mass42r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

rcBC_Duct 	75223 $GTc2 1522 	15223 $fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass52+$mass52r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7523 $GTc2 15223 	1523 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass52+$mass52r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
#--------------------

rcBC_Duct 	7623 $GTc2 1622 	1623 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass62+$mass62r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7723 $GTc2 1722 	1723 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass72+$mass72r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7823 $GTc2 1822 	1823 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass82+$mass82r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

# Y=3;
rcBC_Duct 	7133 $GTc2 1132 	1133 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass13+$mass13r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7233 $GTc2 1232 	1233 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass23+$mass23r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7333 $GTc2 1332 	1333 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass33+$mass33r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7433 $GTc2 1432 	1433 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass43+$mass43r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7533 $GTc2 1532 	1533 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass53+$mass53r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7633 $GTc2 1632 	1633 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass63+$mass63r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7733 $GTc2 1732 	1733 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass73+$mass73r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7833 $GTc2 1832 	1833 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass83+$mass83r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

# Y=4;
rcBC_Duct 	7143 $GTc2 1142 	1143 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass14+$mass14r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7243 $GTc2 1242 	1243 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass24+$mass24r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7343 $GTc2 1342 	1343 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass34+$mass34r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7443 $GTc2 1442 	1443 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass44+$mass44r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7543 $GTc2 1542 	1543 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass54+$mass54r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7643 $GTc2 1642 	1643 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass64+$mass64r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7743 $GTc2 1742 	1743 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass74+$mass74r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7843 $GTc2 1842 	1843 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (1*$mass84+$mass84r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

#4th Floor

# Y=1;
rcBC_Duct 	7114 $GTc2 1113 	1114 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass11+$mass11r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7214 $GTc2 1213 	1214 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass21+$mass21r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7314 $GTc2 1313 	1314 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass31+$mass31r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7414 $GTc2 1413 	1414  $fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass41+$mass41r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7514 $GTc2 1513 	1514 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass51+$mass51r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7614 $GTc2 1613 	1614 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass61+$mass61r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7714 $GTc2 1713 	1714 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass71+$mass71r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7814 $GTc2 1813 	1814 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass81+$mass81r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

# Y=2;
rcBC_Duct 	7124 $GTc2 1123 	1124 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass12+$mass12r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7224 $GTc2 1223 	1224 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass22+$mass22r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7324 $GTc2 1323 	1324 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass32+$mass32r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7424 $GTc2 1423 	1424 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass42+$mass42r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7524 $GTc2 1523 	1524 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass52+$mass52r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7624 $GTc2 1623 	1624 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass62+$mass62r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7724 $GTc2 1723 	1724 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass72+$mass72r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7824 $GTc2 1823 	1824 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass82+$mass82r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

# Y=3;
rcBC_Duct 	7134 $GTc2 1133 	1134 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass13+$mass13r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7234 $GTc2 1233 	1234 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass23+$mass23r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7334 $GTc2 1333 	1334 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass33+$mass33r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7434 $GTc2 1433 	1434 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass43+$mass43r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7534 $GTc2 1533 	1534 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass53+$mass53r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7634 $GTc2 1633 	1634 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass63+$mass63r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7734 $GTc2 1733 	1734 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass73+$mass73r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7834 $GTc2 1833 	1834 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass83+$mass83r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

# Y=4;
rcBC_Duct 	7144 $GTc2 1143 	1144 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass14+$mass14r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7244 $GTc2 1243 	1244 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass24+$mass24r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7344 $GTc2 1343 	1344 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass34+$mass34r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7444 $GTc2 1443 	1444 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass44+$mass44r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7544 $GTc2 1543 	1544 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass54+$mass54r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$pfile_cols
rcBC_Duct 	7644 $GTc2 1643 	1644 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass64+$mass64r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7744 $GTc2 1743 	1744 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass74+$mass74r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols
rcBC_Duct 	7844 $GTc2 1843 	1844 	$fyL $fyV $Es $fcc1 $Ecc1 $bc2 $hc2 $sc $cv $dbL2 $dbV [expr (0*$mass84+$mass84r)*$g] [expr $H/2] 	$rC2_shr 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot 	$rC2_top 	0.0 		$rC2_bot	$pfile_cols

puts "Columns created..."
}

if {$infillsOPT == 1} {
  # -------------------
  # Infills
  # -------------------
  # X-Direction
  # -------------------

  # 1st Floor

  # X=1;
  infill 		2111 	single 	[list 1111 1211 1210 1110] 	 3500. [expr $H*1000] 	   $hb1  	$bc1	$hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2211 	single 	[list 1211 1311 1310 1210] 	 2000. [expr $H*1000] 	   $hb1  	$bc1	$hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2311 	single 	[list 1311 1411 1410 1310] 	 3150. [expr $H*1000] 	   $hb1  	$bc1	$hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2411 	single 	[list 1411 1511 1510 1410] 	 2700. [expr $H*1000] 	   $hb1  	$bc1	$hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2511 	single 	[list 1511 1611 1610 1510] 	 3150. [expr $H*1000] 	   $hb1  	$bc1	$hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2611 	single 	[list 1611 1711 1710 1610] 	 2000. [expr $H*1000] 	   $hb1  	$bc1	$hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2711 	single 	[list 1711 1811 1810 1710] 	 3500. [expr $H*1000] 	   $hb1  	$bc1	$hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

  # X=2;
  infill 		2221 	single 	[list 1221 1321 1320 1220] 	 2000. [expr $H*1000] 	   $hb1  	$bc1	$hc1 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
  infill 		2621 	single 	[list 1621 1721 1720 1620] 	 2000. [expr $H*1000] 	   $hb1  	$bc1	$hc1 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0

  # X=3;
  infill 		2231 	single 	[list 1231 1331 1330 1230] 	 2000. [expr $H*1000] 	   $hb1  	$bc1	$hc1 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
  infill 		2631 	single 	[list 1631 1731 1730 1630] 	 2000. [expr $H*1000] 	   $hb1  	$bc1	$hc1 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0

  # X=4;
  infill 		2141 	single 	[list 1141 1241 1240 1140] 	 3500. [expr $H*1000] 	   $hb1  	$bc1	$hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2241 	single 	[list 1241 1341 1340 1240] 	 2000. [expr $H*1000] 	   $hb1  	$bc1	$hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2341 	single 	[list 1341 1441 1440 1340] 	 3150. [expr $H*1000] 	   $hb1  	$bc1	$hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2441 	single 	[list 1441 1541 1540 1440] 	 2700. [expr $H*1000] 	   $hb1  	$bc1	$hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2541 	single 	[list 1541 1641 1640 1540] 	 3150. [expr $H*1000] 	   $hb1  	$bc1	$hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2641 	single 	[list 1641 1741 1740 1640] 	 2000. [expr $H*1000] 	   $hb1  	$bc1	$hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2741 	single 	[list 1741 1841 1840 1740] 	 3500. [expr $H*1000] 	   $hb1  	$bc1	$hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

  # 2nd Floor

  # X=1;
  infill 		2112 	single 	[list 1112 1212 1211 1111] 	 3500. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2212 	single 	[list 1212 1312 1311 1211] 	 2000. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2312 	single 	[list 1312 1412 1411 1311] 	 3150. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2412 	single 	[list 1412 1512 1511 1411] 	 2700. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2512 	single 	[list 1512 1612 1611 1511] 	 3150. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2612 	single 	[list 1612 1712 1711 1611] 	 2000. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2712 	single 	[list 1712 1812 1811 1711] 	 3500. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

  # X=2;
  infill 		2222 	single 	[list 1222 1322 1321 1221] 	 2000. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
  infill 		2622 	single 	[list 1622 1722 1721 1621] 	 2000. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0

  # X=3;
  infill 		2232 	single 	[list 1232 1332 1331 1231] 	 2000. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
  infill 		2632 	single 	[list 1632 1732 1731 1631] 	 2000. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0

  # X=4;
  infill 		2142 	single 	[list 1142 1242 1241 1141] 	 3500. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2242 	single 	[list 1242 1342 1341 1241] 	 2000. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2342 	single 	[list 1342 1442 1441 1341] 	 3150. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2442 	single 	[list 1442 1542 1541 1441] 	 2700. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2542 	single 	[list 1542 1642 1641 1541] 	 3150. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2642 	single 	[list 1642 1742 1741 1641] 	 2000. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2742 	single 	[list 1742 1842 1841 1741] 	 3500. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

  # 3rd Floor

  # X=1;
  infill 		2113 	single 	[list 1113 1213 1212 1112] 	 3500. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2213 	single 	[list 1213 1313 1312 1212] 	 2000. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2313 	single 	[list 1313 1413 1412 1312] 	 3150. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2413 	single 	[list 1413 1513 1512 1412] 	 2700. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2513 	single 	[list 1513 1613 1612 1512] 	 3150. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2613 	single 	[list 1613 1713 1712 1612] 	 2000. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2713 	single 	[list 1713 1813 1812 1712] 	 3500. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

  # X=2;
  infill 		2223 	single 	[list 1223 1323 1322 1222] 	 2000. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
  infill 		2623 	single 	[list 1623 1723 1722 1622] 	 2000. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0

  # X=3;
  infill 		2233 	single 	[list 1233 1333 1332 1232] 	 2000. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
  infill 		2633 	single 	[list 1633 1733 1732 1632] 	 2000. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0

  # X=4;
  infill 		2143 	single 	[list 1143 1243 1242 1142] 	 3500. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2243 	single 	[list 1243 1343 1342 1242] 	 2000. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2343 	single 	[list 1343 1443 1442 1342] 	 3150. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2443 	single 	[list 1443 1543 1542 1442] 	 2700. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2543 	single 	[list 1543 1643 1642 1542] 	 3150. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2643 	single 	[list 1643 1743 1742 1642] 	 2000. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2743 	single 	[list 1743 1843 1842 1742] 	 3500. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

  # 4th Floor

  # X=1;
  infill 		2114 	single 	[list 1114 1214 1213 1113] 	 3500. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2214 	single 	[list 1214 1314 1313 1213] 	 2000. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2314 	single 	[list 1314 1414 1413 1313] 	 3150. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2414 	single 	[list 1414 1514 1513 1413] 	 2700. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2514 	single 	[list 1514 1614 1613 1513] 	 3150. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2614 	single 	[list 1614 1714 1713 1613] 	 2000. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2714 	single 	[list 1714 1814 1813 1713] 	 3500. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

  # X=2;
  infill 		2224 	single 	[list 1224 1324 1323 1223] 	 2000. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
  infill 		2624 	single 	[list 1624 1724 1723 1623] 	 2000. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0

  # X=3;
  infill 		2234 	single 	[list 1234 1334 1333 1233] 	 2000. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
  infill 		2634 	single 	[list 1634 1734 1733 1633] 	 2000. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0

  # X=4;
  infill 		2144 	single 	[list 1144 1244 1243 1143] 	 3500. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2244 	single 	[list 1244 1344 1343 1243] 	 2000. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2344 	single 	[list 1344 1444 1443 1343] 	 3150. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2444 	single 	[list 1444 1544 1543 1443] 	 2700. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2544 	single 	[list 1544 1644 1643 1543] 	 3150. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2644 	single 	[list 1644 1744 1743 1643] 	 2000. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		2744 	single 	[list 1744 1844 1843 1743] 	 3500. [expr $H*1000] 	   $hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

  # -------------------
  # Y-Direction
  # -------------------

  # 1st Floor

  # Y=1;
  infill 		3111 	single 	[list 1111 1121 1120 1110] 	3000. [expr $H*1000] 	$hb1  	$bc1	$hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		3211 	single 	[list 1121 1131 1130 1120] 	2000. [expr $H*1000] 	$hb1  	$bc1	$hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		3311 	single 	[list 1131 1141 1140 1130] 	4000. [expr $H*1000] 	$hb1  	$bc1	$hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

  # Y=2;
  infill 		3121 	single 	[list 1211 1221 1220 1210] 	3000. [expr $H*1000] 	$hb2  	$bc1	$hc1 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
  infill 		3221 	single 	[list 1221 1231 1230 1220] 	2000. [expr $H*1000] 	$hb2  	$bc1	$hc1 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0

  # Y=3;
  infill 		3131 	single 	[list 1311 1321 1320 1310] 	3000. [expr $H*1000] 	$hb2  	$bc1	$hc1 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
  infill 		3231 	single 	[list 1321 1331 1330 1320] 	2000. [expr $H*1000] 	$hb2  	$bc1	$hc1 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0

  # Y=4;
  infill 		3141 	single 	[list 1411 1421 1420 1410] 	3000. [expr $H*1000] 	$hb2  	$bc1	$hc1 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0
  infill 		3241 	single 	[list 1421 1431 1430 1420] 	2000. [expr $H*1000] 	$hb2  	$bc1	$hc1 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

  # Y=5;
  infill 		3151 	single 	[list 1511 1521 1520 1510] 	3000. [expr $H*1000] 	$hb2  	$bc1	$hc1 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0
  infill 		3251 	single 	[list 1521 1531 1530 1520] 	2000. [expr $H*1000] 	$hb2  	$bc1	$hc1 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

  # Y=6;
  infill 		3161 	single 	[list 1611 1621 1620 1610] 	3000. [expr $H*1000] 	$hb2  	$bc1	$hc1 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1	  $fws1 	0.0
  infill 		3261 	single 	[list 1621 1631 1630 1620] 	2000. [expr $H*1000] 	$hb2  	$bc1	$hc1 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0

  # Y=7;
  infill 		3171 	single 	[list 1711 1721 1720 1710] 	3000. [expr $H*1000] 	$hb2  	$bc1	$hc1 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
  infill 		3271 	single 	[list 1721 1731 1730 1720] 	2000. [expr $H*1000] 	$hb2  	$bc1	$hc1 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0

  # Y=8;
  infill 		3181 	single 	[list 1811 1821 1820 1810] 	3000. [expr $H*1000] 	$hb1  	$bc1	$hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		3281 	single 	[list 1821 1831 1830 1820] 	2000. [expr $H*1000] 	$hb1  	$bc1	$hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		3381 	single 	[list 1831 1841 1840 1830] 	4000. [expr $H*1000] 	$hb1  	$bc1	$hc1 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

  # 2nd Floor

  # Y=1;
  infill 		3112 	single 	[list 1112 1122 1121 1111] 	3000. [expr $H*1000] 	$hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		3212 	single 	[list 1122 1132 1131 1121] 	2000. [expr $H*1000] 	$hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		3312 	single 	[list 1132 1142 1141 1131] 	4000. [expr $H*1000] 	$hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

  # Y=2;
  infill 		3122 	single 	[list 1212 1222 1221 1211] 	3000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
  infill 		3222 	single 	[list 1222 1232 1231 1221] 	2000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0

  # Y=3;
  infill 		3132 	single 	[list 1312 1322 1321 1311] 	3000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
  infill 		3232 	single 	[list 1322 1332 1331 1321] 	2000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0

  # Y=4;
  infill 		3142 	single 	[list 1412 1422 1421 1411] 	3000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0
  infill 		3242 	single 	[list 1422 1432 1431 1421] 	2000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

  # Y=5;
  infill 		3152 	single 	[list 1512 1522 1521 1511] 	3000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0
  infill 		3252 	single 	[list 1522 1532 1531 1521] 	2000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

  # Y=6;
  infill 		3162 	single 	[list 1612 1622 1621 1611] 	3000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1	  $fws1 	0.0
  infill 		3262 	single 	[list 1622 1632 1631 1621] 	2000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0

  # Y=7;
  infill 		3172 	single 	[list 1712 1722 1721 1711] 	3000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
  infill 		3272 	single 	[list 1722 1732 1731 1721] 	2000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0

  # Y=8;
  infill 		3182 	single 	[list 1812 1822 1821 1811] 	3000. [expr $H*1000] 	$hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		3282 	single 	[list 1822 1832 1831 1821] 	2000. [expr $H*1000] 	$hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		3382 	single 	[list 1832 1842 1841 1831] 	4000. [expr $H*1000] 	$hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

  # 3rd Floor

  # Y=1;
  infill 		3113 	single 	[list 1113 1123 1122 1112] 	3000. [expr $H*1000] 	$hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		3213 	single 	[list 1123 1133 1132 1122] 	2000. [expr $H*1000] 	$hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		3313 	single 	[list 1133 1143 1142 1132] 	4000. [expr $H*1000] 	$hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

  # Y=2;
  infill 		3123 	single 	[list 1213 1223 1222 1212] 	3000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
  infill 		3223 	single 	[list 1223 1233 1232 1222] 	2000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0

  # Y=3;
  infill 		3133 	single 	[list 1313 1323 1322 1312] 	3000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
  infill 		3233 	single 	[list 1323 1333 1332 1322] 	2000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0

  # Y=4;
  infill 		3143 	single 	[list 1413 1423 1422 1412] 	3000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0
  infill 		3243 	single 	[list 1423 1433 1432 1422] 	2000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

  # Y=5;
  infill 		3153 	single 	[list 1513 1523 1522 1512] 	3000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0
  infill 		3253 	single 	[list 1523 1533 1532 1522] 	2000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

  # Y=6;
  infill 		3163 	single 	[list 1613 1623 1622 1612] 	3000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1	  $fws1 	0.0
  infill 		3263 	single 	[list 1623 1633 1632 1622] 	2000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0

  # Y=7;
  infill 		3173 	single 	[list 1713 1723 1722 1712] 	3000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
  infill 		3273 	single 	[list 1723 1733 1732 1722] 	2000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0

  # Y=8;
  infill 		3183 	single 	[list 1813 1823 1822 1812] 	3000. [expr $H*1000] 	$hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		3283 	single 	[list 1823 1833 1832 1822] 	2000. [expr $H*1000] 	$hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		3383 	single 	[list 1833 1843 1842 1832] 	4000. [expr $H*1000] 	$hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

  # 4th Floor

  # Y=1;
  infill 		3114 	single 	[list 1114 1124 1123 1113] 	3000. [expr $H*1000] 	$hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		3214 	single 	[list 1124 1134 1133 1123] 	2000. [expr $H*1000] 	$hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		3314 	single 	[list 1134 1144 1143 1133] 	4000. [expr $H*1000] 	$hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

  # Y=2;
  infill 		3124 	single 	[list 1214 1224 1223 1213] 	3000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
  infill 		3224 	single 	[list 1224 1234 1233 1223] 	2000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0

  # Y=3;
  infill 		3134 	single 	[list 1314 1324 1323 1313] 	3000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
  infill 		3234 	single 	[list 1324 1334 1333 1323] 	2000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0

  # Y=4;
  infill 		3144 	single 	[list 1414 1424 1423 1413] 	3000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0
  infill 		3244 	single 	[list 1424 1434 1433 1423] 	2000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

  # Y=5;
  infill 		3154 	single 	[list 1514 1524 1523 1513] 	3000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0
  infill 		3254 	single 	[list 1524 1534 1533 1523] 	2000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

  # Y=6;
  infill 		3164 	single 	[list 1614 1624 1623 1613] 	3000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1	  $fws1 	0.0
  infill 		3264 	single 	[list 1624 1634 1633 1623] 	2000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0

  # Y=7;
  infill 		3174 	single 	[list 1714 1724 1723 1713] 	3000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0
  infill 		3274 	single 	[list 1724 1734 1733 1723] 	2000. [expr $H*1000] 	$hb2  	$bc2	$hc2 $tw1	$Ecc1 $Ewh1 	$Ewv1 	$Gw1 0.2 $fwv1 	$fwu1 	$fws1 	0.0

  # Y=8;
  infill 		3184 	single 	[list 1814 1824 1823 1813] 	3000. [expr $H*1000] 	$hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		3284 	single 	[list 1824 1834 1833 1823] 	2000. [expr $H*1000] 	$hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
  infill 		3384 	single 	[list 1834 1844 1843 1833] 	4000. [expr $H*1000] 	$hb1  	$bc2	$hc2 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

  puts "Infills created..."
  }

  # --------------------------------------
  # DEFINE STAIRS
  # --------------------------------------
  if {$stairsOPT == 1} {

  # Y-direction
  # Stairs from 0 to 1
  rcBC_nonDuct            $STb 	99911     $GTbY1  40   30 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99921     $GTbY1  1520 20 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99931     $GTbY1  15201 15101 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99941     $GTbX1  15101 14101 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99951     $GTbY1  30 41 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99961     $GTbY1  14201 14101 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99971     $GTbY1  10 1421 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99981     $GTbX1  20 30 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 0.675  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99991     $GTbX1  30 10 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 0.675  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	999101     $GTbX1  1421 41 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 0.675  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	999111     $GTbX1  41 1521 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 0.675  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

  # Stairs from 1 to 2
  rcBC_nonDuct            $STb 	99912     $GTbY1  41   31 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99922     $GTbY1  1521 21 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99932     $GTbY1  15212 15112 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99942     $GTbX1  15112 14112 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99952     $GTbY1  31 42 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99962     $GTbY1  14212 14112 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99972     $GTbY1  11 1422 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	999982     $GTbX1  21 31 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 0.675  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	999992     $GTbX1  31 11 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 0.675  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	999102     $GTbX1  1422 42 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	999112     $GTbX1  42 1522 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

  # Stairs from 2 to 3
  rcBC_nonDuct            $STb 	99913     $GTbY1  42   32 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99923     $GTbY1  1522 22 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99933     $GTbY1  15223 15123 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99943     $GTbX1  15123 14123 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99953     $GTbY1  32 43 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99963     $GTbY1  14223 14123 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99973     $GTbY1  12 1423 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99983     $GTbX1  22 32 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 0.675  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99993     $GTbX1  32 12 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 0.675  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	999103     $GTbX1  1423 43 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

  puts "Stairs created..."
  }

close $pfile_jnts
close $pfile_cols
close $pfile_bms

# --------------------------------------
# BOUNDARY CONDITIONS
# --------------------------------------
# Base Supports
# fix 	node	dX dY dZ rX rY rZ
fix 	1110	1  1  1  1  1  1
fix 	1210	1  1  1  1  1  1
fix 	1310	1  1  1  1  1  1
fix 	1410	1  1  1  1  1  1
fix 	1510	1  1  1  1  1  1
fix 	1610	1  1  1  1  1  1
fix 	1710	1  1  1  1  1  1
fix 	1810	1  1  1  1  1  1

fix 	1120	1  1  1  1  1  1
fix 	1220	1  1  1  1  1  1
fix 	1320	1  1  1  1  1  1
fix 	1420	1  1  1  1  1  1
fix 	1520	1  1  1  1  1  1
fix 	1620	1  1  1  1  1  1
fix 	1720	1  1  1  1  1  1
fix 	1820	1  1  1  1  1  1

fix 	1130	1  1  1  1  1  1
fix 	1230	1  1  1  1  1  1
fix 	1330	1  1  1  1  1  1
fix 	1430	1  1  1  1  1  1
fix 	1530	1  1  1  1  1  1
fix 	1630	1  1  1  1  1  1
fix 	1730	1  1  1  1  1  1
fix 	1830	1  1  1  1  1  1

fix 	1140	1  1  1  1  1  1
fix 	1240	1  1  1  1  1  1
fix 	1340	1  1  1  1  1  1
fix 	1440	1  1  1  1  1  1
fix 	1540	1  1  1  1  1  1
fix 	1640	1  1  1  1  1  1
fix 	1740	1  1  1  1  1  1
fix 	1840	1  1  1  1  1  1

if {$stairsOPT == 1} {
  fix 40 1 1 1 1 1 1
}

#Rigid Diaphragm (Closest node to center of stiffness)

rigidDiaphragm 3	1431 1111 1211 1311 1411 1511 1611 1711  1121 1221 1321 1421 1521 1621 1721 1131 1231 1331 1531 1631 1731 1141 1241 1341 1441 1541 1641 1741
rigidDiaphragm 3	1432 1112 1212 1312 1412 1512 1612 1712  1122 1222 1322 1422 1522 1622 1722 1132 1232 1332 1532 1632 1732 1142 1242 1342 1442 1542 1642 1742
rigidDiaphragm 3	1433 1113 1213 1313 1413 1513 1613 1713  1123 1223 1323 1423 1523 1623 1723 1133 1233 1333 1533 1633 1733 1143 1243 1343 1443 1543 1643 1743
rigidDiaphragm 3	1434 1114 1214 1314 1414 1514 1614 1714  1124 1224 1324 1424 1524 1624 1724 1134 1234 1334 1534 1634 1734 1144 1244 1344 1444 1544 1644 1744

# --------------------------------------
# GRAVITY LOAD PATTERN + ANALYSIS
# --------------------------------------
# Assign the loads
pattern Plain 101 Constant {
	load 1111 	0.0	0.0	[expr -$mass11*$g] 	0.0	0.0	0.0; # First Floor
	load 1211 	0.0	0.0	[expr -$mass21*$g] 	0.0	0.0	0.0; # First Floor
	load 1311 	0.0	0.0	[expr -$mass31*$g] 	0.0	0.0	0.0; # First Floor
	load 1411 	0.0	0.0	[expr -$mass41*$g] 	0.0	0.0	0.0; # First Floor
  load 1511 	0.0	0.0	[expr -$mass51*$g] 	0.0	0.0	0.0; # First Floor
  load 1611 	0.0	0.0	[expr -$mass61*$g] 	0.0	0.0	0.0; # First Floor
  load 1711 	0.0	0.0	[expr -$mass71*$g] 	0.0	0.0	0.0; # First Floor
  load 1811 	0.0	0.0	[expr -$mass81*$g] 	0.0	0.0	0.0; # First Floor

	load 1121 	0.0	0.0	[expr -$mass12*$g] 	0.0	0.0	0.0; # First Floor
	load 1221 	0.0	0.0	[expr -$mass22*$g] 	0.0	0.0	0.0; # First Floor
	load 1321 	0.0	0.0	[expr -$mass32*$g] 	0.0	0.0	0.0; # First Floor
	load 1421 	0.0	0.0	[expr -$mass42*$g] 	0.0	0.0	0.0; # First Floor
  load 1521 	0.0	0.0	[expr -$mass52*$g] 	0.0	0.0	0.0; # First Floor
  load 1621 	0.0	0.0	[expr -$mass62*$g] 	0.0	0.0	0.0; # First Floor
  load 1721 	0.0	0.0	[expr -$mass72*$g] 	0.0	0.0	0.0; # First Floor
  load 1821 	0.0	0.0	[expr -$mass82*$g] 	0.0	0.0	0.0; # First Floor

	load 1131 	0.0	0.0	[expr -$mass13*$g] 	0.0	0.0	0.0; # First Floor
	load 1231 	0.0	0.0	[expr -$mass23*$g] 	0.0	0.0	0.0; # First Floor
	load 1331 	0.0	0.0	[expr -$mass33*$g] 	0.0	0.0	0.0; # First Floor
	load 1431 	0.0	0.0	[expr -$mass43*$g] 	0.0	0.0	0.0; # First Floor
  load 1531 	0.0	0.0	[expr -$mass53*$g] 	0.0	0.0	0.0; # First Floor
  load 1631 	0.0	0.0	[expr -$mass63*$g] 	0.0	0.0	0.0; # First Floor
  load 1731 	0.0	0.0	[expr -$mass73*$g] 	0.0	0.0	0.0; # First Floor
  load 1831 	0.0	0.0	[expr -$mass83*$g] 	0.0	0.0	0.0; # First Floor

  load 1141 	0.0	0.0	[expr -$mass14*$g] 	0.0	0.0	0.0; # First Floor
  load 1241 	0.0	0.0	[expr -$mass24*$g] 	0.0	0.0	0.0; # First Floor
  load 1341 	0.0	0.0	[expr -$mass34*$g] 	0.0	0.0	0.0; # First Floor
  load 1441 	0.0	0.0	[expr -$mass44*$g] 	0.0	0.0	0.0; # First Floor
  load 1541 	0.0	0.0	[expr -$mass54*$g] 	0.0	0.0	0.0; # First Floor
  load 1641 	0.0	0.0	[expr -$mass64*$g] 	0.0	0.0	0.0; # First Floor
  load 1741 	0.0	0.0	[expr -$mass74*$g] 	0.0	0.0	0.0; # First Floor
  load 1841 	0.0	0.0	[expr -$mass84*$g] 	0.0	0.0	0.0; # First Floor

  load 1112 	0.0	0.0	[expr -$mass11*$g] 	0.0	0.0	0.0; # Second Floor
  load 1212 	0.0	0.0	[expr -$mass21*$g] 	0.0	0.0	0.0;
  load 1312 	0.0	0.0	[expr -$mass31*$g] 	0.0	0.0	0.0;
  load 1412 	0.0	0.0	[expr -$mass41*$g] 	0.0	0.0	0.0;
  load 1512 	0.0	0.0	[expr -$mass51*$g] 	0.0	0.0	0.0;
  load 1612 	0.0	0.0	[expr -$mass61*$g] 	0.0	0.0	0.0;
  load 1712 	0.0	0.0	[expr -$mass71*$g] 	0.0	0.0	0.0;
  load 1812 	0.0	0.0	[expr -$mass81*$g] 	0.0	0.0	0.0;

  load 1122 	0.0	0.0	[expr -$mass12*$g] 	0.0	0.0	0.0;
  load 1222 	0.0	0.0	[expr -$mass22*$g] 	0.0	0.0	0.0;
  load 1322 	0.0	0.0	[expr -$mass32*$g] 	0.0	0.0	0.0;
  load 1422 	0.0	0.0	[expr -$mass42*$g] 	0.0	0.0	0.0;
  load 1522 	0.0	0.0	[expr -$mass52*$g] 	0.0	0.0	0.0;
  load 1622 	0.0	0.0	[expr -$mass62*$g] 	0.0	0.0	0.0;
  load 1722 	0.0	0.0	[expr -$mass72*$g] 	0.0	0.0	0.0;
  load 1822 	0.0	0.0	[expr -$mass82*$g] 	0.0	0.0	0.0;

  load 1132 	0.0	0.0	[expr -$mass13*$g] 	0.0	0.0	0.0;
  load 1232 	0.0	0.0	[expr -$mass23*$g] 	0.0	0.0	0.0;
  load 1332 	0.0	0.0	[expr -$mass33*$g] 	0.0	0.0	0.0;
  load 1432 	0.0	0.0	[expr -$mass43*$g] 	0.0	0.0	0.0;
  load 1532 	0.0	0.0	[expr -$mass53*$g] 	0.0	0.0	0.0;
  load 1632 	0.0	0.0	[expr -$mass63*$g] 	0.0	0.0	0.0;
  load 1732 	0.0	0.0	[expr -$mass73*$g] 	0.0	0.0	0.0;
  load 1832 	0.0	0.0	[expr -$mass83*$g] 	0.0	0.0	0.0;

  load 1142 	0.0	0.0	[expr -$mass14*$g] 	0.0	0.0	0.0;
  load 1242 	0.0	0.0	[expr -$mass24*$g] 	0.0	0.0	0.0;
  load 1342 	0.0	0.0	[expr -$mass34*$g] 	0.0	0.0	0.0;
  load 1442 	0.0	0.0	[expr -$mass44*$g] 	0.0	0.0	0.0;
  load 1542 	0.0	0.0	[expr -$mass54*$g] 	0.0	0.0	0.0;
  load 1642 	0.0	0.0	[expr -$mass64*$g] 	0.0	0.0	0.0;
  load 1742 	0.0	0.0	[expr -$mass74*$g] 	0.0	0.0	0.0;
  load 1842 	0.0	0.0	[expr -$mass84*$g] 	0.0	0.0	0.0;

  load 1113 	0.0	0.0	[expr -$mass11*$g] 	0.0	0.0	0.0; # Third Floor
  load 1213 	0.0	0.0	[expr -$mass21*$g] 	0.0	0.0	0.0;
  load 1313 	0.0	0.0	[expr -$mass31*$g] 	0.0	0.0	0.0;
  load 1413 	0.0	0.0	[expr -$mass41*$g] 	0.0	0.0	0.0;
  load 1513 	0.0	0.0	[expr -$mass51*$g] 	0.0	0.0	0.0;
  load 1613 	0.0	0.0	[expr -$mass61*$g] 	0.0	0.0	0.0;
  load 1713 	0.0	0.0	[expr -$mass71*$g] 	0.0	0.0	0.0;
  load 1813 	0.0	0.0	[expr -$mass81*$g] 	0.0	0.0	0.0;

  load 1123 	0.0	0.0	[expr -$mass12*$g] 	0.0	0.0	0.0;
  load 1223 	0.0	0.0	[expr -$mass22*$g] 	0.0	0.0	0.0;
  load 1323 	0.0	0.0	[expr -$mass32*$g] 	0.0	0.0	0.0;
  load 1423 	0.0	0.0	[expr -$mass42*$g] 	0.0	0.0	0.0;
  load 1523 	0.0	0.0	[expr -$mass52*$g] 	0.0	0.0	0.0;
  load 1623 	0.0	0.0	[expr -$mass62*$g] 	0.0	0.0	0.0;
  load 1723 	0.0	0.0	[expr -$mass72*$g] 	0.0	0.0	0.0;
  load 1823 	0.0	0.0	[expr -$mass81*$g] 	0.0	0.0	0.0;

  load 1133 	0.0	0.0	[expr -$mass13*$g] 	0.0	0.0	0.0;
  load 1233 	0.0	0.0	[expr -$mass23*$g] 	0.0	0.0	0.0;
  load 1333 	0.0	0.0	[expr -$mass33*$g] 	0.0	0.0	0.0;
  load 1433 	0.0	0.0	[expr -$mass43*$g] 	0.0	0.0	0.0;
  load 1533 	0.0	0.0	[expr -$mass53*$g] 	0.0	0.0	0.0;
  load 1633 	0.0	0.0	[expr -$mass63*$g] 	0.0	0.0	0.0;
  load 1733 	0.0	0.0	[expr -$mass73*$g] 	0.0	0.0	0.0;
  load 1833 	0.0	0.0	[expr -$mass83*$g] 	0.0	0.0	0.0;

  load 1143 	0.0	0.0	[expr -$mass14*$g] 	0.0	0.0	0.0;
  load 1243 	0.0	0.0	[expr -$mass24*$g] 	0.0	0.0	0.0;
  load 1343 	0.0	0.0	[expr -$mass34*$g] 	0.0	0.0	0.0;
  load 1443 	0.0	0.0	[expr -$mass44*$g] 	0.0	0.0	0.0;
  load 1543 	0.0	0.0	[expr -$mass54*$g] 	0.0	0.0	0.0;
  load 1643 	0.0	0.0	[expr -$mass64*$g] 	0.0	0.0	0.0;
  load 1743 	0.0	0.0	[expr -$mass74*$g] 	0.0	0.0	0.0;
  load 1843 	0.0	0.0	[expr -$mass84*$g] 	0.0	0.0	0.0;

  load 1114 	0.0	0.0	[expr -$mass11r*$g] 	0.0	0.0	0.0; # Fourth Floor
  load 1214 	0.0	0.0	[expr -$mass21r*$g] 	0.0	0.0	0.0;
  load 1314 	0.0	0.0	[expr -$mass31r*$g] 	0.0	0.0	0.0;
  load 1414 	0.0	0.0	[expr -$mass41r*$g] 	0.0	0.0	0.0;
  load 1514 	0.0	0.0	[expr -$mass51r*$g] 	0.0	0.0	0.0;
  load 1614 	0.0	0.0	[expr -$mass61r*$g] 	0.0	0.0	0.0;
  load 1714 	0.0	0.0	[expr -$mass71r*$g] 	0.0	0.0	0.0;
  load 1814 	0.0	0.0	[expr -$mass81r*$g] 	0.0	0.0	0.0;

  load 1124 	0.0	0.0	[expr -$mass12r*$g] 	0.0	0.0	0.0;
  load 1224 	0.0	0.0	[expr -$mass22r*$g] 	0.0	0.0	0.0;
  load 1324 	0.0	0.0	[expr -$mass32r*$g] 	0.0	0.0	0.0;
  load 1424 	0.0	0.0	[expr -$mass42r*$g] 	0.0	0.0	0.0;
  load 1524 	0.0	0.0	[expr -$mass52r*$g] 	0.0	0.0	0.0;
  load 1624 	0.0	0.0	[expr -$mass62r*$g] 	0.0	0.0	0.0;
  load 1724 	0.0	0.0	[expr -$mass72r*$g] 	0.0	0.0	0.0;
  load 1824 	0.0	0.0	[expr -$mass82r*$g] 	0.0	0.0	0.0;

  load 1134 	0.0	0.0	[expr -$mass13r*$g] 	0.0	0.0	0.0;
  load 1234 	0.0	0.0	[expr -$mass23r*$g] 	0.0	0.0	0.0;
  load 1334 	0.0	0.0	[expr -$mass33r*$g] 	0.0	0.0	0.0;
  load 1434 	0.0	0.0	[expr -$mass43r*$g] 	0.0	0.0	0.0;
  load 1534 	0.0	0.0	[expr -$mass53r*$g] 	0.0	0.0	0.0;
  load 1634 	0.0	0.0	[expr -$mass63r*$g] 	0.0	0.0	0.0;
  load 1734 	0.0	0.0	[expr -$mass73r*$g] 	0.0	0.0	0.0;
  load 1834 	0.0	0.0	[expr -$mass83r*$g] 	0.0	0.0	0.0;

  load 1144 	0.0	0.0	[expr -$mass14r*$g] 	0.0	0.0	0.0;
  load 1244 	0.0	0.0	[expr -$mass24r*$g] 	0.0	0.0	0.0;
  load 1344 	0.0	0.0	[expr -$mass34r*$g] 	0.0	0.0	0.0;
  load 1444 	0.0	0.0	[expr -$mass44r*$g] 	0.0	0.0	0.0;
  load 1544 	0.0	0.0	[expr -$mass54r*$g] 	0.0	0.0	0.0;
  load 1644 	0.0	0.0	[expr -$mass64r*$g] 	0.0	0.0	0.0;
  load 1744 	0.0	0.0	[expr -$mass74r*$g] 	0.0	0.0	0.0;
  load 1844 	0.0	0.0	[expr -$mass84r*$g] 	0.0	0.0	0.0;

}

# Apply the load
constraints Transformation
numberer RCM
system UmfPack
test NormDispIncr	1e-6 500
algorithm Newton
set nG 100;
integrator LoadControl [expr 1/$nG]
analysis Static
analyze $nG

# maintain constant gravity loads and reset time to zero
loadConst -time 0.0

# --------------------------------------
# MODAL ANALYSIS
# --------------------------------------
modalAnalysis $nst 1 _Archetype_1_${nst}st_${mtype} "$outsdir/info/modal/"

# --------------------------------------
# PRINT STUFF
# --------------------------------------
file delete $outsdir/info/models/Archetype_1_model_${nst}st_${mtype}.txt
print $outsdir/info/models/Archetype_1_model_${nst}st_${mtype}.txt

# --------------------------------------
# DEFINE RECORDERS
# --------------------------------------
set node_recorder 		{1430 1431 1432 1433 1434}; # List of nodes to record

set bNode {1430 1431 1432 1433}; # iNodes for drift
set tNode {1431 1432 1433 1434}; # jNodes for drift
set baseNode 1430; #1220; # Base Node (for roof drift recorder)
set roofNode 1434; #1222; # Top Node


# Print a list of the elements and nodes recorded
file delete $outsdir/info/recorders/Archetype_1_recordersList_${nst}st_${mtype}.m
set rec_list [open $outsdir/info/recorders/Archetype_1_recordersList_${nst}st_${mtype}.m w];
puts $rec_list "node_list=\[$node_recorder];"
# puts $rec_list "bm_list=\[$beam_recorder];"
# puts $rec_list "col_list=\[$column_recorder];"
puts $rec_list "bNode=\[$bNode];"
puts $rec_list "tNode=\[$tNode];"
puts $rec_list "bdg_w=$bdg_w;"
close $rec_list

puts "Model Built..."


# --------------------------------------
# LATERAL ANALYSIS PARAMETERS
# --------------------------------------
if {$AType == "NRHA" || $AType == "IDA"} {
	# --------------------------------------
	# DEFINE DAMPING
	# --------------------------------------
	# Use a constant modal damping model
	modalDamping $xi

	# --------------------------------------
	# DEFINE TIME SERIES
	# --------------------------------------
	set tsTagX 1		; # Set a timeseries tag, this is needed for total floor acceleration recorder
	set tsTagY 2		; # Set a timeseries tag, this is needed for total floor acceleration recorder
	set pTagX 1		; # Set a pattern tag
	set pTagY 2		; # Set a pattern tag
	timeSeries Path $tsTagX -dt $dtX -filePath $EQnameX -factor $sfX
	timeSeries Path $tsTagY -dt $dtY -filePath $EQnameY -factor $sfY

	# --------------------------------------
	# DEFINE LOAD PATTERN
	# --------------------------------------
	#pattern  UniformExcitation       ptag     dir  -accel  timetag
	pattern UniformExcitation 		  $pTagX 	1 -accel $tsTagX
	pattern UniformExcitation 		  $pTagY 	2 -accel $tsTagY

  # --------------------------------------
  # DEFINE RECORDERS
  # --------------------------------------
  # Displacements
  eval "recorder Node	-file $outsdir/dispX.${AType}.${nst}st_${mtype}.$run.txt 	-node $node_recorder -dof 1 disp"
  eval "recorder Node	-file $outsdir/dispY.${AType}.${nst}st_${mtype}.$run.txt 	-node $node_recorder -dof 2 disp"
  # Storey Drifts
  eval "recorder Drift -file $outsdir/drftX.${AType}.${nst}st_${mtype}.$run.txt -iNode $bNode -jNode $tNode -dof 1 -perpDirn 3"
  eval "recorder Drift -file $outsdir/drftY.${AType}.${nst}st_${mtype}.$run.txt -iNode $bNode -jNode $tNode -dof 2 -perpDirn 3"
  # Relative Accelerations
  eval "recorder Node	-file $outsdir/accelRelX.${AType}.${nst}st_${mtype}.$run.txt -time -node $node_recorder -dof 1 accel"
  eval "recorder Node	-file $outsdir/accelRelY.${AType}.${nst}st_${mtype}.$run.txt -time -node $node_recorder -dof 2 accel"
  # Floor Accelerations (if no timeseries given, records relative accel)
  eval "recorder Node	-file $outsdir/accelX.${AType}.${nst}st_${mtype}.$run.txt -time -timeSeries $tsTagX -node $node_recorder -dof 1 accel"
  eval "recorder Node	-file $outsdir/accelY.${AType}.${nst}st_${mtype}.$run.txt -time -timeSeries $tsTagY -node $node_recorder -dof 2 accel"



	# --------------------------------------
	# DEFINE ANALYSIS OBJECTS
	# --------------------------------------
	constraints Transformation
	numberer RCM
	system UmfPack

}
