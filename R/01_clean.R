# R/01_clean.R
suppressPackageStartupMessages({
  library(readr); library(dplyr)
})

dir.create("outputs", showWarnings = FALSE)
dir.create("outputs/tables", showWarnings = FALSE)

d <- read_csv("data/synthetic_trials.csv", show_col_types = FALSE)

if (!("vi" %in% names(d))) {
  d <- d |> mutate(vi = ifelse(is.na(sei), NA_real_, sei^2))
}
if (!("sei" %in% names(d))) {
  d <- d |> mutate(sei = ifelse(is.na(vi), NA_real_, sqrt(vi)))
}

d <- d |>
  mutate(study_id = as.character(study_id))

write_rds(d, "outputs/clean_data.rds")
write_csv(d, "outputs/tables/clean_data.csv")
message("Clean data saved to outputs/")
