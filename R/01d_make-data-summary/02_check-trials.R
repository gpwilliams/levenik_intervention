# make list to store data
check_trials <- list()

# find subjects with missing trials; create summary ----

expected_trials <- 324 # can vary due to glitches

check_trials$unexpected_trials <- learning_data %>%
  group_by(participant_number, variety_exposure) %>%
  summarise(total_trials = length(unique(participant_trial_id))) %>%
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

# inaudible trials ----

# get number of missing trials per block
check_trials$missing_data_count <- learning_data %>% 
  filter(block %in% c("exposure_test", "test")) %>% 
  group_by(variety_exposure, block) %>% 
  summarise(
    n = n(),
    n_na = sum(is.na(lenient_nLED)),
    percent_na = n_na/n*100
  )

# get the number of inaudible trials per block
# that were allocated a lenient nLED of 1.
check_trials$inaudible_trials <- learning_data %>% 
  filter(
    task == "reading" &
    block %in% c("exposure_test", "test") & 
    primary_coder_transcription == "?" &
    secondary_coder_transcription == "?"
  ) %>% 
  group_by(variety_exposure, block) %>% 
  summarise(
    n_inaudible = n()
  )
check_trials$inaudible_trials$n <- check_trials$missing_data_count$n
check_trials$inaudible_trials$percent_inaudible <- 
  check_trials$inaudible_trials$n_inaudible/
  check_trials$inaudible_trials$n*100

# get inaudible trials ignoring variety exposure grouping
check_trials$overall_inaudible_trials <- check_trials$inaudible_trials %>% 
  group_by(block) %>% 
  summarise(
    n_inaudible = sum(n_inaudible),
    n = sum(n),
    percent_inaudible = n_inaudible/n*100
  )
  
# save output ----
names(check_trials) %>%
  map(~ write_csv(
    check_trials[[.]], 
    here("02_data", "04_summaries", paste0(., ".csv"))
  ))
