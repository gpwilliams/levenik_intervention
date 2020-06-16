# set themes for plotting ----

# define shared options for summaries and plotting ---- 

summary_options <- list(
  summary_intervals = c(0.95, 0.9, 0.8),
  rounding = 3
)

plotting_options <- list(
  height = 8,
  width = 13,
  intervals = c(0.8, 0.9),
  pp_samples = 100,
  scale_fill = c("grey80", "grey30"), 
  fill = "grey50", # old green: #67d4c4
  colour = "black", # old green: #006671
  nLED_title = "Lenient nLED",
  nLED_title_agg = "Mean Lenient nLED",
  diff_nLED_title = "\u0394 lenient nLED",
  point_size = c(1, 2),
  title_size = 14
)

plotting_options$caption <- paste0(
  "Pointranges show posterior median \u00B1",
  plotting_options$intervals[1]*100,
  "% and ",
  plotting_options$intervals[2]*100,
  "% credible intervals."
)

# set theme ----
theme_set(
  theme_bw() +
    theme(
      text = element_text(size = 20),
      panel.grid.minor = element_blank(),
      panel.grid.major = element_line(size = 1.25),
      panel.border = element_rect(colour = "black"),
      strip.text = element_text(size = 14),
      legend.position = "none",
      panel.grid.major.x = element_blank(),
      panel.grid.major.y = element_line(size = 1.25),
      plot.title = element_text(size = plotting_options$title_size)
    ) 
)
