# Compare differences in performance across levels ----

# currently uses mean and percentile intervals

# exposure test ----

# variety exposure

draws$exposure_v_compare_agg <- draws$exposure_vw_agg %>% 
  group_by(variety_exposure, .draw) %>%
  summarise(.value = mean(.value)) %>% 
  compare_levels(.value, by = variety_exposure)

# word type by variety exposure

draws$exposure_vw_compare_agg <- draws$exposure_vw_agg %>% 
  compare_levels(.value, by = word_type)

# testing ----

# overall performance by variety exposure ----

draws$testing_v_compare_agg <- draws$testing_tvw_agg %>% 
  group_by(variety_exposure, .draw) %>%
  summarise(.value = mean(.value)) %>% 
  compare_levels(
    .value, 
    by = variety_exposure,
    comparison = list(
      c("Variety Match", "Variety Mismatch"), 
      c("Variety Match", "Variety Mismatch Social"),
      c("Variety Match", "Dialect Literacy"),
      c("Variety Mismatch", "Variety Mismatch Social"),
      c("Variety Mismatch Social", "Dialect Literacy")
    )
  )

# performance for novel words by variety exposure ----

draws$testing_v_n_compare_agg <- draws$testing_tvw_agg %>% 
  filter(word_familiarity == "Novel") %>% 
  group_by(variety_exposure, .draw) %>%
  summarise(.value = mean(.value)) %>% 
  compare_levels(
    .value, 
    by = variety_exposure,
    comparison = list(
      c("Variety Match", "Variety Mismatch"), 
      c("Variety Match", "Variety Mismatch Social"),
      c("Variety Match", "Dialect Literacy"),
      c("Variety Mismatch", "Variety Mismatch Social"),
      c("Variety Mismatch Social", "Dialect Literacy")
    )
  )

# word type by task and variety exposure

draws$testing_tvw_compare_agg <- draws$testing_tvw_agg %>% 
  filter(word_familiarity != "Novel") %>%  
  group_by(task, variety_exposure, word_type) %>%
  compare_levels(.value, by = word_type)

# magnitude of word type in mismatch and mismatch social

draws$testing_tvw_ms_compare_agg <- draws$testing_tvw_agg %>% 
  filter(
    word_familiarity != "Novel", 
    variety_exposure %in% c("Variety Mismatch", "Variety Mismatch Social")
  ) %>% 
  group_by(task, variety_exposure, word_type) %>%
  compare_levels(.value, by = word_type) %>% 
  compare_levels(.value, by = variety_exposure)

# testing covariate comparisons ----

# note, has only 20% of draws as other contrasts

# compare high vs. low performing voctest scores, and check for differences
# between variety exposure conditions, split by task.
draws$testing_cov_median_etv_n_compare_agg <- 
  draws$testing_cov_median_etv_agg %>%
  filter(word_familiarity == "Novel") %>%
  select(-c(.chain, .iteration)) %>% 
  group_by(exposure_test_nLED_group, task, variety_exposure, .draw) %>% 
  summarise(.value = mean(.value)) %>% 
  compare_levels(.value, by = exposure_test_nLED_group) %>% 
  compare_levels(.value, by = variety_exposure)

# word type split by voctest group, task, and variety exposure
draws$testing_cov_median_etvw_compare_agg <- 
  draws$testing_cov_median_etv_agg %>%
  filter(word_familiarity != "Novel") %>%
  select(-c(.chain, .iteration)) %>% 
  group_by(exposure_test_nLED_group, task, variety_exposure, word_type, .draw) %>% 
  summarise(.value = mean(.value)) %>% 
  compare_levels(.value, by = word_type)