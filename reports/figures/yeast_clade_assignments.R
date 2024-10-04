### This script attempts to recreate Shen et al. 2018 figure for OrthoGarden results to compare with read2tree.

# Load in packages and set working directory
setwd("C:/Users/jturn/Downloads")
library(ape)
library(phangorn)
library(ggtree)
library(ggplot2)

### The following code was used to combined multiple sets of metadata to ultimately generate a data frame with all tip/clade combinations across trees. It is no longer needed to generate the figures since the generated data frame is now available.

metadata <- read.csv("yeast_metadata.csv", header = TRUE)
species_vec <- metadata[[2]]
tip_labels <- read.csv("tip_names.csv")
tip_vec <- tip_labels[[1]]

df <- data.frame(Species=character(),Clade=character())
count = 0

for (i in 1:length(tip_vec)) {
  if (tip_vec[i] %in% species_vec) {
    count <- count + 1
    clade <- which(species_vec == tip_vec[i])
    if (class(clade) == "integer"){
      clade <- clade[1]
    }
    df[count,1] <- tip_vec[i]
    cat(tip_vec[i], "\n")
    if (is.na(metadata[clade,5]) == FALSE) {
      df[count,2] <- metadata[clade,5] #clade assignment}
    }
    else {
      df[count,2] <- "nothing :("
    }
  }
  else{
    count <- count + 1
    df[count,1] <- tip_vec[i]
    df[count,2] <- "unknown"
    cat(tip_vec[i], "\n")
  }
}

### Here starts the code required to generate the yeast figures for OrthoGarden.

# Load in and root trees for benchmarking. S. pombe was chosen to reflect the outgroup chosen in Shen et al. 2018.

shen <- read.tree("shen_renamed_tree.nwk")
shen <- root(shen,"Schizosaccharomyces_pombe")

r2t <- read.tree("r2t_renamed_tree.nwk")
r2t <- root(r2t,"Schizosaccharomyces_pombe")

og <- read.tree("og_renamed_tree.nwk")
og <- root(og,"Schizosaccharomyces_pombe")

# Load in the data frame with tip label/clade combinations

df <- read.csv("tip_labels_w_clades.csv")

# Create an alphabetically ordered vector of all clades (to make the legend behave in the desired way).

clade_order <- c("Alloascoideaceae","Ascomycota","CUG-Ala","CUG-Ser1","CUG-Ser2","Dipodascaceae/Trichomonascaceae","Lipomycetaceae","Mycosphaerellaceae","Phaffomycetaceae","Sporopachydermia clade","Trigonopsidaceae","Pichiaceae","Saccharomycetaceae","Saccharomycodaceae")

### Shen et al. 2018 Tree

# Create a vector of the tip labels present in the Shen tree, and make an empty vector to eventually populate with clade assignments.

shen_tip_vec <- shen$tip.label
shen_clade_assignment <- vector()

# This for loop identifies the clade assignment of each tip label in the Shen tree from the master data frame and populates the vector in the order of the tip labels.

for (i in 1:length(shen_tip_vec)){
  clade_no <- which(df[,1] == shen_tip_vec[i])
  shen_clade_assignment <- c(shen_clade_assignment, df[clade_no,2])
  cat(shen_tip_vec[i],i,shen_clade_assignment[i],"\n")
}

# Combine the tip label and clade assignment vectors into a data frame.

shen_df <- data.frame(
  ID = factor(shen_tip_vec),
  clade = factor(shen_clade_assignment)
)

# Write the figure. The file generated is large, so prepare accordingly.

tiff("shen.tiff", width = 25, height = 20, units = 'in', res = 300)
ggtree(shen,layout="circular") %<+% shen_df +
  geom_tiplab(aes(fill=clade, color=clade),
              size = 3,
              linesize = 6,
              linetype = "solid",
              align=TRUE) +
  geom_tiplab(color = "black",
              size = 3,
              align=TRUE) +
  scale_color_manual(breaks = clade_order, values = c("#e7d4e8","#C49CD5","#9970ab","#873A95","#210333","#A95506","#BAA611","#D8CA5E","#E4DDA4","#D3F0E4","#A0DBB6","#5AAD8B","#226B4E","#033621")) +
  scale_fill_manual(breaks = clade_order, values = c("#e7d4e8","#C49CD5","#9970ab","#873A95","#210333","#A95506","#BAA611","#D8CA5E","#E4DDA4","#D3F0E4","#A0DBB6","#5AAD8B","#226B4E","#033621")) +
  theme(legend.background = element_rect(),
        legend.title = element_blank(),
        legend.key = element_blank(),
        legend.key.size = unit(2, 'cm'), 
        legend.text = element_text(size = 24), 
        title = element_text(size = 28))
dev.off()

# Dylus et al. 2024 (read2tree) Tree

# See the Shen tree for an explanation of the code here, since it's nearly identical to the read2tree tree.

r2t_tip_vec <- r2t$tip.label
r2t_clade_assignment <- vector()

for (i in 1:length(r2t_tip_vec)){
  clade_no <- which(df[,1] == r2t_tip_vec[i])
  r2t_clade_assignment <- c(r2t_clade_assignment, df[clade_no,2])
  cat(r2t_tip_vec[i],i,r2t_clade_assignment[i],"\n")
}

r2t_df <- data.frame(
  ID = factor(r2t_tip_vec),
  clade = factor(r2t_clade_assignment)
)

# The read2tree and OrthoGarden trees have more tips than the Shen et al. tree, some of which with long labels, so these figures are slightly wider to compensate for this. The legend is also removed in this figure.

tiff("r2t.tiff", width = 25, height = 20, units = 'in', res = 300)
ggtree(r2t,layout="circular") %<+% r2t_df +
  geom_tiplab(aes(fill=clade, color=clade),
              size = 3,
              linesize = 4,
              linetype = "solid",
              align=TRUE) +
  geom_tiplab(color = "black",
              size = 3,
              align=TRUE) +
  scale_color_manual(breaks = clade_order, values = c("#e7d4e8","#C49CD5","#9970ab","#873A95","#210333","#A95506","#BAA611","#D8CA5E","#E4DDA4","#D3F0E4","#A0DBB6","#5AAD8B","#226B4E","#033621")) +
  scale_fill_manual(breaks = clade_order, values = c("#e7d4e8","#C49CD5","#9970ab","#873A95","#210333","#A95506","#BAA611","#D8CA5E","#E4DDA4","#D3F0E4","#A0DBB6","#5AAD8B","#226B4E","#033621")) +
  theme(legend.position="none")
dev.off()

# OrthoGarden

# See the Shen tree for an explanation of the code here, since it's nearly identical to the OrthoGarden tree.

og_tip_vec <- og$tip.label
og_clade_assignment <- vector()

for (i in 1:length(og_tip_vec)){
  clade_no <- which(df[,1] == og_tip_vec[i])
  og_clade_assignment <- c(og_clade_assignment, df[clade_no,2])
  cat(og_tip_vec[i],i,og_clade_assignment[i],"\n")
}

og_df <- data.frame(
  ID = factor(og_tip_vec),
  clade = factor(og_clade_assignment)
)

tiff("og.tiff", width = 25, height = 20, units = 'in', res = 300)
ggtree(og,layout="circular") %<+% og_df +
  geom_tiplab(aes(fill=clade, color=clade),
              size = 3,
              linesize = 4,
              linetype = "solid",
              align=TRUE) +
  geom_tiplab(color = "black",
              size = 3,
              align=TRUE) +
  scale_color_manual(breaks = clade_order, values = c("#e7d4e8","#C49CD5","#9970ab","#873A95","#210333","#A95506","#BAA611","#D8CA5E","#E4DDA4","#D3F0E4","#A0DBB6","#5AAD8B","#226B4E","#033621")) +
  scale_fill_manual(breaks = clade_order, values = c("#e7d4e8","#C49CD5","#9970ab","#873A95","#210333","#A95506","#BAA611","#D8CA5E","#E4DDA4","#D3F0E4","#A0DBB6","#5AAD8B","#226B4E","#033621"))
  #theme(legend.position="none")
dev.off()

