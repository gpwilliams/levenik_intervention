# descriptive statistics ----

# counts for all words ----

# counts for all words
# report all cases with complete (makes props sum to 1 in summaries)
all_error_by_subj <- data_subset %>% 
  group_by(
    participant_number, 
    task, 
    variety_exposure, 
    word_type,
    lenient_coder_error_types
  ) %>% 
  summarise(counts = length(lenient_coder_error_types)) %>% 
  complete(lenient_coder_error_types, fill = list(counts = 0)) %>% 
  ungroup() %>% 
  group_by(
    participant_number, 
    task, 
    variety_exposure, 
    word_type
  ) %>% 
  mutate(n = sum(counts), prop = counts/n)

# summaries ----

# averages
mean_proportions <- all_error_by_subj %>% 
  group_by(
    task, 
    variety_exposure, 
    word_type,
    lenient_coder_error_types
  ) %>% 
  summarise(
    n_subj = length(counts),
    mean_prop = mean(prop), 
    sd_prop = sd(prop),
    se_prop = sd(prop)/sqrt(n_subj),
    ci = qt(0.975, df = n_subj-1)*sd_prop/sqrt(n_subj)
  )

# grand proportions, looking all subjects and trials
grand_proportions <- data_subset %>% 
  group_by(
    task, 
    variety_exposure, 
    word_type,
    lenient_coder_error_types
  ) %>% 
  summarise(
    counts = length(lenient_coder_error_types), 
    n_subj = length(unique(participant_number))
  ) %>% 
  ungroup() %>% 
  group_by(
    task, 
    variety_exposure, 
    word_type
  ) %>% 
  mutate(n = sum(counts), proportion = counts/n) %>% 
  complete(
    lenient_coder_error_types, 
    fill = list(
      counts = 0, 
      n_subj = 0, 
      n = 0, 
      proportion = 0
    )
  )

# save results ----

write_csv(
  mean_proportions,
  here(
    "04_analysis",
    "04_exploratory-analysis",
    "mean_proportions.csv"
  )
)

write_csv(
  grand_proportions,
  here(
    "04_analysis",
    "04_exploratory-analysis",
    "grand_proportions.csv"
  )
)