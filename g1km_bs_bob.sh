#!/bin/bash

##
# g1km_bs_bob.sh - Created by Timothy Morey on 10/16/2012
#
# This script launches a batch of batches on ranger to perform a parameter 
# sweep using the g1km_bs.sh batch.
#

qsub -N g1km_bs_n16_w1 -pe 1way 256 g1km_bs.sh
qsub -N g1km_bs_n32_w1 -pe 1way 512 g1km_bs.sh
qsub -N g1km_bs_n48_w1 -pe 1way 768 g1km_bs.sh
qsub -N g1km_bs_n64_w1 -pe 1way 1024 g1km_bs.sh

