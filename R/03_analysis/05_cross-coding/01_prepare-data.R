# cross coding ----

# subset and order data
# reading task only, with responses coded by either person

# make sure data is split by experiment in the case of experiments 1 and 2
data_subset <- bind_rows(all_data$exposure, all_data$testing) %>% 
  filter(
    task == "reading" &
    !is.na(primary_coder_transcription) |
    !is.na(secondary_coder_transcription)
  ) %>%
  select(
    participant_number,
    task_trial_id,
    target,
    primary_coder_transcription: secondary_coder_nLED
  ) %>%
  arrange(participant_number, task_trial_id)

# summed scores needed for random subjects/raters models
summed_data <- data_subset %>% 
  group_by(participant_number) %>% 
  summarise(
    primary_coder_nLED_sum = sum(primary_coder_nLED, na.rm = TRUE),
    secondary_coder_nLED_sum = sum(secondary_coder_nLED, na.rm = TRUE)
  )