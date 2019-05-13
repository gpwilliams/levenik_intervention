# Demographics ----

demographics <- demographics %>%
  mutate(
    dialect_location_condition = str_sub(
      dialect_location_condition, 
      start = 1, 
      end = str_length(dialect_location_condition)-4 # remove file endings
    ),
    language = str_to_lower(language),
    order_condition = str_replace_all(order_condition, c("W" = "S"))
  ) %>%
  rename(
    language_proficiency = self_rating,
    speaker_gender = speaker_condition,
    participant_number = session_number,
    english_proficiency = english,
    additional_languages = language,
    participant_gender = gender,
    fun_rating = fun,
    noise_rating = noise
  )

# Learning data ----
    
# update data    
learning_data <- learning_data %>%
  rename_at(
    vars(ends_with("edit_distance")),
    ~sub("edit_distance", "nLED", .)
  ) %>%
  rename_at(
    vars(contains("coded_response")),
    ~sub("coded_response", "response", .)
  ) %>% # fix section names
  rename_at( # give participant input a more sensible name
    vars(ends_with("participant_input")),
    ~str_replace_all(., "participant_input", "transcription")
  ) %>%
  mutate(
    # several section reassignments due to non-independent cases
    section =
      str_replace_all(section, c(
        "R_" = "", 
        "W_" = "",
        "EXP_" = "EXPOSURE_",
        "TR" = "TRAINING")
      ),
    section = case_when ( # add underscore between section and number
      str_detect(section, "\\d") ~ paste0( # detect digit
        str_sub(section, start = 1, end = -2), # everything except the last char
        "_", 
        str_sub(section, start = -1) # get just the last char
      ),
      TRUE ~ section
    ),
    section = tolower(section)
  ) %>%
  rename(
    participant_number = session_number,
    participant_trial_id = session_trial_id,
    block = section,
    block_trial_id = section_trial_id,
    base_word = word,
    target_word_length = word_length,
    dialect_pronunciation = dialect_version
  )