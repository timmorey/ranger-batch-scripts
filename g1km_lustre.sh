#!/bin/bash

##
# g1km_lustre.sh - Created by Timothy Morey on 11/28/2012
#
# This script does a run based on the first control run from the
# examples/searise-antarctica/experiments.sh file distributed with PISM.
#

#$ -V
#$ -cwd
#$ -j y
#$ -o o.$JOB_NAME.$JOB_ID
#$ -q normal
#$ -N g1km_lustre_N64_w4
#$ -pe 4way 1024
#$ -l h_rt=01:00:00
#$ -M timmorey@gmail.com
#$ -m be

#set -x

PISM=$WORK/pism/intel/pism-dev/build-ylib-v5/pismr
INDIR=$SCRATCH/input-c16-s1M
INFILE=$INDIR/g1km_0_ftt.cdf5.nc
OUTDIR=$SCRATCH/output-c64-s1M/$JOB_NAME.$JOB_ID 

CONFIG="-config $INDIR/pism_config.nc"
SKIP="-skip -skip_max 2000"
COUPLER="-atmosphere searise_greenland -surface pdd -pdd_annualize -ocean constant"
OPTS="$SKIP $COUPLER $CONFIG -bed_def lc -ssa_sliding -thk_eff -topg_to_phi 5.0,20.0,-300.0,700.0 -ocean_kill -acab_cumulative -y 0"

mkdir $OUTDIR
export PISM_ECHO_HINTS=true

for i in 1 2 3
do
	export PISM_MPIIO_HINTS="use_pism_customizations=1:pism_co_ratio=1"

	/usr/bin/time -p ibrun $PISM $OPTS \
		-i $INFILE \
		-o_format pnetcdf -o $OUTDIR/g1km.$i.$co.opt.cdf5.nc \
		-log_summary

        export PISM_MPIIO_HINTS="use_pism_customizations=0"

        /usr/bin/time -p ibrun $PISM $OPTS \
                -i $INFILE \
                -o_format pnetcdf -o $OUTDIR/g1km.$i.cdf5.nc \
                -log_summary


done

rm -rf $OUTDIR

