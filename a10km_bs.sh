#!/bin/bash
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

mkdir $OUTDIR

for i in 1 2 3 
do
	/usr/bin/time -p ibrun $PISM \
		-boot_file $BOOTFILE \
		-Lz 5000 -Lbz 2000 -Mx 600 -My 600 -Mz 301 -Mbz 31 -y 0 \
		-sia_e 5.6 \
		-atmosphere given -atmosphere_given_file $BOOTFILE \
		-surface simple -ocean pik -ocean_kill \
		-meltfactor_pik 1.5e-2 \
		-o_format netcdf3 -o $OUTDIR/a10km.nc3.$i.nc \
		-log_summary

	/usr/bin/time -p ibrun $PISM \
		-boot_file $BOOTFILE \
		-Lz 5000 -Lbz 2000 -Mx 600 -My 600 -Mz 301 -Mbz 31 -y 0 \
		-sia_e 5.6 \
		-atmosphere given -atmosphere_given_file $BOOTFILE \
		-surface simple -ocean pik -ocean_kill \
		-meltfactor_pik 1.5e-2 \
		-o_format netcdf4_parallel -o $OUTDIR/a10km.nc4.$i.nc \
		-log_summary

	/usr/bin/time -p ibrun $PISM \
		-boot_file $BOOTFILE \
		-Lz 5000 -Lbz 2000 -Mx 600 -My 600 -Mz 301 -Mbz 31 -y 0 \
		-sia_e 5.6 \
		-atmosphere given -atmosphere_given_file $BOOTFILE \
		-surface simple -ocean pik -ocean_kill \
		-meltfactor_pik 1.5e-2 \
		-o_format pnetcdf -o $OUTDIR/a10km.pnc.$i.nc \
		-log_summary
done

