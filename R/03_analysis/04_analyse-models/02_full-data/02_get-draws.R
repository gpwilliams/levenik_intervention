# get draws from the fitted model for use in summarising results ----

# dpar = TRUE gets draws conditional on all distributional parameters
#   i.e. for mu, phi, zoi, and coi with the zoib model

draws <- list()

# exposure phase test ----

draws$exposure_vw <- 
  all_data$exposure %>% 
  as.data.frame() %>% 
  data_grid(variety_exposure, word_type) %>% 
  add_fitted_draws(
    models$exposure, 
    dpar = TRUE, 
    re_formula = ~0, 
    seed = analysis_options$rand_seed
  ) %>% 
  ungroup() %>% 
  mutate_if(is.factor, fct_relabel, ~str_to_title(gsub("_", " ", .x))) %>% 
  mutate(word_type = fct_relabel(word_type, str_replace, " ", "-")) %>% 
  mutate(word_type = fct_relevel(word_type, "Non-Contrastive")) %>% 
  group_by(variety_exposure, word_type)

draws$exposure_v <- draws$exposure_vw %>% 
  group_by(variety_exposure, .draw) %>% 
  summarise(.value = mean(.value))
  
# testing phase ----

# task, variety exposure, and word type

draws$testing_tvw <- 
  all_data$testing %>% 
  as.data.frame() %>% 
  data_grid(task, variety_exposure, word_type) %>% 
  add_fitted_draws(
    models$testing, 
    dpar = TRUE, 
    re_formula = ~0, 
    seed = analysis_options$rand_seed
  ) %>% 
  ungroup() %>% 
  mutate(
    word_familiarity = factor(case_when(
      word_type != "novel" ~ "Trained",
      word_type == "novel" ~ "Novel"
    ))
  ) %>% 
  mutate_if(is.factor, fct_relabel, ~str_to_title(gsub("_", " ", .x))) %>% 
  mutate(word_type = fct_relabel(word_type, str_replace, " ", "-")) %>% 
  mutate(
    word_type = fct_relevel(word_type, "Non-Contrastive"),
    word_familiarity = fct_relevel(word_familiarity, "Trained")) %>% 
  group_by(task, variety_exposure, word_type)

# testing phase with vocabulary test performance as a covariate ----

draws$testing_cov_tvw <- 
  all_data$testing %>% 
  as.data.frame() %>% 
  data_grid(
    mean_exposure_test_nLED = modelr::seq_range(
      mean_exposure_test_nLED, 
      n = 51
    ),
    task, 
    variety_exposure, 
    word_type
  ) %>% 
  add_fitted_draws(
    models$testing_cov, 
    dpar = TRUE, 
    re_formula = ~0, 
    seed = analysis_options$rand_seed,
    n = 1000
  ) %>% 
  ungroup() %>% 
  mutate(
    word_familiarity = factor(case_when(
      word_type != "novel" ~ "Trained",
      word_type == "novel" ~ "Novel"
    ))
  ) %>% 
  mutate_if(is.factor, fct_relabel, ~str_to_title(gsub("_", " ", .x))) %>% 
  mutate(word_type = fct_relabel(word_type, str_replace, " ", "-")) %>% 
  mutate(
    word_type = fct_relevel(word_type, "Non-Contrastive"),
    word_familiarity = fct_relevel(word_familiarity, "Trained")) %>% 
  group_by(task, variety_exposure, word_type)

# testing phase with vocabulary test performance as a covariate (median split) ----

draws$testing_cov_median_etv <- draws$testing_cov_tvw %>% 
  ungroup() %>% 
  mutate(exposure_test_nLED_group = case_when( # median split
    mean_exposure_test_nLED < 
      median(all_data$testing$mean_exposure_test_nLED) ~ "Low",
    mean_exposure_test_nLED > 
      median(all_data$testing$mean_exposure_test_nLED) ~ "High"
    )
  ) %>% 
  mutate(
    exposure_test_nLED_group = fct_relevel(
      exposure_test_nLED_group, 
      "Low"
  )) %>% 
  select(-c(mean_exposure_test_nLED)) %>% 
  group_by(exposure_test_nLED_group, task, variety_exposure, word_type)