#!/bin/bash

qsub -N a10km_n2_w1 -pe 1way 32 a10km.sh
qsub -N a10km_n4_w1 -pe 1way 64 a10km.sh
qsub -N a10km_n8_w1 -pe 1way 128 a10km.sh
#qsub -N a10km_n16_w1 -pe 1way 256 a10km.sh
qsub -N a10km_n32_w1 -pe 1way 512 a10km.sh
#qsub -N a10km_n64_w1 -pe 1way 1024 a10km.sh

qsub -N a10km_n32_w2 -pe 2way 256 a10km.sh
qsub -N a10km_n32_w4 -pe 4way 128 a10km.sh
qsub -N a10km_n32_w8 -pe 8way 64 a10km.sh
qsub -N a10km_n32_w16 -pe 16way 32 a10km.sh

