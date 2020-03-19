# nLED zero-one inflation & conditional one inflation ---- 

# make aggregate data
testing_word_type_zo_agg <- testing_data %>%
  filter(word_type != "Novel") %>%
  mutate(word_type = factor(word_type)) %>% 
  group_by(task, variety_exposure, word_type) %>%
  summarise(
    sum_zero = sum(lenient_nLED %in% c(0, 1)),
    sum_one = sum(lenient_nLED %in% 1),
    n_obs = length(word_id)
  ) %>%
  mutate(
    zero_percent = ((sum_zero - sum_one)/n_obs) * 100,
    one_percent = (sum_one/n_obs) * 100,
    zoi_percent = ((sum_zero + sum_one)/n_obs) * 100,
    coi_percent = (sum_one/sum_zero) * 100,
    czi_percent = 100 - coi_percent
  ) %>% 
  gather(key = parameter, value = percentage, zero_percent:czi_percent)

ggplot(
  data = testing_word_type_zo_agg %>% filter(parameter %in% c("zoi_percent", "czi_percent")), 
  aes(x = word_type, y = percentage, fill = parameter)
) + 
  geom_bar(stat = "identity", width = 0.95, position = "dodge") +
  # geom_text(aes(label = paste(round(percentage, 2), "%"))) +
  facet_grid(task~variety_exposure, switch = "x", scales = "free_x", space = "free_x") +
  theme(
    panel.spacing = unit(0, "lines"), 
    strip.background = element_blank(),
    strip.placement = "outside"
    ) + 
  coord_cartesian(ylim = c(0, 100)) +
  scale_y_continuous(breaks = seq(0, 100, 20)) +
  labs(x = "Word Type", y = "Percentage")

ggsave(
  here("03_plots", "testing_word_type_zo.png"), 
  last_plot(), 
  height = 8, 
  width = 14
)

# COI
ggplot(
  data = testing_word_type_zo_agg %>% filter(parameter == "coi_percent"), 
  aes(x = word_type, y = percentage)
) + 
  geom_bar(stat = "identity", width = 0.95) +
  # geom_text(aes(label = paste(round(percentage, 2), "%"))) +
  facet_grid(task~variety_exposure, switch = "x", scales = "free_x", space = "free_x") +
  theme(
    panel.spacing = unit(0, "lines"), 
    strip.background = element_blank(),
    strip.placement = "outside") + 
  coord_cartesian(ylim = c(0, 50)) +
  labs(x = "Word Type", y = "Percentage")










testing_word_familiarity_zo_agg <- testing_data %>%
  group_by(task, variety_exposure, word_familiarity) %>%
  summarise(
    sum_zero = sum(lenient_nLED %in% c(0, 1)),
    sum_one = sum(lenient_nLED %in% 1),
    n_obs = length(word_id)
  ) %>%
  mutate(
    zoi_percent = ((sum_zero - sum_one)/n_obs) * 100,
    one_percent = (sum_one/n_obs) * 100,
    coi_percent = (sum_one/sum_zero) * 100,
    czi_percent = 100 - coi_percent
  )  %>% 
  gather(key = parameter, value = percentage, zoi_percent:czi_percent)

ggplot(
  data = testing_word_familiarity_zo_agg %>% filter(parameter %in% c("zoi_percent", "czi_percent")), 
  aes(x = word_familiarity, y = percentage, fill = parameter)
  ) + 
  geom_bar(stat = "identity", position = "dodge", width = 0.95) +
  # geom_text(aes(label = paste(round(percentage, 2), "%"))) +
  facet_grid(task~variety_exposure, switch = "x", scales = "free_x", space = "free_x") +
  theme(
    panel.spacing = unit(0, "lines"), 
    strip.background = element_blank(),
    strip.placement = "outside") + 
  coord_cartesian(ylim = c(0, 100)) +
  labs(x = "Word Familiarity", y = "percentage")

ggsave(
  here("03_plots", "testing_word_familiarity_zo.png"), 
  last_plot(), 
  height = 8, 
  width = 14
)

# text has to be cumulative
  
