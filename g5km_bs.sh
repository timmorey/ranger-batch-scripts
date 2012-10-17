#!/bin/bash

##
# g5km_bs.sh - Created by Timothy Morey on 10/16/2012.
#
# This file provides a ranger batch script that will do a PISM bootstrapping
# run using 5km Greenland data.  The parameters used in this file are based on
# the parameters of the first run in the examples/searise-greenland/spinup.sh
# script that is distributed with PISM 0.5.
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
BOOTFILE=$WORK/pism/pism_Antarctica_5km.nc
OUTDIR=$SCRATCH/$JOB_NAME.$JOB_ID 

SKIP="-skip -skip_max 200"
VGRID="-Lz 4000 -Lbz 2000 -Mz 401 -Mbz 41 -z_spacing equal"
HGRID="-Mx 301 -My 561"
COUPLER="-atmosphere searise_greenland -surface pdd -ocean_kill $BOOTFILE"
OPTS="$SKIP $VGRID $HGRID $COUPLER -boot_file $BOOTFILE -y 0"

mkdir $OUTDIR

for i in 1 2 3 
do
	/usr/bin/time -p ibrun $PISM $OPTS \
		-o_format netcdf3 -o $OUTDIR/g5km.nc3.$i.nc \
		-log_summary

	/usr/bin/time -p ibrun $PISM $OPTS \
		-o_format netcdf4_parallel -o $OUTDIR/g5km.nc4.$i.nc \
		-log_summary

	/usr/bin/time -p ibrun $PISM $OPTS \
		-o_format pnetcdf -o $OUTDIR/g5km.pnc.$i.nc \
		-log_summary
done

