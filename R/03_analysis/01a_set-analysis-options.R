# set options for analyses ----

analysis_options <- list(
  cores = parallel::detectCores(), # 6 for me; also defines number of chains
  chains = 6,
  iterations = 6000,
  rand_seed = 1892, # allows for reproducibility
  exposure_adapt_delta = .99,
  testing_adapt_delta = .90,
  max_treedepth = 15
)