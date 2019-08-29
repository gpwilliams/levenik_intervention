# aggregate by subjects
testing_agg <- testing_data %>%
  group_by(participant_number, task, variety_exposure, word_type) %>%
  summarise(mean_nLED = mean(lenient_nLED)) %>% 
  mutate(conds = interaction(variety_exposure, word_type, sep = " x "))

# make summary with appropriately adjusted error bars
testing_summary <- summariseWithin(
  data = testing_data,
  subj_ID = "participant_number",
  betweenGroups = "variety_exposure",
  withinGroups = c("task", "word_type"),
  dependentVariable = "lenient_nLED",
  errorTerm = "Standard Error"
) %>% 
  mutate(conds = interaction(variety_exposure, word_type, sep = " x "))