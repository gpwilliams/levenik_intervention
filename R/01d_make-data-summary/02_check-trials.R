# make list to store data
check_trials <- list()

# find subjects with missing trials; create summary ----

expected_trials <- 324 # can vary due to glitches

check_trials$unexpected_trials <- learning_data %>%
  group_by(participant_number) %>%
  summarise(total_trials = max(participant_trial_id)) %>%
  filter(total_trials != expected_trials)

# determine a lagging strategy in responses; ----
# i.e. giving the previous answer on the current trial
check_trials$lag_strategy_summary <- learning_data %>% 
  filter(block != "test") %>%
  select(
    participant_number,
    participant_trial_id,
    target,
    primary_coder_transcription,
    secondary_coder_transcription
  ) %>%
  mutate(target_lag = lag(target)) %>%
  select(
    participant_number: target,
    target_lag,
    everything()) %>%
  na.omit() %>%
  filter(
    target_lag == primary_coder_transcription |
      target_lag == secondary_coder_transcription
  ) %>%
  filter(target != target_lag)

# save output ----
names(check_trials) %>%
  map(~ write_csv(
    check_trials[[.]], 
    here("02_data", "04_summaries", paste0(., ".csv"))
  ))