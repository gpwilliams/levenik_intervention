# plot exposure test data
ggplot() + 
  geom_flat_violin(
    data = exposure_agg,
    aes(x = word_type, y = mean_nLED, fill = word_type),
    scale = "count", 
    trim = TRUE
  ) +
  geom_dotplot(
    data = exposure_agg,
    aes(x = word_type, y = mean_nLED),
    binaxis = "y",
    dotsize = 1,
    stackdir = "down",
    binwidth = 0.01,
    position = position_nudge(x = -0.025, y = 0),
    alpha = 0.7
  ) +
  geom_pointrange(
    data = exposure_summary, 
    aes(
      x = word_type, 
      y = means, 
      ymin = means - sds * Err, 
      ymax = means + sds * Err,
      colour = word_type
    ),
    size = 1,
    position = position_nudge(x = +0.08, y = 0)
  ) +
  scale_colour_manual(values = c("white", "white")) +
  scale_fill_manual(values = c("black", "grey48")) +
  scale_y_continuous(breaks = seq(0, 1, by = 0.2)) +
  facet_grid(. ~ variety_exposure) +
  labs(x = "Word Type", y = "Mean Normalised Levenshtein Edit Distance") +
  two_panel_theme

ggsave(
  here("03_plots", "03_frequentist-style", "exposure_plot.png"), 
  last_plot(), 
  height = 8, 
  width = 14
)