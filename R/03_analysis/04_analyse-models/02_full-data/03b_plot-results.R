# plot draws from the posterior for conditions ----

# exposure phase ----

# by variety exposure and word type

plots$exposure_vw <- ggplot(
  data = escape_character(
    draws$exposure_vw, 
    word_type, 
    pattern = "C"
  ), 
  aes(x = .value, y = word_type, fill = word_type)) +
  geom_halfeyeh(
    color = plotting_options$colour,
    point_interval = median_qi,
    .width = plotting_options$intervals,
    interval_size_range = plotting_options$point_size
  ) +
  facet_grid(.~variety_exposure) +
  labs(
    x = plotting_options$nLED_title, 
    y = "Word Type",
    title = paste(
      "Median Lenient nLEDs by Exposure Condition and Word Type",
      "in the Vocabulary Test."
    ),
    caption = plotting_options$caption
  ) +
  scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.2)) +
  scale_fill_manual(values = plotting_options$scale_fill) +
  coord_flip() +
  theme(axis.text.x = element_text(size = 14))

# by variety exposure

plots$exposure_v <- ggplot(
  data = draws$exposure_v, 
  aes(x = .value, y = variety_exposure)
  ) +
  geom_halfeyeh(
    fill = plotting_options$fill, 
    color = plotting_options$colour,
    point_interval = median_qi,
    .width = plotting_options$intervals,
    interval_size_range = plotting_options$point_size
  ) +
  labs(
    x = plotting_options$nLED_title, 
    y = "Exposure Condition",
    title = "Median Lenient nLEDs by Exposure Condition in the Vocabulary Test.",
    caption = plotting_options$caption
  ) +
  scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.2)) +
  coord_flip()

# testing phase ----

# by task and variety exposure

plots$testing_tv <- ggplot(
  data = draws$testing_tv %>% 
    escape_character(variety_exposure, pattern = " "), 
  aes(x = .value, y = variety_exposure)
  ) +
  geom_halfeyeh(
    fill = plotting_options$fill, 
    color = plotting_options$colour,
    point_interval = median_qi,
    .width = plotting_options$intervals,
    interval_size_range = plotting_options$point_size
  ) +
  facet_grid(.~task) +
  labs(
    x = plotting_options$nLED_title, 
    y = "Exposure Condition",
    title = paste(
      "Median Lenient nLEDs by Task and Exposure Condition",
      "in the Testing Phase."
    ),
    caption = plotting_options$caption
  ) +
  scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.2)) +
  coord_flip()

# by task, variety exposure, and word type

plots$testing_tvw <- ggplot(
  data = escape_character(draws$testing_tvw, word_type, after = TRUE), 
  aes(x = .value, y = word_type, fill = word_type)) +
  geom_halfeyeh(
    color = plotting_options$colour,
    point_interval = median_qi,
    .width = plotting_options$intervals,
    interval_size_range = plotting_options$point_size - plotting_options$point_size/2
  ) +
  facet_grid(task~variety_exposure) +
  labs(
    x = plotting_options$nLED_title, 
    y = "Word Type",
    title = paste(
      "Median Lenient nLEDs by Task, Exposure Condition,",
      "and Word Type in the Testing Phase."
      ),
    caption = plotting_options$caption
  ) +
  scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.2)) +
  scale_fill_manual(values = plotting_options$scale_fill) +
  coord_flip()

# by task and variety exposure for novel words only

plots$testing_tv_n <- ggplot(
  data = draws$testing_tv_n %>% 
    escape_character(variety_exposure, pattern = " "), 
  aes(x = .value, y = variety_exposure)) +
  geom_halfeyeh(
    fill = plotting_options$fill, 
    color = plotting_options$colour,
    point_interval = median_qi,
    .width = plotting_options$intervals,
    interval_size_range = plotting_options$point_size
  ) +
  facet_grid(.~task) +
  labs(
    x = plotting_options$nLED_title, 
    y = "Exposure Condition",
    title = paste(
      "Median Lenient nLEDs by Task and Exposure Condition",
      "for Novel Words Only in the Testing Phase."
    ),
    caption = plotting_options$caption
  ) +
  scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.2)) +
  coord_flip()

# by variety exposure for novel words only

plots$testing_v_n <- ggplot(
  data = draws$testing_v_n, 
  aes(x = .value, y = variety_exposure)
  ) +
  geom_halfeyeh(
    fill = plotting_options$fill, 
    color = plotting_options$colour,
    point_interval = median_qi,
    .width = plotting_options$intervals,
    interval_size_range = plotting_options$point_size
  ) +
  labs(
    x = plotting_options$nLED_title, 
    y = "Exposure Condition",
    title = paste(
      "Median Lenient nLEDs by Task and Exposure Condition",
      "for Novel Words Only in the Testing Phase."
    ),
    caption = plotting_options$caption
  ) +
  scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.2)) +
  coord_flip()

# by variety exposure

plots$testing_v <- ggplot(
  data = draws$testing_v, 
  aes(x = .value, y = variety_exposure)
  ) +
  geom_halfeyeh(
    fill = plotting_options$fill, 
    color = plotting_options$colour,
    point_interval = median_qi,
    .width = plotting_options$intervals,
    interval_size_range = plotting_options$point_size
  ) +
  labs(
    x = plotting_options$nLED_title, 
    y = "Exposure Condition",
    title = paste(
      "Median Lenient nLEDs by Exposure Condition",
      "in the Testing Phase."
    ),
    caption = plotting_options$caption
  ) +
  scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.2)) +
  coord_flip()

# testing with vocab test performance as a covariate ----

plots$testing_cov_etvw <- ggplot(
  data = draws$testing_cov_tvw %>% 
    ungroup() %>% 
    filter(word_familiarity != "Novel") %>%
    mutate(word_type = factor(word_type)), 
  aes(
    x = mean_exposure_test_nLED , 
    linetype = word_type, 
    colour = word_type, 
    fill = word_type)
  ) +
  stat_lineribbon(
    aes(y = .value), 
    .width = plotting_options$intervals[2], 
    alpha = 0.5
  ) +
  geom_vline(
    xintercept = median(all_data$testing$mean_exposure_test_nLED),
    linetype = "dashed"
  ) +
  facet_grid(task ~ variety_exposure) +
  guides(fill = FALSE) +
  labs(
    x = "Mean nLED for the Vocabulary Test",
    y = "Median nLED during Testing",
    title = paste(
      "Median Lenient nLEDs by Word Type in the Testing Phase ",
      "by Task and Exposure Condition relative to Mean Performance",
      "\non the Vocabulary Test."
    ),
    caption = paste0(
      "Lines and ribbons show posterior median and \u00B1",
      plotting_options$intervals[2]*100,
      "% credible interval.",
      "\nVertical line indicates grand median vocabulary test performance."
      ),
    colour = "Word Type",
    linetype = "Word Type"
  ) +
  scale_x_continuous(limits = c(0, 0.8), breaks = seq(0, 0.8, by = 0.2)) +
  coord_cartesian(ylim = c(0, 0.5)) +
  scale_colour_manual(values = rep("black", 3)) +
  scale_fill_manual(values = rep("grey70", 3)) +
  theme(
    legend.title = element_text(size = 10),
    legend.text = element_text(size = 8),
    legend.position = c(.0535, .935),
    legend.background = element_blank(),
    legend.box.background = element_rect(colour = "black"),
    plot.title = element_text(size = plotting_options$title_size - 1)
  )

# testing with vocab test performance by word type (median split) ----

plots$testing_cov_median_etvw <- ggplot(
  data = draws$testing_cov_median_etvw %>% 
    escape_character(variety_exposure, pattern = " ") %>% 
    escape_character(word_type, pattern = "-", after = TRUE),
  aes(x = .value, y = word_type, fill = word_type)) + # exposure_test_nLED_group
  geom_halfeyeh(
    color = plotting_options$colour,
    point_interval = median_qi,
    .width = plotting_options$intervals,
    interval_size_range = plotting_options$point_size/3
  ) +
  facet_grid(
    variety_exposure ~ interaction(
      exposure_test_nLED_group, 
      task, 
      sep = ":\n"
    )
  ) +
  labs(
    x = "Median Lenient nLED during Testing", 
    y = "Word Type",
    title = paste0(
      "Median Lenient nLEDs by Word Type in the Testing Phase by ",
      "Task, Exposure Condition, and Vocabulary ",
      "Test Performance."
    ),
    caption = plotting_options$caption
  ) +
  scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.2)) +
  scale_fill_manual(values = plotting_options$scale_fill) +
  theme(
    axis.text.x = element_text(size = 14),
    strip.text.x = element_text(size = 14),
    plot.title = element_text(size = plotting_options$title_size - 1)
  ) +
  coord_flip()

# testing with vocab test performance by variety exposure for novel words (median split) ----

plots$testing_cov_median_ev_n <- ggplot(
  data = escape_character(
    draws$testing_cov_median_etv_n, 
    exposure_test_nLED_group, 
    pattern = "P"
  ), 
  aes(x = .value, y = exposure_test_nLED_group)
  ) +
  geom_halfeyeh(
    fill = plotting_options$fill, 
    color = plotting_options$colour,
    point_interval = median_qi,
    .width = plotting_options$intervals,
    interval_size_range = plotting_options$point_size
  ) +
  facet_grid(~ variety_exposure) +
  labs(
    x = "Median Lenient nLED during Testing", 
    y = "Vocabulary Test Performance",
    title = paste(
      "Median Lenient nLEDs for Novel Words in the Testing Phase by",
      "Exposure Condition and Vocabulary Test Performance."
    ),
    caption = plotting_options$caption
  ) +
  scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.2)) +
  coord_flip() +
  theme(axis.text.x = element_text(size = 12)) 

# testing with vocab test performance by task and variety exposure for novel words ----

plots$testing_cov_etv_n <- ggplot(
  data = draws$testing_cov_tvw %>% 
    ungroup() %>% 
    filter(word_familiarity == "Novel"),
  aes(
    x = mean_exposure_test_nLED , 
    linetype = variety_exposure, 
    colour = variety_exposure, 
    fill = variety_exposure)
) +
  stat_lineribbon(
    aes(y = .value), 
    .width = plotting_options$intervals[2], 
    alpha = 0.5
  ) +
  geom_vline(
    xintercept = median(all_data$testing$mean_exposure_test_nLED),
    linetype = "dashed"
  ) +
  facet_wrap(~task) +
  guides(fill = FALSE) +
  labs(
    x = "Mean nLED for the Vocabulary Test",
    y = "Median nLED during Testing",
    title = paste(
      "Median Lenient nLEDs by Word Type in the Testing Phase",
      "by Task and Exposure Condition relative to Vocabulary Test Performance."
    ),
    caption = paste0(
      "Lines and ribbons show posterior median and \u00B1",
      plotting_options$intervals[2]*100,
      "% credible interval.",
      "\nVertical line indicates grand median vocabulary test performance."
    ),
    colour = "Word Type",
    linetype = "Word Type"
  ) +
  scale_x_continuous(limits = c(0, 0.8), breaks = seq(0, 0.8, by = 0.2)) +
  coord_cartesian(ylim = c(0, 0.5)) +
  scale_colour_manual(values = rep("black", 4)) +
  scale_fill_manual(values = rep("grey70", 4)) +
  scale_linetype_manual(values = c("solid", "dashed", "twodash", "dotted"))+
  theme(
    legend.title = element_text(size = 10),
    legend.text = element_text(size = 8),
    legend.position = c(.0518, .8935),
    legend.background = element_blank(),
    legend.box.background = element_rect(colour = "black"),
    plot.title = element_text(size = plotting_options$title_size - 1)
  )

# testing with vocab test performance by task and variety exposure for novel words (median split) ----

plots$testing_cov_median_etv_n <- ggplot(
  data = escape_character(
    draws$testing_cov_median_etv_n, 
    exposure_test_nLED_group, 
    pattern = "P"
  ), 
  aes(x = .value, y = exposure_test_nLED_group)
  ) +
  geom_halfeyeh(
    fill = plotting_options$fill, 
    color = plotting_options$colour,
    point_interval = median_qi,
    .width = plotting_options$intervals,
    interval_size_range = plotting_options$point_size
  ) +
  facet_grid(task ~ variety_exposure) +
  labs(
    x = "Median Lenient nLED during Testing", 
    y = "Vocabulary Test Performance",
    title = paste(
      "Median Lenient nLEDs for Novel Words in the Testing Phase by",
      "Task, Exposure Condition, and Vocabulary Test Performance."
    ),
    caption = plotting_options$caption
  ) +
  scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.2)) +
  coord_flip() +
  theme(axis.text.x = element_text(size = 12))