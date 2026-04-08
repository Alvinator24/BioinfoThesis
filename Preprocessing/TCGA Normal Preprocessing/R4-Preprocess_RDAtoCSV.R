# 1. Load the .rda file generated earlier
load("C:/Users/Roooiz/Desktop/Thesis Preprocessing/gene_level_methylation__TSS1500-TSS200__Both.rda")
# This loads two objects: Des and Data

# 2. Combine Des (metadata) and Data (matrix)
gene_level_df <- cbind(Des, Data)

# 3. Write to CSV
write.csv(gene_level_df,
          "C:/Users/Roooiz/Desktop/Thesis Preprocessing/gene_level_methylation.csv",
          row.names = FALSE)

cat("✅ gene_level_methylation.csv saved successfully.\n")