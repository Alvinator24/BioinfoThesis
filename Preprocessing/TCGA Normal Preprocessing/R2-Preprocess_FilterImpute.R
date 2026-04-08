beta_raw <- read.delim("C:/Users/Roooiz/Desktop/Thesis Preprocessing/HumanMethylation450", 
                       row.names = 1, check.names = FALSE)

# --- Initial counts ---
initial_probes <- nrow(beta_raw)
initial_samples <- ncol(beta_raw)

# 6. Filter probes with >20% missing values
beta_filtered <- beta_raw[rowMeans(is.na(beta_raw)) <= 0.20, ]

# Probe filtering stats
filtered_probes <- nrow(beta_filtered)
removed_probes <- initial_probes - filtered_probes

cat("Probes removed:", removed_probes, "\n")
cat("Probes remaining:", filtered_probes, "\n\n")

# 7. Filter samples with >10% missing values
beta_filtered <- beta_filtered[, colMeans(is.na(beta_filtered)) <= 0.10]

# Sample filtering stats
filtered_samples <- ncol(beta_filtered)
removed_samples <- initial_samples - filtered_samples

cat("Samples removed:", removed_samples, "\n")
cat("Samples remaining:", filtered_samples, "\n\n")

# --- Missing values before imputation ---
missing_before <- sum(is.na(beta_filtered))

# 8. KNN Imputation
if (!requireNamespace("impute", quietly = TRUE)) {
  BiocManager::install("impute")
}
library(impute)

k <- 5  # KNN parameter
beta_imputed <- t(impute.knn(t(beta_filtered), k = k)$data)

# --- Missing values after imputation ---
missing_after <- sum(is.na(beta_imputed))
imputed_values <- missing_before - missing_after

cat("Missing values before imputation:", missing_before, "\n")
cat("Missing values after imputation:", missing_after, "\n")
cat("Total values imputed:", imputed_values, "\n")

# --- Percent imputed ---
total_values <- prod(dim(beta_filtered))
percent_imputed <- (imputed_values / total_values) * 100

cat("Percent of matrix imputed:", round(percent_imputed, 2), "%\n\n")

# Store final cleaned matrix
beta_clean <- beta_imputed

# 10. Save the final cleaned matrix to CSV
write.csv(beta_clean, 
          file = "C:/Users/Roooiz/Desktop/Thesis Preprocessing/filtered_imputed_data.csv")

cat("Saved cleaned matrix to: C:/Users/Roooiz/Desktop/Thesis Preprocessing/filtered_imputed_data.csv\n")