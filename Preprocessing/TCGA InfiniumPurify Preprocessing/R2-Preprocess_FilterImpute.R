beta_raw <- read.delim("C:/Users/Roooiz/Desktop/Thesis Preprocessing/tryingInfiniumPurify/HumanMethylation450", row.names = 1, check.names = FALSE)

# 6. Filter probes with >20% missing values
beta_filtered <- beta_raw[rowMeans(is.na(beta_raw)) <= 0.20, ]

# 7. Filter samples with >10% missing values
beta_filtered <- beta_filtered[, colMeans(is.na(beta_filtered)) <= 0.10]

# 8. KNN
if (!requireNamespace("impute", quietly = TRUE)) {
  BiocManager::install("impute")
}
library(impute)
k <- 5  # KNN parameter
beta_imputed <- t(impute.knn(t(beta_filtered), k = k)$data)

# Store final cleaned matrix
beta_clean <- beta_imputed

# 10. Save the final cleaned matrix to CSV
write.csv(beta_clean, file = "C:/Users/Roooiz/Desktop/Thesis Preprocessing/tryingInfiniumPurify/filtered_imputed_data.csv")
cat("Saved cleaned matrix to: C:/Users/Roooiz/Desktop/Thesis Preprocessing/tryingInfiniumPurify/filtered_imputed_data.csv\n")