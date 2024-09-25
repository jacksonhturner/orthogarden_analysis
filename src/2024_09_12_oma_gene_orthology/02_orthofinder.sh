#!/bin/bash

source .env

singularity exec -B $proj_dir $ofind_sif \
    orthofinder \
        -t 20 \
        -og \
        -f ${der_dir}/orthofinder

