#!/bin/bash

ml macs2
NAME="$(echo $1 | grep -Eo "\w{11}.bam" | cut -c 1-11)"

macs2 callpeak --treatment $1 --name ${NAME} --outdir ../../data/peaks/ --gsize hs --nomodel --shift -100 --extsize 200 --keep-dup all --call-summits
