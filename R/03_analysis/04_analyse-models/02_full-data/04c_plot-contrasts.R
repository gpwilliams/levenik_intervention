# plot draws from the posterior for conditions ----

# removed code for setting continuous bounds (strange bug in plotting)
# + scale_x_continuous(limits = c(-0.25, 0.25), 
# breaks = round(seq(-0.25, 0.25, by = 0.05), 2))
# this was on base plot...

# exposure test ----

# variety exposure

# this template plot will be used for all data sets

base_plot <- ggplot(
  data = escape_character(draws$exposure_v_compare, variety_exposure),
  aes(y = variety_exposure, x = .value)
  ) +
  geom_halfeyeh(
    fill = plotting_options$fill, 
    color = plotting_options$colour,
    point_interval = median_qi,
    .width = plotting_options$intervals,
    interval_size_range = plotting_options$point_size
  ) +
  geom_vline(xintercept = 0, linetype = "dashed", size = 1.25) +
  coord_cartesian(xlim = c(-0.25, 0.25)) +
  theme(
    panel.grid.major.x = element_line(size = 1.25),
    panel.grid.major.y = element_blank()
  )

# variety exposure

plots$exposure_v_compare <- base_plot +
  labs(
    x = plotting_options$diff_nLED_title, 
    y = NULL, 
    title = paste(
      "Median Difference in nLEDs by Variety Exposure during",
      "the Vocabulary Test."
      ),
    caption = plotting_options$caption
  )

# word type by variety exposure

plots$exposure_vw_compare <- base_plot %+%
  draws$exposure_vw_compare +
  labs(
    x = plotting_options$diff_nLED_title, 
    y = NULL,
    title = paste(
      "Median Difference in nLEDs by Word Type",
      "(Contrastive \u2212 Non-Contrastive) during the Vocabulary Test."
      ),
    caption = plotting_options$caption
  )
  
# testing ----

# overall performance by variety exposure

plots$testing_v_compare <- base_plot %+%
  escape_character(draws$testing_v_compare, variety_exposure) +
  labs(
    x = plotting_options$diff_nLED_title, 
    y = NULL,
    title = paste(
      "Median Difference in nLEDs by Variety Exposure",
      "during the Testing Phase."
      ),
    caption = plotting_options$caption
    ) + 
  coord_cartesian(xlim = c(-0.2, 0.2))

# by task and variety exposure

plots$testing_tv_compare <- base_plot %+%
  escape_character(draws$testing_tv_compare, variety_exposure) +
  facet_wrap(.~task) +
  labs(
    x = plotting_options$diff_nLED_title, 
    y = NULL,
    title = paste(
      "Median Difference in nLEDs by Task and Variety Exposure",
      "during the Testing Phase."
    ),
    caption = plotting_options$caption
  )

# performance for novel words by task and variety exposure

plots$testing_tv_n_compare <- base_plot %+% 
  escape_character(draws$testing_tv_n_compare, variety_exposure)  +
  facet_wrap(.~task) +
  labs(
    x = plotting_options$diff_nLED_title, 
    y = NULL,
    title = paste(
      "Median Difference in nLEDs by Task and Variety Exposure",
      "for Novel Words during the Testing Phase."
    ),
    caption = plotting_options$caption
  )

# performance for novel words by variety exposure

plots$testing_v_n_compare <- base_plot %+% 
  escape_character(draws$testing_v_n_compare, variety_exposure)  +
  labs(
    x = plotting_options$diff_nLED_title, 
    y = NULL,
    title = paste(
      "Median Difference in nLEDs by Variety Exposure",
      "for Novel Words during the Testing Phase."
      ),
    caption = plotting_options$caption
  )

# word type by task and variety exposure

plots$testing_tvw_compare <- base_plot %+% 
  draws$testing_tvw_compare +
  facet_grid(.~task) +
  labs(
    x = plotting_options$diff_nLED_title, 
    y = NULL,
    title = paste(
      "Median Difference in nLEDs by Task and Variety Exposure",
      "Testing Phase (Contrastive Words \u2212 Non-Contrastive Words)."
      ),
    caption = plotting_options$caption
  )
  
# magnitude of word type in mismatch and mismatch social

plots$testing_tvw_ms_compare <- draws$testing_tvw_ms_compare %>% 
  ggplot(aes(y = task, x = .value)) +
  geom_halfeyeh(
    fill = plotting_options$fill, 
    color = plotting_options$colour,
    point_interval = median_qi,
    .width = plotting_options$intervals,
    interval_size_range = plotting_options$point_size
  ) +
  geom_vline(xintercept = 0, linetype = "dashed", size = 1.25) +
  scale_y_discrete(expand = c(0.1, 0.1)) +
  labs(
    x = plotting_options$diff_nLED_title, 
    y = "Task", 
    title = paste(
      "Median Difference in Difference Scores by Word Type in the",
      "Dialect & Social and Dialect Conditions",
      "(Dialect & Social \u2212 Dialect)."
      ),
    caption = plotting_options$caption
  ) +
  coord_cartesian(xlim = c(-0.25, 0.25)) +
  theme(
    panel.grid.major.x = element_line(size = 1.25),
    panel.grid.major.y = element_blank()
  )

# covariate model ----

# vocab test by task and variety exposure (vocab test median split)
plots$testing_cov_median_etv_compare <- ggplot(
  data = escape_character(draws$testing_cov_median_etv_compare, variety_exposure),
  aes(y = variety_exposure, x = .value)
) +
  geom_halfeyeh(
    fill = plotting_options$fill, 
    color = plotting_options$colour,
    point_interval = median_qi,
    .width = plotting_options$intervals,
    interval_size_range = plotting_options$point_size
  ) +
  facet_grid(exposure_test_nLED_group~task) +
  geom_vline(xintercept = 0, linetype = "dashed", size = 1.25) +
  labs(
    x = plotting_options$diff_nLED_title, 
    y = NULL,
    title = paste0(
      "Median Difference in Testing Phase nLEDs between Variety Exposure ",
      "conditions with Better and Worse ",
      "\nVocabulary Test Performance."
    ),
    caption = plotting_options$caption
  ) +
  coord_cartesian(xlim = c(-0.25, 0.25)) +
  theme(
    axis.text.y = element_text(size = 12),
    panel.grid.major.x = element_line(size = 1.25),
    panel.grid.major.y = element_blank()
  )

# word type split by voctest group, task, and variety exposure
# (vocab by median split)
plots$testing_cov_median_etvw_compare <- ggplot(
  data = escape_character(
    draws$testing_cov_median_etvw_compare, 
    exposure_test_nLED_group,
    pattern = " "
  ),
  aes(y = exposure_test_nLED_group, x = .value)
) +
  geom_halfeyeh(
    fill = plotting_options$fill, 
    color = plotting_options$colour,
    point_interval = median_qi,
    .width = plotting_options$intervals,
    interval_size_range = plotting_options$point_size/3
  ) +
  facet_grid(task~variety_exposure) +
  geom_vline(xintercept = 0, linetype = "dashed", size = 1.25) +
  labs(
    x = plotting_options$diff_nLED_title, 
    y = "Vocabulary Test nLED Performance",
    title = paste0(
      "Median Difference in Testing Phase nLEDs between Contrastive and ",
      "Non-Contrastive (Contrastive \u2212 Non-Contrastive) Words by ",
      "\nVocabulary Test Performance and Task."
    ),
    caption = plotting_options$caption
  ) +
  coord_cartesian(xlim = c(-0.25, 0.25)) +
  theme(
    panel.grid.major.x = element_line(size = 1.25),
    panel.grid.major.y = element_blank()
  )

# vocab test by task and variety exposure for novel words testing
# (vocab test median split)
plots$testing_cov_median_etv_n_compare <- ggplot(
  data = escape_character(
    draws$testing_cov_median_etv_n_compare, 
    variety_exposure
  ),
  aes(y = variety_exposure, x = .value)
) +
  geom_halfeyeh(
    fill = plotting_options$fill, 
    color = plotting_options$colour,
    point_interval = median_qi,
    .width = plotting_options$intervals,
    interval_size_range = plotting_options$point_size
  ) +
  facet_grid(exposure_test_nLED_group~task) +
  geom_vline(xintercept = 0, linetype = "dashed", size = 1.25) +
  labs(
    x = plotting_options$diff_nLED_title, 
    y = NULL,
    title = paste0(
      "Median Difference in Testing Phase nLEDs for Novel Words ",
      "between Variety Exposure conditions for those with",
      "\nBetter and Worse Vocabulary Testing Performance."
    ),
    caption = plotting_options$caption
  ) +
  coord_cartesian(xlim = c(-0.25, 0.25)) +
  theme(
    axis.text.y = element_text(size = 12),
    panel.grid.major.x = element_line(size = 1.25),
    panel.grid.major.y = element_blank()
  )

# magnitude of vocab test differences across variety exposure conditions 
# for novel words in testing (vocab test median split)
plots$testing_cov_median_t_ev_n_compare <- ggplot(
  data = escape_character(draws$testing_cov_median_t_ev_n_compare, variety_exposure),
  aes(y = variety_exposure, x = .value)
  ) +
  geom_halfeyeh(
    fill = plotting_options$fill, 
    color = plotting_options$colour,
    point_interval = median_qi,
    .width = plotting_options$intervals,
    interval_size_range = plotting_options$point_size
  ) +
  facet_grid(~task) +
  geom_vline(xintercept = 0, linetype = "dashed", size = 1.25) +
  labs(
    x = plotting_options$diff_nLED_title, 
    y = NULL,
    title = paste0(
      "Median Difference in Testing Phase nLEDs for Novel Words ",
      "between those with Better and Worse Vocabulary Testing\n",
      "Performance (Worse Performance \u2212 Better Performance) ",
      "in the Vocabulary Test compared across Variety Exposure conditions."
    ),
    caption = plotting_options$caption
  ) +
  coord_cartesian(xlim = c(-0.25, 0.25)) +
  theme(
    panel.grid.major.x = element_line(size = 1.25),
    panel.grid.major.y = element_blank()
  )