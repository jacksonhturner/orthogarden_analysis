#!/bin/bash
source .env

cat ${oma_dir}/*fna > $dna_ref

singularity exec -B $proj_dir $r2t_sif \
    read2tree --standalone_path $oma_dir \
        --output_path $out_dir \
        --reference \
        --dna_reference $dna_ref
