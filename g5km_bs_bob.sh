#!/bin/bash

qsub -N g5km_bs_n1_w1 -pe 1way 16 g5km_bs.sh
qsub -N g5km_bs_n2_w1 -pe 1way 32 g5km_bs.sh
qsub -N g5km_bs_n4_w1 -pe 1way 64 g5km_bs.sh
qsub -N g5km_bs_n8_w1 -pe 1way 128 g5km_bs.sh
qsub -N g5km_bs_n16_w1 -pe 1way 256 g5km_bs.sh
qsub -N g5km_bs_n32_w1 -pe 1way 512 g5km_bs.sh
qsub -N g5km_bs_n64_w1 -pe 1way 1024 g5km_bs.sh

qsub -N g5km_bs_n16_w2 -pe 2way 128 g5km_bs.sh
qsub -N g5km_bs_n16_w4 -pe 4way 64 g5km_bs.sh
qsub -N g5km_bs_n16_w8 -pe 8way 32 g5km_bs.sh
qsub -N g5km_bs_n16_w16 -pe 16way 16 g5km_bs.sh

