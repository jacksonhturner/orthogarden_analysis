#!/bin/bash

proj_dir=$( dirname $( dirname $PWD ) )
out_dir=${proj_dir}/results/2024_06_14_anopheles_50_genes_0p9

nextflow run ~/nextflow/orthogarden/main.nf \
    --input metadata.csv \
    --threshold_val 0.9 \
    --publish_dir $out_dir \
    -profile local,eight \
    -resume
