#!/bin/bash

source .env

while read line ; do
    grep "^$line" ${der_dir}/orthofinder/Results_Sep12/Orthogroups.csv >> ${der_dir}/best_ogs.tsv
done < best_ogs.csv

while read line ; do
    grep "^$line" ${der_dir}/orthofinder/Results_Sep12/Orthogroups.csv >> ${der_dir}/worst_ogs.tsv
done < worst_ogs.csv

python3 ${proj_dir}/src/scripts/get_oma_names.py ${der_dir}/best_ogs.tsv ${der_dir}/best_oma_names.csv
python3 ${proj_dir}/src/scripts/get_oma_names.py ${der_dir}/worst_ogs.tsv ${der_dir}/worst_oma_names.csv

while read line ; do
    cp ${oma_dir}/OMAGroup_${line}* ${proj_dir}/data/anopheles/marker_genes_diptera_minus_full_best
done < ${der_dir}/best_oma_names.csv

while read line ; do
    cp ${oma_dir}/OMAGroup_${line}* ${proj_dir}/data/anopheles/marker_genes_diptera_minus_full_worst
done < ${der_dir}/worst_oma_names.csv
