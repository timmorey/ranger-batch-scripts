#!/bin/bash

qsub -N a10km_N16_w1 -pe 1way 256 a10km.sh
qsub -N a10km_N16_w4 -pe 4way 256 a10km.sh
qsub -N a10km_N16_w8 -pe 8way 256 a10km.sh
qsub -N a10km_N16_w16 -pe 16way 256 a10km.sh

