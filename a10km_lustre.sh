#!/bin/bash

##
# a10km_lustre.sh - Created by Timothy Morey on 11/28/2012
#
# This script does a run based on the first control run from the
# examples/searise-antarctica/experiments.sh file distributed with PISM.
#

#$ -V
#$ -cwd
#$ -j y
#$ -o o.$JOB_NAME.$JOB_ID
#$ -q development 
#$ -N a10km_lustre
#$ -pe 4way 256
#$ -l h_rt=00:30:00
#$ -M timmorey@gmail.com
#$ -m be

#set -x

PISMDIR=$WORK/pism/intel/pism-dev/build
PISM=$PISMDIR/pismr
INDIR=$SCRATCH/input-c16-s1M
OUTDIR=$SCRATCH/output-c16-s1M/$JOB_NAME.$JOB_ID 
INFILE=$INDIR/a10km.cdf1.nc
CONFIGFILE=$INDIR/pism_config.nc

SKIP="-skip 10"
SIA_ENHANCEMENT="-e 5.6"
PIKPHYS_COUPLING="-atmosphere pik -ocean pik -meltfactor_pik 1.5e-2"
PIKPHYS="-ssa_method fd -e_ssa 0.6 -pik -eigen_calving 2.0e18 -calving_at_thickness 50.0"
FULLPHYS="-ssa_sliding -thk_eff -pseudo_plastic_q 0.25 -plastic_pwfrac 0.97 -topg_to_phi 5.0,20.0,-300.0,700."
OPTS="$SKIP $SIA_ENHANCEMENT $PIKPHYS_COUPLING $PIKPHYS $FULLPHYS -y 0"

mkdir $OUTDIR

for i in 1 2 3 4 5
do

	export PISM_ECHO_HINTS=true
	export PISM_MPIIO_HINTS="use_pism_customizations=1"

	/usr/bin/time -p ibrun $PISM $OPTS \
		-config $CONFIGFILE \
		-i $INFILE \
		-o_format pnetcdf -o $OUTDIR/a10km.$i.opt.cdf5.nc \
		-log_summary

        export PISM_MPIIO_HINTS="use_pism_customizations=0"

        /usr/bin/time -p ibrun $PISM $OPTS \
                -config $CONFIGFILE \
                -i $INFILE \
                -o_format pnetcdf -o $OUTDIR/a10km.$i.cdf5.nc \
                -log_summary


done

#rm -rf $OUTDIR

