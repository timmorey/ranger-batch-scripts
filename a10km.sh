#!/bin/bash

##
# a10km.sh - Created by Timothy Morey on 10/17/2012
#
# This file does a continuation of the bootstrapping run defined in a10km_bs.sh.
#

#$ -V
#$ -cwd
#$ -j y
#$ -o o.$JOB_NAME.$JOB_ID
#$ -q normal
#$ -l h_rt=00:30:00
#$ -M timmorey@gmail.com
#$ -m be

set -x

PISM=$WORK/pism/software/pism-dev/build/pismr
INFILEDIR=$WORK/pism
OUTDIR=$SCRATCH/$JOB_NAME.$JOB_ID 

COUPLER="-atmosphere given -atmosphere_given_file $INFILEDIR/pism_Antarctica_5km.nc -surface simple -ocean pik -ocean_kill"
MISC="-sia_e 5.6 -meltfactor_pik 1.5e-2"
OPTS="$COUPLER $MISC -y 0"

mkdir $OUTDIR

for i in 1 2 3 
do
	/usr/bin/time -p ibrun $PISM $OPTS \
		-i $INFILEDIR/a10km.nc3.nc \
		-o_format netcdf3 -o $OUTDIR/a10km.nc3.$i.nc \
		-log_summary

	/usr/bin/time -p ibrun $PISM $OPTS \
		-i $INFILEDIR/a10km.nc3.nc \
		-o_format netcdf4_parallel -o $OUTDIR/a10km.nc4.$i.nc \
		-log_summary

	/usr/bin/time -p ibrun $PISM $OPTS \
		-i $INFILEDIR/a10km.nc3.nc \
		-o_format pnetcdf -o $OUTDIR/a10km.pnc.$i.nc \
		-log_summary
done

