plotting_options <- list(
  axis_x_size = 17,
  axis_y_size = 20,
  scale_colours = c("black", "white"),
  scale_fills = c("grey80", "grey30"),
  error_caption = "Pointranges show the mean \u00B1 1 SE of the mean.",
  height = 8,
  width = 14
)

theme_set(
  theme_bw() +
    theme(
      text = element_text(size = 20),
      panel.grid.minor = element_blank(),
      panel.grid.major.x = element_blank(),
      panel.grid.major = element_line(size = 1.25),
      legend.position = "none",
      panel.border = element_rect(colour = "black"),
      axis.title = element_text(size = plotting_options$axis_y_size),
      axis.text.y = element_text(size = plotting_options$axis_y_size),
      strip.text = element_text(size = plotting_options$axis_y_size - 3),
      plot.caption = element_text(size = 12, vjust = 3)
    ) 
)

two_panel_theme <- theme(
  axis.text.x = element_text(size = plotting_options$axis_x_size - 4),
  strip.text = element_text(size = plotting_options$axis_y_size - 3)
  )

four_panel_theme <- theme(
  axis.text.x = element_text(size = plotting_options$axis_x_size - 7),
  axis.text.y = element_text(size = plotting_options$axis_y_size - 8),
  strip.text = element_text(size = plotting_options$axis_y_size - 3),
  strip.text.y = element_text(size = plotting_options$axis_y_size - 5)
  )