#!/bin/bash

source .env

nextflow run ~/nextflow/orthogarden/main.nf \
    --input metadata.csv \
    --threshold_val 1 \
    --publish_dir $out_dir \
    -profile local,eight \
    -resume
