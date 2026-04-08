# A Comprehensive Benchmarking of Machine Learning Models Using DNA Methylation Data for Breast Cancer Subtype Classification

Authors
| Role | Name | Contact |
| -------- | -------- | -------- |
| Author | Arco, Gabrielle Mae | gabrielle_mae_arco@dlsu.edu.ph |
| Author | Buencamino, Prince Bendrik | prince_buencamino@dlsu.edu.ph |
| Author | Cua, Alvin Sean | alvin_cua@dlsu.edu.ph |
| Author | Ruiz, Chester Bryan | chester_ruiz@dlsu.edu.ph |
| Advisor| Dr. Shrestha, Anish | anish.shrestha@dlsu.edu.ph |

In partial fulfillment of the requirements for the degree of Bachelor of Science in Computer Science Major in Software Technology

## Overview

### Breast Cancer
According to the Global Cancer Statistics 2020 and estimates from the Global Cancer Observatory, breast cancer was the most commonly diagnosed cancer in 2020. It accounted for approximately 2.3 million new cases and around 684,996 deaths, making up to 11.7% of the estimated global distribution of new cancer cases.

Given its global prevalence, it is important to understand its molecular subtypes, as these can help in guiding treatment decisions and predicting patient outcomes.

For our study, we focused on the PAM50 subtypes, because compared to other subtype classifications, these are more closely linked with prognostic and clinical outcomes. PAM50 subtypes include: Luminal A, Luminal B, HER2-enriched, Basal-like, Normal-like. With each responding differently to treatment.

### DNA Methylation
DNA methylation is a form of epigenetic regulation that helps cells determine which genes should be turned on or off. These methylation markers can be obtained from blood, urine, or saliva, and they are more stable over time compared to RNA data, allowing for longer-term storage and analysis. In breast cancer, abnormal methylation patterns may lead to the silencing of tumor suppressor genes or the activation of oncogenes. Moreover, studies have shown that methylation profiles are often subtype-specific, making them particularly useful for distinguishing between different breast cancer subtypes.

### Tumor Purity
Tumor purity refers to the percentage of cancer cells present in a tissue sample, compared to non-cancerous cells such as normal tissue cells. It is important to account for because low-purity samples can distort DNA methylation signals, which may lead to incorrect clustering or cancer subtype classification.

To address this, we use an R package called InfiniumPurify, which estimates tumor purity and adjusts methylation beta values, which could allow for more accurate analysis of tumor-specific patterns.

### Datasets
For the project, we used the following datasets:
- TCGA Methylation450k
  - 485,578 identifiers x 888 samples
  - Obtained from UCSC Xena
 
- Norway Dataset (GSE84207)
  - 622,399 identifiers x 330 samples
  - Obtained from Gene Expression Omnibus
 
For testing, each dataset was duplicated and applied with InfiniumPurify, for a total of 4 datasets:
- TCGA Unpurified
- TCGA Purified
- Norway Unpurified
- Norway Purified
Each dataset was split into 80% for training and 20% for testing.

### Models and Techniques
- Machine Learning Algorithms
  - Random Forest
  - Support Vector Machines
  - Neural Networks

- Feature Elimination Techniques
  - Recursive Feature Elimination (RFE) (For Random Forest and Support Vector Machine)
  - Autoencoders (For Neural Networks)
  - No RFE/Autoencoders

- Class Imbalance Handling Techniques
  - Synthetic Minority Oversampling Technique (SMOTE)
  - Inverse Random Under Sampling (IRUS)
  - No Class Imbalance Handling

- Explainability Techniques
  - Shapley Additive Explanations (SHAP)
 
For a total of 72 models.

## File Structure
- Preprocessing/
  - Contains all Preprocessing related files such as:
- RandomForest/
  - Contains all RF related files
- SVM/
  - Contains all SVM related files
- NeuralNetworks/
  - Contains all NN related files
- Final Graphs/
  - Contains .npy files of all the best models and a .ipynb for graphing these models
- exploredata.ipynb
- purification_effect.ipynb
- TCGA_Norway_EDA_No_Split.ipynb
