# Stata Training Do‑file – Complete Workflow

**A complete Stata do‑file for learning data cleaning, analysis, and visualization.**  
Covers: data cleaning, missing values, duplicates, recoding, `egen`, t‑tests, chi‑square, correlation, ANOVA, logistic regression, and graphs (bar, scatter, pie). Perfect for mastering Stata workflow.

## 📌 Overview

This repository contains a single Stata do‑file that walks through an end‑to‑end data analysis pipeline:

- **Data cleaning** – handling missing values, duplicates, inconsistencies  
- **Variable manipulation** – recoding, `encode`, `egen` for means/sums  
- **Statistical testing** – t‑tests, chi‑square, correlation, ANOVA  
- **Regression** – logistic regression (odds ratios)  
- **Visualisation** – bar charts, scatter plots, pie charts  
- **Best practices** – comments, labelling, and reproducible code

## 📁 Repository contents

- `stata_training_dofile.do` – main Stata script  
- `README.md` – this file

## 🔧 Requirements

- Stata (version 12 or later)  
- A dataset (the do‑file assumes `stidata-unclean.dta` – update the file path as needed)

## 🚀 Usage

1. Clone the repository  
2. Open Stata and set your working directory to the repo folder  
3. Update the file path in the do‑file to point to your dataset  
4. Run the do‑file:  
   ```stata
   do "stata_training_dofile.do"
