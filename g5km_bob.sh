#!/bin/bash

##
# g5km_bob.sh - Created by Timothy Morey on 10/17/2012.
#
# This file launches a set of Greenland 5km runs on ranger, doing a parameter
# sweep of various n and w values.
#

qsub -N g5km_n1_w1 -pe 1way 16 g5km.sh
qsub -N g5km_n2_w1 -pe 1way 32 g5km.sh
qsub -N g5km_n4_w1 -pe 1way 64 g5km.sh
qsub -N g5km_n8_w1 -pe 1way 128 g5km.sh
qsub -N g5km_n16_w1 -pe 1way 256 g5km.sh
qsub -N g5km_n32_w1 -pe 1way 512 g5km.sh
qsub -N g5km_n64_w1 -pe 1way 1024 g5km.sh

qsub -N g5km_n16_w2 -pe 2way 128 g5km.sh
qsub -N g5km_n16_w4 -pe 4way 64 g5km.sh
qsub -N g5km_n16_w8 -pe 8way 32 g5km.sh
qsub -N g5km_n16_w16 -pe 16way 16 g5km.sh

