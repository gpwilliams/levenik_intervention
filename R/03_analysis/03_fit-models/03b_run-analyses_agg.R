# fit models using brms::brm() ----

message("Fitting models.")

message("Fitting exposure model on aggregate data.")

models$exposure_agg <- brm(
  formula = formulae$exposure_agg, 
  family = "beta",
  data = all_data_agg$exposure_agg,
  prior = priors$exposure_agg,
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
  models$exposure_agg, 
  here("04_analysis", "01_models", "exposure_model_agg.rds")
)

message("Fitting testing model on aggregate data.")

models$testing_agg <- brm(
  formula = formulae$testing_agg, 
  data = all_data_agg$testing_agg,
  prior = priors$testing_agg,
  cores = analysis_options$cores,
  chains = analysis_options$chains,
  iter = analysis_options$iterations_agg,
  seed = analysis_options$rand_seed,
  control = list(
    adapt_delta = analysis_options$testing_adapt_delta_agg, 
    max_treedepth = analysis_options$max_treedepth_agg
  )
)

write_rds(
  models$testing_agg, 
  here("04_analysis", "01_models", "testing_model_agg.rds")
)

message("Fitting testing covariate model on aggregate data.")

models$testing_cov_agg <- brm(
  formula = formulae$testing_cov_agg, 
  data = all_data_agg$testing_agg,
  prior = priors$testing_agg,
  cores = analysis_options$cores,
  chains = analysis_options$chains,
  iter = analysis_options$iterations_agg,
  seed = analysis_options$rand_seed,
  control = list(
    adapt_delta = analysis_options$testing_adapt_delta_agg, 
    max_treedepth = analysis_options$max_treedepth_agg
  )
)

write_rds(
  models$testing_cov_agg, 
  here("04_analysis", "01_models", "testing_cov_model_agg.rds")
)