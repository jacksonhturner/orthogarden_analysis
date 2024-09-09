#!/bin/bash
source .env

for R1 in ${read_dir}*_1.fastq*; do
    link_dir=$( realpath $R1 )
    link_dir="${link_dir%/*/*}"
    R2=$( echo "$R1" | sed 's/_1/_2/' )
    echo "singularity exec -B $link_dir -B $proj_dir $r2t_sif read2tree --standalone_path $oma_dir_sub --output_path $out_dir --reads ${R1} ${R2}" >> parallel_read2tree.txt
done

