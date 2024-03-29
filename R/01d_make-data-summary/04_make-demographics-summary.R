# Make demographics ----

message("Making demographics summary.")

demographics_summaries <- list()

# Makes mean, sd, and range of ages, number of genders, and
# English proficiency for each variety exposure condition.

# count genders
demographics_gender <- demographics %>% 
  group_by(participant_number, variety_exposure) %>% 
  summarise(participant_gender = unique(participant_gender)) %>% 
  group_by(variety_exposure) %>% 
  count(participant_gender) %>% 
  spread(key = participant_gender, value = n) %>% 
  rename(female_count = f, male_count = m, other_count = o) %>% 
  mutate(other_count = replace_na(other_count, 0))

# get age and English proficiency summaries
demographics_age_language_proficiency <- demographics %>% 
  filter(additional_languages == "english") %>% 
  group_by(participant_number) %>% # remove any duplicates with slice
  slice(1) %>% 
  ungroup() %>% 
  group_by(variety_exposure) %>% 
  summarise(
    N = length(unique(participant_number)),
    mean_eng_proficiency = mean(language_proficiency),
    sd_eng_proficiency = sd(language_proficiency),
    min_eng_proficiency = min(language_proficiency),
    max_eng_proficiency = max(language_proficiency),
    mean_age = mean(age[age >= 18]), # assuming ages meeting Prolific's ts and cs.
    sd_age = sd(age[age >= 18]),
    min_age = min(age[age >= 18]),
    max_age = max(age[age >= 18])
  )

# get count of multilingual participants per study
multilingual_count <- additional_languages %>% 
  group_by(variety_exposure) %>% 
  summarise(
    multilingual_count = length(unique(participant_number)),
    multilingual_proficiency_mean = mean(language_proficiency),
    multilingual_proficiency_sd = sd(language_proficiency),
    multilingual_proficiency_min = min(language_proficiency),
    multilingual_proficiency_max = max(language_proficiency)
  )

# merge demographics information
demographics_summaries$summary_demographics <- left_join(
  demographics_age_language_proficiency, 
  demographics_gender, 
  by = "variety_exposure"
) %>% 
  left_join(., multilingual_count, by = "variety_exposure")

# count of ages below Prolific's ts and cs per experiment
demographics_summaries$unexpected_ages <- demographics %>%
  filter(additional_languages == "english") %>% 
  group_by(participant_number) %>% # remove any duplicates with slice
  slice(1) %>% 
  ungroup() %>% 
  group_by(participant_number, variety_exposure) %>% 
  summarise(age = unique(age)) %>% 
  filter(age < 18) %>% 
  group_by(variety_exposure) %>% 
  count(age)

# save output
names(demographics_summaries) %>%
  map(~ write_csv(
    demographics_summaries[[.]], 
    here("02_data", "04_summaries", paste0(., ".csv"))
  ))
