#!/bin/bash
source .env

singularity exec -B $proj_dir $r2t_sif \
    read2tree \
        --standalone_path $oma_dir \
        --output_path $out_dir \
        --merge_all_mappings \
        --remove_species_ogs ANOGA,ANOST,ANOSI,ANODA \
        --tree

