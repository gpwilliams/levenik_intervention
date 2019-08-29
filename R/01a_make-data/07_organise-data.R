# demographics ----

# Drops alphabet_key, browser, completion_code and progress.

demographics <- demographics %>%
  select(
    participant_number, 
    variety_exposure,
    language_condition,
    social_cue_condition:dialect_location_condition,
    order_condition,
    speaker_gender,
    additional_languages,
    language_proficiency,
    age,
    participant_gender,
    fun_rating,
    noise_rating,
    start_timestamp,
    end_timestamp
  )

# learning data ----

# Drops trial_id, novel_word_for_task, language_condition, and order_condition
# and speaker_gender.

learning_data <- learning_data %>%
  select(
    participant_number,
    task,
    variety_exposure,
    block, 
    participant_trial_id,
    task_trial_id,
    block_trial_id,
    picture_id,
    word_id,
    base_word,
    target,
    dialect_pronunciation:word_type,
    target_word_length,
    exposure_count,
    primary_coder_transcription,
    primary_coder_correct,
    primary_coder_nLED,
    secondary_coder_transcription, 
    secondary_coder_correct,
    secondary_coder_nLED,
    lenient_correct:stringent_nLED,
    mean_exposure_test_nLED,
    submission_time,
    timestamp
  )