#!/bin/bash
source .env

singularity exec -B ${proj_dir} ${proj_dir}/src/images/pandas_2.2.1.sif \
	python3 ${proj_dir}/src/scripts/rename_newick.py \
	${proj_dir}/data/henckelia/henckelia_rename.csv \
	${out_dir}/tree_merge.nwk \
	${out_dir}/r2t_henckelia_renamed.nwk > rename.log
