#!/bin/bash

##
# g1km_chunking.sh - Created by Timothy Morey on 1/31/2013.
#
# This file provides a ranger batch script that will do a PISM run using 1km 
# Greenland data.  The parameters used in this file are based on the parameters 
# of the first run in the examples/searise-greenland/experiments.sh script that 
# is distributed with PISM 0.5.
#

#$ -V
#$ -cwd
#$ -j y
#$ -o o.$JOB_NAME.$JOB_ID
#$ -q normal
#$ -N g1km_chunking
#$ -pe 4way 2048
#$ -l h_rt=01:00:00
#$ -M timmorey@gmail.com
#$ -m be

#set -x

INDIR=$SCRATCH/input-c16-s1M
PISMDIR=$WORK/pism/intel/pism-dev/build-default-chunking
PISM=$PISMDIR/pismr
CONFIG="-config $INDIR/pism_config.nc"
CONFIGOVERRIDE="-config_override $INDIR/searise_config.nc"
OUTDIR=$SCRATCH/output-c128-s1M/$JOB_NAME.$JOB_ID 

SKIP="-skip -skip_max 2000"
COUPLER="-atmosphere searise_greenland -surface pdd -pdd_annualize -ocean constant"
OPTS="$SKIP $COUPLER $CONFIG $CONFIGOVERRIDE -bed_def lc -ssa_sliding -thk_eff -topg_to_phi 5.0,20.0,-300.0,700.0 -ocean_kill -acab_cumulative -y 0"

mkdir $OUTDIR

for i in 1 2 3
do
	/usr/bin/time -p ibrun tacc_affinity $PISM $OPTS \
		-i $INDIR/g1km_0_ftt.cdf5.nc \
		-o_format pnetcdf -o $OUTDIR/g1km.cdf5.$i.nc \
		-log_summary

	/usr/bin/time -p ibrun tacc_affinity $PISM $OPTS \
		-i $INDIR/g1km_0_ftt.hdf5.nc \
		-o_format netcdf4_parallel -o $OUTDIR/g1km.hdf5.$i.nc \
		-log_summary

done

rm -rf $OUTDIR

