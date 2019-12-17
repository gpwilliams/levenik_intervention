# set options for analyses ----

analysis_options <- list(
  cores = parallel::detectCores(), # 6 for me; using same number of chains
  chains = 6,
  iterations = 8000,
  iterations_agg = 6000,
  rand_seed = 1892, # allows for reproducibility
  exposure_adapt_delta = .80,
  testing_adapt_delta = .80,
  testing_adapt_delta_agg = .90,
  max_treedepth = 10,
  max_treedepth_agg = 15,
  init_r = 0.1
)