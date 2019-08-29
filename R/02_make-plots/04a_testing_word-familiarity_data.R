# aggregate by subjects
testing_agg <- testing_data %>%
  group_by(participant_number, task, variety_exposure, word_familiarity) %>%
  summarise(mean_nLED = mean(lenient_nLED)) %>% 
  mutate(conds = interaction(variety_exposure, word_familiarity, sep = " x "))

# make summary with appropriately adjusted error bars
testing_summary <- summariseWithin(
  data = testing_data,
  subj_ID = "participant_number",
  betweenGroups = "variety_exposure",
  withinGroups = c("task", "word_familiarity"),
  dependentVariable = "lenient_nLED",
  errorTerm = "Standard Error"
) %>% 
  mutate(conds = interaction(variety_exposure, word_familiarity, sep = " x "))