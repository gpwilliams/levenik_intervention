# save all plots and summaries to file ----

# plots ----

# save plots with titles and captions in them
for(i in seq_along(plots)){
  ggsave(
    plot = plots[[i]], 
    file = here(
      "03_plots", 
      "02_posterior-full-data", 
      "01_with-titles",
      paste0(names(plots)[i], ".png")
    ),
    height = plotting_options$height,
    width = plotting_options$width
  )
}

# save plots without titles or captions (for publication)

# minor tweaks to legend position on the covariate plots
plots$testing_cov_etvw <- plots$testing_cov_etvw +
  theme(legend.position = c(.0535, .94))
  
plots$testing_cov_etv_n <- plots$testing_cov_etv_n +
  theme(legend.position = c(.05175, .906))

for(i in seq_along(plots)) {
  # remove titles and captions
  plots[[i]] <- plots[[i]] + 
    theme(plot.title = element_blank(), plot.caption = element_blank())
  
  # save in a separate folder
  ggsave(
    plot = plots[[i]], 
    file = here(
      "03_plots", 
      "02_posterior-full-data", 
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
      "02_posterior-full-data",
      paste0(names(model_summaries)[[i]], ".csv")
    )
  )
}
