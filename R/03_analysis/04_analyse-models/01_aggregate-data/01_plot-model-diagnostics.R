# perform posterior predictive check to assess model robustness ----

plots <- list()

pp_arrows <- list(
  exposure_arrows = tibble(
    x1 = c(0.15, 0.5),
    x2 = c(0.25, 0.4),
    y1 = c(0.7, 0.35),
    y2 = c(0.55, 0.7)
  ),
  testing_arrows = tibble(
    x1 = c(0.50, 0.25),
    x2 = c(0.40, 0.38),
    y1 = c(1.00, 0.35),
    y2 = c(0.83, 0.70)
  ),
  testing_cov_arrows = tibble(
    x1 = c(0.50, 0.25),
    x2 = c(0.40, 0.38),
    y1 = c(1.00, 0.35),
    y2 = c(0.83, 0.70)
  )
)

# exposure ----

plots$pp_check_exposure_agg <- pp_check(
  models$exposure_agg, 
  nsamples = plotting_options$pp_samples
) +
  scale_colour_grey() +
  theme(legend.position = "none") +
  labs(
    x = plotting_options$nLED_title,
    y = "Density",
    title = paste0(
      "Posterior Predictive Check for the Model",
      " Fitted to the Exposure Phase Data."
    )
  ) +
  annotate(
    "text", 
    x = 0.15, 
    y = 0.75, 
    fontface = "italic", 
    label = "Posterior Sample Density", 
    size = 6
  ) +
  annotate(
    "text", 
    x = 0.5, 
    y = 0.3, 
    fontface = "italic", 
    label = "Observed Sample Density", 
    size = 6,
    colour = "dimgrey"
  ) +
  geom_curve(
    data = pp_arrows$exposure_arrows,
    aes(x = x1, y = y1, xend = x2, yend = y2),
    arrow = arrow(length = unit(0.2, "cm")), 
    size = 0.9,
    curvature = 0.25,
    colour = c("dimgrey", "black")
  )

# testing ----

plots$pp_check_testing_agg <- pp_check(
  models$testing_agg, 
  nsamples = plotting_options$pp_samples
) +
  scale_colour_grey() +
  theme(legend.position = "none") +
  labs(
    x = plotting_options$nLED_title,
    y = "Density",
    title = paste0(
      "Posterior Predictive Check for the Model",
      " Fitted to the Testing Phase Data."
    )
  ) +
  annotate(
    "text", 
    x = 0.50, 
    y = 1.05, 
    fontface = "italic", 
    label = "Posterior Sample Density", 
    size = 6,
    colour = "dimgrey"
  ) +
  annotate(
    "text", 
    x = 0.15, 
    y = 0.3, 
    fontface = "italic", 
    label = "Observed Sample Density", 
    size = 6
  ) +
  geom_curve(
    data = pp_arrows$testing_arrows,
    aes(x = x1, y = y1, xend = x2, yend = y2),
    arrow = arrow(length = unit(0.2, "cm")), 
    size = 0.9,
    curvature = -0.1,
    colour = c("dimgrey", "black")
  )

# testing covariate ----

plots$pp_check_testing_cov_agg <- pp_check(
  models$testing_cov_agg, 
  nsamples = plotting_options$pp_samples
) +
  scale_colour_grey() +
  theme(legend.position = "none") +
  labs(
    x = plotting_options$nLED_title,
    y = "Density",
    title = paste0(
      "Posterior Predictive Check for the Model",
      " Fitted to the Testing Phase Data \nwith",
      " Vocabulary Test as a Covariate."
    )
  ) +
  annotate(
    "text", 
    x = 0.50, 
    y = 1.05, 
    fontface = "italic", 
    label = "Posterior Sample Density", 
    size = 6,
    colour = "dimgrey"
  ) +
  annotate(
    "text", 
    x = 0.15, 
    y = 0.3, 
    fontface = "italic", 
    label = "Observed Sample Density", 
    size = 6
  ) +
  geom_curve(
    data = pp_arrows$testing_cov_arrows,
    aes(x = x1, y = y1, xend = x2, yend = y2),
    arrow = arrow(length = unit(0.2, "cm")), 
    size = 0.9,
    curvature = -0.1,
    colour = c("dimgrey", "black")
  )