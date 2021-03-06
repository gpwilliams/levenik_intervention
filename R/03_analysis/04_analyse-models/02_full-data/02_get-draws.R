# get draws from the fitted model for use in summarising results ----

# dpar = TRUE gets draws conditional on all distributional parameters
#   i.e. for mu, phi, zoi, and coi with the zoib model
# re_formula = ~0, allow_new_levels = TRUE allows new levels from those in the 
# data that were used to fit the models. This includes removing factors
# entirely or even adding new levels.

draws <- list()

# exposure phase test ----

# variety and word type
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
  mutate(
    word_type = fct_relabel(word_type, str_replace, " ", "-"),
    word_type = fct_relevel(word_type, "Non-Contrastive"),
    variety_exposure = fct_recode(
      variety_exposure, 
      "No Dialect" = "Variety Match", # new names for paper
      "Dialect" = "Variety Mismatch",
      "Dialect & Social" = "Variety Mismatch Social"
    )
  ) %>% 
  group_by(variety_exposure, word_type)

# variety exposure

draws$exposure_v <- 
  draws$exposure_vw %>% 
  ungroup() %>% 
  group_by(variety_exposure)

# testing phase ----

# task and variety exposure and word type (all levels)
draws$testing_tvw_all <- 
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
  mutate(
    word_type = fct_relabel(word_type, str_replace, " ", "-"),
    word_type = fct_relevel(word_type, "Non-Contrastive"),
    word_familiarity = fct_relevel(word_familiarity, "Trained"),
    variety_exposure = fct_recode(
      variety_exposure, 
      "No Dialect" = "Variety Match", # new names for paper
      "Dialect" = "Variety Mismatch",
      "Dialect & Social" = "Variety Mismatch Social"
    )
  ) %>% 
  group_by(task, variety_exposure, word_type)

# task and variety exposure
draws$testing_tv <- 
  draws$testing_tvw_all %>% 
  ungroup() %>% 
  group_by(task, variety_exposure)

# task and variety exposure for contrastive and non-contrastive words

draws$testing_tvw <- draws$testing_tvw_all %>% 
  filter(word_familiarity == "Trained") %>% 
  ungroup() %>% 
  mutate(word_type = factor(word_type)) %>% 
  group_by(task, variety_exposure, word_type)

# task and variety exposure for novel words only

draws$testing_tv_n <- 
  draws$testing_tvw_all %>% 
  filter(word_type == "Novel") %>%
  ungroup() %>% 
  group_by(task, variety_exposure)

# variety exposure for novel words only

draws$testing_v_n <- draws$testing_tv_n %>% 
  ungroup() %>% 
  group_by(variety_exposure)

# variety exposure

draws$testing_v <- 
  draws$testing_tvw_all %>% 
  ungroup() %>% 
  group_by(variety_exposure)

# testing phase with vocabulary test performance as a covariate ----

draws$testing_cov_tvw <- 
  all_data$testing %>% 
  as.data.frame() %>% 
  data_grid(
    mean_exposure_test_nLED = modelr::seq_range(
      mean_exposure_test_nLED, 
      n = 50
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
  mutate(word_type = fct_relabel(word_type, str_replace, " ", "-"),
    word_type = fct_relevel(word_type, "Non-Contrastive"),
    word_familiarity = fct_relevel(word_familiarity, "Trained"),
    variety_exposure = fct_recode(
      variety_exposure, 
      "No Dialect" = "Variety Match", # new names for paper
      "Dialect" = "Variety Mismatch",
      "Dialect & Social" = "Variety Mismatch Social"
    )
  ) %>% 
  group_by(task, variety_exposure, word_type)

# testing phase with vocabulary test performance as a covariate (median split) ----

draws$testing_cov_median_etv <- draws$testing_cov_tvw %>% 
  ungroup() %>% 
  mutate(exposure_test_nLED_group = case_when( # median split
    mean_exposure_test_nLED < 
      median(all_data$testing$mean_exposure_test_nLED) ~ "Better Performance",
    mean_exposure_test_nLED > 
      median(all_data$testing$mean_exposure_test_nLED) ~ "Worse Performance"
    )
  ) %>% 
  mutate(
    exposure_test_nLED_group = fct_relevel(
      exposure_test_nLED_group, 
      "Better Performance"
  )) %>% 
  select(-c(mean_exposure_test_nLED)) %>% 
  group_by(exposure_test_nLED_group, task, variety_exposure, word_type)

# testing cov (median split): task and variety for 
# contrastive and non-contrastive words
draws$testing_cov_median_etvw <- 
  draws$testing_cov_median_etv %>% 
  filter(word_familiarity != "Novel")

# testing cov (median split): variety for novel words
draws$testing_cov_median_ev_n <- 
  draws$testing_cov_median_etv %>% 
  filter(word_familiarity == "Novel") %>% 
  ungroup() %>% 
  group_by(exposure_test_nLED_group, variety_exposure)

# testing cov (median split): task and variety for novel words
draws$testing_cov_median_etv_n <- 
  draws$testing_cov_median_etv %>% 
  filter(word_familiarity == "Novel") %>% 
  ungroup() %>% 
  group_by(exposure_test_nLED_group, task, variety_exposure)