# Beta distribution (nLED excluding 0 and 1) ----

# by word-type ----

# make aggregate data
testing_word_type_beta_agg <- testing_data %>%
  filter(
    word_type != "Untrained",
    lenient_nLED > 0 & lenient_nLED < 1
  ) %>%
  mutate(word_type = factor(word_type)) %>% 
  group_by(participant_number, task, variety_exposure, word_type) %>%
  summarise(
    mean_nLED = mean(lenient_nLED),
    sd_nLED = sd(lenient_nLED)
  )

# make summary with appropriately adjusted error bars
testing_word_type_beta_summary <- summariseWithin(
  data = testing_data %>% 
    filter(
      word_type != "Untrained",
      lenient_nLED > 0 & lenient_nLED < 1
    ),
  subj_ID = "participant_number",
  withinGroups = c("task", "word_type"),
  betweenGroups = "variety_exposure",
  dependentVariable = "lenient_nLED",
  errorTerm = "Standard Error"
)

# by word familiarity ----

# make aggregate data
testing_word_familiarity_beta_agg <- testing_data %>%
  filter(lenient_nLED > 0 & lenient_nLED < 1) %>%
  group_by(participant_number, task, variety_exposure, word_familiarity) %>%
  summarise(
    mean_nLED = mean(lenient_nLED),
    sd_nLED = sd(lenient_nLED)
  )

# make summary with appropriately adjusted error bars
testing_word_familiarity_beta_summary <- summariseWithin(
  data = testing_data %>% filter(lenient_nLED > 0 & lenient_nLED < 1),
  subj_ID = "participant_number",
  withinGroups = c("task", "word_familiarity"),
  betweenGroups = "variety_exposure",
  dependentVariable = "lenient_nLED",
  errorTerm = "Standard Error"
)