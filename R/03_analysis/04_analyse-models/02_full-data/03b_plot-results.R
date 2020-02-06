# plot draws from the posterior for conditions ----

# exposure phase ----

# by variety exposure

plots$exposure_v <- ggplot(
  data = escape_character(
    draws$exposure_v, 
    variety_exposure, 
    pattern = " "
  ), 
  aes(x = .value, y = variety_exposure)
  ) +
  geom_halfeyeh(
    fill = plotting_options$fill, 
    color = plotting_options$colour,
    point_interval = median_qi,
    .width = plotting_options$intervals,
    size_range = plotting_options$point_size
  ) +
  labs(
    x = plotting_options$nLED_title, 
    y = "Variety Exposure",
    title = "Median Lenient nLEDs by Variety Exposure in the Exposure Phase.",
    caption = plotting_options$caption
  ) +
  scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.2)) +
  coord_flip()

# by variety exposure and word type

plots$exposure_vw <- ggplot(
  data = escape_character(
    draws$exposure_vw, 
    word_type, 
    pattern = "C"
  ), 
  aes(x = .value, y = word_type)) +
  geom_halfeyeh(
    fill = plotting_options$fill, 
    color = plotting_options$colour,
    point_interval = median_qi,
    .width = plotting_options$intervals,
    size_range = plotting_options$point_size
  ) +
  facet_grid(.~variety_exposure) +
  labs(
    x = plotting_options$nLED_title, 
    y = "Word Type",
    title = paste0(
      "Median Lenient nLEDs by Variety Exposure and Word Type",
      "\nin the Exposure Phase."
      ),
    caption = plotting_options$caption
  ) +
  scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.2)) +
  coord_flip()

# testing phase ----

# by task, variety exposure, and word type

plots$testing_tvw <- ggplot(
  data = escape_character(draws$testing_tvw, word_type, after = TRUE), 
  aes(x = .value, y = word_type)) +
  geom_halfeyeh(
    fill = plotting_options$fill, 
    color = plotting_options$colour,
    point_interval = median_qi,
    .width = plotting_options$intervals,
    size_range = plotting_options$point_size - plotting_options$point_size/2
  ) +
  facet_grid(task~variety_exposure) +
  labs(
    x = plotting_options$nLED_title, 
    y = "Word Type",
    title = paste0(
      "Median Lenient nLEDs by Task, Variety Exposure,",
      "\nand Word Type in the Testing Phase."
      ),
    caption = plotting_options$caption
  ) +
  scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.2)) +
  theme(axis.text.x = element_text(size = 10)) +
  coord_flip()

# by task and variety exposure

plots$testing_tv <- ggplot(
  data = draws$testing_tv %>% 
    escape_character(variety_exposure, pattern = " "), 
  aes(x = .value, y = variety_exposure)) +
  geom_halfeyeh(
    fill = plotting_options$fill, 
    color = plotting_options$colour,
    point_interval = median_qi,
    .width = plotting_options$intervals,
    size_range = plotting_options$point_size
  ) +
  facet_grid(.~task) +
  labs(
    x = plotting_options$nLED_title, 
    y = "Variety Exposure",
    title = paste0(
      "Median Lenient nLEDs by Task and Variety Exposure",
      "\nin the Testing Phase."
    ),
    caption = plotting_options$caption
  ) +
  scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.2)) +
  coord_flip()

# by variety exposure for novel words only

plots$testing_v_n <- ggplot(
  data = draws$testing_v_n %>% 
    escape_character(variety_exposure, pattern = " "), 
  aes(x = .value, y = variety_exposure)) +
  geom_halfeyeh(
    fill = plotting_options$fill, 
    color = plotting_options$colour,
    point_interval = median_qi,
    .width = plotting_options$intervals,
    size_range = plotting_options$point_size
  ) +
  labs(
    x = plotting_options$nLED_title, 
    y = "Variety Exposure",
    title = paste0(
      "Median Lenient nLEDs by Task and Variety Exposure",
      "\nfor Novel Words Only in the Testing Phase."
    ),
    caption = plotting_options$caption
  ) +
  scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.2)) +
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
    size_range = plotting_options$point_size
  ) +
  facet_grid(.~task) +
  labs(
    x = plotting_options$nLED_title, 
    y = "Variety Exposure",
    title = paste0(
      "Median Lenient nLEDs by Task and Variety Exposure",
      "\nfor Novel Words Only in the Testing Phase."
      ),
    caption = plotting_options$caption
  ) +
  scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.2)) +
  coord_flip()

# by variety exposure

plots$testing_v <- ggplot(
  data = draws$testing_v %>% 
    escape_character(variety_exposure, pattern = " "), 
  aes(x = .value, y = variety_exposure)) +
  geom_halfeyeh(
    fill = plotting_options$fill, 
    color = plotting_options$colour,
    point_interval = median_qi,
    .width = plotting_options$intervals,
    size_range = plotting_options$point_size
  ) +
  labs(
    x = plotting_options$nLED_title, 
    y = "Variety Exposure",
    title = paste0(
      "Median Lenient nLEDs by Variety Exposure",
      "\nin the Testing Phase."
    ),
    caption = plotting_options$caption
  ) +
  scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.2)) +
  coord_flip()

# testing with vocab test performance as a covariate ----

plots$testing_cov_etv <- ggplot(
  data = draws$testing_cov_tvw %>% 
    escape_character(variety_exposure, pattern = " "), 
  aes(x = mean_exposure_test_nLED , linetype = word_type, colour = word_type, fill = word_type)) +
  stat_lineribbon(aes(y = .value), .width = plotting_options$intervals[2], alpha = 0.5) +
  geom_vline(
    xintercept = median(all_data$testing$mean_exposure_test_nLED),
    linetype = "dashed"
  ) +
  facet_grid(task ~ variety_exposure) +
  guides(fill = FALSE) +
  labs(
    x = "Median nLED for the Vocabulary Test",
    y = "Median nLED during Testing",
    title = paste0(
      "Median Lenient nLEDs by Word Type in the Testing Phase",
      "\nby Task and Variety Exposure relative to Median Performance",
      "\non the Vocabulary Test."
    ),
    caption = paste0(
      "Lines and ribbons show posterior mean and \u00B1",
      plotting_options$intervals[2]*100,
      "% credible interval.",
      "\nVertical line indicates grand median vocabulary test performance."
      ),
    colour = "Word Type",
    linetype = "Word Type"
  ) +
  scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.2)) +
  scale_y_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.2)) +
  scale_colour_manual(values = rep("black", 3)) +
  scale_fill_manual(values = rep("grey70", 3)) +
  theme(
    legend.title = element_text(size = 8),
    legend.text = element_text(size = 6),
    legend.position = c(.95, .89),
    legend.background = element_blank(),
    legend.box.background = element_rect(colour = "black")
  )

# testing with vocab test performance by variety exposure for novel words (median split) ----

plots$testing_cov_median_ev_n <- ggplot(
  data = draws$testing_cov_median_etv_n %>% 
    escape_character(variety_exposure, pattern = " "), 
  aes(x = .value, y = exposure_test_nLED_group)) +
  geom_halfeyeh(
    fill = plotting_options$fill, 
    color = plotting_options$colour,
    point_interval = median_qi,
    .width = plotting_options$intervals,
    size_range = plotting_options$point_size
  ) +
  facet_grid(~ variety_exposure) +
  labs(
    x = "Median Lenient nLED during Testing", 
    y = "Vocabulary Test nLED",
    title = paste0(
      "Median Lenient nLEDs for Novel Words in the Testing Phase split by",
      "\nVariety Exposure Condition, and Vocabulary Test Performance."
    ),
    caption = plotting_options$caption
  ) +
  scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.2)) +
  theme(axis.text.x = element_text(size = 10)) +
  coord_flip()

# testing with vocab test performance by task and variety exposure for novel words (median split) ----

plots$testing_cov_median_etv_n <- ggplot(
  data = draws$testing_cov_median_etv_n %>% 
    escape_character(variety_exposure, pattern = " "), 
  aes(x = .value, y = exposure_test_nLED_group)) +
  geom_halfeyeh(
    fill = plotting_options$fill, 
    color = plotting_options$colour,
    point_interval = median_qi,
    .width = plotting_options$intervals,
    size_range = plotting_options$point_size
  ) +
  facet_grid(task ~ variety_exposure) +
  labs(
    x = "Median Lenient nLED during Testing", 
    y = "Vocabulary Test nLED",
    title = paste0(
      "Median Lenient nLEDs for Novel Words in the Testing Phase split by",
      "\nTask, Variety Exposure Condition, and Vocabulary Test Performance."
    ),
    caption = plotting_options$caption
  ) +
  scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.2)) +
  theme(axis.text.x = element_text(size = 10)) +
  coord_flip()

# compare high vs. low performing voctest scores, and check for differences
# between variety exposure conditions, split by task (median split) ----

plots$testing_cov_median_t_ev_n <- ggplot(
  data = draws$testing_cov_median_etv_n %>% 
    escape_character(variety_exposure, pattern = " "), 
  aes(x = .value, y = exposure_test_nLED_group)) +
  geom_halfeyeh(
    fill = plotting_options$fill, 
    color = plotting_options$colour,
    point_interval = median_qi,
    .width = plotting_options$intervals,
    size_range = plotting_options$point_size
  ) +
  facet_grid(task ~ variety_exposure) +
  labs(
    x = "Median Lenient nLED during Testing", 
    y = "Vocabulary Test nLED",
    title = paste0(
      "Median Lenient nLEDs for Novel Words in the Testing Phase split by",
      "\nTask, Variety Exposure Condition, and Vocabulary Test Performance."
    ),
    caption = plotting_options$caption
  ) +
  scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.2)) +
  theme(axis.text.x = element_text(size = 10)) +
  coord_flip()

# testing with vocab test performance by word type (median split) ----

plots$testing_cov_median_etvw <- ggplot(
  data = draws$testing_cov_median_etvw %>% 
    escape_character(variety_exposure, pattern = " ") %>% 
    mutate(exposure_test_nLED_group = as.character(
      paste(exposure_test_nLED_group, "nLED")
    )), 
  aes(x = .value, y = word_type)) + # exposure_test_nLED_group
  geom_halfeyeh(
    fill = plotting_options$fill, 
    color = plotting_options$colour,
    point_interval = median_qi,
    .width = plotting_options$intervals,
    size_range = plotting_options$point_size
  ) +
  facet_grid(
    task ~ interaction(
      exposure_test_nLED_group, 
      variety_exposure, 
      sep = ":\n"
      )
  ) +
  labs(
    x = "Median Lenient nLED during Testing", 
    y = NULL,
    title = paste0(
      "Median Lenient nLEDs by Word Type in the Testing Phase split by",
      "\nTask, Variety Exposure Condition, and Vocabulary Test Performance."
    ),
    caption = plotting_options$caption
  ) +
  scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.2)) +
  theme(axis.text.x = element_text(size = 10))