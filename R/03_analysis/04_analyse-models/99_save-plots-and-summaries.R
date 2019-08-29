# save all plots and summaries to file ----

# plots ----

for(i in seq_along(plots)){
  ggsave(
    plot = plots[[i]], 
    file = here("03_plots", paste0(names(plots)[i], ".png")),
    height = plotting_options$height,
    width = plotting_options$width
  )
}

# data summaries ---

for(i in seq_along(model_summaries)) {
  write_csv(
    x = model_summaries[[i]],
    path = here(
      "04_analysis", 
      "02_summaries", 
      paste0(names(model_summaries)[[i]], ".csv")
    )
  )
}