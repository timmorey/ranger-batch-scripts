#!/bin/bash

##
# g1km.sh - Created by Timothy Morey on 10/20/2012
#
# This file defines a ranger batch that will do a normal run of 1km Greenland
# data, picking up where the g1km_bs.sh run left off.  It just loads the saved
# model state, fills in diagnostic quantities, and then immediately saves its
# state.
#
# The batch name, node count, and wayness are not defined in this file, so that
# they may easily be varied for a parameter sweep by passing them directly to
# qsub.
#

#$ -V
#$ -cwd
#$ -j y
#$ -o o.$JOB_NAME.$JOB_ID
#$ -q normal
#$ -l h_rt=01:00:00
#$ -M timmorey@gmail.com
#$ -m be

set -x

PISM=$WORK/pism/software/pism-dev/build/pismr
INFILE=$WORK/pism/g1km.nc4.nc
OUTDIR=$SCRATCH/$JOB_NAME.$JOB_ID 

mkdir $OUTDIR

for i in 1
do
	/usr/bin/time -p ibrun $PISM \
		-i $INFILE \
		-ocean_kill \
		-atmosphere searise_greenland \
		-surface pdd \
		-o_format netcdf4_parallel -o $OUTDIR/g1km.nc4.$i.nc \
		-y 0 \
		-log_summary
done

rm -rf $OUTDIR

