#!/bin/bash

##
# a10km_cdf5.sh - Created by Timothy Morey on 11/21/2012
#
# This script gathers performance numbers for the changes we made in adding
# CDF5 support.
#
# The runs in this script are based on the first control run from the
# examples/searise-antarctica/experiments.sh file distributed with PISM.
#

#$ -V
#$ -cwd
#$ -j y
#$ -o o.$JOB_NAME.$JOB_ID
#$ -q development 
#$ -N a10km_cdf5
#$ -pe 4way 128
#$ -l h_rt=02:00:00
#$ -M timmorey@gmail.com
#$ -m be

set -x

INFILE=$SCRATCH/input-c16-s1M/a10km.cdf1.nc
OUTDIR=$SCRATCH/output-c16-s1M/$JOB_NAME.$JOB_ID 

SKIP="-skip 10"
SIA_ENHANCEMENT="-e 5.6"
PIKPHYS_COUPLING="-atmosphere pik -ocean pik -meltfactor_pik 1.5e-2"
PIKPHYS="-ssa_method fd -e_ssa 0.6 -pik -eigen_calving 2.0e18 -calving_at_thickness 50.0"
FULLPHYS="-ssa_sliding -thk_eff -pseudo_plastic_q 0.25 -plastic_pwfrac 0.97 -topg_to_phi 5.0,20.0,-300.0,700."
OPTS="$SKIP $SIA_ENHANCEMENT $PIKPHYS_COUPLING $PIKPHYS $FULLPHYS -y 0"

mkdir $OUTDIR

export PISM_ECHO_HINTS=true

for i in 1 2 3 4 5
do
	echo
	echo "======================================="
	echo "=== i = $i"
	echo "======================================="
	echo

	for BUILD in baseline cdf5-v1 cdf5-v2
	do
		echo
		echo "======================================"
		echo "=== BUILD = $BUILD"
		echo "======================================"
		echo

		PISMDIR=$WORK/pism/intel/pism-dev/build-$BUILD
		PISM=$PISMDIR/pismr
		CONFIGFILE=$PISMDIR/pism_config.nc

		/usr/bin/time -p ibrun $PISM $OPTS \
			-config $CONFIGFILE \
			-i $INFILE \
			-o_format pnetcdf -o $OUTDIR/a10km.$i.$BUILD.cdf5.nc \
			-log_summary
	done
done

rm -rf $OUTDIR

