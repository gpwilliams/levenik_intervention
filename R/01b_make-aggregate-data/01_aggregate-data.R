# aggregate data ----

message("Making aggregate data.")

learning_data_agg <- learning_data %>% 
  filter(block %in% c("exposure_test", "test")) %>% 
  group_by(participant_number, task, variety_exposure, block, word_type) %>% 
  summarise(
    mean_lenient_nLED = mean(lenient_nLED, na.rm = TRUE),
    mean_stringent_nLED = mean(stringent_nLED, na.rm = TRUE),
    mean_exposure_test_nLED = mean(mean_exposure_test_nLED, na.rm = TRUE),
    n = length(word_id)
  ) %>% 
  mutate(
    adjusted_mean_lenient_nLED = (mean_lenient_nLED * (n-1) + 0.5)/n,
    adjusted_mean_stringent_nLED = (mean_stringent_nLED * (n-1) + 0.5)/n
  )