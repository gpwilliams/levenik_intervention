# Demographic data ----

# keep only finishers/correct orthography
demographics <- csv_list[["sessions"]] %>% 
  left_join(
    ., 
    csv_list[["sessions_languages"]] %>% select(-input_id),
    by = "session_number"
  )

# Reading data ----

# Make reading data (dropping columns that will be replaced).
reduced_reading_data <- csv_list[["reading_task"]] %>%
  select(-c(participant_input, correct, edit_distance))
  
# Make reading coding, keep only most recently transcribed input.
corrected_reading_coding <- csv_list[["reading_coding"]] %>%
  arrange(desc(timestamp)) %>%
  distinct(
    session_number,
    trial_id,
    coder,
    .keep_all = TRUE
  ) %>%
  select(-c(code_id, timestamp)) %>%
  rename(participant_input = coded_response)

# Merge reading coding with reading data.
reading_data <- full_join(
  reduced_reading_data, corrected_reading_coding,
  by = c("trial_id", "session_number", "target")
) %>% # make wide format from 3 columns and ID column
  gather(var, val, participant_input:edit_distance) %>%
  unite(var2, coder, var) %>%
  spread(var2, val) %>%
  select(-matches("NA")) %>% # remove unknown coder transcriptions
  rename_at( # give formal names to coders
    vars(starts_with("glenn")),
    ~sub("glenn", "primary_coder", .)
  ) %>%
  rename_at(
    vars(starts_with("vera")),
    ~sub("vera", "secondary_coder", .)
  ) %>% 
  mutate(task = "reading") %>% # make data formats match across tables
  mutate_at( 
    vars(ends_with("correct"), ends_with("edit_distance")), 
    ~as.double(.)
  ) 

# Writing data ----
  
# Make writing data format adhere to reading data format for later merging
# (essentially duplicating the DV and input columns).
writing_data <- csv_list[["writing_task"]] %>%
  mutate(
    secondary_coder_participant_input = participant_input,
    secondary_coder_correct = correct,
    secondary_coder_edit_distance = edit_distance
  ) %>%
  rename(
    primary_coder_participant_input = participant_input,
    primary_coder_correct = correct,
    primary_coder_edit_distance = edit_distance
  ) %>%
  mutate(task = "spelling")

# Merge reading, writing, and word list ----

# Combine reading and spelling (writing) data.
learning_data <- full_join(
  reading_data, 
  writing_data,
  by = names(reading_data) 
  ) %>%
  full_join(., csv_list[["word_list"]], by = "word_id") %>%
  left_join(., csv_list[["word_types"]], by = c("word_id", "word"))