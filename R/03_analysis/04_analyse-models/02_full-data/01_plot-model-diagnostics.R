# perform posterior predictive check to assess model robustness ----

plots <- list()

# exposure ----

plots$pp_check_exposure <- pp_check(
  models$exposure, 
  nsamples = plotting_options$pp_samples, 
  type = "ecdf_overlay"
) +
  scale_colour_grey() +
  labs(
    x = plotting_options$nLED_title,
    y = "Cumulative Probability",
    title = paste0(
      "Posterior Predictive Check for the Model ",
      "Fitted to the Vocabulary Test Data."
    ),
    caption = paste0(
      "Lines indicate the empirical cumulative distribution function of the \n",
      "observations (black) and samples from the posterior (grey)."
    )
  ) +
  scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.2)) +
  scale_y_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.2))

# testing ----

plots$pp_check_testing <- pp_check(
  models$testing, 
  nsamples = plotting_options$pp_samples, 
  type = "ecdf_overlay"
) +
  scale_colour_grey() +
  labs(
    x = plotting_options$nLED_title,
    y = "Cumulative Probability",
    title = paste0(
      "Posterior Predictive Check for the Model ",
      "Fitted to the Testing Phase Data."
    ),
    caption = paste0(
      "Lines indicate the empirical cumulative distribution function of the \n",
      "observations (black) and samples from the posterior (grey)."
    )
  ) +
  scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.2)) +
  scale_y_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.2))

# testing covariate ----

plots$pp_check_testing_cov <-  pp_check(
  models$testing_cov, 
  nsamples = plotting_options$pp_samples, 
  type = "ecdf_overlay"
) +
  scale_colour_grey() +
  labs(
    x = plotting_options$nLED_title,
    y = "Cumulative Probability",
    title = paste0(
      "Posterior Predictive Check for the Model ",
      "Fitted to the Testing Phase Data with ",
      "Vocabulary Test as a Covariate."
    ),
    caption = paste0(
      "Lines indicate the empirical cumulative distribution function of the \n",
      "observations (black) and samples from the posterior (grey)."
    )
  ) +
  scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.2)) +
  scale_y_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.2))
  
