# Meta-analysis Template (R, synthetic data)

**Purpose.** End-to-end meta-analysis with privacy-safe synthetic data. Ready to clone, run, and adapt.

**Data.** Synthetic trials (k=12) with effect sizes (`yi`) and standard errors (`sei`).

**Methods.**
- Random-effects model (`metafor::rma`, REML)
- Heterogeneity: τ², I², H², Cochran's Q
- Small-study bias check: Egger regression (`regtest`)
- Forest and funnel plots saved as PNG

## Quick start
```r
# Optional: reproducible env
# install.packages(c("metafor","readr","dplyr","ggplot2","rmarkdown"))
source("R/01_clean.R")
source("R/02_meta.R")
source("R/03_plots.R")
rmarkdown::render("reports/meta_report.Rmd")
```

## Files
- `data/synthetic_trials.csv` — fabricated input
- `R/01_clean.R` — read + harmonize (`vi = sei^2`), save cleaned data
- `R/02_meta.R` — fit random-effects, export key stats
- `R/03_plots.R` — forest/funnel to `outputs/figures`
- `reports/meta_report.Rmd` — compact HTML report
- `outputs/` — results, figures, tables
- `LICENSE`, `CITATION.cff`, `.gitignore`

## Tech
R, metafor, readr, dplyr, ggplot2, rmarkdown

## License
MIT.
