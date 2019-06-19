# load and subset data
exposure_data <- 
  read_rds(here("02_data", "02_cleaned", "learning_data.RDS")) %>%
  filter(block == "exposure_test") %>%
  mutate(
    variety_exposure = str_to_title(
      str_replace_all(variety_exposure, "_", " ")
    ),
    variety_exposure = factor( # reorder variety_exposure factor levels
      variety_exposure,
      levels = c(
        "Variety Match",
        "Variety Mismatch",
        "Variety Mismatch Social",
        "Dialect Literacy"
      ))
  ) %>%
  drop_na()

# aggregate by subjects
exposure_agg <- exposure_data %>%
  group_by(participant_number, variety_exposure) %>%
  summarise(
    mean = mean(lenient_nLED),
    sd = sd(lenient_nLED)
  )

# make summary with appropriately adjusted error bars
exposure_summary <- summariseBetween(
    data = exposure_data,
    subj_ID = "participant_number",
    groupingVariables = "variety_exposure",
    dependentVariable = "lenient_nLED",
    errorTerm = "Standard Error"
  )

# plot test
ggplot() + 
  geom_flat_violin(
    data = exposure_agg,
    aes(x = variety_exposure, y = mean),
    scale = "count", 
    trim = TRUE
  ) +
  geom_dotplot(
    data = exposure_agg,
    aes(x = variety_exposure, y = mean),
    binaxis = "y",
    dotsize = 0.3,
    stackdir = "down",
    binwidth = 0.05,
    position = position_nudge(x = -0.025, y = 0),
    alpha = 0.7
  ) +
  geom_pointrange(
    data = exposure_summary, 
    aes(
      x = variety_exposure, 
      y = means, 
      ymin = means - sds * Err, 
      ymax = means + sds * Err
    ),
    size = 2,
    position = position_nudge(x = 0.05, y = 0)
  ) +
  scale_y_continuous(breaks = seq(0, 1, by = 0.2)) +
  labs(x = "Word Type", y = "Mean Normalised Levenshtein Edit Distance")

ggsave(
  here("03_plots", "exposure_plot_test.png"), 
  last_plot(), 
  height = 8, 
  width = 14
)
