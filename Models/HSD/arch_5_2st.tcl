# --------------------------------------------------
# 3D Model of Archetype Plan #2
# --------------------------------------------------
# Copyright by Al Mouayed Bellah Nafeh
# IUSS Pavia, Italy
# April 2020
# Description: 2-storey infilled RC building
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
source $procdir/arch_5_inputParam_HSD.tcl

# --------------------------------------
# Define some basic model parameters
# --------------------------------------
# Dimensions and General Para.

set nst 2; #Number of Stories
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

# Y=2;
node	1120		0.0		  $BY1		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1220		$BX1		$BY1		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1320		$BX2		$BY1		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1420		$BX3		$BY1		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1520		$BX4		$BY1		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1620		$BX5		$BY1		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0

# Y=3;
node	1130		0.0		  $BY2		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1230		$BX1		$BY2		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1330		$BX2		$BY2		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1430		$BX3		$BY2		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1530		$BX4		$BY2		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0
node	1630		$BX5		$BY2		0.0 -mass 0.0 0.0 0.0 0.0 0.0 0.0

if {$stairsOPT == 1} {
#Define the staircase Nodes

#nodes on landing [on intersection of axis 3(in x) and between axes 3 and 4(in y) every 0.5 floor]
node 10 $BX3 $BY232 [expr 0.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

#nodes on landing [on intersection of axis 4(in x) and between axes 3 and 4(in y) every 0.5 floor]
node 20 $BX2 $BY232 [expr 0.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

#nodes on landing [on intersection of between axes 3-4 (in x) and 3-4 (in y) every 0.5 floor]
node 30 $BX34 $BY232 [expr 0.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

#mid-stair node which starts at level 0 to level 5
node 40 $BX34 $BY231 [expr 0*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 41 $BX34 $BY231 [expr 1*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

#split the columns nodes
node 13201 $BX2 $BY1 [expr 0.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

node 14201 $BX3 $BY1 [expr 0.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

node 91341 $BX2 $BY231 [expr 1*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

node 91440 $BX3 $BY231 [expr 0*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0
node 91441 $BX3 $BY231 [expr 1*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

node 13301 $BX2 $BY2 [expr 0.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

node 14301 $BX3 $BY2 [expr 0.5*$H] -mass 0.0 0.0 0.0 0.0 0.0 0.0

}

# --------------------------------------
# Define Transformations
# --------------------------------------
# Use P-Delta geometric transformations. Include rigid-end offsets to account for the rigid zones of the beam-column joints.
# These are incorporated here as opposed to inserting rigid members at each joint for computational efficiency.
geomTransf PDelta 	1  0 1 0 -jntOffset 0.0 0.0 [expr $hc1/2] 0.0 0.0 [expr -$hc1/2] ; # z is in Y
geomTransf PDelta 	2  0 1 0 -jntOffset 0.0 0.0 [expr $hc2/2] 0.0 0.0 [expr -$hc2/2] ; # z is in Y
geomTransf PDelta 	3  0 1 0 -jntOffset 0.0 0.0 [expr $hc3/2] 0.0 0.0 [expr -$hc3/2] ; # z is in Y

geomTransf PDelta 	5  0 1 0 -jntOffset [expr $hb1/2] 0.0 0.0  [expr -$hb1/2]  0.0 0.0 ; # z is in Y
geomTransf PDelta 	6  -1 0 0 -jntOffset 0.0 [expr $hb1/2] 0.0  0.0 [expr -$hb1/2]  0.0 ; # z is in Y

geomTransf PDelta 	7  0 1 0 -jntOffset [expr $hb2/2] 0.0 0.0  [expr -$hb2/2]  0.0 0.0 ; # z is in Y
geomTransf PDelta 	8  -1 0 0 -jntOffset 0.0 [expr $hb2/2] 0.0  0.0 [expr -$hb2/2]  0.0 ; # z is in Y

set GTc1 1;
set GTc2 2;
set GTc3 3;

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
set pfile_cols [open $outsdir/Properties_columnn.txt w];

# Build the model without stairs
if {$stairsOPT == 0} {
puts " # -------------------------------------------------- "
puts " # Building Model without Stairs			                "
puts " # -------------------------------------------------- "
# -------------------
# Joints
# -------------------
# Y=1; 1st Floor
jointModel 	 "Exterior"	111 	[list 0.00 0.0 [expr 1*$H]] $mass11  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	211 	[list $BX1 0.0 [expr 1*$H]] $mass21  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	311 	[list $BX2 0.0 [expr 1*$H]] $mass31  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	411 	[list $BX3 0.0 [expr 1*$H]] $mass41  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	511 	[list $BX4 0.0 [expr 1*$H]] $mass51  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass51+$mass51r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	611 	[list $BX5 0.0 [expr 1*$H]] $mass61  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass61+$mass61r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=1; 2nd Floor
jointModel 	 "Exterior"	112 	[list 0.00 0.0 [expr 2*$H]] $mass11  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	212 	[list $BX1 0.0 [expr 2*$H]] $mass21  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	312 	[list $BX2 0.0 [expr 2*$H]] $mass31  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	412 	[list $BX3 0.0 [expr 2*$H]] $mass41  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	512 	[list $BX4 0.0 [expr 2*$H]] $mass51  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass51+$mass51r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	612 	[list $BX5 0.0 [expr 2*$H]] $mass61  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass61+$mass61r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=2; 1st Floor
jointModel 	 "Exterior"	121 	[list 0.00 $BY1 [expr 1*$H]] $mass12 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	221 	[list $BX1 $BY1 [expr 1*$H]] $mass22 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	321 	[list $BX2 $BY1 [expr 1*$H]] $mass32 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	421 	[list $BX3 $BY1 [expr 1*$H]] $mass42 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	521 	[list $BX4 $BY1 [expr 1*$H]] $mass52 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass52+$mass52r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	621 	[list $BX5 $BY1 [expr 1*$H]] $mass62 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass62+$mass62r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=2; 2nd Floor
jointModel 	 "Exterior"	122 	[list 0.00 $BY1 [expr 2*$H]] $mass12 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	222 	[list $BX1 $BY1 [expr 2*$H]] $mass22 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	322 	[list $BX2 $BY1 [expr 2*$H]] $mass32 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	422 	[list $BX3 $BY1 [expr 2*$H]] $mass42 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	522 	[list $BX4 $BY1 [expr 2*$H]] $mass52 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass52+$mass52r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	622 	[list $BX5 $BY1 [expr 2*$H]] $mass62 $col3 $bm1 $c_c1 $brs3  [expr (0$mass62+$mass62r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=3; 1st Floor
jointModel 	 "Exterior"	131 	[list 0.00 $BY2 [expr 1*$H]] $mass13 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	231 	[list $BX1 $BY2 [expr 1*$H]] $mass23 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	331 	[list $BX2 $BY2 [expr 1*$H]] $mass33 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	431 	[list $BX3 $BY2 [expr 1*$H]] $mass43 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	531 	[list $BX4 $BY2 [expr 1*$H]] $mass53 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass53+$mass53r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	631 	[list $BX5 $BY2 [expr 1*$H]] $mass63 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass63+$mass63r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=3; 2nd Floor
jointModel 	 "Exterior"	132 	[list 0.00 $BY2 [expr 2*$H]] $mass13 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	232 	[list $BX1 $BY2 [expr 2*$H]] $mass23 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	332 	[list $BX2 $BY2 [expr 2*$H]] $mass33 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	432 	[list $BX3 $BY2 [expr 2*$H]] $mass43 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	532 	[list $BX4 $BY2 [expr 2*$H]] $mass53 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass53+$mass53r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	632 	[list $BX5 $BY2 [expr 2*$H]] $mass63 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass63+$mass63r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

puts "Joints created..."

# -------------------
# Beams
# -------------------
# X-Direction
# -------------------

#1st Floor

# Y=1;
rcBC_Duct 	5111 $GTbX1  6111 6211 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5211 $GTbX1  6211 6311 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5311 $GTbX1  6311 6411 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5411 $GTbX1  6411 6511 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5511 $GTbX1  6511 6611 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# Y=2;
rcBC_Duct 	5121 $GTbX1  6121 6221 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 2.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5221 $GTbX1  6221 6321 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.200  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5321 $GTbX1  6321 6421 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.300  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5421 $GTbX1  6421 6521 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.200  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5521 $GTbX1  6521 6621 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 2.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=3;
rcBC_Duct 	5131 $GTbX1  6131 6231 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5231 $GTbX1  6231 6331 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5331 $GTbX1  6331 6431 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5531 $GTbX1  6431 6531 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5631 $GTbX1  6531 6631 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#2nd Floor

# Y=1;
rcBC_Duct 	5112 $GTbX1  6112 6212 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5212 $GTbX1  6212 6312 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5312 $GTbX1  6312 6412 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5412 $GTbX1  6412 6512 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5512 $GTbX1  6512 6612 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# Y=2;
rcBC_Duct 	5122 $GTbX1  6122 6222 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 2.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5222 $GTbX1  6222 6322 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.200  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5322 $GTbX1  6322 6422 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.300  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5422 $GTbX1  6422 6522 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.200  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5522 $GTbX1  6522 6622 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 2.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=3;
rcBC_Duct 	5132 $GTbX1  6132 6232 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5232 $GTbX1  6232 6332 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5332 $GTbX1  6332 6432 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5532 $GTbX1  6432 6532 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5632 $GTbX1  6532 6632 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# -------------------
# Y-Direction
# -------------------

#1st Floor

# X=1;
rcBC_Duct 	6111 $GTbY1  6111 6121 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6121 $GTbY1  6121 6131 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# X=2;
rcBC_Duct 	6211 $GTbY2  6211 6221 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6221 $GTbY2  6221 6231 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=3;
rcBC_Duct 	6311 $GTbY2  6311 6321 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6321 $GTbY2  6321 6331 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=4;
rcBC_Duct 	6411 $GTbY2  6411 6421 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6421 $GTbY2  6421 6431 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=5;
rcBC_Duct 	6511 $GTbY2  6511 6521 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6521 $GTbY2  6521 6531 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=6;
rcBC_Duct 	6611 $GTbY1  6611 6621 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6621 $GTbY1  6621 6631 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#2nd Floor

# X=1;
rcBC_Duct 	6112 $GTbY1  6112 6122 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6122 $GTbY1  6122 6132 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# X=2;
rcBC_Duct 	6212 $GTbY2  6212 6222 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL3  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6222 $GTbY2  6222 6232 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL3  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=3;
rcBC_Duct 	6312 $GTbY2  6312 6322 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL3  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6322 $GTbY2  6322 6332 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL3  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=4;
rcBC_Duct 	6412 $GTbY2  6412 6422 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL3  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6422 $GTbY2  6422 6432 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL3  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=5;
rcBC_Duct 	6512 $GTbY2  6512 6522 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL3  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6522 $GTbY2  6522 6532 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL3  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=6;
rcBC_Duct 	6612 $GTbY1  6612 6622 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6622 $GTbY1  6622 6632 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

puts "Beams created..."

# -------------------
# Columns
# -------------------

#1st Floor

# Y=1;
rcBC_Duct 	7111 $GTc3 1110 	1111 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass11+$mass11r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7211 $GTc3 1210 	1211 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass21+$mass21r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7311 $GTc3 1310 	1311 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass31+$mass31r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7411 $GTc3 1410 	1411 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass41+$mass41r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_Duct 	7511 $GTc3 1510 	1511 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass51+$mass51r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7611 $GTc3 1610 	1611 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass61+$mass61r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

# Y=2;
rcBC_Duct 	7121 $GTc3 1120 	1121 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass12+$mass12r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7221 $GTc3 1220 	1221 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass22+$mass22r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7321 $GTc3 1320 	1321 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass32+$mass32r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7421 $GTc3 1420 	1421 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass42+$mass42r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_Duct 	7521 $GTc3 1520 	1521 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass52+$mass52r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7621 $GTc3 1620 	1621 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass62+$mass62r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

# Y=3;
rcBC_Duct 	7131 $GTc3 1130 	1131 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass11+$mass11r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7231 $GTc3 1230 	1231 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass21+$mass21r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7331 $GTc3 1330 	1331 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass31+$mass31r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7431 $GTc3 1430 	1431 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass41+$mass41r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_Duct 	7531 $GTc3 1530 	1531 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass51+$mass51r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7631 $GTc3 1630 	1631 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass61+$mass61r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

#2nd Floor

# Y=1;
rcBC_Duct 	7112 $GTc3 1111 	1112 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass11+$mass11r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7212 $GTc3 1211 	1212 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass21+$mass21r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7312 $GTc3 1311 	1312 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass31+$mass31r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7412 $GTc3 1411 	1412 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass41+$mass41r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_Duct 	7512 $GTc3 1511 	1512 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass51+$mass51r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7612 $GTc3 1611 	1612 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass61+$mass61r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

# Y=2;
rcBC_Duct 	7122 $GTc3 1121 	1122 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass12+$mass11r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7222 $GTc3 1221 	1222 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass22+$mass21r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7322 $GTc3 1321 	1322 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass32+$mass31r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7422 $GTc3 1421 	1422 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass42+$mass41r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_Duct 	7522 $GTc3 1521 	1522 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass52+$mass51r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7622 $GTc3 1621 	1622 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass62+$mass61r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

# Y=3;
rcBC_Duct 	7132 $GTc3 1131 	1132 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass11+$mass11r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7232 $GTc3 1231 	1232 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass21+$mass21r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7332 $GTc3 1331 	1332 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass31+$mass31r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7432 $GTc3 1431 	1432 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass41+$mass41r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_Duct 	7532 $GTc3 1531 	1532 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass51+$mass51r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7632 $GTc3 1631 	1632 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass61+$mass61r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

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
jointModel 	 "Exterior"	111 	[list 0.00 0.0 [expr 1*$H]] $mass11  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	211 	[list $BX1 0.0 [expr 1*$H]] $mass21  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	311 	[list $BX2 0.0 [expr 1*$H]] $mass31  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	411 	[list $BX3 0.0 [expr 1*$H]] $mass41  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	511 	[list $BX4 0.0 [expr 1*$H]] $mass51  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass51+$mass51r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	611 	[list $BX5 0.0 [expr 1*$H]] $mass61  $col3 $bm1 $c_c1 $brs3  [expr (1*$mass61+$mass61r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=1; 2nd Floor
jointModel 	 "Exterior"	112 	[list 0.00 0.0 [expr 2*$H]] $mass11  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass11+$mass11r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	212 	[list $BX1 0.0 [expr 2*$H]] $mass21  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass21+$mass21r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	312 	[list $BX2 0.0 [expr 2*$H]] $mass31  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass31+$mass31r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	412 	[list $BX3 0.0 [expr 2*$H]] $mass41  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass41+$mass41r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	512 	[list $BX4 0.0 [expr 2*$H]] $mass51  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass51+$mass51r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	612 	[list $BX5 0.0 [expr 2*$H]] $mass61  $col3 $bm1 $c_c1 $brs3  [expr (0*$mass61+$mass61r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=2; 1st Floor
jointModel 	 "Exterior"	121 	[list 0.00 $BY1 [expr 1*$H]] $mass12 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	221 	[list $BX1 $BY1 [expr 1*$H]] $mass22 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	321 	[list $BX2 $BY1 [expr 1*$H]] $mass32 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	421 	[list $BX3 $BY1 [expr 1*$H]] $mass42 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	521 	[list $BX4 $BY1 [expr 1*$H]] $mass52 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass52+$mass52r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	621 	[list $BX5 $BY1 [expr 1*$H]] $mass62 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass62+$mass62r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=2; 2nd Floor
jointModel 	 "Exterior"	122 	[list 0.00 $BY1 [expr 2*$H]] $mass12 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass12+$mass12r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	222 	[list $BX1 $BY1 [expr 2*$H]] $mass22 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass22+$mass22r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	322 	[list $BX2 $BY1 [expr 2*$H]] $mass32 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass32+$mass32r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	422 	[list $BX3 $BY1 [expr 2*$H]] $mass42 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass42+$mass42r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	522 	[list $BX4 $BY1 [expr 2*$H]] $mass52 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass52+$mass52r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	622 	[list $BX5 $BY1 [expr 2*$H]] $mass62 $col3 $bm1 $c_c1 $brs3  [expr (0$mass62+$mass62r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=3; 1st Floor
jointModel 	 "Exterior"	131 	[list 0.00 $BY2 [expr 1*$H]] $mass13 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	231 	[list $BX1 $BY2 [expr 1*$H]] $mass23 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	331 	[list $BX2 $BY2 [expr 1*$H]] $mass33 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	431 	[list $BX3 $BY2 [expr 1*$H]] $mass43 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	531 	[list $BX4 $BY2 [expr 1*$H]] $mass53 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass53+$mass53r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	631 	[list $BX5 $BY2 [expr 1*$H]] $mass63 $col3 $bm1 $c_c1 $brs3  [expr (1*$mass63+$mass63r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

# Y=3; 2nd Floor
jointModel 	 "Exterior"	132 	[list 0.00 $BY2 [expr 2*$H]] $mass13 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass13+$mass13r)*$g] $H $ptc_ext $gamm_ext $hyst_ext $pfile_jnts
jointModel 	 "Interior"	232 	[list $BX1 $BY2 [expr 2*$H]] $mass23 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass23+$mass23r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	332 	[list $BX2 $BY2 [expr 2*$H]] $mass33 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass33+$mass33r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	432 	[list $BX3 $BY2 [expr 2*$H]] $mass43 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass43+$mass43r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Interior"	532 	[list $BX4 $BY2 [expr 2*$H]] $mass53 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass53+$mass53r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts
jointModel 	 "Exterior"	632 	[list $BX5 $BY2 [expr 2*$H]] $mass63 $col3 $bm1 $c_c1 $brs3  [expr (0*$mass63+$mass63r)*$g] $H $ptc_int $gamm_int $hyst_int $pfile_jnts

puts "Joints created..."

# -------------------
# Beams
# -------------------
# X-Direction
# -------------------

#1st Floor

# Y=1;
rcBC_Duct 	5111 $GTbX1  6111 6211 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5211 $GTbX1  6211 6311 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5311 $GTbX1  6311 6411 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5411 $GTbX1  6411 6511 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5511 $GTbX1  6511 6611 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# Y=2;
rcBC_Duct 	5121 $GTbX1  6121 6221 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 2.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5221 $GTbX1  6221 6321 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.200  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5321 $GTbX1  6321 6421 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.300  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5421 $GTbX1  6421 6521 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.200  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5521 $GTbX1  6521 6621 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 2.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=3;
rcBC_Duct 	5131 $GTbX1  6131 6231 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5231 $GTbX1  6231 6331 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5331 $GTbX1  6331 6431 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5531 $GTbX1  6431 6531 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5631 $GTbX1  6531 6631 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#2nd Floor

# Y=1;
rcBC_Duct 	5112 $GTbX1  6112 6212 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5212 $GTbX1  6212 6312 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5312 $GTbX1  6312 6412 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5412 $GTbX1  6412 6512 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5512 $GTbX1  6512 6612 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# Y=2;
rcBC_Duct 	5122 $GTbX1  6122 6222 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 2.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5222 $GTbX1  6222 6322 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.200  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5322 $GTbX1  6322 6422 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.300  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5422 $GTbX1  6422 6522 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.200  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms
rcBC_Duct 	5522 $GTbX1  6522 6622 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 2.500  $rB2_shr   $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $rB2_top    $rB2_web 	$rB2_bot    $pfile_bms

# Y=3;
rcBC_Duct 	5132 $GTbX1  6132 6232 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5232 $GTbX1  6232 6332 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5332 $GTbX1  6332 6432 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.300  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5532 $GTbX1  6432 6532 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 1.200  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	5632 $GTbX1  6532 6632 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL4  $dbV 0.0 2.500  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# -------------------
# Y-Direction
# -------------------

#1st Floor

# X=1;
rcBC_Duct 	6111 $GTbY1  6111 6121 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6121 $GTbY1  6121 6131 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# X=2;
rcBC_Duct 	6211 $GTbY2  6211 6221 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6221 $GTbY2  6221 6231 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=3;
rcBC_Duct 	6311 $GTbY2  6311 6321 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6321 $GTbY2  6321 6331 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=4;
rcBC_Duct 	6411 $GTbY2  6411 6421 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6421 $GTbY2  6421 6431 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=5;
rcBC_Duct 	6511 $GTbY2  6511 6521 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6521 $GTbY2  6521 6531 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=6;
rcBC_Duct 	6611 $GTbY1  6611 6621 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6621 $GTbY1  6621 6631 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

#2nd Floor

# X=1;
rcBC_Duct 	6112 $GTbY1  6112 6122 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6122 $GTbY1  6122 6132 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

# X=2;
rcBC_Duct 	6212 $GTbY2  6212 6222 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL3  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6222 $GTbY2  6222 6232 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL3  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=3;
rcBC_Duct 	6312 $GTbY2  6312 6322 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL3  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6322 $GTbY2  6322 6332 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL3  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=4;
rcBC_Duct 	6412 $GTbY2  6412 6422 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL3  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6422 $GTbY2  6422 6432 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL3  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=5;
rcBC_Duct 	6512 $GTbY2  6512 6522 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL3  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms
rcBC_Duct 	6522 $GTbY2  6522 6532 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb2 $sb $cv $dbL3  $dbV 0.0 2.50  $rB3_shr   $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $rB3_top    $rB3_web 	$rB3_bot    $pfile_bms

# X=6;
rcBC_Duct 	6612 $GTbY1  6612 6622 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
rcBC_Duct 	6622 $GTbY1  6622 6632 $fyL $fyV $Es $fcb1 $Ecb1 $bb1 $hb1 $sb $cv $dbL3  $dbV 0.0 2.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

puts "Beams created..."

# -------------------
# Columns
# -------------------

#1st Floor

# Y=1;
rcBC_Duct 	7111 $GTc3 1110 	1111 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass11+$mass11r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7211 $GTc3 1210 	1211 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass21+$mass21r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7311 $GTc3 1310 	1311 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass31+$mass31r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7411 $GTc3 1410 	1411 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass41+$mass41r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_Duct 	7511 $GTc3 1510 	1511 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass51+$mass51r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7611 $GTc3 1610 	1611 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass61+$mass61r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

# Y=2;
rcBC_Duct 	7121 $GTc3 1120 	1121 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass12+$mass12r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7221 $GTc3 1220 	1221 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass22+$mass22r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols

#split these columns
#--------------------
rcBC_Duct 	73201 $GTc3 1320 	13201 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass32+$mass32r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7321 $GTc3 13201 	1321 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass32+$mass32r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols

rcBC_Duct 	74201 $GTc3 1420 	14201 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass42+$mass42r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_Duct 	7421 $GTc3 14201 	1421 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass42+$mass42r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
#--------------------

rcBC_Duct 	7521 $GTc3 1520 	1521 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass52+$mass52r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7621 $GTc3 1620 	1621 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass62+$mass62r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

# Y=3;
rcBC_Duct 	7131 $GTc3 1130 	1131 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass11+$mass11r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7231 $GTc3 1230 	1231 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass21+$mass21r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols

#split these columns
#--------------------
rcBC_Duct 	73301 $GTc3 1330 	13301 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass31+$mass31r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7331 $GTc3 13301 	1331 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass31+$mass31r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols

rcBC_Duct 	74301 $GTc3 1430 	14301 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass41+$mass41r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_Duct 	7431 $GTc3 14301 	1431 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass41+$mass41r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
#--------------------

rcBC_Duct 	7531 $GTc3 1530 	1531 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass51+$mass51r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7631 $GTc3 1630 	1631 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (1*$mass61+$mass61r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

#2nd Floor

# Y=1;
rcBC_Duct 	7112 $GTc3 1111 	1112 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass11+$mass11r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7212 $GTc3 1211 	1212 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass21+$mass21r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7312 $GTc3 1311 	1312 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass31+$mass31r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7412 $GTc3 1411 	1412 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass41+$mass41r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_Duct 	7512 $GTc3 1511 	1512 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass51+$mass51r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7612 $GTc3 1611 	1612 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass61+$mass61r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

# Y=2;
rcBC_Duct 	7122 $GTc3 1121 	1122 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass12+$mass11r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7222 $GTc3 1221 	1222 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass22+$mass21r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7322 $GTc3 1321 	1322 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass32+$mass31r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7422 $GTc3 1421 	1422 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass42+$mass41r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_Duct 	7522 $GTc3 1521 	1522 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass52+$mass51r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7622 $GTc3 1621 	1622 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass62+$mass61r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

# Y=3;
rcBC_Duct 	7132 $GTc3 1131 	1132 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass11+$mass11r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7232 $GTc3 1231 	1232 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass21+$mass21r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7332 $GTc3 1331 	1332 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass31+$mass31r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7432 $GTc3 1431 	1432 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass41+$mass41r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols
rcBC_Duct 	7532 $GTc3 1531 	1532 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass51+$mass51r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$pfile_cols
rcBC_Duct 	7632 $GTc3 1631 	1632 	$fyL $fyV $Es $fcc1 $Ecc1 $bc3 $hc3 $sc $cv $dbL3 $dbV [expr (0*$mass61+$mass61r)*$g] [expr $H/2] 	$rC3_shr 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot 	$rC3_top 	0.0 		$rC3_bot	$pfile_cols

puts "Columns created..."
}

if {$infillsOPT == 1} {
# -------------------
# Infills
# -------------------
# X-Direction
# -------------------

# 1st Floor

# Y=1;
infill 		2111 	single 	[list 1111 1211 1210 1110] 	 5000. [expr $H*1000] 	   $hb1  	$hc3	$bc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2211 	single 	[list 1211 1311 1310 1210] 	 2400. [expr $H*1000] 	   $hb1  	$hc3	$bc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2311 	single 	[list 1311 1411 1410 1310] 	 2700. [expr $H*1000] 	   $hb1  	$hc3	$bc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2411 	single 	[list 1411 1511 1510 1410] 	 2400. [expr $H*1000] 	   $hb1  	$hc3	$bc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2511 	single 	[list 1511 1611 1610 1510] 	 5000. [expr $H*1000] 	   $hb1  	$hc3	$bc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# Y=3;
infill 		2131 	single 	[list 1131 1231 1230 1130] 	 5000. [expr $H*1000] 	   $hb1  	$hc3	$bc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw1 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2231 	single 	[list 1231 1331 1330 1230] 	 2400. [expr $H*1000] 	   $hb1  	$hc3	$bc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw1 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2331 	single 	[list 1331 1431 1430 1330] 	 2700. [expr $H*1000] 	   $hb1  	$hc3	$bc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2431 	single 	[list 1431 1531 1530 1430] 	 2400. [expr $H*1000] 	   $hb1  	$hc3	$bc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw1 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2531 	single 	[list 1531 1631 1630 1530] 	 5000. [expr $H*1000] 	   $hb1  	$hc3	$bc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw1 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# 2nd Floor

# Y=1;
infill 		2112 	single 	[list 1112 1212 1211 1111] 	 5000. [expr $H*1000] 	   $hb1  	$hc3	$bc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2212 	single 	[list 1212 1312 1311 1211] 	 2400. [expr $H*1000] 	   $hb1  	$hc3	$bc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2312 	single 	[list 1312 1412 1411 1311] 	 2700. [expr $H*1000] 	   $hb1  	$hc3	$bc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2412 	single 	[list 1412 1512 1511 1411] 	 2400. [expr $H*1000] 	   $hb1  	$hc3	$bc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2512 	single 	[list 1512 1612 1611 1511] 	 5000. [expr $H*1000] 	   $hb1  	$hc3	$bc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# Y=3;
infill 		2132 	single 	[list 1132 1232 1231 1131] 	 5000. [expr $H*1000] 	   $hb1  	$hc3	$bc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw1 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2232 	single 	[list 1232 1332 1331 1231] 	 2400. [expr $H*1000] 	   $hb1  	$hc3	$bc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw1 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2332 	single 	[list 1332 1432 1431 1331] 	 2700. [expr $H*1000] 	   $hb1  	$hc3	$bc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2432 	single 	[list 1432 1532 1531 1431] 	 2400. [expr $H*1000] 	   $hb1  	$hc3	$bc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw1 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		2532 	single 	[list 1532 1632 1631 1531] 	 5000. [expr $H*1000] 	   $hb1  	$hc3	$bc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw1 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# -------------------
# Y-Direction
# -------------------

# 1st Floor

# X=1;
infill 		3111 	single 	[list 1111 1121 1120 1110] 	5000. [expr $H*1000] 	$hb1  	$hc3	$bc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3211 	single 	[list 1121 1131 1130 1120] 	5000. [expr $H*1000] 	$hb1  	$hc3	$bc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# X=3;
infill 		3131 	single 	[list 1311 1321 1320 1310] 	5000. [expr $H*1000] 	$hb2  	$hc3	$bc3 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

# X=4;
infill 		3141 	single 	[list 1411 1421 1420 1410] 	5000. [expr $H*1000] 	$hb2  	$hc3	$bc3 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

# X=6;
infill 		3161 	single 	[list 1611 1621 1620 1610] 	5000. [expr $H*1000] 	$hb1  	$hc3	$bc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3261 	single 	[list 1621 1631 1630 1620] 	5000. [expr $H*1000] 	$hb1  	$hc3	$bc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# 2nd Floor

# X=1;
infill 		3112 	single 	[list 1112 1122 1121 1111] 	5000. [expr $H*1000] 	$hb1  	$hc3	$bc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3212 	single 	[list 1122 1132 1131 1121] 	5000. [expr $H*1000] 	$hb1  	$hc3	$bc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

# X=3;
infill 		3132 	single 	[list 1312 1322 1321 1311] 	5000. [expr $H*1000] 	$hb2  	$hc3	$bc3 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

# X=4;
infill 		3142 	single 	[list 1412 1422 1421 1411] 	5000. [expr $H*1000] 	$hb2  	$hc3	$bc3 $tw3	$Ecc1 $Ewh3 	$Ewv3 	$Gw3 0.2 $fwv3 	$fwu3 	$fws3 	0.0

# X=6;
infill 		3162 	single 	[list 1612 1622 1621 1611] 	5000. [expr $H*1000] 	$hb1  	$hc3	$bc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0
infill 		3262 	single 	[list 1622 1632 1631 1621] 	5000. [expr $H*1000] 	$hb1  	$hc3	$bc3 $tw2	$Ecc1 $Ewh2 	$Ewv2 	$Gw2 0.2 $fwv2 	$fwu2 	$fws2 	0.0

puts "Infills created..."
}

# --------------------------------------
# DEFINE STAIRS
# --------------------------------------
if {$stairsOPT == 1} {

  # Stairs from 0 to 1

  rcBC_nonDuct            $STb 	99911     $GTbY2  91440 10 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99921     $GTbY2  40    30 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99931     $GTbY2  10 14301 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99941     $GTbX2  14301 13301 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99951     $GTbY2  13301 20 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb1 $sb $cv $dbL2  $dbV 0.0 1.350  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99961     $GTbX2  10 30 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99971     $GTbX2  30 20 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb1 $sb $cv $dbL2  $dbV 0.0 1.50  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99981     $GTbY2  30 41    $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	99991     $GTbY2  20 91341 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb1 $sb $cv $dbL2  $dbV 0.0 1.00  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms
  rcBC_nonDuct            $STb 	999101     $GTbX2  91341 41 $fyL $fyV $Es $fcb1 $Ecb1 $bb2 $hb1 $sb $cv $dbL2  $dbV 0.0 0.675  $rB1_shr   $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $rB1_top    $rB1_web 	$rB1_bot    $pfile_bms

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

fix 	1120	1  1  1  1  1  1
fix 	1220	1  1  1  1  1  1
fix 	1320	1  1  1  1  1  1
fix 	1420	1  1  1  1  1  1
fix 	1520	1  1  1  1  1  1
fix 	1620	1  1  1  1  1  1

fix 	1130	1  1  1  1  1  1
fix 	1230	1  1  1  1  1  1
fix 	1330	1  1  1  1  1  1

if {$stairsOPT == 1} {
  fix  40   1  1  1  1  1  1; #added node for stairs
  fix 91440 1  1  1  1  1  1
}

fix 	1430	1  1  1  1  1  1
fix 	1530	1  1  1  1  1  1
fix 	1630	1  1  1  1  1  1

# Rigid Diaphragm

rigidDiaphragm 3	1431 1111 1211 1311 1411 1511 1611  1121 1221 1321 1421 1521 1621 1131 1231 1331 1531 1631
rigidDiaphragm 3	1432 1112 1212 1312 1412 1512 1612  1122 1222 1322 1422 1522 1622 1132 1232 1332 1532 1632

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

	load 1121 	0.0	0.0	[expr -$mass12*$g] 	0.0	0.0	0.0; # First Floor
	load 1221 	0.0	0.0	[expr -$mass22*$g] 	0.0	0.0	0.0; # First Floor
	load 1321 	0.0	0.0	[expr -$mass32*$g] 	0.0	0.0	0.0; # First Floor
	load 1421 	0.0	0.0	[expr -$mass42*$g] 	0.0	0.0	0.0; # First Floor
  load 1521 	0.0	0.0	[expr -$mass52*$g] 	0.0	0.0	0.0; # First Floor
  load 1621 	0.0	0.0	[expr -$mass62*$g] 	0.0	0.0	0.0; # First Floor

	load 1131 	0.0	0.0	[expr -$mass13*$g] 	0.0	0.0	0.0; # First Floor
	load 1231 	0.0	0.0	[expr -$mass23*$g] 	0.0	0.0	0.0; # First Floor
	load 1331 	0.0	0.0	[expr -$mass33*$g] 	0.0	0.0	0.0; # First Floor
	load 1431 	0.0	0.0	[expr -$mass43*$g] 	0.0	0.0	0.0; # First Floor
  load 1531 	0.0	0.0	[expr -$mass53*$g] 	0.0	0.0	0.0; # First Floor
  load 1631 	0.0	0.0	[expr -$mass63*$g] 	0.0	0.0	0.0; # First Floor

  load 1112 	0.0	0.0	[expr -$mass11r*$g] 	0.0	0.0	0.0; # Second Floor
  load 1212 	0.0	0.0	[expr -$mass21r*$g] 	0.0	0.0	0.0;
  load 1312 	0.0	0.0	[expr -$mass31r*$g] 	0.0	0.0	0.0;
  load 1412 	0.0	0.0	[expr -$mass41r*$g] 	0.0	0.0	0.0;
  load 1512 	0.0	0.0	[expr -$mass51r*$g] 	0.0	0.0	0.0;
  load 1612 	0.0	0.0	[expr -$mass61r*$g] 	0.0	0.0	0.0;

  load 1122 	0.0	0.0	[expr -$mass12r*$g] 	0.0	0.0	0.0;
  load 1222 	0.0	0.0	[expr -$mass22r*$g] 	0.0	0.0	0.0;
  load 1322 	0.0	0.0	[expr -$mass32r*$g] 	0.0	0.0	0.0;
  load 1422 	0.0	0.0	[expr -$mass42r*$g] 	0.0	0.0	0.0;
  load 1522 	0.0	0.0	[expr -$mass52r*$g] 	0.0	0.0	0.0;
  load 1622 	0.0	0.0	[expr -$mass62r*$g] 	0.0	0.0	0.0;

  load 1132 	0.0	0.0	[expr -$mass13r*$g] 	0.0	0.0	0.0;
  load 1232 	0.0	0.0	[expr -$mass23r*$g] 	0.0	0.0	0.0;
  load 1332 	0.0	0.0	[expr -$mass33r*$g] 	0.0	0.0	0.0;
  load 1432 	0.0	0.0	[expr -$mass43r*$g] 	0.0	0.0	0.0;
  load 1532 	0.0	0.0	[expr -$mass53r*$g] 	0.0	0.0	0.0;
  load 1632 	0.0	0.0	[expr -$mass63r*$g] 	0.0	0.0	0.0;

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
modalAnalysis $nst 1 _Archetype_5_${nst}st_${mtype} "$outsdir/info/modal/"

# --------------------------------------
# PRINT STUFF
# --------------------------------------
file delete $outsdir/info/models/Archetype_5_model_${nst}st_${mtype}.txt
print $outsdir/info/models/Archetype_5_model_${nst}st_${mtype}.txt

# --------------------------------------
# DEFINE RECORDERS
# --------------------------------------
set node_recorder 		{1430 1431 1432}; # List of nodes to record

set bNode {1430 1431}; # iNodes for drift
set tNode {1431 1432}; # jNodes for drift
set baseNode 1430; #1220; # Base Node (for roof drift recorder)
set roofNode 1432; #1222; # Top Node


# Print a list of the elements and nodes recorded
file delete $outsdir/info/recorders/Archetype_5_recordersList_${nst}st_${mtype}.m
set rec_list [open $outsdir/info/recorders/Archetype_5_recordersList_${nst}st_${mtype}.m w];
puts $rec_list "node_list=\[$node_recorder];"
#puts $rec_list "bm_list=\[$beam_recorder];"
#puts $rec_list "col_list=\[$column_recorder];"
#puts $rec_list "jnt_list=\[$joint_recorder];"
puts $rec_list "bNode=\[$bNode];"
puts $rec_list "tNode=\[$tNode];"
puts $rec_list "bdg_w=$bdg_w;"
close $rec_list


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
