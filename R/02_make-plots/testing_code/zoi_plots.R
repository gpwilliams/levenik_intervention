# this was originally in 02d_testing_plots_zoi_data.R

yyyy <- testing_data %>%
  filter(word_type != "Novel", lenient_nLED == 1) %>%
  mutate(word_type = factor(word_type)) %>% 
  group_by(participant_number, task, variety_exposure, word_type) %>%
  summarise(
    mean_zero_one = mean(lenient_nLED %in% c(0, 1)),
    mean_one = mean(lenient_nLED %in% 1),
    sd_zero = sd(lenient_nLED %in% c(0, 1)),
    sd_one = sd(lenient_nLED %in% 1),
    n_obs = length(word_id)
  )


ggplot(xxxx, aes(x = variety_exposure, y = mean_one, colour = word_type)) +
  stat_summary(fun.data = "mean_se", geom = "pointrange")

### FRESH STUFF

zoi_by_subj <- testing_data %>%
  filter(word_type != "Novel") %>%
  mutate(word_type = factor(word_type)) %>% 
  group_by(participant_number, task, variety_exposure, word_type) %>%
  summarise(
    sum_zero_one = sum(lenient_nLED %in% c(0, 1)),
    sum_one = sum(lenient_nLED %in% 1),
    n_obs = length(word_id)
  ) %>%
  mutate(
    zero_prop = (sum_zero_one - sum_one)/n_obs,
    one_prop = sum_one/n_obs,
    zoi_prop = (sum_zero_one + sum_one)/n_obs,
    coi_prop = sum_one/sum_zero_one,
    czi_prop = (sum_zero_one - sum_one)/sum_zero_one
  ) %>% 
  ungroup()

zoi_summary <- zoi_by_subj %>%
  select(-c(zero_prop, one_prop)) %>%
  gather(key = parameter, value = mean_prop, zoi_prop:czi_prop) %>% 
  group_by(task, variety_exposure, word_type, parameter) %>%
  summarise(
    mean = mean(mean_prop, na.rm = TRUE), 
    sd = sd(mean_prop, na.rm = TRUE),
    n = length(unique(participant_number)),
    se = sd/sqrt(n),
    ci = qt(0.975, df = n-1)*sd/sqrt(n)
  )


## COI doesn't make sense to have densities like this -- people are either one or the other

zoi_prop <- zoi_summary %>%  filter(parameter == "zoi_prop") %>% 
  ggplot(
    aes(x = variety_exposure, y = mean, ymin = mean - se, ymax = mean + se, fill = word_type)) +
  geom_bar(position = position_dodge(width = 0.9), stat = "identity", width = 0.9) +
  geom_errorbar(position = position_dodge(width = 0.9), width = 0.25) +
  facet_wrap(~task) +
  theme(legend.position = "none", axis.text.x = element_text(angle = 45)) +
  coord_cartesian(ylim = c(0, 1)) +
  labs(title = "Zero-one Inflation")

coi_prop <- zoi_prop %+% filter(zoi_summary, parameter == "coi_prop") +
  theme(legend.position = "top") +
  labs(title = "Conditional One Inflation")

zoicoi <- zoi_prop + coi_prop

ggsave("zoicoi.png", zoicoi, height = 8, width = 14)






zoi_by_subj %>% 
  ggplot(
    aes(x = variety_exposure, y = zoi_prop, fill = word_type)) +
  geom_boxplot(position = position_dodge(width = 0.8)) +
  stat_summary(fun.data = "mean_se", geom = "pointrange", position = position_dodge(width = 0.8)) +
  facet_wrap(~task) +
  theme(legend.position = "none", axis.text.x = element_text(angle = 45)) +
  coord_cartesian(ylim = c(0, 1)) +
  labs(title = "Zero-one Inflation")







# newest 

testing_wt_by_subj <- testing_data %>%
  filter(word_type != "Novel") %>%
  mutate(word_type = factor(word_type)) %>% 
  group_by(participant_number, task, variety_exposure, word_type) %>%
  summarise(
    mean = mean(lenient_nLED),
    sd = sd(lenient_nLED),
    n_obs = length(word_id)
  )





summariseWithin(
  data = testing_data %>% filter(word_type != "Novel"),
  subj_ID = "participant_number",
  withinGroups = c("task", "word_type"),
  betweenGroups = "variety_exposure",
  dependentVariable = "lenient_nLED",
  errorTerm = "Standard Error"
)

summariseWithin(
  data = testing_wt_by_subj,
  subj_ID = "participant_number",
  withinGroups = c("task", "word_type"),
  betweenGroups = c("variety_exposure"),
  dependentVariable = "mean",
  errorTerm = "Standard Error"
)

testing_wt_by_subj <- testing_wt_by_subj %>% 
  ungroup() %>% 
  mutate(
    participant_number = factor(participant_number),
    task = factor(task)
  ) %>% 
  rename(y = mean)

# task must be a factor for this code to work. 
# Update function to coerce to factor.


testing_wf_summary <- summariseWithin(
  data = testing_data,
  subj_ID = "participant_number",
  withinGroups = c("task", "word_familiarity"),
  betweenGroups = "variety_exposure",
  dependentVariable = "lenient_nLED",
  errorTerm = "Standard Error"
)


summariseWithin(
  data = testing_data,
  subj_ID = "participant_number",
  withinGroups = c("task", "word_familiarity"),
  betweenGroups = "variety_exposure",
  dependentVariable = "lenient_nLED",
  errorTerm = "Standard Error"
)

summariseWithin(
  data = testing_data %>% mutate(task = factor(task)),
  subj_ID = "participant_number",
  withinGroups = c("task", "word_familiarity"),
  betweenGroups = "variety_exposure",
  dependentVariable = "lenient_nLED",
  errorTerm = "Standard Error"
)

