# This script loads in benchmarking trees and uses them to generate Jaccard Robinson-Foulds distances.

setwd("C:/Users/jturn")
library(ape)
library(phangorn)
library(TreeDist)

# Load in Anopheles reference tree, root it, and drop A. melas.

science_tree <- read.tree("anopheles_science2.treefile")
science_tree <- root(science_tree,"C_quinquefasciatus")

science_tree <- drop.tip(science_tree, "A_melas")

# Load in the aTRAM trees, determine the Robinson-Foulds scores, and generate co-phylogenies.

aTRAM_tree <- read.tree("anopheles_atram.treefile")
aTRAM_tree <- root(aTRAM_tree,"C_quinquefasciatus")
JaccardRobinsonFoulds(aTRAM_tree, science_tree) 
# R-F score: 3
VisualizeMatching(RobinsonFouldsMatching,aTRAM_tree,science_tree)

aTRAM_drosophila <- read.tree("anopheles_aTRAM_drosophila.treefile")
aTRAM_drosophila <- root(aTRAM_drosophila, "C_quinquefasciatus")
JaccardRobinsonFoulds(aTRAM_drosophila, science_tree) 
# R-F score: 5.6
VisualizeMatching(RobinsonFouldsMatching,aTRAM_drosophila,science_tree)

# Do the same thing for the OrthoGarden trees

OG_fasta <- read.tree("anopheles_OG_fasta.treefile")
OG_fasta <- root(OG_fasta, "C_quinquefasciatus")
JaccardRobinsonFoulds(OG_fasta, science_tree) 
# R-F score: 3
VisualizeMatching(RobinsonFouldsMatching,OG_fasta,science_tree)

OG_fastq <- read.tree("anopheles_OG_fastq.treefile")
OG_fastq <- root(OG_fastq , "C_quinquefasciatus")
JaccardRobinsonFoulds(OG_fastq, science_tree) 
# R-F score: 3
VisualizeMatching(RobinsonFouldsMatching,OG_fastq,science_tree)

OG_fly <- read.tree("anopheles_OG_fly.treefile")
OG_fly <- root(OG_fly, "C_quinquefasciatus")
JaccardRobinsonFoulds(OG_fly, science_tree) 
# R-F score: 3
VisualizeMatching(RobinsonFouldsMatching,OG_fly,science_tree)

# Same for Read2Tree

r2t_anopheles <- read.tree("anopheles_r2t_ref.treefile")
r2t_anopheles <- root(r2t_anopheles, "C_quinquefasciatus")
JaccardRobinsonFoulds(r2t_anopheles, science_tree) 
# R-F score: 5
VisualizeMatching(RobinsonFouldsMatching,r2t_anopheles,science_tree)

r2t_drosophila <- read.tree("anopheles_r2t_drosophila.treefile")
r2t_drosophila <- root(r2t_drosophila, "C_quinquefasciatus")
JaccardRobinsonFoulds(r2t_drosophila, science_tree) 
# R-F score: 11.79
VisualizeMatching(RobinsonFouldsMatching,r2t_drosophila,science_tree)

r2t_minus_tree <-read.tree("anopheles_r2t_minus.treefile")
r2t_minus_tree <- root(r2t_minus_tree, "C_quinquefasciatus")
JaccardRobinsonFoulds(r2t_minus_tree, science_tree) 
# R-F score: 12.46
VisualizeMatching(RobinsonFouldsMatching,r2t_minus_tree,science_tree)

# Load in the Henckelia reference tree, root it, and increase the branch lengths since the topology recovered with TreeSnatcher was shortened.

henckelia_ref <- read.tree("henckelia_skeleton.treefile")
henckelia_ref <- root(henckelia_ref,"Ornithoboea_henryi")
henckelia_ref$edge.length = henckelia_ref$edge.length * 10

# aTRAM

aTRAM_henck <- read.tree("henckelia_aTRAM_full.treefile")
aTRAM_henck <- root(aTRAM_henck,"Ornithoboea_henryi")
aTRAM_henck$edge.length = aTRAM_henck$edge.length * 10
JaccardRobinsonFoulds(aTRAM_henck, henckelia_ref) 
# R-F score: 5.3333
VisualizeMatching(RobinsonFouldsMatching,aTRAM_henck,henckelia_ref)

# Read2tree

r2t_henck <- read.tree("r2t_henckelia_renamed.nwk")
r2t_henck <- drop.tip(r2t_henck,"SOLTU")
r2t_henck <- drop.tip(r2t_henck,"SOLLC")

r2t_henck <- root(r2t_henck,"Ornithoboea_henryi")
JaccardRobinsonFoulds(r2t_henck, henckelia_ref) 
# R-F score: 16.57
VisualizeMatching(RobinsonFouldsMatching,r2t_henck,henckelia_ref)

# OrthoGarden

OG_henck <- read.tree("Henckelia_OG_all_taxa.treefile")
OG_henck <- root(OG_henck,"Ornithoboea_henryi")
JaccardRobinsonFoulds(OG_henck, henckelia_ref)
# R-F score: 3.06
VisualizeMatching(RobinsonFouldsMatching,OG_henck,henckelia_ref)


# Deprecated: Load in the reference, Read2tree, and OrthoGarden trees for the yeast dataset.

yeast_ref <- read.tree("shen_test.nwk")
r2t_yeast <- read.tree("r2t_test.nwk")
OG_yeast <- read.tree("og_test.nwk")

JaccardRobinsonFoulds(OG_yeast,r2t_yeast) 
JaccardRobinsonFoulds(yeast_ref,r2t_yeast)
VisualizeMatching(SharedPhylogeneticInfo,OG_yeast)
