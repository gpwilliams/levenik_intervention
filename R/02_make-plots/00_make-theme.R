axis_x_size <- 17
axis_y_size <- 20

custom_theme <- theme_bw() +
  theme(
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    strip.background = element_blank(),
    panel.border = element_rect(colour = "black"),
    axis.title = element_text(size = axis_y_size),
    axis.text.y = element_text(size = axis_y_size),
    strip.text = element_text(size = axis_y_size - 3),
    legend.position = "none"
  )

two_panel_theme <- custom_theme +
  theme(
    axis.text.x = element_text(size = axis_x_size - 4),
    strip.text = element_text(size = axis_y_size - 3),
  )

four_panel_theme <- custom_theme +
  theme(
    axis.text.x = element_text(size = axis_x_size - 7),
    strip.text = element_text(size = axis_y_size - 3),
  )