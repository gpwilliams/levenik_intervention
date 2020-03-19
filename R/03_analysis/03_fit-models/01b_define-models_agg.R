# define models for Bayesian analyses using brms::brm() ----

# random intercepts by subjects; shared across all terms hence ( | id_subj |)

# only 5 observations at 0 or 1, thus the adjusted mean is used here.
# adjustment factor applied to all observations.

formulae$exposure_agg <- bf(
  adjusted_mean_lenient_nLED ~ variety_exposure * word_type + 
    (1 | participant_number)
)

formulae$testing_agg <- bf(
  mean_lenient_nLED ~ task * variety_exposure * word_type + 
    (1 | id_subj | participant_number),
  phi ~ task * variety_exposure * word_type + 
    (1 | id_subj | participant_number),
  zoi ~ task * variety_exposure * word_type + 
    (1 | id_subj | participant_number),
  coi ~ task * variety_exposure * word_type + 
    (1 | id_subj | participant_number),
  family = zero_one_inflated_beta()
)

formulae$testing_cov_agg <- bf(
  mean_lenient_nLED ~
    mean_exposure_test_nLED * task * variety_exposure * word_type + 
    (1 | id_subj | participant_number),
  phi ~ mean_exposure_test_nLED * task * variety_exposure * word_type + 
    (1 | id_subj | participant_number),
  zoi ~ mean_exposure_test_nLED * task * variety_exposure * word_type + 
    (1 | id_subj | participant_number),
  coi ~ mean_exposure_test_nLED * task * variety_exposure * word_type + 
    (1 | id_subj | participant_number),
  family = zero_one_inflated_beta()
)