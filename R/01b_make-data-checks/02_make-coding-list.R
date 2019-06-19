
# make a summary of the data that has been and needs transcribed
transcription_data <- learning_data %>%
  filter(task == "reading", block %in% c("exposure_test", "test")) %>%
  select(
    participant_number, 
    task_trial_id, 
    target, 
    primary_coder_transcription, 
    secondary_coder_transcription
  ) %>%
  mutate(
    primary_coded = case_when(
      !is.na(primary_coder_transcription) ~ 1,
      TRUE ~ 0
    ),
    secondary_coded = case_when(
      !is.na(secondary_coder_transcription) ~ 1,
      TRUE ~ 0
    )
  )

# which participants have been coded and which need to be coded?

transcription_by_participant <- transcription_data %>%
  group_by(participant_number) %>%
  summarise(
    primary_coded = sum(primary_coded),
    secondary_coded = sum(secondary_coded),
    total_trials = length(task_trial_id)
  )

# which participant and items have been coded and which need to be coded?

transcription_by_trial <- transcription_data %>%
  group_by(participant_number, task_trial_id) %>%
  summarise(
    primary_coded = sum(primary_coded),
    secondary_coded = sum(secondary_coded)
  )