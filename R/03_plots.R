# R/03_plots.R
suppressPackageStartupMessages({
  library(metafor); library(readr)
})

dir.create("outputs/figures", recursive = TRUE, showWarnings = FALSE)

d <- read_rds("outputs/clean_data.rds")
fit <- rma(yi = yi, vi = vi, data = d, method = "REML")

png("outputs/figures/forest.png", width = 1200, height = 1600, res = 200)
try({
  slab <- if ("label" %in% names(d)) d$label else paste0("Study ", d$study_id)
  forest(fit, slab = slab, xlab = "Effect size")
})
dev.off()

png("outputs/figures/funnel.png", width = 1200, height = 1200, res = 200)
try(funnel(fit, xlab = "Effect size"))
dev.off()

message("Figures saved in outputs/figures")
