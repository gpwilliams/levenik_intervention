# aggregate by subjects
exposure_agg <- exposure_data %>%
  group_by(participant_number, variety_exposure, word_type) %>%
  summarise(mean_nLED = mean(lenient_nLED))

# make summary with appropriately adjusted error bars
exposure_summary <- summariseWithin(
    data = exposure_data,
    subj_ID = "participant_number",
    betweenGroups = "variety_exposure",
    withinGroups = "word_type",
    dependentVariable = "lenient_nLED",
    errorTerm = "Standard Error"
  )