#!/bin/bash

source .env

singularity exec -B $proj_dir $ofind_sif \
    orthofinder \
        -t 20 \
        -og \
        -f ${proj_dir}/data/derived/2024_07_18_oma_gene_orthology/orthofinder

