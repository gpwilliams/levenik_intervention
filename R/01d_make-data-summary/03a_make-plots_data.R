message("Making plots.")

# Make data summaries ----

# find participants with poor performance
participant_performance <- learning_data %>%
  filter(block == "test") %>%
  group_by(participant_number, variety_exposure, task) %>%
  summarise(
    mean_nLED = mean(lenient_nLED, na.rm = TRUE),
    sd_nLED = sd(lenient_nLED, na.rm = TRUE),
    median_submission_time = median(submission_time, na.rm = TRUE)
  ) %>%
  ungroup() %>% 
  mutate_if(is.numeric, round, 2) %>% 
  mutate(high_nLED = case_when(
    task == "reading" & mean_nLED > .60 ~ TRUE,
    task == "spelling" & mean_nLED > .8 ~ TRUE,
    TRUE ~ FALSE
  )) ## NEED SIMULATION FOR "BAD" PERFORMANCE

# make summary of distance from target for participant input
test_data <- learning_data %>%
  filter(block == "test") %>%
  mutate(
    target_distance = 
      abs(
        nchar(as.character(target)) - 
          nchar(as.character(primary_coder_transcription))
        ),
    target_distance = replace_na(target_distance, 0)
  ) %>%
  left_join(
    ., 
    participant_performance %>% # add high_nLED check to all data
      select(participant_number, high_nLED, mean_nLED, task),
    by = c("participant_number", "task")
    )

# make summary of performance during exposure testing
exposure_summary <- learning_data %>%
  group_by(participant_number, task, variety_exposure) %>%
  filter(block == "exposure_test") %>%
  summarise(mean_nLED = mean(lenient_nLED, na.rm = TRUE)) %>%
  filter(!is.na(mean_nLED)) %>% # keep people with at least one coded response
  ungroup()

# set plotting labels
variety_exposure_names <- str_to_title(
  str_replace_all(
    levels(learning_data$variety_exposure), 
    "_", 
    " "
    )
  )
names(variety_exposure_names) <- levels(learning_data$variety_exposure)

# track tasks in the experiment (used for looping plots by task)
tasks <- unique(learning_data$task)