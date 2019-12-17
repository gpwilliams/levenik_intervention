# plot draws from the posterior for conditions ----

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
    point_interval = mean_qi,
    .width = plotting_options$intervals,
    size_range = plotting_options$point_size
  ) +
  geom_vline(xintercept = 0, linetype = "dashed", size = 1.25) +
  scale_x_continuous(
    limits = c(-0.2, 0.2), 
    breaks = seq(-0.2, 0.2, by = 0.05)
  ) 

plots$exposure_v_compare <- base_plot +
  labs(
    x = plotting_options$diff_nLED_title, 
    y = NULL, 
    title = paste0(
      "Mean Difference in nLEDs by Variety Exposure during",
      "\nthe Exposure Phase."
      ),
    caption = plotting_options$caption
  )

# word type by variety exposure

plots$exposure_vw_compare <- base_plot %+%
  draws$exposure_vw_compare +
  labs(
    x = plotting_options$diff_nLED_title, 
    y = NULL,
    title = paste0(
      "Mean Difference in nLEDs by Word Type",
      "\n(Contrastive \u2212 Non-Contrastive) during the Exposure Phase."
      ),
    caption = plotting_options$caption
  )
  
# testing ----

# overall performance by variety exposure ----

plots$testing_v_compare <- base_plot %+%
  escape_character(draws$testing_v_compare, variety_exposure) +
  labs(
    x = plotting_options$diff_nLED_title, 
    y = NULL,
    title = paste0(
      "Mean Difference in nLEDs by Variety Exposure",
      "\nduring the Testing Phase."
      ),
    caption = plotting_options$caption
  )

# performance for novel words by variety exposure ----

plots$testing_v_n_compare <- base_plot %+% 
  escape_character(draws$testing_v_n_compare, variety_exposure)  +
  labs(
    x = plotting_options$diff_nLED_title, 
    y = NULL,
    title = paste0(
      "Mean Difference in nLEDs by Variety Exposure",
      "\nfor Novel Words during the Testing Phase."
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
    title = paste0(
      "Mean Difference in nLEDs by Word Type during the",
      "\nTesting Phase (Contrastive Words \u2212 Non-Contrastive Words)."
      ),
    caption = plotting_options$caption
  )
  
# magnitude of word type in mismatch and mismatch social

plots$testing_tvw_ms_compare <- draws$testing_tvw_ms_compare %>% 
  ggplot(aes(y = task, x = .value)) +
  geom_halfeyeh(
    fill = plotting_options$fill, 
    color = plotting_options$colour,
    point_interval = mean_qi,
    .width = plotting_options$intervals,
    size_range = plotting_options$point_size
  ) +
  geom_vline(xintercept = 0, linetype = "dashed", size = 1.25) +
  scale_x_continuous(
    limits = c(-0.2, 0.2), 
    breaks = seq(-0.2, 0.2, by = 0.05)
  ) +
  scale_y_discrete(expand = c(0.1, 0.1)) +
  labs(
    x = plotting_options$diff_nLED_title, 
    y = "Task", 
    title = paste0(
      "Mean Difference in Difference Scores by Word Type in the",
      "\nVariety Mismatch Social and Variety Mismatch Conditions",
      "\n(Variety Mismatch Social \u2212 Variety Mismatch)."
      ),
    caption = plotting_options$caption
  )

# covariate model ----

# magnitude of vocab test differences across variety exposure conditions in testing
# (vocab test median split)
plots$testing_cov_median_etv_n_compare <- ggplot(
  data = escape_character(draws$testing_cov_median_etv_n_compare, variety_exposure),
  aes(y = variety_exposure, x = .value)
) +
  geom_halfeyeh(
    fill = plotting_options$fill, 
    color = plotting_options$colour,
    point_interval = mean_qi,
    .width = plotting_options$intervals,
    size_range = plotting_options$point_size
  ) +
  facet_grid(~task) +
  geom_vline(xintercept = 0, linetype = "dashed", size = 1.25) +
  labs(
    x = plotting_options$diff_nLED_title, 
    y = NULL,
    title = paste0(
      "Mean Difference in Testing Phase nLEDs for Novel Words",
      "\nbetween High and Low Performing Groups",
      "\n(High nLED \u2212 Low nLED) from the Vocabulary Test",
      "\ncompared across Variety Exposure conditions."
    ),
    caption = plotting_options$caption
  ) +
  scale_x_continuous(
    limits = c(-0.4, 0.4),
    breaks = round(seq(-0.4, 0.4, by = 0.1), 2)
  )

# word type split by voctest group, task, and variety exposure
# (vocab by median split)
plots$testing_cov_median_etvw_compare <- ggplot(
  data = escape_character(
    draws$testing_cov_median_etvw_compare, 
    variety_exposure,
    pattern = " "
  ),
  aes(y = exposure_test_nLED_group, x = .value)
) +
  geom_halfeyeh(
    fill = plotting_options$fill, 
    color = plotting_options$colour,
    point_interval = mean_qi,
    .width = plotting_options$intervals,
    size_range = plotting_options$point_size - 0.5
  ) +
  facet_grid(task~variety_exposure) +
  geom_vline(xintercept = 0, linetype = "dashed", size = 1.25) +
  labs(
    x = plotting_options$diff_nLED_title, 
    y = "Vocabulary Test nLED Group",
    title = paste0(
      "Mean Difference in Testing Phase nLEDs between Contrastive and",
      "\nNon-Contrastive (Contrastive \u2212 Non-Contrastive) Words by",
      "\nVocabulary Test Group (High nLED and Low nLED) and Task."
    ),
    caption = plotting_options$caption
  ) +
  scale_x_continuous(
    limits = c(-0.4, 0.4),
    breaks = round(seq(-0.4, 0.4, by = 0.2), 2)
  )