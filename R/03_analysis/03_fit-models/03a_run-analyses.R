# fit models using brms::brm() ----

message("Fitting models.")

# vocabulary test data ----

message("Fitting exposure model on full data.")

models$exposure <- brm(
  formula = formulae$exposure, 
  data = all_data$exposure,
  prior = priors$exposure,
  cores = analysis_options$cores,
  chains = analysis_options$chains,
  iter = analysis_options$iterations,
  seed = analysis_options$rand_seed,
  control = list(
    adapt_delta = analysis_options$exposure_adapt_delta, 
    max_treedepth = analysis_options$max_treedepth
  )
)

write_rds(
  models$exposure, 
  here("04_analysis", "01_models", "exposure_model.rds")
)

# testing data ----

message("Fitting testing model on full data.")

models$testing <- brm(
  formula = formulae$testing, 
  data = all_data$testing,
  prior = priors$testing,
  cores = analysis_options$cores,
  chains = analysis_options$chains,
  iter = analysis_options$iterations,
  seed = analysis_options$rand_seed,
  control = list(
    adapt_delta = analysis_options$testing_adapt_delta, 
    max_treedepth = analysis_options$max_treedepth
  )
)

write_rds(
  models$testing, 
  here("04_analysis", "01_models", "testing_model.rds")
)

message("Fitting testing model with covariate on full data.")

models$testing_cov <- brm(
  formula = formulae$testing_cov, 
  data = all_data$testing,
  prior = priors$testing,
  cores = analysis_options$cores,
  chains = analysis_options$chains,
  iter = analysis_options$iterations,
  seed = analysis_options$rand_seed,
  control = list(
    adapt_delta = analysis_options$testing_adapt_delta, 
    max_treedepth = analysis_options$max_treedepth
  )
)

write_rds(
  models$testing_cov, 
  here("04_analysis", "01_models", "testing_cov_model.rds")
)