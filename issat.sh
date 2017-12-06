#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $(basename $0) filename(*.cnf)" 1>&2
  exit 1
fi

cnffile=$1
resfile="${cnffile}.res"

# Solve by MiniSAT
minisat ${1} ${resfile} &>/dev/null

test=$(cat ${resfile} | head -n 1)
if [ $test = "UNSAT" ]; then
  echo 0
  rm $resfile
elif  [ $test = "SAT" ]; then
  echo 1
  rm $resfile
else
  exit 2
fi
