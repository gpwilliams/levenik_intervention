# plot testing test data
ggplot() + 
  geom_flat_violin(
    data = testing_agg,
    aes(x = word_type, y = mean_nLED, fill = word_type),
    scale = "count", 
    trim = TRUE
  ) +
  geom_dotplot(
    data = testing_agg,
    aes(x = word_type, y = mean_nLED),
    binaxis = "y",
    dotsize = 1,
    stackdir = "down",
    binwidth = 0.01,
    position = position_nudge(x = -0.025, y = 0),
    alpha = 0.7
  ) +
  geom_pointrange(
    data = testing_summary, 
    aes(
      x = word_type, 
      y = means, 
      ymin = means - sds * Err, 
      ymax = means + sds * Err,
      colour = word_type
    ),
    size = 0.5,
    position = position_nudge(x = +0.08, y = 0)
  ) +
  scale_colour_manual(values = c("white", "white", "black")) +
  scale_fill_grey() +
  scale_y_continuous(breaks = seq(0, 1, by = 0.2)) +
  facet_grid(task ~ variety_exposure) +
  labs(x = "Word Type", y = "Mean Normalised Levenshtein Edit Distance") +
  four_panel_theme

ggsave(
  here("03_plots", "03_frequentist-style", "testing_word-type_plot.png"), 
  last_plot(), 
  height = 8, 
  width = 14
)