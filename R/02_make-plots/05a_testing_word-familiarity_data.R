# aggregate by subjects
testing_word_familiarity_agg <- testing_data %>%
  group_by(participant_number, task, variety_exposure, word_familiarity) %>%
  summarise(mean_nLED = mean(lenient_nLED))

# make summary with appropriately adjusted error bars
testing_word_familiarity_summary <- summariseWithin(
  data = testing_data,
  subj_ID = "participant_number",
  betweenGroups = "variety_exposure",
  withinGroups = c("task", "word_familiarity"),
  dependentVariable = "lenient_nLED",
  errorTerm = "Standard Error"
)