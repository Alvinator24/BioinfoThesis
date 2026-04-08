# Install BiocManager (manages Bioconductor packages)
 cat("Step 1: Checking BiocManager...\n")
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}

# Install only what you need
 cat("Step 2: Installing packages...\n")
BiocManager::install(c("ChAMP", "impute", "Biobase"), ask = FALSE, force = TRUE)