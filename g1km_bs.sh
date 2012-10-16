#!/bin/bash

##
# g1km_bs.sh - Created by Timothy Morey on 10/16/2012
#
# This file defines a ranger batch that will do a bootstrap load of 1km
# Greenland data and then immediately save its state.
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
BOOTFILE=$WORK/pism/pism_Greenland1km.nc
OUTDIR=$SCRATCH/$JOB_NAME.$JOB_ID 

mkdir $OUTDIR

for i in 1 2 3
do
	/usr/bin/time -p ibrun $PISM \
		-boot_file $BOOTFILE \
		-ocean_kill $BOOTFILE \
		-Lz 4000 -Lbz 2000 -z_spacing equal \
		-Mx 1501 -My 2801 -Mz 401 -Mbz 41 \
		-atmosphere searise_greenland \
		-surface pdd \
		-o_format netcdf4_parallel -o $OUTDIR/bootstrapped1km.nc4.$i.nc \
		-y 0 \
		-log_summary
done

rm -rf $OUTDIR

