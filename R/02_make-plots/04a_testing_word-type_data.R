# aggregate by subjects
testing_word_type_agg <- testing_data %>%
  filter(word_familiarity != "Untrained") %>% 
  mutate(word_type = factor(word_type)) %>% 
  group_by(participant_number, task, variety_exposure, word_type) %>%
  summarise(mean_nLED = mean(lenient_nLED))

# make summary with appropriately adjusted error bars
testing_word_type_summary <- summariseWithin(
  data = testing_data %>% filter(word_familiarity != "Untrained"),
  subj_ID = "participant_number",
  betweenGroups = "variety_exposure",
  withinGroups = c("task", "word_type"),
  dependentVariable = "lenient_nLED",
  errorTerm = "Standard Error"
)