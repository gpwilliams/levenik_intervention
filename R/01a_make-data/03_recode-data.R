# learning data ----

# ensure missing data (*) or no input ("") is NA (not 0 or 1)
learning_data <- learning_data %>% 
  mutate(
    primary_coder_correct = ifelse(
      primary_coder_participant_input %in% c("*", ""), 
      NA, 
      primary_coder_correct
    ),
    primary_coder_edit_distance = ifelse(
      primary_coder_participant_input %in% c("*", ""), 
      NA, 
      primary_coder_edit_distance
    ),
    secondary_coder_correct = ifelse(
      secondary_coder_participant_input %in% c("*", ""), 
      NA, 
      secondary_coder_correct
    ),
    secondary_coder_edit_distance = ifelse(
      secondary_coder_participant_input %in% c("*", ""), 
      NA, 
      secondary_coder_edit_distance
    )
  )