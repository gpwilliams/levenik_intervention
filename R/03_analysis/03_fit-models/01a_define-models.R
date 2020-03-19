# define models for Bayesian analyses using brms::brm() ----

# random effects by subjects; shared across all terms hence ( | *_id |)

# preregistered exposure model

# deviations include: fitting 

formulae$exposure <- bf(
  lenient_nLED ~ variety_exposure * word_type + 
    (1 + word_type | p_id | participant_number) + 
    (1 + variety_exposure | i_id | base_word),
  phi ~ variety_exposure * word_type + 
    (1 + word_type | p_id | participant_number) + 
    (1 + variety_exposure | i_id | base_word),
  zoi ~ variety_exposure * word_type + 
    (1 + word_type | p_id | participant_number) + 
    (1 + variety_exposure | i_id | base_word),
  coi ~ variety_exposure * word_type + 
    (1 + word_type | p_id | participant_number) + 
    (1 + variety_exposure | i_id | base_word),
  family = zero_one_inflated_beta()
)

# preregistered testing model

# deviations include: removed corr in ranefs during testing (i.e. + instead of *)

formulae$testing <- bf(
  lenient_nLED ~ task * variety_exposure * word_type + 
    (1 + task + word_type | p_id | participant_number) + 
    (1 + variety_exposure | i_id | base_word),
  phi ~ task * variety_exposure * word_type + 
    (1 + task + word_type | p_id | participant_number) +
    (1 + variety_exposure | i_id | base_word),
  zoi ~ task * variety_exposure * word_type + 
    (1 + task + word_type | p_id | participant_number) + 
    (1 + variety_exposure | i_id | base_word),
  coi ~ task * variety_exposure * word_type + 
    (1 + task + word_type | p_id | participant_number) + 
    (1 + variety_exposure | i_id | base_word),
  family = zero_one_inflated_beta()
)

# exploratory testing model with exposure testing performance as a covariate

formulae$testing_cov <- bf(
  lenient_nLED ~ 
    mean_exposure_test_nLED * task * variety_exposure * word_type + 
    (1 + task + word_type | p_id | participant_number) + 
    (1 + mean_exposure_test_nLED + variety_exposure | i_id | base_word),
  phi ~ mean_exposure_test_nLED * task * variety_exposure * word_type + 
    (1 + task + word_type | p_id | participant_number) + 
    (1 + mean_exposure_test_nLED + variety_exposure | i_id | base_word),
  zoi ~ mean_exposure_test_nLED * task * variety_exposure * word_type + 
    (1 + task + word_type | p_id | participant_number) + 
    (1 + mean_exposure_test_nLED + variety_exposure | i_id | base_word),
  coi ~ mean_exposure_test_nLED * task * variety_exposure * word_type + 
    (1 + task + word_type | p_id | participant_number) + 
    (1 + mean_exposure_test_nLED + variety_exposure | i_id | base_word),
  family = zero_one_inflated_beta()
)