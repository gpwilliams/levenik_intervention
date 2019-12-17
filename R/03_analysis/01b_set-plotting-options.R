# set themes for plotting ----

# set theme ----
theme_set(
  theme_bw() +
    theme(
      text = element_text(size = 20),
      panel.grid.minor = element_blank(),
      panel.grid.major.y = element_blank(),
      panel.grid.major = element_line(size = 1.25)
    ) 
)

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
  fill = "grey", # old green: #67d4c4
  colour = "black", # old green: #006671
  nLED_title = "Lenient nLED",
  nLED_title_agg = "Mean Lenient nLED",
  diff_nLED_title = "\u0394 lenient nLED",
  point_size = c(2, 3)
)

plotting_options$caption <- paste0(
  "Pointranges show posterior mean \u00B1",
  plotting_options$intervals[1]*100,
  "% and ",
  plotting_options$intervals[2]*100,
  "% credible intervals."
)