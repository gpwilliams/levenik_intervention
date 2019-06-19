# demographics ----

# Filter out only those who completed, 
# who did the right orthography (opaque),
# who had pictures during the task,
# and who aren't in exclusions list.
demographics <- demographics %>%
  filter(
    progress == "END", 
    orthography_condition == "opaque", 
    picture_condition == 1
  ) %>%
  anti_join(
    ., 
    csv_list[["exclusions"]], 
    by = c("participant_number" = "session_number")
  )

# learning data ----

learning_data <- semi_join(
  learning_data, 
  demographics %>% select(participant_number), 
  by = "participant_number"
  ) %>% 
  left_join(., demographics %>%
    select(
      participant_number, 
      language_condition, 
      order_condition, 
      speaker_gender, 
      variety_exposure
    ) %>%
    distinct(participant_number, .keep_all = TRUE),
  by = "participant_number"
)