# nLED zero-one inflation & conditional one inflation ---- 

# make aggregate data

# word type ----

testing_word_type_zo_agg <- testing_data %>%
  filter(word_type != "Untrained") %>%
  mutate(word_type = factor(word_type)) %>% 
  group_by(participant_number, task, variety_exposure, word_type) %>%
  summarise(
    sum_zero_one = sum(lenient_nLED %in% c(0, 1)),
    sum_one = sum(lenient_nLED %in% 1),
    n_obs = length(word_id)
  ) %>%
  mutate(
    zero_percent = ((sum_zero_one - sum_one)/n_obs) * 100,
    one_percent = (sum_one/n_obs) * 100,
    zoi_percent = ((sum_zero_one + sum_one)/n_obs) * 100,
    coi_percent = (sum_one/sum_zero_one) * 100,
    czi_percent = 100 - coi_percent
  ) %>% 
  select(-c(zero_percent, one_percent)) %>%
  gather(key = parameter, value = percentage, zoi_percent:czi_percent) %>% 
  mutate(
    parameter = factor( # reorder parameter factor levels
      parameter,
      levels = c(
        "zoi_percent",
        "czi_percent",
        "coi_percent"
      )),
    parameter = fct_recode(
      parameter,
      "Zero-One Inflation" = "zoi_percent",
      "Conditional-Zero Inflation" = "czi_percent",
      "Conditional-One Inflation" = "coi_percent"
    )
  )

testing_word_type_zo_agg_summary <- summariseWithin(
    data = testing_word_type_zo_agg,
    subj_ID = "participant_number",
    withinGroups = c("task", "word_type", "parameter"),
    betweenGroups = "variety_exposure",
    dependentVariable = "percentage",
    errorTerm = "Standard Error"
  )

# word familiarity ----

testing_word_familiarity_zo_agg <- testing_data %>%
  group_by(participant_number, task, variety_exposure, word_familiarity) %>%
  summarise(
    sum_zero_one = sum(lenient_nLED %in% c(0, 1)),
    sum_one = sum(lenient_nLED %in% 1),
    n_obs = length(word_id)
  ) %>%
  mutate(
    zero_percent = ((sum_zero_one - sum_one)/n_obs) * 100,
    one_percent = (sum_one/n_obs) * 100,
    zoi_percent = ((sum_zero_one + sum_one)/n_obs) * 100,
    coi_percent = (sum_one/sum_zero_one) * 100,
    czi_percent = 100 - coi_percent
  ) %>% 
  select(-c(zero_percent, one_percent)) %>%
  gather(key = parameter, value = percentage, zoi_percent:czi_percent) %>% 
  mutate(
    parameter = factor( # reorder parameter factor levels
      parameter,
      levels = c(
        "zoi_percent",
        "czi_percent",
        "coi_percent"
      )),
    parameter = fct_recode(
      parameter,
      "Zero-One Inflation" = "zoi_percent",
      "Conditional-Zero Inflation" = "czi_percent",
      "Conditional-One Inflation" = "coi_percent"
    )
  )

testing_word_familiarity_zo_agg_summary <- summariseWithin(
  data = testing_word_familiarity_zo_agg,
  subj_ID = "participant_number",
  withinGroups = c("task", "word_familiarity", "parameter"),
  betweenGroups = "variety_exposure",
  dependentVariable = "percentage",
  errorTerm = "Standard Error"
)