PROJ = $(shell dirname $(shell dirname $(shell pwd)))
PWD = $(notdir $(shell pwd))
RESULTS = ${PROJ}/results/2024_09_10_compare_yeast

og_tree = $(PROJ)/results/2024_06_27_yeast_orthogarden/run_iqtree.treefile
og_rn = $(PROJ)/data/yeast/og_rename.csv

og_tree_426 = $(PROJ)/results/2024_09_18_orthogarden_yeast_426_taxa/iqtree/run_iqtree.treefile
og_426_rn = $(PROJ)/data/yeast/og_426_rename.csv

r2t_tree = $(PROJ)/data/yeast/concat.fa.contree
r2t_rn = $(PROJ)/data/yeast/r2t_rename.csv

shen_tree = $(PROJ)/data/yeast/RAxML_bipartitions.343_2408OGs.nwk
shen_rn = $(PROJ)/data/yeast/shen_rename.csv

$(RESULTS)/tip_names.csv : compare.log
	python3 $(PROJ)/src/scripts/extract_newick.py $(RESULTS)/og_renamed_tree.nwk $(RESULTS)/og_tips.txt
	python3 $(PROJ)/src/scripts/extract_newick.py $(RESULTS)/og_426_renamed_tree.nwk $(RESULTS)/og_426_tips.txt
	python3 $(PROJ)/src/scripts/extract_newick.py $(RESULTS)/r2t_renamed_tree.nwk $(RESULTS)/r2t_tips.txt
	python3 $(PROJ)/src/scripts/extract_newick.py $(RESULTS)/shen_renamed_tree.nwk $(RESULTS)/shen_tips.txt
	cat $(RESULTS)/og_tips.txt $(RESULTS)/og_426_tips.txt $(RESULTS)/r2t_tips.txt $(RESULTS)/shen_tips.txt > $(RESULTS)/tmp_names.csv
	sort $(RESULTS)/tmp_names.csv | uniq > $(RESULTS)/tip_names.csv
	rm $(RESULTS)/tmp_names.csv $(RESULTS)/*tips.txt

compare.log : rename.log
	python3 $(PROJ)/src/scripts/compare_newick.py \
		$(RESULTS)/r2t_renamed_tree.nwk \
		$(RESULTS)/og_renamed_tree.nwk > $(RESULTS)/r2t_og_comp.txt 2>> compare.log
	python3 $(PROJ)/src/scripts/compare_newick.py \
		$(RESULTS)/r2t_renamed_tree.nwk \
		$(RESULTS)/shen_renamed_tree.nwk > $(RESULTS)/r2t_shen_comp.txt 2>> compare.log
	python3 $(PROJ)/src/scripts/compare_newick.py \
		$(RESULTS)/shen_renamed_tree.nwk \
		$(RESULTS)/og_renamed_tree.nwk > $(RESULTS)/shen_og_comp.txt 2>> compare.log
	python3 $(PROJ)/src/scripts/compare_newick.py \
		$(RESULTS)/shen_renamed_tree.nwk \
		$(RESULTS)/og_426_renamed_tree.nwk > $(RESULTS)/shen_og_426_comp.txt 2>> compare.log
	python3 $(PROJ)/src/scripts/compare_newick.py \
		$(RESULTS)/r2t_renamed_tree.nwk \
		$(RESULTS)/og_426_renamed_tree.nwk > $(RESULTS)/r2t_og_426_comp.txt 2>> compare.log
	python3 $(PROJ)/src/scripts/compare_newick.py \
		$(RESULTS)/og_renamed_tree.nwk \
		$(RESULTS)/og_426_renamed_tree.nwk > $(RESULTS)/og_og_426_comp.txt 2>> compare.log

rename.log :
	singularity exec -B $(PROJ) $(PROJ)/src/images/pandas_2.2.1.sif \
		python3 $(PROJ)/src/scripts/rename_newick.py \
		$(og_rn) \
		$(og_tree) \
		$(RESULTS)/og_renamed_tree.nwk >> rename.log
	singularity exec -B $(PROJ) $(PROJ)/src/images/pandas_2.2.1.sif \
		python3 $(PROJ)/src/scripts/rename_newick.py \
		$(og_426_rn) \
		$(og_tree_426) \
		$(RESULTS)/og_426_renamed_tree.nwk >> rename.log
	singularity exec -B $(PROJ) $(PROJ)/src/images/pandas_2.2.1.sif \
		python3 $(PROJ)/src/scripts/rename_newick.py \
		$(r2t_rn) \
		$(r2t_tree) \
		$(RESULTS)/r2t_renamed_tree.nwk >> rename.log
	singularity exec -B $(PROJ) $(PROJ)/src/images/pandas_2.2.1.sif \
		python3 $(PROJ)/src/scripts/rename_newick.py \
		$(shen_rn) \
		$(shen_tree) \
		$(RESULTS)/shen_renamed_tree.nwk >> rename.log

clean:
	rm $(RESULTS)/r2t_renamed_tree.nwk
	rm $(RESULTS)/og_renamed_tree.nwk
	rm $(RESULTS)/shen_renamed_tree.nwk
	rm $(RESULTS)/*_comp.txt
	rm $(RESULTS)/tip_names.csv
	rm compare.log
	rm rename.log
