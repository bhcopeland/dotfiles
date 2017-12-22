#!/bin/bash

#gputemp=$(aticonfig --odgt --adapter=0 | grep -oE '[0-9]{2}[.][0-9]{2}' | sed -r 's/([0-9]*).*/\1/g')

gpuradeon=$(sensors | grep 'temp1' | cut -c16-17)
echo $gpuradeon

#if which aticonfig >/dev/null; then
#  echo -ne "$gputemp"
#else
#  echo $gpuradeon
#fi
