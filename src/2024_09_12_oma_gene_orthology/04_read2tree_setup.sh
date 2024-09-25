#!/bin/bash
source .env

cat ${proj_dir}/data/anopheles/marker_genes_diptera_minus_full_worst/*fna > ${der_dir}/worst.fna

singularity exec -B $proj_dir $r2t_sif \
    read2tree --standalone_path ${proj_dir}/data/anopheles/marker_genes_diptera_minus_full_worst \
        --output_path ${proj_dir}/results/2024_09_12_oma_gene_orthology/worst_oma_genes \
        --reference \
        --dna_reference ${der_dir}/worst.fna

cat ${proj_dir}/data/anopheles/marker_genes_diptera_minus_full_best/*fna > ${der_dir}/best.fna

singularity exec -B $proj_dir $r2t_sif \
    read2tree --standalone_path ${proj_dir}/data/anopheles/marker_genes_diptera_minus_full_best \
        --output_path ${proj_dir}/results/2024_09_12_oma_gene_orthology/best_oma_genes \
        --reference \
        --dna_reference ${der_dir}/best.fna
