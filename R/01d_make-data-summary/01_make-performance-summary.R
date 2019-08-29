message("Making data summaries.")

# make list to store data
data_summaries <- list()

# nLED (with ZO) ----

data_summaries$summary_nLED_zo_inclusive <- learning_data %>%
  filter(block == "test") %>%
  group_by(task, variety_exposure, word_type) %>%
  summarise(
    mean_nLED = mean(lenient_nLED, na.rm = TRUE),
    sd_nLED = sd(lenient_nLED, na.rm = TRUE),
    n_obs = length(word_id)
  ) %>%
  ungroup() %>% 
  mutate_if(is.numeric, round, 2)

# nLED (no ZO) ----

data_summaries$summary_nLED_zo_exclusive <- learning_data %>%
  filter(lenient_nLED > 0, lenient_nLED < 1, block == "test") %>%
  group_by(task, variety_exposure, word_type) %>%
  summarise(
    mean_nLED = mean(lenient_nLED, na.rm = TRUE),
    sd_nLED = sd(lenient_nLED, na.rm = TRUE),
    n_obs = length(word_id)
  ) %>%
  ungroup() %>% 
  mutate_if(is.numeric, round, 2)
  
# zero-one inflation counts ----

data_summaries$summary_zo_only <- learning_data %>%
  filter(block == "test") %>%
  group_by(task, variety_exposure, word_type) %>%
  summarise(
    sum_zero_one = sum(lenient_nLED %in% c(0, 1)),
    sum_zero = sum(lenient_nLED %in% 0),
    sum_one = sum(lenient_nLED %in% 1),
    n_obs = length(word_id)
  ) %>%
  mutate(
    zero_percent = ((sum_zero_one - sum_one)/n_obs) * 100,
    one_percent = (sum_one/n_obs) * 100,
    zoi_percent = (sum_zero_one/n_obs) * 100,
    coi_percent = (sum_one/sum_zero_one) * 100,
    czi_percent = 100 - coi_percent
  ) %>%
  ungroup() %>% 
  mutate_if(is.numeric, round, 2)

# means and SD by word and condition

data_summaries$summary_word_by_variety <- learning_data %>%
  filter(block == "exposure_test") %>%
  group_by(variety_exposure, word_type, target) %>%
  summarise(
    mean_nLED = mean(lenient_nLED, na.rm = TRUE),
    sd_nLED = sd(lenient_nLED, na.rm = TRUE)
  ) %>% 
  ungroup() %>% 
  mutate_if(is.numeric, round, 2)

# Write data to .csv for ease of access across systems/programs ----
names(data_summaries) %>%
  map(~ write_csv(
    data_summaries[[.]], 
    here("02_data", "04_summaries", paste0(., ".csv"))
  ))