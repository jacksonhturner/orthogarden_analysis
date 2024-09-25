#!/bin/bash
source .env

for R1 in ${read_dir}/*_1.fastq*; do
    link_dir=$( realpath $R1 )
    link_dir="${link_dir%/*/*}"
    R2=$( echo "$R1" | sed 's/_1/_2/' )
    echo "singularity exec -B $link_dir -B $proj_dir $r2t_sif read2tree --standalone_path ${proj_dir}/data/anopheles/marker_genes_diptera_minus_full_worst --output_path ${proj_dir}/results/2024_09_12_oma_gene_orthology/worst_oma_genes --reads ${R1} ${R2}" >> worst_parallel_read2tree.txt
    echo "singularity exec -B $link_dir -B $proj_dir $r2t_sif read2tree --standalone_path ${proj_dir}/data/anopheles/marker_genes_diptera_minus_full_best --output_path ${proj_dir}/results/2024_09_12_oma_gene_orthology/best_oma_genes --reads ${R1} ${R2}" >> best_parallel_read2tree.txt
done
