# ========================
# STEP 1: Setup Environment
# ========================

# Set working directory to TCGA-Assembler source folder
setwd("C:/Users/Roooiz/Desktop/Thesis Preprocessing/tryingInfiniumPurify/TCGA-Assembler")

# Source the main module that contains the function
source("Module_B.R")

# ========================
# STEP 2: Load Your Data
# ========================

# Load cleaned probe-level methylation matrix
library(data.table)

beta_clean <- fread(
  "C:/Users/Roooiz/Desktop/Thesis Preprocessing/tryingInfiniumPurify/purified_probe_level.csv",
  data.table = FALSE
)

# Set row names and remove first column
rownames(beta_clean) <- beta_clean[,1]
beta_clean <- beta_clean[,-1]

# ========================
# STEP 3: Load Annotation
# ========================

# Load methylation annotation file (this provides IlmnID ↔ gene mapping)
load("SupportingFiles/MethylationChipAnnotation.rda")  # loads MethylAnno

# ========================
# STEP 4: Prepare Input List for the Function
# ========================

# Match annotation to matrix probes
matched_anno <- MethylAnno[MethylAnno$IlmnID %in% rownames(beta_clean), ]

# Construct Des: metadata table with REF and GeneSymbol
Des <- data.frame(
  REF = matched_anno$IlmnID,
  GeneSymbol = matched_anno$GeneSymbol,
  stringsAsFactors = FALSE
)

# Reorder beta matrix to match Des
Data <- beta_clean[Des$REF, ]

# Combine into input list
input <- list(Des = Des, Data = as.matrix(Data))

# ========================
# STEP 5: Run Gene-Level Mapping
# ========================

# This will:
# - filter for TSS1500 and TSS200 regions
# - average per gene
# - output matrix + .txt + .rda + .png boxplot

result <- CalculateSingleValueMethylationData(
  input = input,
  regionOption = c("TSS1500", "TSS200"),
  DHSOption = "Both",
  outputFileName = "gene_level_methylation",
  outputFileFolder = "C:/Users/Roooiz/Desktop/Thesis Preprocessing/tryingInfiniumPurify"
)

# ========================
# STEP 6: Done — Your Output Files Are:
# ========================
# - gene_level_methylation__TSS1500-TSS200__Both.txt
# - gene_level_methylation__TSS1500-TSS200__Both.rda
# - gene_level_methylation__TSS1500-TSS200__Both_boxplot.png

cat("✅ Gene-level methylation matrix saved in Thesis folder.\n")