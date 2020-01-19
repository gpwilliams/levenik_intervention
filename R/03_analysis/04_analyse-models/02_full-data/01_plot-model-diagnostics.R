# perform posterior predictive check to assess model robustness ----

plots <- list()

pp_arrows <- list(
  exposure_arrows = tibble(
    x1 = c(0.55, 0.63),
    y1 = c(1.6, 0.3),
    x2 = c(0.74, 0.83),
    y2 = c(1.2, 0.65)
  ),
  testing_arrows = tibble(
    x1 = c(0.5, 0.7),
    y1 = c(2.1, 1.3),
    x2 = c(0.23, 0.6),
    y2 = c(1.45, 0.7)
  ),
  testing_cov_arrows = tibble(
    x1 = c(0.50, 0.30),    
    y1 = c(1.20, 1.58),
    x2 = c(0.40, 0.25),
    y2 = c(0.94, 1.3)
  )
)

# exposure ----

plots$pp_check_exposure <- pp_check(
  models$exposure, 
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
    x = 0.55, 
    y = 1.7, 
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

plots$pp_check_testing <- pp_check(
  models$testing, 
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
    x = 0.7, 
    y = 1.4, 
    fontface = "italic", 
    label = "Posterior Sample Density", 
    size = 6,
    colour = "dimgrey"
  ) +
  annotate(
    "text", 
    x = 0.5, 
    y = 2.2, 
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

plots$pp_check_testing_cov <- pp_check(
  models$testing_cov, 
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
    y = 1.3, 
    fontface = "italic", 
    label = "Posterior Sample Density", 
    size = 6,
    colour = "dimgrey"
  ) +
  annotate(
    "text", 
    x = 0.3, 
    y = 1.7, 
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