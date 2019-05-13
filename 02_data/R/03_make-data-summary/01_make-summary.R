# nLED (with ZO)
summary_nLED_zo_inclusive <- learning_data %>%
  drop_na(variety_exposure, word_type) %>%
  filter(block == "test") %>%
  group_by(task, variety_exposure, word_type) %>%
  summarise(
    mean_nLED = mean(lenient_nLED, na.rm = TRUE),
    sd_nLED = sd(lenient_nLED, na.rm = TRUE),
    n_subj = length(unique(participant_number))
  ) %>%
  mutate_if(is.numeric, round, 2)

# nLED (no ZO)
summary_nLED_zo_exclusive <- learning_data %>%
  drop_na(variety_exposure, word_type) %>%
  filter(lenient_nLED > 0 & lenient_nLED < 1 & block == "test") %>%
  group_by(task, variety_exposure, word_type) %>%
  summarise(
    mean_nLED = mean(lenient_nLED, na.rm = TRUE),
    sd_nLED = sd(lenient_nLED, na.rm = TRUE),
    n_subj = length(unique(participant_number))
  ) %>%
  mutate_if(is.numeric, round, 2)
  
# zero-one inflation counts
summary_nLED_zo_only <- learning_data %>%
  drop_na(variety_exposure, word_type) %>%
  filter(lenient_nLED == 0 | lenient_nLED == 1 & block == "test") %>%
  group_by(task, variety_exposure, word_type) %>%
  summarise(
    zoi = n(),
    coi = sum(lenient_nLED, na.rm = TRUE),
    n_subj = length(unique(participant_number)),
    n_item = length(unique(word_id))
  ) %>%
  mutate(
    coi_percent = coi/zoi*100,
    prop_correct = (zoi - coi)/(n_subj * n_item)
  ) %>%
  mutate_if(is.numeric, round, 2)