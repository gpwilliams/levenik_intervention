# plots ----

# plot grand proportions of errors (i.e. stacked bars)
grand_prop_plot <- ggplot(
  grand_proportions,
  aes(x = word_type, y = proportion, fill = lenient_coder_error_types)
  ) +
  facet_grid(variety_exposure ~ task) +
  geom_bar(stat = "identity", position = "stack", colour = "black") +
  scale_y_continuous(breaks = seq(0, 1, by = 0.2)) +
  labs(x = shared_x_axis_label, y = grand_prop_y_axis_label) +
  scale_fill_manual(values = shared_manual_scale) +
  custom_theme

# plot the average proportion of dialect errors vs. others (i.e. error bars)
average_prop_plot <- ggplot(
  mean_proportions, 
  aes(x = word_type, y = mean_prop, fill = lenient_coder_error_types)
  ) +
  facet_grid(variety_exposure ~ task) +
  geom_bar(stat = "identity", position = "dodge", colour = "black", width = 0.9) +
  geom_errorbar(
    aes(ymin = mean_prop - se_prop, ymax = mean_prop + se_prop), 
    position = position_dodge(width = 0.90), 
    width = 0.25,
    colour = "white",
    size = 1.25
  ) +
  geom_errorbar(
    aes(ymin = mean_prop - se_prop, ymax = mean_prop + se_prop), 
    position = position_dodge(width = 0.9), 
    width = 0.20
  ) +
  scale_y_continuous(breaks = seq(0, 1, by = 0.2)) +
  coord_cartesian(ylim = c(0, 1)) +
  labs(x = shared_x_axis_label, y = prop_y_axis_label) +
  scale_fill_manual(values = shared_manual_scale) +
  labs(errorbar_caption) +
  custom_theme +
  theme(plot.caption = element_text(size = 14))

# save individual plots ----

ggsave(
  filename = here(
    "03_plots", 
    "04_exploratory", 
    "grand-proportions-error-responses.png"
  ),
  plot = grand_prop_plot,
  height = 14, width = 12
)

ggsave(
  filename = here(
    "03_plots", 
    "04_exploratory", 
    "mean-proportions-error-responses.png"
  ),
  plot = average_prop_plot,
  height = 14, width = 12
)