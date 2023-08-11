#!/usr/bin/env bash

set -eu

PWD=$(pwd)
TIMESTAMP="${TIMESTAMP:-$(date -u +"%Y%m%d%H%M%S")}"

west update

# West Build (left)
west build -s zmk/app -d build/left -b nice_nano_v2 -- -DSHIELD=charybdis_left -DZMK_CONFIG="${PWD}/config"
# Adv360 Left Kconfig file
cat build/left/zephyr/.config | grep -v "^#" | grep -v "^$"
# West Build (right)
west build -s zmk/app -d build/right -b -- -DSHIELD=charybdis_right -DZMK_CONFIG="${PWD}/config"
# Adv360 Right Kconfig file
cat build/right/zephyr/.config | grep -v "^#" | grep -v "^$"
# Rename zmk.uf2
cp build/left/zephyr/zmk.uf2 ./firmware/${TIMESTAMP}-left.uf2 && cp build/right/zephyr/zmk.uf2 ./firmware/${TIMESTAMP}-right.uf2
