#!/bin/bash

nbproblems=100

for k in 3; do
  for nbvar in 100; do
    for rate in 3; do
      nbclauses=$((nbvar * rate))

      outdir="./ksat_k=${k}_nbvar=${nbvar}_nbclauses=${nbclauses}"
      mkdir -p $outdir

      for ((i=0; i < $nbproblems; i++)); do
        idx=$(printf "%03d\n" $i)
        outfilename="${outdir}/ins_${idx}.cnf"
        python genksat.py $k $nbvar $nbclauses False >> $outfilename
        echo "${outfilename} generated!"

        ./rm_ifsat.sh $outfilename
      done
    done
  done
done
