# save all plots and summaries to file ----

# plots ----

# save plots with titles and captions in them
for(i in seq_along(plots)){
  ggsave(
    plot = plots[[i]], 
    file = here(
      "03_plots", 
      "01_posterior-aggregate-data",
      "01_with-titles",
      paste0(names(plots)[i], ".png")
    ),
    height = plotting_options$height,
    width = plotting_options$width
  )
}

# save plots without titles or captions (for publication)

for(i in seq_along(plots)) {
  # remove titles and captions
  plots[[i]] <- plots[[i]] + 
    theme(plot.title = element_blank(), plot.caption = element_blank())
  
  # save in a separate folder
  ggsave(
    plot = plots[[i]], 
    file = here(
      "03_plots", 
      "01_posterior-aggregate-data",
      "02_without-titles",
      paste0(names(plots)[i], ".png")
    ),
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
      "01_posterior-aggregate-data",
      paste0(names(model_summaries)[[i]], ".csv")
    )
  )
}