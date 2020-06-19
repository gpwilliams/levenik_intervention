# save individual plots ----

# save plots with titles and captions in them
for(i in seq_along(plots)){
  ggsave(
    plot = plots[[i]], 
    file = here(
      "03_plots", 
      "04_exploratory",  
      "01_with-titles",
      paste0(names(plots)[i], ".png")
    ),
    height = 14,
    width = 12
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
      "04_exploratory", 
      "02_without-titles",
      paste0(names(plots)[i], ".png")
    ),
    height = 14,
    width = 12
  )
}