# Quantitative Color Analysis Workflow

This repository demonstrates a reproducible workflow for processing, analyzing, and modeling image-derived quantitative color data in R. The project integrates simulated pixel-level image data and longitudinal behavioral datasets to illustrate approaches for metadata parsing, feature engineering, exploratory visualization, and generalized linear mixed modeling (GLMM).

Although inspired by biological signaling research, the analytical framework demonstrated here is broadly applicable to quantitative image analysis and longitudinal data modeling workflows across scientific and data-driven disciplines.

---

## Repository Structure

```text
quantitative-color-analysis-workflow/
│
├── data/
│   ├── pixelvalues/
│   └── toy_behavior_data.csv
│
├── output/
│   ├── color_metrics.csv
│   └── rawpixels/
│
├── scripts/
│   ├── simulate_color_data.R
│   ├── simulate_behavior_data.R
│   ├── color-data-wrangling-workflow.Rmd
│   └── longitudinal-behavior-modeling.Rmd
│
├── quantitative-color-analysis-workflow.Rproj
└── README.md
```

---

## Workflow Overview

### 1. Simulated Data Generation
Toy pixel-level image datasets and longitudinal behavioral datasets are generated to demonstrate reproducible analytical workflows without requiring access to original research data.

### 2. Image-Derived Color Wrangling
The color wrangling workflow:
- parses image metadata from file names,
- reconstructs channel-specific image data,
- filters low-quality pixels,
- calculates opponent-channel color metrics,
- extracts localized peak-color subsets,
- and summarizes region-level color features.

### 3. Longitudinal Mixed-Effects Modeling
The modeling workflow:
- merges behavioral and color datasets,
- performs exploratory visualization,
- fits generalized linear mixed models (GLMMs),
- evaluates model diagnostics,
- and visualizes predicted effects.

---

## Methods Demonstrated

### Data Wrangling
- Metadata parsing
- Large-scale file handling
- Feature engineering
- Reproducible workflows

### Quantitative Analysis
- Opponent-channel color metrics
- Longitudinal data processing
- Generalized linear mixed models (GLMMs)
- Negative binomial modeling
- Model diagnostics and residual simulation

### Visualization
- Longitudinal trajectory plots
- Distribution visualization
- Predicted effect visualization
- Pixel-level heatmaps

---

## Software and Packages

Primary packages used include:

- tidyverse
- data.table
- glmmTMB
- DHARMa
- ggeffects
- patchwork
- here

---

## Running the Workflow

Recommended execution order:

1. `simulate_color_data.R`
2. `color-data-wrangling-workflow.Rmd`
3. `simulate_behavior_data.R`
4. `longitudinal-behavior-modeling.Rmd`

---

## Notes

- All datasets included in this repository are simulated.
- The repository is intended as a reproducible portfolio workflow demonstrating quantitative analytical methods and computational research practices.
- Original research data are not included.