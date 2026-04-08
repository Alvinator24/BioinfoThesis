install.packages("InfiniumPurify")

library(InfiniumPurify)

library(data.table)

# ----------------------------------
# Identify tumor vs normal samples
# ----------------------------------

beta_clean <- fread(
  "C:/Users/Roooiz/Desktop/Thesis Preprocessing/tryingInfiniumPurify/put back normal/filtered_imputed_data.csv",
  data.table = FALSE
)

rownames(beta_clean) <- beta_clean[,1]
beta_clean <- beta_clean[,-1]


tumor_samples  <- grep("-01", colnames(beta_clean), value = TRUE)
normal_samples <- grep("-11", colnames(beta_clean), value = TRUE)

tumor_beta  <- beta_clean[, tumor_samples]
normal_beta <- beta_clean[, normal_samples]

# ----------------------------------
# Estimate purity
# ----------------------------------

purity <- getPurity(
  tumor.data  = tumor_beta,
  normal.data = normal_beta,
  tumor.type  = "BRCA"
)

# ----------------------------------
# Purity statistics (before adjustment)
# ----------------------------------

# Ensure purity is numeric (just in case)
purity <- as.numeric(purity)

cat("Purity Statistics:\n")
cat("Min:", min(purity, na.rm = TRUE), "\n")
cat("1st Quartile:", quantile(purity, 0.25, na.rm = TRUE), "\n")
cat("Median:", median(purity, na.rm = TRUE), "\n")
cat("Mean:", mean(purity, na.rm = TRUE), "\n")
cat("3rd Quartile:", quantile(purity, 0.75, na.rm = TRUE), "\n")
cat("Max:", max(purity, na.rm = TRUE), "\n\n")

# save purity stats to CSV
purity_stats <- data.frame(
  Min = min(purity, na.rm = TRUE),
  Q1 = quantile(purity, 0.25, na.rm = TRUE),
  Median = median(purity, na.rm = TRUE),
  Mean = mean(purity, na.rm = TRUE),
  Q3 = quantile(purity, 0.75, na.rm = TRUE),
  Max = max(purity, na.rm = TRUE)
)

write.csv(
  purity_stats,
  "C:/Users/Roooiz/Desktop/Thesis Preprocessing/tryingInfiniumPurify/put back normal/purity_stats.csv",
  row.names = FALSE
)

cat("Saved purity statistics.\n\n")

# ----------------------------------
# Purify tumor methylation
# ----------------------------------

tumor_beta_purified <- InfiniumPurify(
  tumor.data  = tumor_beta,
  normal.data = normal_beta,
  purity      = purity
)

# ----------------------------------
# Continue with purified tumors
# ----------------------------------

beta_final <- cbind(
  tumor_beta_purified,
  normal_beta
)

# ----------------------------------
# Save purified tumor CpG matrix
# ----------------------------------

write.csv(
  beta_final,
  "C:/Users/Roooiz/Desktop/Thesis Preprocessing/tryingInfiniumPurify/put back normal/purified_probe_level.csv"
)

cat("✅ Saved purified CpG-level matrix.\n")
