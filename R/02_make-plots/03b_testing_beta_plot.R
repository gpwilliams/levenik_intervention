# by word type ----

ggplot() + 
  geom_flat_violin(
    data = testing_word_type_beta_agg,
    aes(x = word_type, y = mean_nLED, fill = word_type),
    scale = "count", 
    trim = TRUE
  ) +
  geom_dotplot(
    data = testing_word_type_beta_agg,
    aes(x = word_type, y = mean_nLED),
    binaxis = "y",
    dotsize = 1,
    stackdir = "down",
    binwidth = 0.01,
    position = position_nudge(x = -0.025, y = 0),
    alpha = 0.7
  ) +
  geom_pointrange(
    data = testing_word_type_beta_summary, 
    aes(
      x = word_type, 
      y = means, 
      ymin = means - sds * Err, 
      ymax = means + sds * Err,
      colour = word_type
    ),
    size = 0.6,
    fatten = 1.5,
    position = position_nudge(x = 0.06, y = 0)
  ) +
  scale_colour_manual(values = plotting_options$scale_colours) +
  scale_fill_manual(values = plotting_options$scale_fills) +
  scale_y_continuous(breaks = seq(0, 1, by = 0.2)) +
  coord_cartesian(ylim = c(0, 1)) +
  facet_grid(task ~ variety_exposure) +
  labs(
    x = "Word Type", 
    y = "Mean Normalised Levenshtein Edit Distance", 
    caption = plotting_options$error_caption
  ) +
  two_panel_theme

ggsave(
  here("03_plots", "03_main-data-summary", "testing_word_type_beta_plot.png"), 
  last_plot(), 
  height = 8, 
  width = 14
)

# by word familiarity ----

ggplot() + 
  geom_flat_violin(
    data = testing_word_familiarity_beta_agg,
    aes(x = word_familiarity, y = mean_nLED, fill = word_familiarity),
    scale = "count", 
    trim = TRUE
  ) +
  geom_dotplot(
    data = testing_word_familiarity_beta_agg,
    aes(x = word_familiarity, y = mean_nLED),
    binaxis = "y",
    dotsize = 1,
    stackdir = "down",
    binwidth = 0.01,
    position = position_nudge(x = -0.025, y = 0),
    alpha = 0.6
  ) +
  geom_pointrange(
    data = testing_word_familiarity_beta_summary, 
    aes(
      x = word_familiarity, 
      y = means, 
      ymin = means - sds * Err, 
      ymax = means + sds * Err,
      colour = word_familiarity
    ),
    size = 0.6,
    fatten = 1.5,
    position = position_nudge(x = 0.06, y = 0)
  ) +
  scale_colour_manual(values = plotting_options$scale_colours) +
  scale_fill_manual(values = plotting_options$scale_fills) +
  scale_y_continuous(breaks = seq(0, 1, by = 0.2)) +
  coord_cartesian(ylim = c(0, 1)) +
  facet_grid(task ~ variety_exposure) +
  labs(
    x = "Word Type", 
    y = "Mean Normalised Levenshtein Edit Distance", 
    caption = plotting_options$error_caption
  ) +
  two_panel_theme

ggsave(
  here("03_plots", "03_main-data-summary", "testing_word_familiarity_beta_plot.png"), 
  last_plot(), 
  height = 8, 
  width = 14
)