# mean performance: exposure phase ----
exposure_testing_density <- exposure_summary %>% 
  mutate(
    task = str_to_title(task),
    variety_exposure = 
      str_to_title(str_replace_all(variety_exposure, "_", " "))
  ) %>% 
  ggplot(., aes(x = mean_nLED, y = variety_exposure)) +
    geom_density_ridges(bandwidth = 0.05) +
    theme_ridges() +
    coord_cartesian(xlim = c(0, 1)) +
    ggtitle(
      paste(
        "Density of nLEDs for the reading task during the",
        "Exposure test by Variety Exposure condition."
        )
      ) +
    labs(x = "Mean nLED", y = "Variety Exposure") + 
    xlim(c(0, 1))

# mean performance: testing phase ----
testing_density <- participant_performance %>%
  mutate(
    task = str_to_title(task),
    variety_exposure = 
      str_to_title(str_replace_all(variety_exposure, "_", " "))
  ) %>% 
  ggplot(., aes(x = mean_nLED, y = variety_exposure)) +
    geom_density_ridges(bandwidth = 0.05) +
    theme_ridges() +
    theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
    coord_cartesian(xlim = c(0, 1)) +
    facet_wrap(~task) +
    ggtitle(
      paste(
        "Density of nLEDs for the each task during the",
        "testing phase by Variety Exposure condition."
      )
    ) +
    labs(x = "Mean nLED", y = "Variety Exposure") + 
    xlim(c(0, 1))

# save both plots ----
ggsave(
  filename = here(
    "02_data", 
    "03_checks",
    "exposure_testing_density.pdf"
  ),
  plot = exposure_testing_density, 
  height = 8, 
  width = 12
)

ggsave(
  filename = here(
    "02_data", 
    "03_checks",
    "testing_density.pdf"
  ),
  plot = testing_density, 
  height = 8, 
  width = 12
)