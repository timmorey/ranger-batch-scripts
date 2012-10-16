#!/bin/bash

qsub -N a10km_bs_n1_w1 -pe 1way 16 a10km_bs.sh
qsub -N a10km_bs_n2_w1 -pe 1way 32 a10km_bs.sh
qsub -N a10km_bs_n4_w1 -pe 1way 64 a10km_bs.sh
qsub -N a10km_bs_n8_w1 -pe 1way 128 a10km_bs.sh
qsub -N a10km_bs_n16_w1 -pe 1way 256 a10km_bs.sh
qsub -N a10km_bs_n32_w1 -pe 1way 512 a10km_bs.sh
qsub -N a10km_bs_n64_w1 -pe 1way 1024 a10km_bs.sh

qsub -N a10km_bs_n32_w2 -pe 2way 256 a10km_bs.sh
qsub -N a10km_bs_n32_w4 -pe 4way 128 a10km_bs.sh
qsub -N a10km_bs_n32_w8 -pe 2way 64 a10km_bs.sh
qsub -N a10km_bs_n32_w16 -pe 2way 32 a10km_bs.sh

