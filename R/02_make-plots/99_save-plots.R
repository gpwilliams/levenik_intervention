# save all plots to file ----

# save plots with titles and captions in them
for(i in seq_along(plots)){
  ggsave(
    plot = plots[[i]], 
    file = here(
      "03_plots", 
      "03_main-data-summary", 
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
      "03_main-data-summary", 
      "02_without-titles",
      paste0(names(plots)[i], ".png")
    ),
    height = plotting_options$height,
    width = plotting_options$width
  )
}