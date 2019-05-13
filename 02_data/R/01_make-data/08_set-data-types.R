# demographics ----

demographics <- demographics %>%
  mutate_at(
    vars(ends_with("condition")),
    ~ factor(.)
  ) %>%
  mutate(
    variety_exposure = factor(
      variety_exposure, 
      levels = c(
        "variety_match", 
        "variety_mismatch", 
        "variety_mismatch_social", 
        "dialect_literacy"
        )
      ),
    speaker_gender = factor(speaker_gender),
    participant_gender = factor(participant_gender)
    )

# demographics ----
learning_data <- learning_data %>%
  mutate_at(
    vars(ends_with("condition")),
    ~ factor(.)
  ) %>%
  mutate(
    variety_exposure = factor(
      variety_exposure, 
      levels = c(
        "variety_match", 
        "variety_mismatch", 
        "variety_mismatch_social", 
        "dialect_literacy"
        )),
    task = factor(task),
    block = factor(
      block,
      levels = c(
        paste0("exposure_", 1:3), 
        "exposure_test", 
        paste0("training_", 1:2), 
        "test"
      )),
    picture_id = as.numeric(picture_id),
    word_type = factor(word_type)
    )