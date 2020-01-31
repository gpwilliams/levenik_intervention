# Calculate ROPE using bayestestR ----

# exposure ----

# difference in nLED between variety exposure conditions
model_summaries$exposure_v_compare_rope <- gmap_rope(
  data = draws$exposure_v_compare, 
  draws = .value, 
  variety_exposure,
  bounds = c(-.035, .035) # half smallest variety exposure effect in JEP:G
) %>% 
  mutate_if(is.numeric, round, summary_options$rounding)

# difference in nLED by word type within each variety exposure condition
model_summaries$exposure_vw_compare_rope <- gmap_rope(
  data = draws$exposure_vw_compare, 
  draws = .value, 
  variety_exposure,
  word_type,
  bounds = c(-.02, .02) # half smallest word type effect in JEP:G
) %>% 
  mutate_if(is.numeric, round, summary_options$rounding)

# testing ----

# difference in nLED between variety exposure conditions
model_summaries$testing_v_compare_rope <- gmap_rope(
  data = draws$testing_v_compare, 
  draws = .value, 
  variety_exposure,
  bounds = c(-.035, .035)
) %>% 
  mutate_if(is.numeric, round, summary_options$rounding)

# difference in nLED by task between variety exposure conditions
model_summaries$testing_tv_compare_rope <- gmap_rope(
  data = draws$testing_tv_compare, 
  draws = .value, 
  variety_exposure,
  bounds = c(-.035, .035)
) %>% 
  mutate_if(is.numeric, round, summary_options$rounding)

# difference in nLED between variety exposure conditions for novel words
model_summaries$testing_v_n_compare_rope <- gmap_rope(
  data = draws$testing_v_n_compare, 
  draws = .value, 
  variety_exposure,
  bounds = c(-.035, .035)
) %>% 
  mutate_if(is.numeric, round, summary_options$rounding)

# difference in nLED between variety exposure conditions by task for novel words
model_summaries$testing_tv_n_compare_rope <- gmap_rope(
  data = draws$testing_tv_n_compare, 
  draws = .value, 
  variety_exposure,
  bounds = c(-.035, .035)
) %>% 
  mutate_if(is.numeric, round, summary_options$rounding)

# difference in nLED for word type by task and variety exposure condition
model_summaries$testing_tvw_compare_rope <- gmap_rope(
  data = draws$testing_tvw_compare, 
  draws = .value, 
  task, 
  variety_exposure,
  word_type,
  bounds = c(-.02, .02)
) %>% 
  mutate_if(is.numeric, round, summary_options$rounding)

# difference in nLED for the magnitude of word type effect 
# in mismatch vs. mismatch social variety conditions only
model_summaries$testing_tvw_ms_compare_rope <- gmap_rope(
  data = draws$testing_tvw_ms_compare, 
  draws = .value, 
  task, 
  word_type,
  variety_exposure,
  bounds = c(-.02, .02)
) %>% 
  mutate_if(is.numeric, round, summary_options$rounding)

# difference in nLED for the magnitude of vocab test differences 
# across variety exposure conditions in testing
# (vocab test median split)
model_summaries$testing_cov_median_etv_n_compare_rope <- gmap_rope(
  data = draws$testing_cov_median_etv_n_compare, 
  draws = .value, 
  exposure_test_nLED_group,
  task, 
  variety_exposure,
  bounds = c(-.02, .02)
) %>% 
  mutate_if(is.numeric, round, summary_options$rounding)

# word type split by voctest group, task, and variety exposure
# (vocab by median split)
model_summaries$testing_cov_median_etvw_compare_rope <- gmap_rope(
  data = draws$testing_cov_median_etvw_compare, 
  draws = .value, 
  exposure_test_nLED_group,
  task, 
  variety_exposure,
  word_type,
  bounds = c(-.02, .02)
) %>% 
  mutate_if(is.numeric, round, summary_options$rounding)