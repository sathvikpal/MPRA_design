#!/bin/bash

ml homer
mkdir -p ../../data/tags
ENCODE_NAME="$(echo $1 | grep -Eo "\w{11}.bam" | cut -c 1-11)"
TAG="../../data/tags/${ENCODE_NAME}"

makeTagDirectory ${TAG} $1 -keepAll
