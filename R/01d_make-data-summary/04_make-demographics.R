# Make demographics ----

message("Making demographics.")

# Makes mean, sd, and range of ages, number of genders, and
# English proficiency for each variety exposure condition.

# get age and english proficiency summaries
demographics_age_proficiency <- demographics %>% 
  group_by(variety_exposure) %>% 
  summarise(
    mean_age = mean(age),
    sd_age = sd(age),
    min_age = min(age),
    max_age = max(age),
    mean_eng_proficiency = mean(language_proficiency),
    sd_eng_proficiency = sd(language_proficiency),
    min_eng_proficiency = min(language_proficiency),
    max_eng_proficiency = max(language_proficiency)
  )

# count genders
demographics_gender <- demographics %>% 
  group_by(variety_exposure) %>% 
  count(participant_gender) %>% 
  spread(key = participant_gender, value = n) %>% 
  rename(female_count = f, male_count = m, other_count = o)

demographics_summary <- left_join(
  demographics_age_proficiency, demographics_gender, by = "variety_exposure"
)

# save output
write_csv(
  demographics_summary, 
  here("02_data", "04_summaries", "demographics_summary.csv")
)