# Prepare Data for Error Explorations ----

# Complex analysis with a join. Lookup table needs dialect spelling, 
# dialect spelling again(but with primary or secondary input label) and a target word column. 
# Joining will give you two new columns, dialect spelling and correct target spelling. 
# See if target and target and dialect with transcription match in table. If so, give 1. If not, give 0.

# get dialect pronunciations, used for indexing responses
# in the main data set
word_list_data <- readr::read_csv(
  here::here(
    "01_materials", 
    "spelling_and_pronunciations.csv"
  )
)

word_list_reading <- word_list_data %>% 
  select(
    dialect_contrastive_transcription = contrastive_pronunciation, 
    target = `non-contrastive_pronunciation`) %>% 
  mutate(task = "reading")

# targets selected relating to the opaque spelling
word_list_spelling <- word_list_data %>% 
  select(target = opaque_spelling) %>% 
  mutate(task = "spelling")

keydict <- full_join(
  word_list_reading, 
  word_list_spelling, 
  by = c("target", "task")
  ) %>% 
  mutate(key_target = target)

# filter to only testing data
# and generate an ID for dialect pronunciation or not

# logic:
# if the key target matches the actual target
# AND if the item was incorrect
# AND if the dialect contrastive pronunciation matches the primary coder response
# then give it the label "dialect word match",
# otherwise assign to other label

data_subset <- read_rds(here("02_data", "02_cleaned", "learning_data.RDS")) %>%
  drop_na(lenient_nLED) %>% 
  filter(block == "test") %>% 
  arrange(participant_number, task_trial_id) %>%
  left_join(., keydict, by = c("task", "target")) %>% 
  mutate(
    primary_coder_error_types = case_when(
      key_target == target & 
        primary_coder_correct == 0 & 
        dialect_contrastive_transcription == primary_coder_transcription ~ 
        "dialect_word_match",
      primary_coder_correct == 0 & 
        primary_coder_transcription %in% 
        unique(na.omit(dialect_contrastive_transcription))  ~ 
        "dialect_word_mismatch",
      key_target == target &
        primary_coder_correct == 0 &
        primary_coder_transcription %in% unique(target) ~ 
        "standard_word_mismatch",
      key_target == target & 
        primary_coder_correct == 0 ~ 
        "other_mismatch",
      primary_coder_correct == 1 ~ "correct"
    ),
    secondary_coder_error_types = case_when(
      key_target == target & 
        secondary_coder_correct == 0 & 
        dialect_contrastive_transcription == secondary_coder_transcription ~ 
        "dialect_word_match",
      secondary_coder_correct == 0 & 
        secondary_coder_transcription %in% 
        unique(na.omit(dialect_contrastive_transcription))  ~ 
        "dialect_word_mismatch",
      key_target == target &
        secondary_coder_correct == 0 &
        secondary_coder_transcription %in% unique(target) ~ 
        "standard_word_mismatch",
      key_target == target & 
        secondary_coder_correct == 0 ~ 
        "other_mismatch",
      secondary_coder_correct == 1 ~ "correct"
    ),
    lenient_coder_error_types = case_when(
      primary_coder_error_types == "correct" | 
        secondary_coder_error_types == "correct" ~ 
        "correct",
      primary_coder_error_types == "dialect_word_match" | 
        secondary_coder_error_types == "dialect_word_match" ~ 
        "dialect_word_match",
      primary_coder_error_types == "dialect_word_mismatch" | 
        secondary_coder_error_types == "dialect_word_mismatch" ~ 
        "dialect_word_mismatch",
      primary_coder_error_types == "standard_word_mismatch" | 
        secondary_coder_error_types == "standard_word_mismatch" ~ 
        "standard_word_mismatch",
      primary_coder_error_types == "other_mismatch" | 
        secondary_coder_error_types == "other_mismatch" ~ 
        "other_mismatch",
    )
  )

# relabel and reorder things for plotting
data_subset <- data_subset %>% 
  mutate(
    task = fct_recode(
      task,
      "Reading" = "reading",
      "Spelling" = "spelling"
      ),
    variety_exposure = fct_relevel(
      variety_exposure,
      "variety_match", 
      "variety_mismatch",
      "variety_mismatch_social",
      "dialect_literacy"
    ),
    variety_exposure = fct_recode(
      variety_exposure,
      "No Dialect" = "variety_match",
      "Dialect" = "variety_mismatch",
      "Dialect & Social" = "variety_mismatch_social",
      "Dialect Literacy" = "dialect_literacy"
      ),
    word_type = fct_relevel(
      word_type,
      "non_contrastive", 
      "contrastive", 
      "novel"
    ),
    word_type = fct_recode(
      word_type,
      "Non-contrastive" = "non_contrastive",
      "Contrastive" = "contrastive",
      "Untrained" = "novel"
    ),
    lenient_coder_error_types = fct_relevel(
      lenient_coder_error_types,
      "correct", 
      "dialect_word_match", 
      "dialect_word_mismatch",
      "standard_word_mismatch", 
      "other_mismatch"
    ),
    lenient_coder_error_types = fct_recode(
      lenient_coder_error_types,
      "Correct" = "correct", 
      "Dialect Word Match" = "dialect_word_match", 
      "Dialect Word Mismatch" = "dialect_word_mismatch",
      "Standard Word Mismatch" = "standard_word_mismatch", 
      "Other Mismatch" = "other_mismatch"
    )
  )