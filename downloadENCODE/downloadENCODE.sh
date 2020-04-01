#!/bin/bash

mkdir -p $2
cd $2
xargs -L 1 curl -O -L < $1
