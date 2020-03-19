# plot testing test data
ggplot() + 
  geom_flat_violin(
    data = testing_agg,
    aes(x = word_familiarity, y = mean_nLED, fill = word_familiarity),
    scale = "count", 
    trim = TRUE
  ) +
  geom_dotplot(
    data = testing_agg,
    aes(x = word_familiarity, y = mean_nLED),
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
      x = word_familiarity, 
      y = means, 
      ymin = means - sds * Err, 
      ymax = means + sds * Err,
      colour = word_familiarity
    ),
    size = 0.5,
    position = position_nudge(x = +0.06, y = 0)
  ) +
  scale_colour_manual(values = c("white", "white")) +
  scale_fill_manual(values = c("black", "grey48")) +
  scale_y_continuous(breaks = seq(0, 1, by = 0.2)) +
  facet_grid(task ~ variety_exposure) +
  labs(x = "Word Type", y = "Mean Normalised Levenshtein Edit Distance") +
  four_panel_theme

ggsave(
  here("03_plots", "03_frequentist-style", "testing_word-familiarity_plot.png"), 
  last_plot(), 
  height = 8, 
  width = 14
)