# nLED zero-one inflation & conditional one inflation ---- 

# make aggregate data
testing_word_type_zo_agg <- testing_data %>%
  filter(word_type != "Novel") %>%
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
  gather(key = parameter, value = percentage, zero_percent:czi_percent)

testing_word_familiarity_zo_agg <- testing_data %>%
  group_by(task, variety_exposure, word_familiarity) %>%
  summarise(
    sum_zero_one = sum(lenient_nLED %in% c(0, 1)),
    sum_one = sum(lenient_nLED %in% 1),
    n_obs = length(word_id)
  ) %>%
  mutate(
    zoi_percent = ((sum_zero_one - sum_one)/n_obs) * 100,
    one_percent = (sum_one/n_obs) * 100,
    coi_percent = (sum_one/sum_zero_one) * 100,
    czi_percent = 100 - coi_percent
  )  %>% 
  gather(key = parameter, value = percentage, zoi_percent:czi_percent)