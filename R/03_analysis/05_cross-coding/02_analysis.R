# inter-rater reliability measures ----

# see: http://www.cookbook-r.com/Statistical_analysis/Inter-rater_reliability/

# intraclass correlation for nLED; automatically ignores NAs
irr_results <- icc(
  summed_data %>% select(contains("nLED")), 
  model = "twoway", 
  type = "agreement",
  unit = "single"
)

# save results
saveRDS(
  irr_results, 
  file = here(
    "04_analysis", 
    "03_cross-coding", 
    "irr-results.RData"
  )
)