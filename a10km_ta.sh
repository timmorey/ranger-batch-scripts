#!/bin/bash

##
# a10km_ta.sh - Created by Timothy Morey on 12/2/2012
#
# This script does a run based on the first control run from the
# examples/searise-antarctica/experiments.sh file distributed with PISM.
#

#$ -V
#$ -cwd
#$ -j y
#$ -o o.$JOB_NAME.$JOB_ID
#$ -q development 
#$ -N a10km_ta
#$ -pe 4way 256
#$ -l h_rt=00:30:00
#$ -M timmorey@gmail.com
#$ -m be

#set -x

INDIR=$SCRATCH/input-c16-s1M
PISMDIR=$WORK/pism/intel/pism-improving-io/build
PISM=$PISMDIR/pismr
CONFIGFILE=$INDIR/pism_config.nc
INFILE=$INDIR/a10km.cdf1.nc
OUTDIR=$SCRATCH/$JOB_NAME.$JOB_ID 

SKIP="-skip 10"
SIA_ENHANCEMENT="-e 5.6"
PIKPHYS_COUPLING="-atmosphere pik -ocean pik -meltfactor_pik 1.5e-2"
PIKPHYS="-ssa_method fd -e_ssa 0.6 -pik -eigen_calving 2.0e18 -calving_at_thickness 50.0"
FULLPHYS="-ssa_sliding -thk_eff -pseudo_plastic_q 0.25 -plastic_pwfrac 0.97 -topg_to_phi 5.0,20.0,-300.0,700."
OPTS="$SKIP $SIA_ENHANCEMENT $PIKPHYS_COUPLING $PIKPHYS $FULLPHYS -y 0"

mkdir $OUTDIR

for i in 1 2 3 4 5
do
	echo
	echo "========================"
	echo "=== normal"
	echo "========================"
	echo

	/usr/bin/time -p ibrun $PISM $OPTS \
		-config $CONFIGFILE \
		-i $INFILE \
		-o_format pnetcdf -o $OUTDIR/a10km.$i.cdf5.nc \
		-log_summary

	echo
	ehco "======================="
	echo "=== tacc_affinity"
	echo "======================="
	echo

	/usr/bin/time -p ibrun tacc_affinity $PISM $OPTS \
		-config $CONFIGFILE \
		-i $INFILE \
		-o_format pnetcdf -o $OUTDIR/a10km.ta.$i.cdf5.nc \
		-log_summary
done

rm -rf $OUTDIR

