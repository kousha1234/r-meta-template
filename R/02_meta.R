# R/02_meta.R
suppressPackageStartupMessages({
  library(metafor); library(readr); library(dplyr); library(tibble)
})

dir.create("outputs", showWarnings = FALSE)
dir.create("outputs/tables", showWarnings = FALSE)

d <- read_rds("outputs/clean_data.rds")

fit <- rma(yi = yi, vi = vi, data = d, method = "REML")

res <- tibble(
  k = fit$k,
  estimate = as.numeric(fit$b),
  se = fit$se,
  zval = fit$zval,
  pval = fit$pval,
  ci_lb = fit$ci.lb,
  ci_ub = fit$ci.ub,
  tau2 = fit$tau2,
  i2 = fit$I2,
  h2 = fit$H2,
  QE = fit$QE,
  QEp = fit$QEp
)

egger <- tryCatch({
  et <- regtest(fit, model = "rma")
  tibble(egger_z = et$zval, egger_p = et$pval)
}, error = function(e) tibble(egger_z = NA_real_, egger_p = NA_real_))

out <- bind_cols(res, egger)
write_csv(out, "outputs/tables/meta_results.csv")
saveRDS(list(model = fit, results = out), file = "outputs/meta_fit.rds")
message("Meta-analysis complete. Results -> outputs/tables/meta_results.csv")
