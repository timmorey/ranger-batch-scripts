#!/bin/bash

qsub -q normal -N a10km_N4_w1 -pe 1way 64 a10km.sh
qsub -q normal -N a10km_N4_w4 -pe 4way 64 a10km.sh
qsub -q normal -N a10km_N4_w8 -pe 8way 64 a10km.sh
qsub -q normal -N a10km_N4_w16 -pe 16way 64 a10km.sh

#qsub -q normal -N a10km_N16_w1 -pe 1way 256 a10km.sh
#qsub -q normal -N a10km_N16_w4 -pe 4way 256 a10km.sh
#qsub -q normal -N a10km_N16_w8 -pe 8way 256 a10km.sh
#qsub -q normal -N a10km_N16_w16 -pe 16way 256 a10km.sh

#qsub -q normal -N a10km_N32_w1 -pe 1way 512 a10km.sh
#qsub -q normal -N a10km_N32_w4 -pe 4way 512 a10km.sh
#qsub -q normal -N a10km_N32_w8 -pe 8way 512 a10km.sh
#qsub -q normal -N a10km_N32_w16 -pe 16way 512 a10km.sh

#qsub -q normal -N a10km_N64_w1 -pe 1way 1024 a10km.sh
#qsub -q normal -N a10km_N64_w4 -pe 4way 1024 a10km.sh
#qsub -q normal -N a10km_N64_w8 -pe 8way 1024 a10km.sh
#qsub -q normal -N a10km_N64_w16 -pe 16way 1024 a10km.sh

