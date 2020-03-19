# demographics ----

demographics <- demographics %>%
  mutate(
    variety_exposure = case_when( # make conditions
      language_condition == "standard" ~ 
        "variety_match",
      language_condition == "dialect" & 
      social_cue_condition == 0 ~ 
        "variety_mismatch",
      language_condition == "dialect" & 
      social_cue_condition == 1 & 
      dialect_training_condition == 0 ~ 
        "variety_mismatch_social",
      language_condition == "dialect" & 
      social_cue_condition == 1 & 
      dialect_training_condition == 1 ~ 
        "dialect_literacy"
      )
    )

# learning data ----

learning_data <- learning_data %>%
  arrange(participant_number, participant_trial_id) %>%
  group_by(participant_number, block) %>%
  mutate(submission_time = c(NA, diff(timestamp))) %>%
  ungroup() %>%
  mutate( # make lenient and stringent DVs
    lenient_correct = pmax( # max as correct = 1
      primary_coder_correct, 
      secondary_coder_correct, 
      na.rm = TRUE
    ),
    lenient_nLED = pmin( # min as perfectly correct nLED = 0
      primary_coder_nLED, 
      secondary_coder_nLED, 
      na.rm = TRUE
    ),
    stringent_correct = pmin(
      primary_coder_correct, 
      secondary_coder_correct, 
      na.rm = TRUE     
    ),
    stringent_nLED = pmax( 
      primary_coder_nLED, 
      secondary_coder_nLED, 
      na.rm = TRUE
    )
  ) %>%
  group_by(participant_number, task) %>%
  mutate(task_trial_id = row_number()) %>% # make trial id split by task
  ungroup() 

# add mean exposure test score for use as a covariate
learning_data <- left_join(
  learning_data,
  learning_data %>% 
    filter(block == "exposure_test") %>% 
    group_by(participant_number) %>% 
    summarise(mean_exposure_test_nLED = mean(lenient_nLED, na.rm = TRUE)) %>% 
    drop_na(),
  by = "participant_number"
)